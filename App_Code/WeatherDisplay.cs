using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Contains functions dealing with the presentation of weather information
/// </summary>
public class WeatherDisplay
{
    public static string TEMP_PREFIX_MIN = "Minimum:";
    public static string TEMP_PREFIX_CURRENT = "Current:";
    public static string TEMP_PREFIX_MAX = "Maximum:";

    public static string HUMIDITY_PREFIX = "Humidity:";
    public static string CLOUD_AMOUNT_PREFIX = "Coverage:";
    public static string CLOUD_DESCRIPTION_PREFIX = "Description:";
    

    public static string BuildWeatherIconUrl(string iconName)
    {
        return "http://openweathermap.org/img/w/" + iconName + ".png";
    }

    public static string BuildWind(string speed, string direction)
    {
        return speed + "km/h, " + direction;
    }

    public static string BuildPressure(string value, string unit)
    {
        return value + " " + unit;
    }

    public static string BuildCurrentTemperature(string temperature)
    {
        return TEMP_PREFIX_CURRENT + " " + temperature + " °C";
    }

    public static string BuildMinTemperature(string temperature)
    {
        return TEMP_PREFIX_MIN + " " + temperature + " °C";
    }

    public static string BuildMaxTemperature(string temperature)
    {
        return TEMP_PREFIX_MAX + " " + temperature + " °C";
    }

    public static string BuildCloudAmount(int amount)
    {
        return CLOUD_AMOUNT_PREFIX + " " + amount + "%";
    }

    public static string BuildCloudDescription(string description)
    {
        return description;
    }

    public static string BuildHumidity(string humidity)
    {
        return HUMIDITY_PREFIX + " " + humidity + "%";
    }
}