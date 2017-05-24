function getWorldCurrencyRates(data) {
    converter.quotes = data.quotes;
}

var converter = {
    key: "64ee3e0e3059f67b253bb4632781bb03",
    quotes: {},
    onFinishEvent: null,

    // gets all the world currencies
    getWorldCurrencies: function (callback) {
        $.getJSON("http://apilayer.net/api/list?access_key=" + this.key, function (data) {
            callback(data);
        });
    },

    // fills all given dropdown select elements with the values in currencies array
    populateCurrencyDropdowns: function (currencies, dropdowns) {
        for (var i = 0; i < dropdowns.length; i++) {
            Object.keys(currencies).forEach(function (element, index) {
                dropdowns[i].append($("<option></option").attr("value", element).html(currencies[element]));
            });
        };

        if (this.onFinishEvent != null) {
            this.onFinishEvent();
        }
    },

    // converts currency from the first conversion object to the second
    calculateConversion: function (currentConversionObject, otherConversionObject) {
        var currentConversionTotal = parseFloat(currentConversionObject.value) / (currentConversionObject.rate);
        return currentConversionTotal * parseFloat(otherConversionObject.rate);
    },

    // registers conversion functionality
    registerConversion: function ($changedInput, $inputToChange) {
        $changedInput.on('input paste', function () {
            if (!isNaN($changedInput.val())) {
                this.updateValues($changedInput, $inputToChange);
            }
        }.bind(this));

        this.getSelectFromInput($changedInput).change(function (event) {
            this.updateValues($changedInput, $inputToChange);
        }.bind(this));
    },

    getSelectFromInput: function ($input) {
        return $($input.attr("aria-describedby"));
    },

    // updates $inputToChange based on the value and rate of $changedInput
    updateValues: function ($changedInput, $inputToChange) {
        changedElementConversion = this.buildConversionObject(this.getSelectFromInput($changedInput), $changedInput);
        elementToChangeConversion = this.buildConversionObject(this.getSelectFromInput($inputToChange), $inputToChange);

        var otherElementValue = this.calculateConversion(changedElementConversion, elementToChangeConversion).toFixed(2);
        $inputToChange.val(otherElementValue);
    },

    initializeConverter: function (dropdowns) {
        this.getWorldCurrencies(function (data) {
            this.populateCurrencyDropdowns(data.currencies, dropdowns);
        }.bind(this));

        var script = document.createElement('script');
        script.src = "http://apilayer.net/api/live?access_key=" + this.key + "&callback=getWorldCurrencyRates&format=1";
        document.body.appendChild(script);
    },

    // builds a conversion object with a given text box and dropdown menu
    buildConversionObject: function ($selectElement, $inputElement) {
        var rate = this.quotes["USD" + $selectElement.val()];
        var value = $inputElement.val();
        if (value == "") {
            value = 0;
        }
        return this.createConversionObject(rate, value);
    },

    // returns a conversion object
    createConversionObject: function (rate, value) {
        return {
            rate: rate,
            value: value
        }
    },

    addOnFinishListener: function (callback) {
        this.onFinishEvent = callback;
    }
}
