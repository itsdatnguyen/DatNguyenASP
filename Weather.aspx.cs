using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

public partial class Default2 : System.Web.UI.Page
{
    private USAWeather.ndfdXMLPortTypeClient weather;

    protected void Page_Load(object sender, EventArgs e)
    {
        weather = new USAWeather.ndfdXMLPortTypeClient();
        weather.Open();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        
    }

    protected void btnCities_Click(object sender, EventArgs e)
    {
        //string text = weather.LatLonListCityNames("2");



        string text = weather.CornerPoints("hawaii");
        lblCities.Text = text;

        /*string text = weather.GetCitiesByCountry(txtCityFinder.Text);

        StringReader sr = new StringReader(text);
        XmlTextReader xtr = new XmlTextReader(sr);
        DataSet ds = new DataSet();
        ds.ReadXml(xtr);
        ds.Merge(ds, true);

        if(ds.Tables.Count > 0)
        {
            gdvCities.DataSource = ds.Tables[0];
            gdvCities.DataBind();
        }*/


    }
}