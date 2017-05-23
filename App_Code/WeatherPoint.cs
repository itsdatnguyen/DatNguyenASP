using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// A physical representation of 
/// </summary>
namespace Weather.Data
{
    public class WeatherPoint
    {
        public WeatherPoint(DateTime beginTime, float precipitation, string precipitationType, float windDegree, string windCode, string windDirectionDescription, float windSpeed, string windDescription, float temperature, float temperatureMinimum, float temperatureMaximum, float pressure, int humidity, string cloudDescription, int cloudCoverage)
        {
            BeginTime = beginTime;
            Precipitation = precipitation;
            PrecipitationType = precipitationType;
            WindDegree = windDegree;
            WindCode = windCode;
            WindDirectionDescription = windDirectionDescription;
            WindSpeed = windSpeed;
            WindDescription = windDescription;
            Temperature = temperature;
            TemperatureMinimum = temperatureMinimum;
            TemperatureMaximum = temperatureMaximum;
            Pressure = pressure;
            Humidity = humidity;
            CloudDescription = cloudDescription;
            CloudCoverage = cloudCoverage;
        }

        public DateTime BeginTime { get; set; }

        // Precipitation is in % from 0 to 1
        public float Precipitation { get; set; }
        public string PrecipitationType { get; set; }

        public float WindDegree { get; set; }
        public string WindCode { get; set; }
        public string WindDirectionDescription { get; set; }
        
        public float WindSpeed { get; set; }
        public string WindDescription { get; set; }

        // Temperature is in Celsius
        public float Temperature { get; set; }
        public float TemperatureMinimum { get; set; }
        public float TemperatureMaximum { get; set; }

        // Pressure is in hPa
        public float Pressure { get; set; }

        // Humidity is in %
        public int Humidity { get; set; }

        public string CloudDescription { get; set; }
        // Coverage is in %
        public int CloudCoverage { get; set; }
    }
}