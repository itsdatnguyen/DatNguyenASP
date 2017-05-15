<%@ Page Title="About Me" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="About.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="container">
        <h1><%:Page.Title %></h1>
        <div class="container col-sm-8">
            <div>
                <h3>Dat Nguyen</h3>
                <p>I program in my free time. 
                   Usually I create cool prototypes or explore different languages.
                    I've been exploring with C++ recently, as Unreal Engine 4 uses it and that i am particulary interested
                    in modern C++.
                </p>
                <p>Sample Data. Sample Data. Sample Data. Sample Data. Sample Data. Sample Data. Sample Data. Sample Data. Sample Data. Sample Data. </p>
            </div>

            <div>
                <h3>Title</h3>              
                <p>Sample Data. Sample Data. Sample Data. Sample Data. Sample Data. Sample Data. Sample Data. Sample Data. Sample Data. Sample Data. Sample Data. Sample Data. Sample Data. Sample Data. </p>
            </div>
            
        </div>
        <aside class="col-sm-4">
            <div class="aside-element">
                <h3>Hobbies</h3>
                <p>I play piano and video games in my free time. Music is such a great part of life.</p>
            </div>
        </aside>

        <aside class="col-sm-4">
            <div class="aside-element">
                <h3>Sample</h3>
                <p>Sample Data. Sample Data. Sample Data. Sample Data. Sample Data. Sample Data. Sample Data. Sample Data. Sample Data. Sample Data. </p>
            </div>
        </aside>
    </div>
</asp:Content>

