$(document).ready(function() {

    $('#FC_PN_ENABLE_GENERAL_OPTION').click(function() {
        froggyPriceNegociatorConfigurationFormStatus();
    });

    froggyPriceNegociatorConfigurationFormStatus();

});

function froggyPriceNegociatorConfigurationFormStatus()
{
    if ($('#FC_PN_ENABLE_GENERAL_OPTION').is(':checked'))
    {
        $('#FC_PN_GENERAL_REDUCTION').removeClass('disable');
        $('#FC_PN_TYPE').addClass('disable');
    }
    else
    {
        $('#FC_PN_GENERAL_REDUCTION').addClass('disable');
        $('#FC_PN_TYPE').removeClass('disable');
    }
}