using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;
using Weather.Data;
using Weather.UI;

public partial class Default2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session[WeatherForecast.CITY_NAME_KEY] != null)
        {
            /*txtCity.Text = (string)Session[WeatherForecast.CITY_NAME_KEY];
            GetWeather(txtCity.Text);*/
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //Session[WeatherForecast.CITY_NAME_KEY] = txtCity.Text;
        GetWeather(txtCity.Text);
        panWidgets.Visible = true;
    }

    public void GetWeather(string cityName)
    {
        PopulateCurrentWeather(cityName);
    }

    public void PopulateCurrentWeather(string cityName)
    {
        XDocument xdocument = WeatherForecast.QueryCurrentWeather(cityName);
        
        if (xdocument.Elements().Count() > 0)
        {
            if (SetTitle(xdocument) && SetWeatherWidget(xdocument) && SetCloudWidget(xdocument) && SetAirWidget(xdocument))
            {
                lblOutput.Text = "";
            }
            else
            {
                lblOutput.Text = "Error, failed to parse XML data";
            }
        }
        else
        {
            lblOutput.Text = "Error, city is invalid";
        }
    }

    public bool SetTitle(XDocument xdocument)
    {
        try
        {
            var cityName = (from i in xdocument.Descendants("city")
                         select new
                         {
                             CityName = (string)i.Attribute("name"),
                         }).Single();

            var weatherIcon = (from i in xdocument.Descendants("weather")
                               select new
                               {
                                   IconName = (string)i.Attribute("icon")
                               }).Single();

            var cityCountry = xdocument.Descendants().Where(n => n.Name == "country").First();

            lblTitle.Text = cityName.CityName + ", " + cityCountry.Value;
            imgIcon.ImageUrl = WeatherDisplay.BuildWeatherIconUrl(weatherIcon.IconName);
            
        }
        catch (Exception e)
        {
            Console.Out.WriteLine(e.Message);
            return false;
        }

        return true;
    }

    public bool SetAirWidget(XDocument xdocument)
    {
        try
        {
            var windItems = (from i in xdocument.Descendants("speed")
                                   select new
                                   {
                                       Description = (string)i.Attribute("name"),
                                       Speed = (string)i.Attribute("value")
                                   }).Single();

            var direction = (from i in xdocument.Descendants("direction")
                             select new
                             {
                                 Direction = (string)i.Attribute("code")
                             }).Single();

            var pressureItems = (from i in xdocument.Descendants("pressure")
                                 select new
                                 {
                                     Value = (string)i.Attribute("value"),
                                     Unit = (string)i.Attribute("unit")
                                 }).Single();

            lblWindDescription.Text = windItems.Description;
            lblWindAmount.Text = WeatherDisplay.BuildWind(windItems.Speed, direction.Direction);
            lblPressure.Text = WeatherDisplay.BuildPressure(pressureItems.Value, pressureItems.Unit);
        }
        catch (Exception e)
        {
            Console.Out.WriteLine(e.Message);
            return false;
        }
        return true;
    }

    public bool SetCloudWidget(XDocument xdocument)
    {
        try
        {
            var cloudItems = (from i in xdocument.Descendants("clouds")
                             select new
                             {
                                 Value = (int)i.Attribute("value"),
                                 Name = (string)i.Attribute("name")
                             }).Single();

            var humidity = (from i in xdocument.Descendants("humidity")
                           select new
                           {
                               Humidity = (string)i.Attribute("value")
                           }).Single();

            lblCloudAmount.Text = WeatherDisplay.BuildCloudAmount(cloudItems.Value);
            lblCloudDescription.Text = WeatherDisplay.BuildCloudDescription(cloudItems.Name);
            lblHumidity.Text = WeatherDisplay.BuildHumidity(humidity.Humidity);
        }
        catch(Exception e)
        {
            Console.Out.WriteLine(e.Message);
            return false;
        }
        return true;
    }

    public bool SetWeatherWidget(XDocument xdocument)
    {
        try
        {
            var temperatureItems = (from i in xdocument.Descendants("temperature")
                        select new
                        {
                            CurrentTemp = (string)i.Attribute("value"),
                            MinTemp = (string)i.Attribute("min"),
                            MaxTemp = (string)i.Attribute("max")
                        }).Single();

            lblCurrentTemp.Text = WeatherDisplay.BuildCurrentTemperature(temperatureItems.CurrentTemp);
            lblMinTemp.Text = WeatherDisplay.BuildMinTemperature(temperatureItems.MinTemp);
            lblMaxTemp.Text = WeatherDisplay.BuildMaxTemperature(temperatureItems.MaxTemp);
        }
        catch(Exception e)
        {
            Console.Out.WriteLine(e.Message);
            return false;
        } 

        return true;
    }
}