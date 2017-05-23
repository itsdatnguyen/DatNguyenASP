using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weather.Data;

public partial class ForecastChart : System.Web.UI.UserControl
{
    private List<WeatherPoint> weatherPoints;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public void PopulateChart(List<float> data, string xAxisName, string yAxisName)
    {
        chtForecast.ChartAreas[0].AxisX.Title = xAxisName;
        chtForecast.ChartAreas[0].AxisY.Title = yAxisName;

        chtForecast.DataSource = data;
        chtForecast.DataBind();
    }
}