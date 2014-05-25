function froggyPriceNegociatorUpdate()
{
    // Wait a few milliseconds (wait for the tab to be displayed), then calcul percent reduction
    setTimeout(function() {

        // Get current price
        var current_price = $(froggypricenegociator_current_price_field).val();
        if (!current_price)
            current_price = $(froggypricenegociator_current_price_field).text()

        if (fc_pn_type == 'PRICE_MINI')
        {
            // If "PRICE_MINI" is the configuration
            var price_min = $('#froggypricenegociator-price-min').val();
            var reduction_percent_max = 100 - (price_min * 100 / current_price);
            reduction_percent_max = Math.round(reduction_percent_max * 100) / 100;
            $('#froggypricenegociator-reduction-percent-max').html('- ' + reduction_percent_max + '%');
            $('#froggypricenegociator-reduction-percent-max-hidden').val(reduction_percent_max);
        }
        else
        {
            // IF "PERCENT" is the configuration
            var reduction_percent_max = $('#froggypricenegociator-reduction-percent-max').val();
            var price_min = current_price * ((100 - reduction_percent_max) / 100);
            price_min = Math.round(price_min * 100) / 100;
            $('#froggypricenegociator-price-min').html(price_min + ' ' + fc_pn_currency_sign);
            $('#froggypricenegociator-price-min-hidden').val(price_min);
        }

        // If general option is enabled
        if (fc_pn_enable_general_option == 1)
        {
            var price_min = current_price * ((100 - fc_pn_general_reduction) / 100);
            price_min = Math.round(price_min * 100) / 100;
            $('#froggypricenegociator_minimum_sell_price').text(price_min + ' ' + fc_pn_currency_sign);
        }

    }, 200);
}

function froggyPriceNegociatorOptionStatus()
{
    // If general option is enabled
    if (fc_pn_enable_general_option == 1)
    {
        $('.froggypricenegociator-label').addClass('disable');
        $('#froggypricenegociator-option').addClass('disable');
        $('#froggypricenegociator-price-min').addClass('disable');
        $('#froggypricenegociator-reduction-percent-max').addClass('disable');
        return false;
    }

    // Else depending if option is enabled for this product
    if ($('#froggypricenegociator-option').is(':checked'))
    {
        $('#froggypricenegociator-label-field-2').removeClass('disable');
        $('#froggypricenegociator-price-min').removeClass('disable');
        $('#froggypricenegociator-reduction-percent-max').removeClass('disable');
    }
    else
    {
        $('#froggypricenegociator-label-field-2').addClass('disable');
        $('#froggypricenegociator-price-min').addClass('disable');
        $('#froggypricenegociator-reduction-percent-max').addClass('disable');
    }
    return false;
}

function froggyPriceNegociatorInit()
{
    froggyPriceNegociatorOptionStatus();
    $('#froggypricenegociator-option').click(function() { froggyPriceNegociatorOptionStatus(); });
}

