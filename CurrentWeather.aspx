<%@ Page Title="Current Weather" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="CurrentWeather.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style>
        .nav-tabs{
            padding-top: 40px;
        }

        @media screen and (min-width: 768){
            .widget ul{
                margin-right: 20px;
            }
        }
        .widget{
            padding: 0px 0px 30px 0px;
            width: 220px;
            display: inline-block;
        }
        .widget ul{
            display: inline-block;
            list-style-type: none;
            padding-left: 10px;
        }
        .widget img{
            float: left;
        }
        .widget ul li{
            width: auto;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="container">
        <ul class="nav nav-tabs">
            <li role="presentation" class="active"><a href="CurrentWeather.aspx">Current Weather</a></li>
            <li role="presentation"><a href="WeatherForecast.aspx">Weather Forecast</a></li>
        </ul>
        <div class="container">
            <aside class="pull-right col-sm-4 col-xs-12">
                <div class="aside-element">
                    <p>Powered by the OpenWeatherMap <a href="http://openweathermap.org/">API.</a></p>
                </div>
            </aside>
            <div class="container col-sm-8">
                <h1><%:Page.Title %></h1>            
                <div class="form-group">
                    <asp:TextBox ID="txtCity" runat="server" placeholder="City" CssClass="form-control city-name"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="This field is required." ControlToValidate="txtCity"></asp:RequiredFieldValidator>                    
                    <p><asp:Label ID="lblOutput" runat="server" Text=""></asp:Label></p>
                    <asp:Button ID="btnSubmit" runat="server" Text="Get Current Weather" OnClick="btnSubmit_Click" CssClass="btn btn-primary weather-submit" />
                </div>  
            </div>          
        </div>
        <asp:Panel runat="server" Visible="False" ID="panWidgets">
            <div class="panel-heading">
                <asp:Label ID="lblTitle" runat="server" Font-Size="XX-Large"></asp:Label>
                <asp:Image ID="imgIcon" runat="server" />
            </div>
            <div class="panel-body">
                <div class="widget">
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
                <div class="widget">
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
                <div class="widget">
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
            </div>
        </asp:Panel>  
    </div>  
</asp:Content>

