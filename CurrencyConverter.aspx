<%@ Page Title="Currency Converter" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="CurrencyConverter.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="Scripts/converter.js"></script>

<script>
    function getWorldCurrencyRates (data) {
        converter.quotes = data.quotes;
    }

    $(document).ready(function () {
        converter.initializeConverter("getWorldCurrencyRates", [$("#currency-type-1"), $("#currency-type-2")]);

        converter.registerConversion($("#currency-amount-1"), $("#currency-amount-2"));
        converter.registerConversion($("#currency-amount-2"), $("#currency-amount-1"));   
    });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="container">        
        <div class="col-sm-8">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h1><%: Page.Title %></h1>
                </div>
                <div class="panel-body">
                    <form class="form-inline">
                        <div class="form-group">
                            <input class="form-control" id="currency-amount-1" type="text" aria-describedby="#currency-type-1" />
                            <select class="form-control" id="currency-type-1"></select>
                        </div>
                        <div class="form-group">
                            <input class="form-control" id="currency-amount-2" type="text" aria-describedby="#currency-type-2" />
                            <select class="form-control" id="currency-type-2"></select>
                        </div>
                    </form>
                </div>
            </div>
        </div>   
        <aside class="col-sm-4 col-xs-12 pull-right">
            <div class="aside-element">
                <p>Powered by <a href="https://currencylayer.com/">Currency Layer</a></p>
            </div>
        </aside>
    </div>
</asp:Content>

