<%@ Page Title="Code Example" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="CodeExample.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <link href="Styles/arduino-light.css" rel="stylesheet" type="text/css" />
    <style>
        pre{
            font-size: 0.8em;
        }
    </style>

    <script src="Scripts/highlight.js"></script>
    <script>hljs.initHighlightingOnLoad();</script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="container-fluid">
        <div class="container">
            <div class="panel panel-success">
                <div class="panel-heading">
                    <h1><%:Page.Title %></h1>
                </div>
                <div class="panel-body">
                    <h2>Here is an example of some of the code I write in Unreal Engine 4.</h2>
                </div>
                <div class="panel-footer">
                    <p>
                        C++ within Unreal Engine 4 can be very different from normal c++ due to Unreal Engine macros.
                        The macros are needed in order to wrap up the code in a way that Unreal Engine can use.
                        The macros USTRUCT(), GENERATED_BODY(), UCLASS, UFUNCTION etc are ways to notify Unreal Engine and to use it within Blueprint.
                    </p>
                </div>
            </div>
        </div>
    <div class="col-lg-6">
            <h3>GunComponent.cpp</h3>
            <pre>
<code class="C++">#include "CatAndMouse.h"
#include "GunComponent.h"
#include "Bullet.h"
#include "VisionController.h"
#include "GameCharacter.h"
#include "GameStatics.h"
#include "Gun.h"

UGunComponent::UGunComponent()
{
	PrimaryComponentTick.TickGroup = TG_PrePhysics;
	PrimaryComponentTick.bCanEverTick = true;
	bAutoActivate = true;
	SetComponentTickEnabled(true);
}

void UGunComponent::InitializeComponent()
{
	Super::InitializeComponent();

}

void UGunComponent::TickComponent(float DeltaTime, enum ELevelTick TickType, FActorComponentTickFunction* ThisTickFunction)
{
	Super::TickComponent(DeltaTime, TickType, ThisTickFunction);

	if (EquippedGun->CurrentCombatStats.FireCooldown >= 0.0f) {
		EquippedGun->CurrentCombatStats.FireCooldown -= DeltaTime;
	}
}

ABullet* UGunComponent::Fire(bool IsTriggerHeld)
{
	ABullet* Bullet = nullptr;
	if (EquippedGun && CanFire()) {
		OnFireDelegate.Broadcast();
		switch(EquippedGun->FireType) {
			case EFireType::Automatic:
				EquippedGun->CurrentCombatStats.Rounds--;
				EquippedGun->CurrentCombatStats.FireCooldown = EquippedGun->BaseCombatStats.FireCooldown;

				Bullet = SpawnBullet(60.f);
				break;

			case EFireType::SingleFire:
				if (!IsTriggerHeld) {
					EquippedGun->CurrentCombatStats.Rounds--;
					EquippedGun->CurrentCombatStats.FireCooldown = EquippedGun->BaseCombatStats.FireCooldown;

					Bullet = SpawnBullet(60.f);
				}
				break;
		}
	}
	return Bullet;
}

bool UGunComponent::CanFire()
{
	return EquippedGun->CurrentCombatStats.Rounds > 0 && !IsReloading() && EquippedGun->CurrentCombatStats.FireCooldown < 0;
}

void UGunComponent::Reload()
{
	if (!IsReloading()) {
		OnReloadDelegate.Broadcast(EquippedGun->Reload.ValidReloadTime, EquippedGun->Reload.ReloadTime);
		ReloadTimelineComponent->SetTimelineLength(EquippedGun->Reload.ReloadTime);
		ReloadTimelineComponent->PlayFromStart();
	}
	else if (IsTimedReloading && !FailedReload) {
		if (CheckTimedReload()) {
			OnSuccessTimedReloadDelegate.Broadcast();
			FinishReload();
		}
		else {
			FailedReload = true;
			ReloadTimelineComponent->SetTimelineLength(ReloadTimelineComponent->GetTimelineLength() + 1.f);
			OnFailTimedReloadDelegate.Broadcast(ReloadTimelineComponent->GetTimelineLength());
		}
	}
}

bool UGunComponent::IsReloading() const
{
	return ReloadTimelineComponent->IsPlaying();
}

