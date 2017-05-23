<%@ Page Title="Weather Forecast" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="WeatherFinderChart.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style>
        .nav-tabs{
            padding-top: 40px;
        }
    </style>

    <script src="Scripts/highcharts.js"></script>
    <script src="Scripts/highcharts-more.js"></script>
    <script src="Scripts/forecast.js"></script>
    <script>       
        function clearChartFilters() {
            $(".filter").removeClass("active");
        }

        $(document).ready(function () {
            forecast.initializeForecast("forecast-chart");
            $(".chart-container").hide();

            $("#submit-city").click(function (ev) {
                var cityName = $(".city-name").val();
                forecast.queryForecast(cityName, function (data) {
                    forecast.buildChart("temperature", cityName);
                });

                $(".chart-container").show();
                ev.preventDefault();
            });

            $(".filter").click(function (element) {
                var target = element.currentTarget;
                clearChartFilters();
                target.className += " active";
                forecast.buildChart(target.id, $(".city-name").val());
            });
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="container">
        <ul class="nav nav-tabs">
            <li role="presentation"><a href="WeatherFinder.aspx">Current Weather</a></li>
            <li role="presentation" class="active"><a href="WeatherFinderChart.aspx">Weather Forecast</a></li>
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
                    <br />
                    <asp:Label ID="lblOutput" runat="server" Text=""></asp:Label>
                    <br />
                    <input type="submit" class="btn btn-primary" value="Get Forecast" id="submit-city"/>
                </div>  
            </div>          
        </div>      
        <div class="chart-container">
            <hr />
            <div class="container">
                <ul class="nav nav-pills">
                    <li class="active filter" id="temperature" role="presentation"><a><span>Temperature</span></a></li>
                    <li class="filter" id="humidity" role="presentation"><a><span>Humidity</span></a></li>
                    <li class="filter" id="pressure" role="presentation"><a><span>Pressure</span></a></li>
                    <li class="filter" id="windSpeed" role="presentation"><a><span>Wind Speed</span></a></li>
                </ul>
            </div>
            <div class="chart" id="forecast-chart"></div>
        </div>
    </div>
</asp:Content>

