// Init var
var froggypricenegociator_displayed = 0;
var froggypricenegociator_current_price_field = '#finalPrice';

$(document).ready(function() {

    // When document is ready, if merchant click on link price tab, we add the price negociator fields
    $('#link-Prices').click(function() {
        if (froggypricenegociator_displayed == 0)
        {
            $('#tr_unit_price').parent().find('tr:last').after(fc_pn_negociator_options);
            froggyPriceNegociatorUpdatePercent();
        }
        froggypricenegociator_displayed = 1;

        // If price is updated, we update percent
        $('#priceTE').keydown(function() {
            froggyPriceNegociatorUpdatePercent();
        });
        $('#priceTI').keydown(function() {
            froggyPriceNegociatorUpdatePercent();
        });
        $('#froggypricenegociator-price-min').keydown(function() {
            froggyPriceNegociatorUpdatePercent();
        });
        $('#froggypricenegociator-percent-reduction-max').keydown(function() {
            froggyPriceNegociatorUpdatePercent();
        });

        // Init
        froggyPriceNegociatorInit();
    });
});