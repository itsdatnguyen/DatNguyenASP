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
        this.forecastData.forEach(function (element) {
            points.push(element.main.temp);
        });

        return points;
    },

    getHumidityPoints: function () {
        var points = [];
        this.forecastData.forEach(function (element) {
            points.push(element.main.humidity);
        });

        return points;
    },

    getPressurePoints: function () {
        var points = [];
        this.forecastData.forEach(function (element) {
            points.push(element.main.pressure);
        });

        return points;
    },

    getWindSpeedPoints: function () {
        var points = [];
        this.forecastData.forEach(function (element) {
            points.push(element.wind.speed);
        });

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

            case "humidity":
                this.updateChart(this.getHumidityPoints(), "5 Day Humidity Forecast", cityName, "Humidity (%)");
                break;

            case "pressure":
                this.updateChart(this.getPressurePoints(), "5 Day Pressure Forecast", cityName, "Pressure (hPa)");
                break;

            case "windSpeed":
                this.updateChart(this.getWindSpeedPoints(), "5 Day Wind Speed Forecast", cityName, "Speed (mph/h)");
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