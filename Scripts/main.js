$(document).ready(function () {
    $.getJSON("Content/catfacts.txt", function (data) {
        var randomIndex = getRandomInt(0, data.length - 1);
        $(".cat-facts").html(data[randomIndex]);
    });
});