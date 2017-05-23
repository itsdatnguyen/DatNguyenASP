<%@ Page Title="Weather Forecast" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="WeatherFinderChart.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style>
        .nav-tabs{
            padding-top: 40px;
        }
    </style>

    <script src="Scripts/highcharts.js"></script>
    <script src="Scripts/highcharts-more.js"></script>
    <script>
        var forecast = {
            forecastData: [],
            chart: null,
            elementId: "",

            queryForecast: function (cityName, callback) {
                $.getJSON("http://api.openweathermap.org/data/2.5/forecast?q=" + cityName + "&mode=json&units=metric&appid=6402e473e5743ba258ec0facd59dea01",
                    function (data) {
                        this.forecastData = data.list;
                        callback(data.list);
                }.bind(this));
            },

            getTemperaturePoints: function () {
                var points = [];

                var currentTime = null;
                this.forecastData.forEach(function (element) {
                    points.push(element.main.temp);
                   // points.push([element.dt, element.main.temp]);
                    //element.dt_txt.substring(0, 10)
                });
                console.log(JSON.stringify(points));
                return points;
            },

            updateChart: function (data, title, cityName, highlightLabel) {
                this.chart.series[0].setData(data, true);
                this.chart.setTitle({ text: title }, { text: cityName.charAt(0).toUpperCase() + cityName.slice(1) });
                this.chart.yAxis[0].setTitle({ text: highlightLabel });
                this.chart.series[0].name = highlightLabel;
            },

            buildChart: function (filter, cityName) {
                switch (filter) {
                    case "temperature":
                        this.updateChart(this.getTemperaturePoints(), "5 Day Temperature Forecast", cityName, "Temperature (°C)");
                        break;

                    
                }
            },

            initializeForecast: function (elementId) {
                this.elementId = elementId;
                this.chart = Highcharts.chart(elementId, {
                    chart: {
                        zoomType: 'x'
                    },
                    subtitle: {
                        text: document.ontouchstart === undefined ?
                            'Click and drag in the plot area to zoom in' : 'Pinch the chart to zoom in'
                    },
                    xAxis: {
                        type: 'datetime'                       
                    },
                    legend: {
                        enabled: false
                    },
                    plotOptions: {
                        area: {
                            fillColor: {
                                linearGradient: {
                                    x1: 0,
                                    y1: 0,
                                    x2: 0,
                                    y2: 1
                                },
                                stops: [
                                    [0, Highcharts.getOptions().colors[0]],
                                    [1, Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
                                ]
                            },
                            marker: {
                                radius: 2
                            },
                            lineWidth: 1,
                            states: {
                                hover: {
                                    lineWidth: 1
                                }
                            },
                            threshold: null
                        }
                    },

                    series: [{
                        pointStart: Date.now(),
                        pointInterval: 1000 * 3600 * 3,
                        type: 'area'
                    }]
                });
            }
        }

        $(document).ready(function () {
            forecast.initializeForecast("forecast-chart");
            $(".chart").hide();

            $("#submit-city").click(function (ev) {
                var cityName = $(".city-name").val();
                forecast.queryForecast(cityName, function (data) {
                    forecast.buildChart("temperature", cityName);
                    console.log(data);
                });

                $(".chart").show();
                ev.preventDefault();
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
            <div class="chart" id="forecast-chart">

            </div>
        </div>
    </div>

</asp:Content>

