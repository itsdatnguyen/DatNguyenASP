<%@ Page Title="Motivational Quote" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="MotivationalQuote.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="Scripts/utility.js"></script>
    <script>
        function setupQuotes(filename, callback) {
            $.getJSON(filename, function (data) {
                callback(data.quotes);
            });
        }

        function getRandomQuote(quotes) {
            var randomIndex = getRandomInt(0, quotes.length - 1);
            return quotes[randomIndex];
        }

        function displayRandomQuote(event) {
            var randomQuote = getRandomQuote(quotesObject);
            $(quoteClass).html(randomQuote[0]);
            $(quoteAuthorClass).html(randomQuote[1]);
        }

        var quotesObject;
        var quoteClass = ".quote";
        var quoteAuthorClass = ".quote-author";

        $(document).ready(function () {

            $("#get-random-quote").click(function (event) {
                displayRandomQuote();
                event.preventDefault();
            });

            setupQuotes("Content/motivationalquotes.txt", function (data) {
                $(".quote-container").removeClass("hidden");
                $(".loading-widget").addClass("hidden");

                quotesObject = data;
                displayRandomQuote();
            });           
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="container">
        <div class="col-sm-offset-2 col-sm-8">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h1><%: Page.Title %></h1>
                </div>
                <div class="loading-widget"></div>
                <div class="panel-body quote-container hidden">
                    <blockquote>
                        <p class="quote"></p>
                        <footer class="quote-author"></footer>
                    </blockquote>
                </div>
                <div class="panel-footer">
                    <input class="form-control" id="get-random-quote" type="submit" value="Get Random Quote"/>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

