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

/**
 *  Init var
 *  Define selectors for product price and product attribute price)
 */
var froggypricenegociator_current_price_field = '#finalPrice';
var froggypricenegociator_current_price_combination_field = '#attribute_new_total_price';


/**
 * Init function
 * Call functions to init and add all triggers needed
 * @param boolean combination (are we in combination context ?)
 */
function froggyPriceNegociatorInit(combination)
{
    // Set combination identifier, if we are on a combination edition
    var combination_identifier = '';
    if (combination)
        combination_identifier = 'combination-';

    // Display or hide fields depending of configuration
    froggyPriceNegociatorOptionStatus(combination);
    $('#froggypricenegociator-' + combination_identifier + 'option').click(function() { froggyPriceNegociatorOptionStatus(combination); });
}

/**
 * Option status
 * Display or hide fields depending if there is a general configuration of if the option is enabled (checkbox checked)
 * @param boolean combination (are we in combination context ?)
 */
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


/**
 * Update value
 * Refresh percent or price min depending on others fields update
 * @param boolean combination (are we in combination context ?)
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


/**
 * Load configuration combination
 * Set configuration values depending of the combination selected
 * @param integer id_product_attribute
 */
function froggyPriceNegociatorLoadConfigurationCombination(id_product_attribute)
{
    // If we are not editing a combination (eg. add combination), we hide the form
    if (id_product_attribute < 1)
    {
        froggyPriceNegociatorDisplayHideAll(false, true);
        return false;
    }
    // Else we display it
    froggyPriceNegociatorDisplayHideAll(true, true);

    // Init value of field to blank (in case, there is no configuration yet
    $('#froggypricenegociator-combination-option').removeAttr("checked");
    $('#froggypricenegociator-combination-price-min').val('');
    $('#froggypricenegociator-combination-price-min-hidden').val('');
    $('#froggypricenegociator-combination-reduction-percent-max').val('');
    $('#froggypricenegociator-combination-reduction-percent-max-hidden').val('');

    // Set the matching configuration (if there is any)
    for (i = 1; froggypricenegociator_combinations[i]; i++)
    {
        if (froggypricenegociator_combinations[i][0] == id_product_attribute)
        {
            if (froggypricenegociator_combinations[i][3] == "1")
                $('#froggypricenegociator-combination-option').attr("checked", true);
            $('#froggypricenegociator-combination-price-min').val(froggypricenegociator_combinations[i][1]);
            $('#froggypricenegociator-combination-price-min-hidden').val(froggypricenegociator_combinations[i][1]);
            $('#froggypricenegociator-combination-reduction-percent-max').val(froggypricenegociator_combinations[i][2]);
            $('#froggypricenegociator-combination-reduction-percent-max-hidden').val(froggypricenegociator_combinations[i][2]);
        }
    }

    // Check if box is checked (we hide the input text if not) and we update price min and percent max
    froggyPriceNegociatorOptionStatus(true);
    froggyPriceNegociatorUpdate(true);
}


/**
 * Display or hide it all
 * @param boolean display
 * @param boolean combination (are we in combination context ?)
 */
function froggyPriceNegociatorDisplayHideAll(display, combination)
{
    // Set combination identifier, if we are on a combination edition
    var combination_identifier = '';
    if (combination)
        combination_identifier = 'combination-';

    if (display)
    {
        $('#froggypricenegociator-' + combination_identifier + 'title').hide();
        $('#froggypricenegociator-' + combination_identifier + 'separator').hide();
        $('#froggypricenegociator-' + combination_identifier + 'checkbox-details').hide();
        $('#froggypricenegociator-' + combination_identifier + 'details').hide();
    }
    else
    {
        $('#froggypricenegociator-' + combination_identifier + 'title').show();
        $('#froggypricenegociator-' + combination_identifier + 'separator').show();
        $('#froggypricenegociator-' + combination_identifier + 'checkbox-details').show();
        $('#froggypricenegociator-' + combination_identifier + 'details').show();
    }
}


/**
 *
 * @param string query (url)
 * @param string query_string (get param in url we want to retrieve)
 * @return integer id_product_attribute
 */
function froggyPriceNegociatorGetParamsFromUrl(query, query_string)
{
    var vars = query.split("&");
    for (var i=0; i < vars.length; i++)
    {
        var pair = vars[i].split("=");
        if (pair[0] == query_string)
            return pair[1];
    }
    return 0;
}