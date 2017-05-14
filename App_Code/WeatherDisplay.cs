using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Contains functions dealing with the presentation of weather information
/// </summary>
public class WeatherDisplay
{
    public static string TEMP_PREFIX_MIN = "Minimum Temperature:";
    public static string TEMP_PREFIX_CURRENT = "Current Temperature:";
    public static string TEMP_PREFIX_MAX = "Maximum Temperature:";

    public static string HUMIDITY_PREFIX = "Humidity:";
    public static string CLOUD_AMOUNT_PREFIX = "Cloud Coverage:";
    public static string CLOUD_DESCRIPTION_PREFIX = "Cloud Description:";

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
        return CLOUD_DESCRIPTION_PREFIX + " " + description;
    }

    public static string BuildHumidity(string humidity)
    {
        return HUMIDITY_PREFIX + " " + humidity;
    }
}