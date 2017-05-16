<%@ Page Title="Currency Converter" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="CurrencyConverter.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="Scripts/currencyconverter.js"></script>

<script>
    // function must be in global scope for JSONP to work
    function getWorldCurrencyRates (data) {
        converter.quotes = data.quotes;
        console.log(converter.quotes);
    }

    var converter = {
        key: "64ee3e0e3059f67b253bb4632781bb03",
        quotes: {},

        getWorldCurrencies: function (callback) {
            $.getJSON("http://apilayer.net/api/list?access_key=" + this.key, function (data) {
                callback(data);
            });
        },

        populateCurrencyDropdowns: function (data, dropdowns) {      
            var currencies = data.currencies;

            for (var i = 0; i < dropdowns.length; i++) {
                Object.keys(currencies).forEach(function (element, index) {
                    dropdowns[i].append($("<option></option").attr("value", element).html(currencies[element]));
                });
            };
        },

        calculateConversion: function (currentConversionObject, otherConversionObject) {
            var currentConversionTotal = parseFloat(currentConversionObject.value) / (currentConversionObject.rate);
            return currentConversionTotal * parseFloat(otherConversionObject.rate);
        },

        registerConversion: function ($changedElement, $elementToChange) {
            $changedElement.on('input paste', function () {
                if (!isNaN($changedElement.val())) {
                    changedElementConversion = this.buildConversionObject($($changedElement.attr("aria-describedby")), $changedElement);
                    elementToChangeConversion = this.buildConversionObject($($elementToChange.attr("aria-describedby")), $elementToChange);

                    var otherElementValue = this.calculateConversion(changedElementConversion, elementToChangeConversion);
                    $elementToChange.val(otherElementValue);
                }
            }.bind(this));
        },

        initializeConverter: function (callbackName, dropdowns) {
            this.getWorldCurrencies(function (data) {
                this.populateCurrencyDropdowns(data, dropdowns);
            }.bind(this));

            var script = document.createElement('script');
            script.src = "http://apilayer.net/api/live?access_key=" + this.key + "&callback=" + callbackName + "&format=1";
            document.body.appendChild(script);
        },

        getRate: function (currencyCode) {
            return this.quotes[currencyCode];
        },

        buildConversionObject: function ($selectElement, $inputElement) {
            var rate = this.quotes["USD" + $selectElement.val()];
            var value = $inputElement.val();
            if (value == "") {
                value = 0;
            }
            return this.createConversionObject(rate, value);
        },

        createConversionObject: function (rate, value) {
            return {
                rate: rate,
                value: value
            }
        }
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
        <div class="panel panel-default">
            <div class="panel-heading">
                <h1><%: Page.Title %></h1>
            </div>
            <div class="panel-body">
                <form class="form-inline">
                    <div class="">
                        <input id="currency-amount-1" type="text" aria-describedby="#currency-type-1" />
                        <select id="currency-type-1"></select>
                    </div>
                    <div class="">
                        <input id="currency-amount-2" type="text" aria-describedby="#currency-type-2" />
                        <select id="currency-type-2"></select>
                    </div>
                </form>
            </div>
        </div>
    </div>
</asp:Content>

