<%@ Page Title="" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="Weather.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style>
        .widget-title img{
            padding-left: 20px;
        }

        .widget{
            padding: 0px 50px 30px 0px;
            width: auto;
            display: inline-block;
        }
        .widget ul{
            display: inline-block;
        }
        .widget img{
            float: left;
        }
        .widget ul li{
            width: auto;
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
            <div class="form-group col-sm-6">
                <asp:TextBox ID="txtCity" runat="server" placeholder="City" CssClass="form-control"></asp:TextBox>
                <br />
                <asp:Button ID="btnSubmit" runat="server" Text="Get Weather" OnClick="btnSubmit_Click" CssClass="btn btn-primary" />
                <br />
                <asp:Label ID="lblOutput" runat="server" Text=""></asp:Label>
            </div>
        </div>
        <asp:Panel ID="panWeatherWidget" runat="server" Visible="False" style="margin-bottom: 0px">
            <hr />
            <div class="container widget-title">
                <asp:Label ID="lblTitle" runat="server" Font-Size="XX-Large"></asp:Label>
                <asp:Image ID="imgIcon" runat="server" />
            </div>
            <div class="container widget">
                <asp:Image runat="server" ImageUrl="~/images/thermometer.png" Width="50px"></asp:Image>
                <ul>
                    <li>
                        <asp:Label ID="lblMinTemp" runat="server" Font-Size="Medium"></asp:Label>
                    </li>
                    <li>
                        <asp:Label ID="lblCurrentTemp" runat="server" Font-Size="Medium"></asp:Label>
                    </li>
                    <li>
                        <asp:Label ID="lblMaxTemp" runat="server" Font-Size="Medium"></asp:Label>
                    </li>
                </ul>
            </div>
            <div class="container widget">
                <asp:Image runat="server" ImageUrl="~/images/cloud.png" Width="50px"></asp:Image>
                <ul>
                    <li>
                        <asp:Label ID="lblCloudAmount" runat="server" Font-Size="Medium"></asp:Label>
                    </li>
                    <li>
                        <asp:Label ID="lblCloudDescription" runat="server" Font-Size="Medium" CssClass="capitalize"></asp:Label>
                    </li>
                    <li>
                        <asp:Label ID="lblHumidity" runat="server" Font-Size="Medium" CssClass="capitalize"></asp:Label>
                    </li>
                </ul>
            </div> 
            <div class="container widget">
                <asp:Image ID="Image3" runat="server" ImageUrl="~/images/wind.png" Width="50px" />
                <ul>
                    <li>
                        <asp:Label ID="lblWindDescription" runat="server" Font-Size="Medium"></asp:Label>
                    </li>
                    <li>
                        <asp:Label ID="lblWindAmount" runat="server" Font-Size="Medium"></asp:Label>
                    </li>
                    <li>
                        <asp:Label ID="lblPressure" runat="server"  Font-Size="Medium"></asp:Label>
                    </li>
                </ul>
            </div> 
        </asp:Panel>
    </div>
    <br />
    <br />
    <div class="container">
        <asp:Label ID="lblUrlPrefix" runat="server"></asp:Label>
        <asp:HyperLink ID="lnkUrl" runat="server" Visible="False">[lnkUrl]</asp:HyperLink>
    </div>
    
</asp:Content>