void UGunComponent::CancelReloading()
{
	OnCancelReloadDelegate.Broadcast();
	ReloadTimelineComponent->Stop();
}

void UGunComponent::ReplaceGun(UGun* NewGun)
{	
	OnReplaceGunDelegate.Broadcast();
	EquippedGun = NewGun;
}

void UGunComponent::FinishReload()
{
	OnFinishReloadDelegate.Broadcast();
	EquippedGun->CurrentCombatStats.Rounds = EquippedGun->BaseCombatStats.Rounds;
	FailedReload = false;
}

void UGunComponent::ComponentStart(AActor* Owner)
{
	//@todo pretty bad hack
	AGameCharacter* GameCharacter = Cast<AGameCharacter>(Owner);
	if (GameCharacter) {
		ReloadTimelineComponent = GameCharacter->TimelineComponent;
	}

	if (GunClass) {
		EquippedGun = NewObject<UGun>(this, GunClass, FName("EquippedGun"));

		// Setup timeline component
		if (ReloadTimelineComponent) {
			if (EquippedGun->Reload.ReloadCurve) {
				ReloadTickCallback.BindUFunction(this, FName("ReloadTick"));
				ReloadTimelineComponent->AddInterpFloat(EquippedGun->Reload.ReloadCurve, ReloadTickCallback, FName("ReloadTrack"));
				ReloadTimelineComponent->SetTimelineLength(EquippedGun->Reload.ReloadTime);

				ReloadFinishCallback.BindUFunction(this, FName("FinishReload"));
				ReloadTimelineComponent->SetTimelineFinishedFunc(ReloadFinishCallback);
			}
			else {
				GEngine->AddOnScreenDebugMessage(-1, 2, FColor::Green, FString(Owner->GetName() + " " + GetName() + " Does not have a valid float curve component."));
			}
		}
		else {
			GEngine->AddOnScreenDebugMessage(-1, 2, FColor::Green, FString(Owner->GetName() + " " + GetName() + " Does not have a valid timeline component."));
		}
	}
	else {
		GEngine->AddOnScreenDebugMessage(-1, 2, FColor::Green, FString(Owner->GetName() + " " + GetName() + " Does not have a valid gun class."));
	}
}

void UGunComponent::ReloadTick(float Value)
{
	OnReloadTickDelegate.Broadcast(Value);
}

ABullet* UGunComponent::SpawnBullet(float Distance)
{
	ABullet* Bullet = nullptr;
	APawn* PawnOwner = Cast<APawn>(GetOwner());

	if (PawnOwner && EquippedGun->BulletClass) {
		FRotator Rotation(0, 0, 0);

		// If controller is a VisionController, set rotation to rotation with vision
		// If controller is not a VisionController, set rotation to pawn rotation
		AVisionController* Controller = Cast<AVisionController>(PawnOwner->GetController());
		if (Controller) {
			Rotation = Controller->GetRotationWithVision();
		}
		else {
			Rotation = PawnOwner->GetActorRotation();
		}

		FVector Location = PawnOwner->GetActorLocation() + PawnOwner->GetActorForwardVector() * Distance;

		FActorSpawnParameters SpawnParams = FActorSpawnParameters();
		SpawnParams.bNoFail = true;
		SpawnParams.Instigator = PawnOwner;
		SpawnParams.Owner = PawnOwner;
		SpawnParams.SpawnCollisionHandlingOverride = ESpawnActorCollisionHandlingMethod::AlwaysSpawn;

		Bullet = Cast<ABullet>(GetWorld()->SpawnActor(EquippedGun->BulletClass, &Location, &Rotation, SpawnParams));
	}
	else {
		GEngine->AddOnScreenDebugMessage(-1, 2, FColor::Red, FString("Error, could not create Bullet. PawnOwner is invalid or BulletClass is not set"));
	}
	return Bullet;
}

bool UGunComponent::CheckTimedReload()
{
	float ReloadTime = ReloadTimelineComponent->GetPlaybackPosition();
	FTimeframe Timeframe = EquippedGun->Reload.ValidReloadTime;
	if (ReloadTime >= Timeframe.Start && ReloadTime <= Timeframe.End) {
		return true;
	}

	return false;
}
                </code>
            </pre>
        </div>
    
        <div class="col-lg-6">
            <h3>GunComponent.h</h3>
            <pre>
