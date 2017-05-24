var forecast = {
    forecastData: [],
    chart: null,
    isMetric: true,
    filter: "",

    updateMetric: function (isMetric) {
        this.isMetric = isMetric;
        this.buildChart(this.filter, this.forecastData.city.name);
    },

    isUnitMetric: function (unit) {
        switch (unit) {
            case "metric":
                return true;

            case "imperial":
                return false;
        }
    },

    isValidCode: function (code) {
        if (code == "200") {
            return true;
        }
        else {
            return false;
        }
    },

    queryForecast: function (cityName, successCallback, failureCallback, alwaysCallback) {
        $.getJSON("http://api.openweathermap.org/data/2.5/forecast?q=" + cityName + "&mode=json&units=metric&appid=6402e473e5743ba258ec0facd59dea01",
            function (data) {

            })
            .done(function (data) {
                if (this.isValidCode(data.cod)) {
                    this.forecastData = data;
                    successCallback(data);
                }
            }.bind(this))

            .fail(function (jqxhr, textStatus, error) {
                failureCallback(jqxhr, textStatus, error);
            })

            .always(function () {
                alwaysCallback();
            });      
    },

    getTemperaturePoints: function () {
        var points = [];
        var point = 0;
        this.forecastData.list.forEach(function (element) {
            if (this.isMetric) {
                point = element.main.temp;
            }
            else {
                point = parseFloat((element.main.temp * 1.8 + 32).toFixed(2));
            }
            points.push(point);
        }.bind(this));

        return points;
    },

    getHumidityPoints: function () {
        var points = [];
        this.forecastData.list.forEach(function (element) {
            points.push(element.main.humidity);
        }.bind(this));

        return points;
    },

    getPressurePoints: function () {
        var points = [];
        this.forecastData.list.forEach(function (element) {
            points.push(element.main.pressure);
        }.bind(this));

        return points;
    },

    getWindSpeedPoints: function () {
        var points = [];
        var point = 0;
        this.forecastData.list.forEach(function (element) {
            if (this.isMetric) {
                // convert from meters/second to km/h
                point = parseFloat((element.wind.speed * 3600 / 1000).toFixed(2));
            }
            else {
                // convert from meters/second to mph
                point = parseFloat((element.wind.speed * 2.2369).toFixed(2));
            }
            
            points.push(point);
        }.bind(this));

        return points;
    },
    /*
    getRainPoints: function () {
        var points = [];
        this.forecastData.list.forEach(function (element) {
            points.push(element.rain.3h);
        });

        return points;
    },

    getSnowPoints: function () {
        var points = [];
        this.forecastData.list.forEach(function (element) {
            points.push(element.snow.3h);
        });

        return points;
    },*/
    
    getCloudinessPoints: function () {
        var points = [];
        this.forecastData.list.forEach(function (element) {
            points.push(element.clouds.all);
        });

        return points;
    },

    updateChart: function (data, title, cityName, highlightLabel) {
        this.chart.series[0].setData(data);
        this.chart.setTitle(
            { text: cityName.charAt(0).toUpperCase() + cityName.slice(1) + " " + this.forecastData.city.country + ", " + title  },
            { text: document.ontouchstart === undefined ? 'Click and drag in the plot area to zoom in' : 'Pinch the chart to zoom in' });
        this.chart.yAxis[0].setTitle({ text: highlightLabel });
        this.chart.series[0].name = highlightLabel;

        this.chart.update({});
    },

    buildChart: function (cityName) {
        switch (this.filter) {
            case "temperature":
                var temperature = "Temperature";
                if (this.isMetric) {
                    temperature += " (°C)";
                }
                else {
                    temperature += " (°F)";
                }
                this.updateChart(this.getTemperaturePoints(), "Temperature Forecast", cityName, temperature);
                break;

            case "humidity":
                this.updateChart(this.getHumidityPoints(), "Humidity Forecast", cityName, "Humidity (%)");
                break;

            case "pressure":
                this.updateChart(this.getPressurePoints(), "Pressure Forecast", cityName, "Pressure (hPa)");
                break;

            case "windSpeed":
                var speed = "Speed";
                if (this.isMetric) {
                    speed += " (km/h)";
                }
                else {
                    speed += " (mph)";
                }
                this.updateChart(this.getWindSpeedPoints(), "Wind Speed Forecast", cityName, speed);
                break;

            case "cloudiness":
                this.updateChart(this.getCloudinessPoints(), "Cloud Coverage Forecast", cityName, "Coverage (%)");
                break;

                /*
            case "rain":
                this.updateChart(this.getRainPoints(), "5 Day Rain Volume Forecast", cityName, "Rainfall (mm)");
                break;

            case "snow":
                this.updateChart(this.getSnowPoints(), "5 Day Snow Volume Forecast", cityName, "Snowfall (mm)");
                break;*/
        }
    },

    initializeForecast: function (elementId) {
        this.chart = Highcharts.chart(elementId, {
            chart: {
                zoomType: 'x'
            },
            dateTimeLabelFormats: {               
                millisecond: '%H:%M',
                second: '%H:%M',
                minute: '%H:%M',
                hour: '%H:%M',
                day: '%e. %b',
                week: '%e. %b',
                month: '%b \'%y',
                year: '%Y'           
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