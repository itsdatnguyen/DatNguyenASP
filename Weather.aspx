<%@ Page Title="" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="Weather.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="container">
        <%
            Response.Write("Version: " + System.Environment.Version.ToString());
%>
    <h1>This web service allows you to retrieve weather information for certain cities</h1>
    <div class="container">
        <h2>Using this form allows you to get the valid cities for this service by inserting a country name.</h2>
        <asp:Label ID="Label3" runat="server" Text="Country Name"></asp:Label>
        <asp:TextBox ID="txtCityFinder" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="btnCities" runat="server" Text="Get Cities" OnClick="btnCities_Click" />
        <br />
        <asp:Label ID="lblCities" runat="server"></asp:Label>
    </div>

    <div class="container">
        <h2>Inserting a valid city and country name will return the weather for that city.</h2>
        <p>You can use the service above this one to find a valid city for a certain country.</p>
        <asp:Label ID="Label1" runat="server" Text="City"></asp:Label>
        <asp:TextBox ID="txtCity" runat="server"></asp:TextBox>
        <br />

        <asp:Label ID="Label2" runat="server" Text="Country Name"></asp:Label>
        <asp:TextBox ID="txtCountry" runat="server"></asp:TextBox>
        <br />

        <asp:Button ID="btnSubmit" runat="server" Text="Get Weather" OnClick="btnSubmit_Click" />
        <br />
        <asp:Label ID="lblOutput" runat="server" Text=""></asp:Label>
        <br />
    </div>
        </div>
</asp:Content>

