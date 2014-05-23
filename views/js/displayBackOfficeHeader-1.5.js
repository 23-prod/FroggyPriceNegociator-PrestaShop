var froggypricenegociator_displayed = 0;
$(document).ready(function() {
    $('#link-Prices').click(function() {
        if (froggypricenegociator_displayed == 0)
            $('#tr_unit_price').parent().find('tr:last').after(negociator_options);
        froggypricenegociator_displayed = 1;
    });
});