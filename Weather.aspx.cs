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

public partial class Default2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string stringUrl;
        XmlDocument xdoc = WeatherHandler.GetWeatherFromCity(txtCity.Text, out stringUrl);

        if(xdoc.HasChildNodes && SetWeatherWidget(xdoc) && SetCloudWidget(xdoc) && SetTitle(xdoc))
        {
            lblOutput.Text = "";
            panWeatherWidget.Visible = true;
        }
        else
        {
            lblOutput.Text = "Error, city is invalid";
        }

        lblUrl.Text = "This is the url used to get the weather data: " + stringUrl;       
    }

    public bool SetTitle(XmlDocument xmldoc)
    {
        try
        {
            XDocument xdocument = XDocument.Parse(xmldoc.OuterXml);

            var items = from i in xdocument.Descendants("city")
                        select new
                        {
                            CityName = (string)i.Attribute("name"),

                        };

            foreach (var item in items)
            {
                lblTitle.Text = item.CityName;
            }
        }
        catch (Exception e)
        {
            Console.Out.WriteLine(e.Message);
            return false;
        }

        return true;
    }

    public bool SetCloudWidget(XmlDocument xmldoc)
    {
        try
        {
            XDocument xdocument = XDocument.Parse(xmldoc.OuterXml);

            var cloudItems = from i in xdocument.Descendants("clouds")
                             select new
                             {
                                 Value = (int)i.Attribute("value"),
                                 Name = (string)i.Attribute("name")
                             };
            var humidity = from i in xdocument.Descendants("humidity")
                           select new
                           {
                               Humidity = (string)i.Attribute("value")
                           };

            foreach(var item in cloudItems)
            {
                lblCloudAmount.Text = WeatherDisplay.BuildCloudAmount(item.Value);
                lblCloudDescription.Text = WeatherDisplay.BuildCloudDescription(item.Name);
            }
            foreach(var item in humidity)
            {
                lblHumidity.Text = WeatherDisplay.BuildHumidity(item.Humidity);
            }
        }
        catch(Exception e)
        {
            Console.Out.WriteLine(e.Message);
            return false;
        }
        return true;
    }

    public bool SetWeatherWidget(XmlDocument xmldoc)
    {
        try
        {
            XDocument xdocument = XDocument.Parse(xmldoc.OuterXml);

            var items = from i in xdocument.Descendants("temperature")
                        select new
                        {
                            CurrentTemp = (string)i.Attribute("value"),
                            MinTemp = (string)i.Attribute("min"),
                            MaxTemp = (string)i.Attribute("max")
                        };

            foreach (var item in items)
            {
                lblCurrentTemp.Text = WeatherDisplay.BuildCurrentTemperature(item.CurrentTemp);
                lblMinTemp.Text = WeatherDisplay.BuildMinTemperature(item.MinTemp);
                lblMaxTemp.Text = WeatherDisplay.BuildMaxTemperature(item.MaxTemp);
            }
        }
        catch(Exception e)
        {
            Console.Out.WriteLine(e.Message);
            return false;
        } 

        return true;
    }
}