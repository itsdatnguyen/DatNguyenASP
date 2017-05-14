<%@ Page Title="" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="Weather.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style>
        .widget ul{
            display: inline-block;
        }
        .widget img{
            float: left;
        }
        .widget ul li{
            width: 100%;
        }
        .capitalize{
            text-transform: capitalize;
        }
        .widget-title{
            margin-bottom:20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="container">      
        <h1>Weather Finder</h1>
        <div class="container">
            <div class="form-group col-sm-4">
                <asp:TextBox ID="txtCity" runat="server" placeholder="City" CssClass="form-control"></asp:TextBox>
                <br />
                <asp:Button ID="btnSubmit" runat="server" Text="Get Weather" OnClick="btnSubmit_Click" CssClass="btn btn-primary" />
                <br />
                <asp:Label ID="lblOutput" runat="server" Text=""></asp:Label>
            </div>
        </div>
        <asp:Panel ID="panWeatherWidget" runat="server" Visible="False">
            <hr />
            <div class="container widget-title">
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
            <div class="container widget col-sm-6" style="display:inline">
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

