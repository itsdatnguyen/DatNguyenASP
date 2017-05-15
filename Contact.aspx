<%@ Page Title="Contact" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Default3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="container">
        <h1><%:Page.Title %></h1>
        <address>
            <strong>Dat Nguyen</strong><br>
            123 Avenue Ave.<br>
            Siberia, 12G4<br>
            <abbr title="Phone">P:</abbr> (123) 456-7890
        </address>

        <address>
            <strong>Dat Nguyen</strong><br>
            <a href="mailto:#">dat.nguyen.quang7@gmail.com</a>
        </address>
    </div>
</asp:Content>

