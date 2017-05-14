<%@ Page Title="" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="Weather.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style>
        .widget ul{
            display: inline-block;
        }
        .widget ul li{
            width: 100%;
        }
        .widget img{
            margin-bottom: 40px;
        }
        .capitalize{
            text-transform: capitalize;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="container">
        
        <h1>Weather Finder</h1>
        <asp:Label ID="Label1" runat="server" Text="City"></asp:Label>
        <asp:TextBox ID="txtCity" runat="server"></asp:TextBox>
        <br />

        <asp:Button ID="btnSubmit" runat="server" Text="Get Weather" OnClick="btnSubmit_Click" />
        <br />
        <asp:Label ID="lblOutput" runat="server" Text=""></asp:Label>
        <br />
        <br />

        <asp:Panel ID="panWeatherWidget" runat="server" Visible="False">
            <div class="container">
                <asp:Label ID="lblTitle" runat="server" Font-Size="XX-Large"></asp:Label>
            </div>
            <div class="container widget col-sm-6" style="display:inline">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/images/thermometer.png" Width="50px" />
                <ul>
                    <li>
                        <asp:Label ID="lblMinTemp" runat="server" Text="Minimum Temperature:" Font-Size="Large"></asp:Label>
                    </li>
                    <li>
                        <asp:Label ID="lblCurrentTemp" runat="server" Text="Current Temperature:" Font-Size="Large"></asp:Label>
                    </li>
                    <li>
                        <asp:Label ID="lblMaxTemp" runat="server" Text="Maximum Temperature:" Font-Size="Large"></asp:Label>
                    </li>
                </ul>
            </div>
            <div class="container widget col-sm-6"" style="display:inline">
                <asp:Image ID="Image2" runat="server" ImageUrl="~/images/cloud.png" Width="50px" />
                <ul>
                    <li>
                        <asp:Label ID="lblCloudAmount" runat="server" Text="Amount:" Font-Size="Large"></asp:Label>
                    </li>
                    <li>
                        <asp:Label ID="lblCloudDescription" runat="server" Text="Description:" Font-Size="Large" CssClass="capitalize"></asp:Label>
                    </li>
                    <li>
                        <asp:Label ID="lblHumidity" runat="server" Text="Humidity:" Font-Size="Large" CssClass="capitalize"></asp:Label>
                    </li>
                </ul>
            </div>  
        </asp:Panel>
    </div>
    <br />
    <br />
    <div class="container">
        <asp:Label ID="lblUrl" runat="server"></asp:Label>
    </div>
    
</asp:Content>

