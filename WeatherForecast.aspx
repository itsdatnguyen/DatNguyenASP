<%@ Page Title="5 Day Weather Forecast" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="WeatherForecast.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style>
        .nav-tabs{
            padding-top: 40px;
        }
        .chart-modifier{
            display: inline;
        }
        .chart{
            margin-top: 20px;
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

        /**
         * Try to update form with cookies then run forecast query 
         */
        function loadCookies() {
            var cityName = readCookie("cityName");
            if (cityName != "undefined" && cityName) {
                $(".city-name").val(cityName);

                var unit = readCookie("unit");
                if (unit != "undefined" && unit) {
                    clearUnitButtons();
                    $("#" + unit).addClass("active");
                }

                var filter = readCookie("filter");
                if (filter != "undefined" && filter) {
                    clearChartFilters();
                    $("#" + filter).addClass("active");
                }
                queryCity(cityName);
            }
        }

        /**
         * Runs a forecast query with form element parameters
         * @param cityName 
         */
        function queryCity(cityName) {

            forecast.queryForecast(cityName, function (data) {
                var filter = $(".dropdown-filter").find($(".active")).attr("id");
                forecast.filter = filter;

                var unit = $(".dropdown-unit").find($(".active")).attr("id");
                forecast.isMetric = forecast.isUnitMetric(unit);

                forecast.buildChart(cityName);

                $("#city-output").html("");
                $(".chart-container").removeClass("hidden");

                createCookie("cityName", cityName, 2);

            }, function () {
                $("#city-output").html("City was not found.");
                $("#city-output").addClass("text-danger");

            }, function () {
                $(".loading-widget").addClass("hidden");
            });
        }

        $(document).ready(function () {
            forecast.initializeForecast("forecast-chart");
            loadCookies();

            $("#submit-city").click(function (ev) {
                $(".loading-widget").removeClass("hidden");
                $(".chart-container").addClass("hidden");

                queryCity($(".city-name").val());

                ev.preventDefault();
            });

            $(".filter").click(function (element) {
                clearChartFilters();
                $(this).addClass("active");

                forecast.filter = $(this).attr("id");
                forecast.buildChart($(".city-name").val());

                createCookie("filter", $(this).attr("id"), 2);
            });  

            $(".unit").click(function () {
                clearUnitButtons();
                $(this).addClass("active");

                createCookie("unit", $(this).attr("id"), 2);

                switch ($(this).attr("id")) {
                    case "metric":
                        forecast.updateMetric(true);
                        break;

                    case "imperial":
                        forecast.updateMetric(false);
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
            <div class="container col-sm-7">
                <h1><%:Page.Title %></h1>            
                <div class="form-group">
                    <form runat="server">
                        <asp:TextBox ID="txtCity" runat="server" placeholder="City" CssClass="form-control city-name"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="This field is required." ControlToValidate="txtCity"></asp:RequiredFieldValidator>                    
                        <p id="city-output"></p>
                        <input type="submit" class="btn btn-primary" value="Get Forecast" id="submit-city"/>
                    </form>
                </div>  
            </div>          
        </div>      
        <div class="loading-widget hidden"></div>
        <div class="chart-container hidden">
            <hr />      
            <div class="container">    
                <div class="dropdown chart-modifier">
                    <button class="btn btn-default dropdown-toggle" type="button" id="dropdown-menu-unit" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                        Units<span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu dropdown-unit" aria-labelledby="dropdown-menu-unit">
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
            <div class="chart box-shadow" id="forecast-chart"></div>
        </div>
    </div>
</asp:Content>

