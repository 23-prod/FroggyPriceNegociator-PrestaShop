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

function froggyCleanPrice(value_price)
{
	value_price = value_price.replace(',', '.');
	value_price = value_price.replace(/[^\d.-]/g, '');
	return value_price;
}

$(document).ready(function() {

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

	// Empty reduction block and display product price
	$('#froggy-negociator-product-price-reduction').text();
	$('#froggy-negociator-product-price').text($('#our_price_display').text());

	// When an offer is wrote
	$('#froggy-negociator-input-offer').keyup(function() {

		var froggypricenegociator_current_price = froggyCleanPrice($('#froggy-negociator-product-price').text());
		var froggypricenegociator_offer = froggyCleanPrice($('#froggy-negociator-input-offer').val());
		var froggypricenegociator_reduction = froggypricenegociator_current_price - froggypricenegociator_offer;
		var froggypricenegociator_reduction_percent = froggypricenegociator_reduction * 100 / froggypricenegociator_current_price;
		froggypricenegociator_reduction = formatCurrency(froggypricenegociator_reduction, currencyFormat, currencySign, currencyBlank);
		froggypricenegociator_reduction_percent = Math.round(froggypricenegociator_reduction_percent);
		var froggypricenegociator_reduction_label = froggypricenegociator_reduction + ' ( ' + froggypricenegociator_about_label + ' ' + froggypricenegociator_reduction_percent + ' % )';

		$('#froggy-negociator-input-offer').val(froggypricenegociator_offer);
		$('#froggy-negociator-product-price-reduction').text(froggypricenegociator_reduction_label);

		$('#froggy-negociator-seventyfive').trigger('click');
	});

});