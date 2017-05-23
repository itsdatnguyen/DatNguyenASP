<%@ Page Title="Weather Forecast" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="WeatherForecast.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style>
        .nav-tabs{
            padding-top: 40px;
        }
        .chart-modifier{
            display: inline;
        }
    </style>
    <script src="Scripts/highcharts.js"></script>
    <script src="Scripts/highcharts-more.js"></script>
    <script src="Scripts/forecast.js"></script>
    <script>       
        function clearChartFilters() {
            $(".filter").removeClass("active");
        }

        function clearUnitButtons() {
            $(".unit").removeClass("active");
        }

        $(document).ready(function () {
            forecast.initializeForecast("forecast-chart");

            $("#submit-city").click(function (ev) {
                var cityName = $(".city-name").val();
                forecast.queryForecast(cityName, function (data) {
                    var filter = $(".dropdown-filter").find($(".active")).attr("id");
                    forecast.buildChart(filter, cityName);
                    $(".chart-container").removeClass("hidden");
                });

                ev.preventDefault();
            });

            $(".filter").click(function (element) {
                var target = element.currentTarget;
                clearChartFilters();
                target.className += " active";
                forecast.buildChart(target.id, $(".city-name").val());
            });  

            $(".unit").click(function () {
                clearUnitButtons();
                $(this).addClass("active");

                switch ($(this).attr("id")) {
                    case "metric":
                        forecast.setMetric(true);
                        break;

                    case "imperial":
                        forecast.setMetric(false);
                        break;
                }
            });
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="container">
        <ul class="nav nav-tabs">
            <li role="presentation"><a href="CurrentWeather.aspx">Current Weather</a></li>
            <li role="presentation" class="active"><a href="WeatherForecast.aspx">Weather Forecast</a></li>
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
        <div class="chart-container hidden">
            <hr />      
            <div class="container">    
                <div class="dropdown chart-modifier">
                    <button class="btn btn-default dropdown-toggle" type="button" id="dropdown-menu-unit" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                        Units<span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdown-menu-unit">
                        <li class="unit active" id="metric"><a>Metric</a></li>
                        <li class="unit" id="imperial"><a>Imperial</a></li>                      
                    </ul>
                </div>

                <div class="dropdown chart-modifier">
                    <button class="btn btn-default dropdown-toggle" type="button" id="dropdown-menu-filter" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                        Filters<span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu dropdown-filter" aria-labelledby="dropdown-menu-filter">
                        <li class="active filter" id="temperature"><a>Temperature</a></li>
                        <li class="filter" id="humidity"><a>Humidity</a></li>
                        <li class="filter" id="pressure"><a>Pressure</a></li>
                        <li class="filter" id="windSpeed"><a>Wind Speed</a></li>
                        <li class="filter" id="cloudiness"><a>Cloud Coverage</a></li>
                    </ul>
                </div>
            </div>
            <div class="chart" id="forecast-chart"></div>
        </div>
    </div>
</asp:Content>

