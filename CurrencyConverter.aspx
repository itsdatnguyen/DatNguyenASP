<%@ Page Title="Currency Converter" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="CurrencyConverter.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="Scripts/converter.js"></script>
<script>
    function updateInput(cookieKey, $formElement, defaultValue) {
        var cookie = readCookie(cookieKey);
        if (cookie != "undefined" && cookie) {
            $formElement.val(cookie);
        }
        else {
            $formElement.val(defaultValue);
        }
    }

    function loadCookies() {
        updateInput("currency-type-1", $("#currency-type-1"), "USD");
        updateInput("currency-type-2", $("#currency-type-2"), "CAD");
    }

    $(document).ready(function () {
        converter.initializeConverter([$("#currency-type-1"), $("#currency-type-2")]);
        converter.registerConversion($("#currency-amount-1"), $("#currency-amount-2"));
        converter.registerConversion($("#currency-amount-2"), $("#currency-amount-1"));   

        converter.onFinishLoading(function () {
            $(".conversion-container").removeClass("hidden");
            $(".loading-widget").addClass("hidden");
            $(".currency-input").val("0.00");

            loadCookies();
        });

        $(".currency-select").change(function () {
            createCookie($(this).attr("id"), $(this).val(), 2);
        });
    });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="container">        
        <div class="col-sm-8">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h1><%: Page.Title %></h1>
                </div>
                <div class="panel-body">
                    <div class="loading-widget"></div>
                    <div class="conversion-container hidden">
                        <form class="form-inline">
                            <div class="form-group">
                                <input class="form-control currency-input" id="currency-amount-1" type="text" aria-describedby="#currency-type-1" />
                                <select class="form-control currency-select" id="currency-type-1"></select>
                            </div>
                            <div class="form-group">
                                <input class="form-control currency-input" id="currency-amount-2" type="text" aria-describedby="#currency-type-2" />
                                <select class="form-control currency-select" id="currency-type-2"></select>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>   
        <aside class="col-sm-4 col-xs-12 pull-right">
            <div class="aside-element">
                <p>Powered by <a href="https://currencylayer.com/">Currency Layer</a></p>
            </div>
        </aside>
    </div>
</asp:Content>

