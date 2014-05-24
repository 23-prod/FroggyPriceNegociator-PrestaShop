function froggyPriceNegociatorUpdatePercent()
{
    // Wait a few milliseconds (wait for the tab to be displayed), then calcul percent reduction
    setTimeout(function() {

        var current_price = $(froggypricenegociator_current_price_field).val();
        if (!current_price)
            current_price = $(froggypricenegociator_current_price_field).text()
        var price_min = $('#froggypricenegociator_price_min').val();
        var percent_reduction_max = 100 - (price_min * 100 / current_price);
        percent_reduction_max = Math.round(percent_reduction_max * 100) / 100;

        $('#froggypricenegociator_percent_reduction_max').html('- ' + percent_reduction_max + '%');

    }, 200);
}


