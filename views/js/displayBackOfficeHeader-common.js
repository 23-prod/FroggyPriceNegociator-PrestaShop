function froggyPriceNegociatorUpdatePercent()
{
    // Wait a few milliseconds (wait for the tab to be displayed), then calcul percent reduction
    setTimeout(function() {

        var current_price = $(froggypricenegociator_current_price_field).val();
        if (!current_price)
            current_price = $(froggypricenegociator_current_price_field).text()
        var price_min = $('#froggypricenegociator-price-min').val();
        var percent_reduction_max = 100 - (price_min * 100 / current_price);
        percent_reduction_max = Math.round(percent_reduction_max * 100) / 100;

        $('#froggypricenegociator-reduction-percent-max').html('- ' + percent_reduction_max + '%');
        $('#froggypricenegociator-reduction-percent-max-hidden').val(percent_reduction_max);

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