<code class="c++">#pragma once

#include "Components/StaticMeshComponent.h"
#include "GameStatics.h"
#include "GunComponent.generated.h"


DECLARE_DYNAMIC_MULTICAST_DELEGATE(FGunSignature);
DECLARE_DYNAMIC_MULTICAST_DELEGATE_OneParam(FReloadTickSignature, float, Value);
DECLARE_DYNAMIC_MULTICAST_DELEGATE_OneParam(FFloatSignature, float, Value);
DECLARE_DYNAMIC_MULTICAST_DELEGATE_TwoParams(FReloadStartSignature, FTimeframe, Timeframe, float, Value);


/**
 * Equipped gun for an actor. 
 */
UCLASS(Blueprintable)
class CATANDMOUSE_API UGunComponent : public UStaticMeshComponent, public IComponentStartable
{
	GENERATED_BODY()
	
public:
	UPROPERTY(BlueprintReadWrite, EditAnywhere, Category = "Gun")
	TSubclassOf<UGun> GunClass;

	UPROPERTY(BlueprintAssignable, Category = "Gun")
	FGunSignature OnFireDelegate;

	UPROPERTY(BlueprintAssignable, Category = "Gun")
	FReloadStartSignature OnReloadDelegate;

	UPROPERTY(BlueprintAssignable, Category = "Gun")
	FGunSignature OnFinishReloadDelegate;

	UPROPERTY(BlueprintAssignable, Category = "Gun")
	FFloatSignature OnFailTimedReloadDelegate;

	UPROPERTY(BlueprintAssignable, Category = "Gun")
	FGunSignature OnSuccessTimedReloadDelegate;

	UPROPERTY(BlueprintAssignable, Category = "Gun")
	FGunSignature OnCancelReloadDelegate;

	UPROPERTY(BlueprintAssignable, Category = "Gun")
	FReloadTickSignature OnReloadTickDelegate;

	UPROPERTY(BlueprintAssignable, Category = "Gun")
	FGunSignature OnReplaceGunDelegate;

	UPROPERTY(BlueprintReadWrite, EditAnywhere, Category = "Gun")
	bool IsTimedReloading = false;

protected:
	UPROPERTY(BlueprintReadWrite, EditAnywhere, Category = "Gun")
	UGun* EquippedGun;

	UTimelineComponent* ReloadTimelineComponent;

private:
	FOnTimelineFloat ReloadTickCallback;

	FOnTimelineEvent ReloadFinishCallback;

	bool FailedReload = false;

public:
	UGunComponent();

	UFUNCTION(BlueprintCallable, Category = "Gun")
	ABullet* Fire(bool IsTriggerHeld);

	UFUNCTION(BlueprintCallable, Category = "Gun")
	bool CanFire();

	UFUNCTION(BlueprintCallable, Category = "Gun")
	void Reload();

	UFUNCTION(BlueprintCallable, Category = "Gun")
	bool IsReloading() const;

	UFUNCTION(BlueprintCallable, Category = "Gun")
	void CancelReloading();
	
	UFUNCTION(BlueprintCallable, Category = "Gun")
	void ReplaceGun(UGun* NewGun);

	UFUNCTION(BlueprintCallable, Category = "Gun")
	UGun* GetEquippedGun() const { return EquippedGun; }
	
	void SetTimelineComponent(UTimelineComponent* TimelineComponent) { ReloadTimelineComponent = TimelineComponent; }

	virtual void ComponentStart(AActor* Owner) override;

protected:
	virtual void InitializeComponent() override;

	virtual void TickComponent(float DeltaTime, enum ELevelTick TickType, FActorComponentTickFunction* ThisTickFunction) override;

	UFUNCTION(BlueprintCallable, Category = "Gun")
	void FinishReload();

	UFUNCTION(BlueprintCallable, Category = "Gun")
	void ReloadTick(float Value);

private:
	ABullet* SpawnBullet(float Distance);

	virtual bool CheckTimedReload();
};
                </code>
            </pre>
        </div>
    </div>
</asp:Content>

