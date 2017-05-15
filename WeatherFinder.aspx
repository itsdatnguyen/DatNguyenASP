<%@ Page Title="" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="WeatherFinder.aspx.cs" Inherits="Default2" %>

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
        .widget-title{
            margin-bottom:20px;
        }

        .row{
            width: 100%;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="container">     
        <div class="container">
            <div class="container col-sm-8">
                <h1>Weather Finder</h1>
                <div class="form-group col-sm-8">
                    <asp:TextBox ID="txtCity" runat="server" placeholder="City" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="This field is required." ControlToValidate="txtCity"></asp:RequiredFieldValidator>
                    <br />
                    <asp:Label ID="lblOutput" runat="server" Text=""></asp:Label>
                    <br />
                    <asp:Button ID="btnSubmit" runat="server" Text="Get Weather" OnClick="btnSubmit_Click" CssClass="btn btn-primary" />
                </div>  
            </div>
            <aside class="pull-right col-sm-4 col-xs-12">
                <div class="aside-element">
                    <p>Powered by the OpenWeatherMap <a href="http://openweathermap.org/">API.</a></p>
                </div>
            </aside>
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
                        <asp:Label ID="lblCloudDescription" runat="server" Font-Size="Medium" CssClass="text-capitalize"></asp:Label>
                    </li>
                    <li>
                        <asp:Label ID="lblHumidity" runat="server" Font-Size="Medium"></asp:Label>
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
        <div class="container">
            <asp:Label ID="lblUrlPrefix" runat="server"></asp:Label>
            <asp:HyperLink ID="lnkUrl" runat="server" Visible="False">[lnkUrl]</asp:HyperLink>          
        </div>                      
    </div>  
</asp:Content>

