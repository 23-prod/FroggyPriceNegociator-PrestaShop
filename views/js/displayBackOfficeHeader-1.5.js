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

// Init var
var froggypricenegociator_current_price_field = '#finalPrice';
var froggypricenegociator_current_price_combination_field = '#attribute_new_total_price';

$(document).ready(function() {

    // When document is ready, if merchant click on link price tab, we add the price negociator fields
    $('#link-Prices').click(function() {

        if ($('#froggypricenegociator-option').length == 0)
        {
            $('#tr_unit_price').parent().parent().after(fc_pn_negociator_options);

            // Init display and binding
            setTimeout(function() {

                // Init display
                froggyPriceNegociatorInit();
                froggyPriceNegociatorUpdate();

                // If price is updated, we update percent
                $('#priceTE').keydown(function() {
                    froggyPriceNegociatorUpdate();
                });
                $('#priceTI').keydown(function() {
                    froggyPriceNegociatorUpdate();
                });
                $('#froggypricenegociator-price-min').keydown(function() {
                    froggyPriceNegociatorUpdate();
                });
                $('#froggypricenegociator-reduction-percent-max').keydown(function() {
                    froggyPriceNegociatorUpdate();
                });

            }, 500);
        }

    });

    // When document is ready, if merchant click on link price tab, we add the price negociator fields
    $('#product-tab-content-Combinations').click(function() {

        if ($('#froggypricenegociator-combination-option').length == 0)
        {
            var tmp = fc_pn_negociator_options.replace(/id="froggypricenegociator-/g, 'id="froggypricenegociator-combination-');
            $('#tr_unit_impact').parent().parent().after(tmp);
            $('#froggypricenegociator-combination-option-label').text(fc_pn_negociator_label_product_attribute);

            // Init display and binding
            setTimeout(function() {

                // Init display
                froggyPriceNegociatorInit(true);
                froggyPriceNegociatorUpdate(true);

                // If price is updated, we update percent
                $('#attribute_price_impact').keydown(function() {
                    froggyPriceNegociatorUpdate(true);
                });
                $('#attribute_price').keydown(function() {
                    froggyPriceNegociatorUpdate(true);
                });
                $('#attribute_priceTI').keydown(function() {
                    froggyPriceNegociatorUpdate(true);
                });
                $('#froggypricenegociator-combination-price-min').keydown(function() {
                    froggyPriceNegociatorUpdate(true);
                });
                $('#froggypricenegociator-combination-reduction-percent-max').keydown(function() {
                    froggyPriceNegociatorUpdate(true);
                });

            }, 500);
        }

    });

});