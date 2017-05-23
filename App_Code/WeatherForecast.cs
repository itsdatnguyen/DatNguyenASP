using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;
using Weather.Data;
using System.Xml.Linq;

/// <summary>
/// Can forecast weather and process weather information
/// </summary>
namespace Weather.Data
{ 
    public class WeatherForecast
    {
        public static string API_KEY = "6402e473e5743ba258ec0facd59dea01";

        public static string CITY_NAME_KEY = "cityName";

        public WeatherForecast()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public static XDocument QueryCurrentWeather(string cityName)
        {
            XDocument xdoc = new XDocument();
            string url = "http://api.openweathermap.org/data/2.5/weather?q=" + cityName + "&mode=xml&units=metric&appid=" + API_KEY;

            try
            {
                xdoc = XDocument.Load(url);
            }
            catch (Exception e)
            {
                Console.Out.WriteLine(e.Message);
            }

            return xdoc;
        }

        public static List<WeatherPoint> QueryWeatherForecast(string cityName)
        {
            List<WeatherPoint> list = new List<WeatherPoint>();
            XDocument xdoc = new XDocument();

            try
            {
                xdoc = XDocument.Load("http://api.openweathermap.org/data/2.5/forecast?q=" + cityName + "&mode=xml&units=metric&appid=" + API_KEY);
            }
            catch(Exception e)
            {
                Console.Out.WriteLine("Retreiving XML data failed: " + e.Message);
            }

            string a = xdoc.ToString();

            // create anomymous object through super long linq statement
            var forecasts = from i in xdoc.Descendants("time")
                            select new
                            {
                                BeginTime = (string)i.Attribute("from"),

                                // @todo Precipitation. Sometimes theses attributes dont exist.
                                //PrecipitationValue = (float)i.Element("precipitation").Attribute("value"),
                                //PrecipitationType = (string)i.Element("precipitation").Attribute("type"),

                                WindDegree = (float)i.Element("windDirection").Attribute("deg"),
                                WindCode = (string)i.Element("windDirection").Attribute("code"),
                                WindDirectionDescription = (string)i.Element("windDirection").Attribute("name"),

                                WindSpeed = (float)i.Element("windSpeed").Attribute("mps"),
                                WindDescription = (string)i.Element("windSpeed").Attribute("name"),

                                CurrentTemperature = (float)i.Element("temperature").Attribute("value"),
                                MinTemperature = (float)i.Element("temperature").Attribute("min"),
                                MaxTemperature = (float)i.Element("temperature").Attribute("max"),

                                Pressure = (float)i.Element("pressure").Attribute("value"),

                                Humidity = (int)i.Element("humidity").Attribute("value"),

                                CloudDescription = (string)i.Element("clouds").Attribute("value"),
                                CloudCoverage = (int)i.Element("clouds").Attribute("all")
                            };

            WeatherPoint point;
            
            try
            {
                foreach (var item in forecasts)
                {
                    point = new WeatherPoint(DateTime.Parse(item.BeginTime.Substring(0, 9)),
                        //item.PrecipitationValue != null ? item.PrecipitationValue : 0,
                        //item.PrecipitationType != null ? item.PrecipitationType : "",
                        0,
                        "",
                        item.WindDegree,
                        item.WindCode,
                        item.WindDirectionDescription,
                        item.WindSpeed,
                        item.WindDescription,
                        item.CurrentTemperature,
                        item.MinTemperature,
                        item.MaxTemperature,
                        item.Pressure,
                        item.Humidity,
                        item.CloudDescription,
                        item.CloudCoverage);

                    list.Add(point);
                }
            }
            catch(Exception e)
            {
                Console.Out.WriteLine("Retrieving LINQ data failed: " + e.Message);
            }         

            return list;
        }    
    }
}