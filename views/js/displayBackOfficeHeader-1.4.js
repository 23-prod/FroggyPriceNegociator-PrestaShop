// Init var
var froggypricenegociator_current_price_field = '#finalPrice';

$(document).ready(function() {

    // When document is ready, we add the price negociator fields
    $('#tr_unit_price').next().next().next().after(fc_pn_negociator_options);
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

    // Init
    froggyPriceNegociatorInit();
});