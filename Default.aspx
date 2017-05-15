<%@ Page Title="" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="container">
        <div class="col-sm-8">
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
        </div>
        <aside class="pull-right col-sm-4">
            <div class="aside-element">
                <h3>Aside 1</h3>
                <p>Some Content. Some Content. Some Content. Some Content. Some Content. Some Content. Some Content. Some Content. Some Content. </p>
            </div>
            <div class="aside-element">
                <h3>Aside 2</h3>
                <p>Some Content. Some Content. Some Content. Some Content. Some Content. Some Content. Some Content. Some Content. Some Content. </p>
            </div>
        </aside>
    </div>
</asp:Content>

