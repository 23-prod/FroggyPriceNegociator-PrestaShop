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

/** Tool functions **/

function froggyPriceNegociatorCleanPrice(value_price)
{
	value_price = value_price.replace(',', '.');
	value_price = value_price.replace(/[^\d.-]/g, '');
	return value_price;
}

function froggyPriceNegociatorRefreshPrice()
{
	$('#froggy-negociator-product-price').text($('#our_price_display').text());
}

function froggyPriceNegociatorCalculReduction()
{
	var froggypricenegociator_current_price = froggyPriceNegociatorCleanPrice($('#froggy-negociator-product-price').text());
	var froggypricenegociator_offer = froggyPriceNegociatorCleanPrice($('#froggy-negociator-input-offer').val());

	var froggypricenegociator_reduction = froggypricenegociator_current_price - froggypricenegociator_offer;
	var froggypricenegociator_reduction_percent = froggypricenegociator_reduction * 100 / froggypricenegociator_current_price;
	froggypricenegociator_reduction = formatCurrency(froggypricenegociator_reduction, currencyFormat, currencySign, currencyBlank);
	froggypricenegociator_reduction_percent = Math.round(froggypricenegociator_reduction_percent);
	var froggypricenegociator_reduction_label = froggypricenegociator_reduction + ' ( ' + froggypricenegociator_about_label + ' ' + froggypricenegociator_reduction_percent + ' % )';

	$('#froggy-negociator-input-offer').val(froggypricenegociator_offer);
	$('#froggy-negociator-product-price-reduction').text(froggypricenegociator_reduction_label);
}

function froggyPriceNegociatorCalculSuccessInAjax()
{
	var froggypricenegociator_current_price = parseFloat(froggyPriceNegociatorCleanPrice($('#froggy-negociator-product-price').text()));
	var froggypricenegociator_offer = froggyPriceNegociatorCleanPrice($('#froggy-negociator-input-offer').val());

	if (froggypricenegociator_offer > froggypricenegociator_current_price)
	{
		$('#froggy-negociator-onehundred').trigger('click');
		return true;
	}

	var id_product_attribute = $('#idCombination').val();
	var possible_values = new Array('seventyfive', 'fifty', 'twentyfive', 'five');

	var result = 'onehundred';
	for (i = 0; possible_values[i]; i++)
		if (froggypricenegociator_offer < froggypricenegociator_configurations[id_product_attribute][possible_values[i]])
			result = possible_values[i];

	$('#froggy-negociator-' + result).trigger('click');
}

function froggyPriceNegociatorGetNewPriceAjax()
{
	$.ajax({
		type: 'GET',
		url: baseDir + 'modules/froggypricenegociator/ajax.php',
		data: {
			method: 'get.new.price',
			id_product: id_product,
			id_product_attribute: $('#idCombination').val(),
			offer: $('#froggy-negociator-input-offer').val()
		},
		success: function(data, textStatus, jqXHR) {
		},
		error: function(jqXHR, textStatus, errorThrown) {
		}
	});
}

/** FEATURE 1 : Display button with delay **/

function froggyPriceNegociatorDisplayButtonWithDelay()
{
	// If option "display button with a delay" is enabled
	if (FC_PN_DISPLAY_DELAYED > 0)
	{
		// We hide button
		$('#froggypricenegociator-button').hide();

		// Set flag display
		var froggypricenegociator_display = true;

		// If visitor click on "add to cart" button, we do not display the negociator button
		// We use set time out to hook on the "add to cart" button once PS JS is executed
		// because of the $('#add_to_cart input').unbind('click') in ajax-cart.js
		setTimeout(function() {
			$('#add_to_cart input').click(function() {
				froggypricenegociator_display = false;
			});
		}, 500);

		// We display the negociator button with a delay (except if visitor add product to cart)
		setTimeout(function() {
			if (froggypricenegociator_display)
				$('#froggypricenegociator-button').fadeIn(3000);
		}, FC_PN_DISPLAY_DELAYED * 1000);
	}
}



/** FEATURE 2 : Dynamize modal **/

function froggyPriceNegociatorDynamizeModal()
{
	// Init : Empty reduction block and retrieve product price
	froggyPriceNegociatorRefreshPrice();
	$('#froggy-negociator-product-price-reduction').text();

	// Refresh price when we click on the negociate button
	$('#froggypricenegociator-button').click(function() {
		froggyPriceNegociatorRefreshPrice();
		froggyPriceNegociatorCalculReduction();
	});

	// When an offer is wrote
	$('#froggy-negociator-input-offer').keyup(function() {

		froggyPriceNegociatorRefreshPrice();
		froggyPriceNegociatorCalculReduction();
		froggyPriceNegociatorCalculSuccessInAjax();

	});
}


/** Launch script **/

$(document).ready(function() {
	froggyPriceNegociatorDisplayButtonWithDelay();
	froggyPriceNegociatorDynamizeModal();
});