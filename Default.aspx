<%@ Page Title="Dat Nguyen" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Src="~/Content/ForecastChart.ascx" TagPrefix="uc1" TagName="ForecastChart" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style>
        .jumbotron{
            margin-top: 20px;
            background-image: url(images/stealth-game/starting-area.png);
            background-position: center;
        }
        .jumbotron p{
            color: white;
        }
        .jumbotron h1{
            color: white;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="container">
        <div class="jumbotron box-shadow">
            <h1>Hello!</h1>
            <p>Welcome to my ASP.NET website!</p>
        </div>
    
        <div>
            <div class="col-sm-7">
                <h1><%:Page.Title %></h1>
                <h3>Python</h3>
                <p>
                    The first game that I created was a tank game in Python. You know those old popular flash games where you could move a small tank, change its fire projectory and try to hit the other tank? I made that in grade 9. I remember how intensely motivated I was and how much fun that project was. Through a lot of trial and error, I applied concepts such as trigonometry and physics at an age that was years before I was supposed to learn it. 
                </p> 
                <h3>Game Maker</h3>
                <p>
                    Game Maker was the first game engine I used, since it is a relatively easy engine to create content. I created Red's Adventure in grade 12, which I consider is completely overkill for what was supposed to be a programming culminating project. I found myself spending hours and hours trying to perfect my main characters sprites and animations. Creating Red's Adventure was incredibly fun for me, as having the freedom to play around with game mechanics resulted in interesting interactions. I ended up creating all the interactions through Game Maker Language, and creating several different enemy types. Red's Adventure gave me the skills and abilities to easily move onto larger game engines like Unreal and Unity. <a href="https://github.com/itsdatnguyen/reds-adventure">Red's Adventure</a> is available on Github.
                </p>  
                <h3>Unreal Engine 4 and Unity</h3>     
                <p>
                    After Red's Adventure, I tried out Unity and Unreal Engine 4, trying to figure out which engine was better. Unreal Engine caught my eye, as Blueprint (Unreal Engine's visual scripting system) was incredibly useful for me. Even today, I use a mixture of C++ and Blueprint since Blueprint is so intuitive and productive. I then created "Stealth Game" in Unreal Engine 4, which whats my first attempt at a 3D game with working AI. Through this project, I've learned valuable game development knowledge of shaders (materials), animation, AI, and map design. The most challenging aspect of Stealth Game was creating realistic AI. I spent an absurd amount of time on AI, but I always feel as more work could be done. Thankfully, Unreal provides a great framework for AI design through its built-in <a href="http://www.gamasutra.com/blogs/ChrisSimpson/20140717/221339/Behavior_trees_for_AI_How_they_work.php">Behavior Trees</a>. <a href="https://github.com/itsdatnguyen/stealth-game">Stealth Game</a> is available on Github.
                </p>           
                <asp:Chart ID="Chart1" runat="server">
                    <Series>
                        <asp:Series Name="Series1"></asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                    </ChartAreas>
                </asp:Chart>
                <uc1:ForecastChart runat="server" ID="ForecastChart" />
            </div>
            <aside class="pull-right col-sm-5">
                <div class="aside-element">
                    <h3>Stealth Game</h3>
                    <p>Made in Unreal Engine 4, Stealth game is a cat/mouse game where you can use tools and abilities to sneak past and dodge enemies. <a href="https://github.com/itsdatnguyen/stealth-game">Github</a></p>
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/images/stealth-game/models-mini.png" />
                </div>
                <div class="aside-element">
                    <h3>Red's Adventure</h3>
                    <p>Made in Game Maker, Red's Adventure is a platforming, action based game that rewards good reaction time. <a href="https://github.com/itsdatnguyen/reds-adventure">Github</a></p>
                    <asp:Image ID="Image2" runat="server" ImageUrl="~/images/reds-adventure/red-attacking-mini.png" />
                </div>
            </aside>
        </div>
    </div>
</asp:Content>

