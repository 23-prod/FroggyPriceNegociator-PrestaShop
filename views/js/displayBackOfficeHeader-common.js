/**
 * 2013-2014 Froggy Commerce
 *
 * NOTICE OF LICENSE
 *
 * You should have received a licence with this module.
 * If you didn't buy this module on Froggy-Commerce.com, ThemeForest.net
 * or Addons.PrestaShop.com, please contact us immediately : contact@froggy-commerce.com
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to benefit the updates
 * for newer PrestaShop versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 *  @author Froggy Commerce <contact@froggy-commerce.com>
 *  @copyright  2013-2014 Froggy Commerce
 */

function froggyPriceNegociatorUpdate(combination)
{
    // Set combination identifier, if we are on a combination edition
    var combination_identifier = '';
    if (combination)
        combination_identifier = 'combination-';

    // Get current price
    var current_price = $(froggypricenegociator_current_price_field).val();
    if (!current_price)
        current_price = $(froggypricenegociator_current_price_field).text()
    if (combination)
    {
        var current_price = $(froggypricenegociator_current_price_combination_field).val();
        if (!current_price)
            current_price = $(froggypricenegociator_current_price_combination_field).text()
    }

    // Wait a few milliseconds (wait for the tab to be displayed), then calcul percent reduction
    setTimeout(function() {

        if (fc_pn_type == 'PRICE_MINI')
        {
            // If "PRICE_MINI" is the configuration
            var price_min = $('#froggypricenegociator-' + combination_identifier + 'price-min').val();
            var reduction_percent_max = 100 - (price_min * 100 / current_price);
            reduction_percent_max = Math.round(reduction_percent_max * 100) / 100;
            $('#froggypricenegociator-' + combination_identifier + 'reduction-percent-max').html('- ' + reduction_percent_max + '%');
            $('#froggypricenegociator-' + combination_identifier + 'reduction-percent-max-hidden').val(reduction_percent_max);
        }
        else
        {
            // IF "PERCENT" is the configuration
            var reduction_percent_max = $('#froggypricenegociator-' + combination_identifier + 'reduction-percent-max').val();
            var price_min = current_price * ((100 - reduction_percent_max) / 100);
            price_min = Math.round(price_min * 100) / 100;
            $('#froggypricenegociator-' + combination_identifier + 'price-min').html(price_min + ' ' + fc_pn_currency_sign);
            $('#froggypricenegociator-' + combination_identifier + 'price-min-hidden').val(price_min);
        }

        // If general option is enabled
        if (fc_pn_enable_general_option == 1)
        {
            var price_min = current_price * ((100 - fc_pn_general_reduction) / 100);
            price_min = Math.round(price_min * 100) / 100;
            $('#froggypricenegociator-' + combination_identifier + 'minimum-sell-price').text(price_min + ' ' + fc_pn_currency_sign);
        }

    }, 200);
}

function froggyPriceNegociatorOptionStatus(combination)
{
    // Set combination identifier, if we are on a combination edition
    var combination_identifier = '';
    if (combination)
        combination_identifier = 'combination-';

    // If general option is enabled
    if (fc_pn_enable_general_option == 1)
    {
        $('#froggypricenegociator-' + combination_identifier + 'checkbox-details').fadeOut(500);
        $('#froggypricenegociator-' + combination_identifier + 'details').fadeOut(500);
        return false;
    }

    // Else depending if option is enabled for this product
    if ($('#froggypricenegociator-' + combination_identifier + 'option').is(':checked'))
        $('#froggypricenegociator-' + combination_identifier + 'details').fadeIn(500);
    else
        $('#froggypricenegociator-' + combination_identifier + 'details').fadeOut(500);
    return false;
}

function froggyPriceNegociatorInit(combination)
{
    // Set combination identifier, if we are on a combination edition
    var combination_identifier = '';
    if (combination)
        combination_identifier = 'combination-';

    froggyPriceNegociatorOptionStatus(combination);
    $('#froggypricenegociator-' + combination_identifier + 'option').click(function() { froggyPriceNegociatorOptionStatus(combination); });
}

