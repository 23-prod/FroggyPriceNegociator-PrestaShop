// Init var
var froggypricenegociator_displayed = 0;
var froggypricenegociator_current_price_field = '#finalPrice';

$(document).ready(function() {

    // When document is ready, if merchant click on link price tab, we add the price negociator fields
    $('#link-Prices').click(function() {
        if (froggypricenegociator_displayed == 0)
        {
            $('#tr_unit_price').parent().parent().after(fc_pn_negociator_options);
            froggyPriceNegociatorUpdate();
        }
        froggypricenegociator_displayed = 1;

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

        // Init
        froggyPriceNegociatorInit();
    });
});