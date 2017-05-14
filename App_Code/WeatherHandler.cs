using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;

/// <summary>
/// Contains functions dealing with the handling and acquisition of weather data
/// </summary>
public class WeatherHandler
{
    public static string API_KEY = "6402e473e5743ba258ec0facd59dea01";

    public static XmlDocument GetWeatherFromCity(string cityName, out string urlString)
    {
        XmlDocument xdoc = new XmlDocument();
        string url = "http://api.openweathermap.org/data/2.5/weather?q=" + cityName + "&mode=xml&units=metric&appid=" + API_KEY;
        urlString = url;

        try
        {
            xdoc.Load(url);
        }
        catch(Exception e)
        {
            Console.Out.WriteLine(e.Message);
        }
        
        return xdoc;
    }
}