<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ForecastChart.ascx.cs" Inherits="ForecastChart" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Chart ID="chtForecast" runat="server" Height="400px" Width="400px">
    <Series>
        <asp:Series Name="Series"></asp:Series>
    </Series>
    <ChartAreas>
        <asp:ChartArea Name="ChartArea"></asp:ChartArea>
    </ChartAreas>
</asp:Chart>
