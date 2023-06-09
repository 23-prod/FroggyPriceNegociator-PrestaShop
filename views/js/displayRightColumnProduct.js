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
	if (value_price.indexOf('.') > -1)
		value_price = value_price.replace(',', '');
	else
		value_price = value_price.replace(',', '.');
	value_price = value_price.replace(/[^\d.-]/g, '');
	return value_price;
}

function froggyPriceNegociatorRefreshPrice(empty_fields)
{
	if (empty_fields)
	{
		$('#froggy-negociator-input-offer').val('');
		$('#froggy-negociator-validation-message-step1').text('');
		$('#froggy-negociator-validation-step1-input-submit').hide();
		$('.froggy-price-negociator-progress > .froggy-price-negociator-progress-bar').css({
			'width': '100%',
			'background-color': 'none'
		});
	}
	$('#froggy-negociator-product-price').text($('#our_price_display').text());
}

function froggyPriceNegociatorCalculReduction()
{
	// Retrieve current price and offer and clean them if contains non numeric chars
	var froggypricenegociator_current_price = parseFloat(froggyPriceNegociatorCleanPrice($('#froggy-negociator-product-price').text()));
	var froggypricenegociator_offer = froggyPriceNegociatorCleanPrice($('#froggy-negociator-input-offer').val());

	// Calculate reduction
	var froggypricenegociator_reduction = froggypricenegociator_current_price - froggypricenegociator_offer;
	var froggypricenegociator_reduction_percent = froggypricenegociator_reduction * 100 / froggypricenegociator_current_price;
	froggypricenegociator_reduction = formatCurrency(froggypricenegociator_reduction, currencyFormat, currencySign, currencyBlank);
	froggypricenegociator_reduction_percent = Math.round(froggypricenegociator_reduction_percent);
	var froggypricenegociator_reduction_label = froggypricenegociator_reduction + ' ( ' + froggypricenegociator_about_label + ' ' + froggypricenegociator_reduction_percent + ' % )';

	// Display cleaned offer price and reduction
	if ($('#froggy-negociator-input-offer').val() != froggypricenegociator_offer)
		$('#froggy-negociator-input-offer').val(froggypricenegociator_offer);
	$('#froggy-negociator-product-price-reduction').text(froggypricenegociator_reduction_label);
	if (froggypricenegociator_offer == '')
		$('#froggy-negociator-product-price-reduction').text('-');
}

function froggyPriceNegociatorCalculSuccessInAjax()
{
	// Retrieve current price and offer and clean them if contains non numeric chars
	var froggypricenegociator_current_price = parseFloat(froggyPriceNegociatorCleanPrice($('#froggy-negociator-product-price').text()));
	var froggypricenegociator_offer = froggyPriceNegociatorCleanPrice($('#froggy-negociator-input-offer').val());

	// If price is too high, we hide "Submit offer" button, we hide calculated reduction and we display an error message
	if (froggypricenegociator_offer >= froggypricenegociator_current_price)
	{
		$('#froggy-negociator-product-price-reduction').text('-');
		$('#froggy-negociator-validation-step1-input-submit').hide();
		$('#froggy-negociator-validation-message-step1').text(froggypricenegociator_message_label['step1.too.high']);
		$('#froggy-negociator-onehundred').trigger('click');
		return true;
	}

	// We retrieve id product attribute and we check the possible values
	var id_product_attribute = 0;
	if ($('#idCombination').val() != '')
		id_product_attribute = $('#idCombination').val();
	var possible_values = new Array('seventyfive', 'fifty', 'twentyfive', 'five', 'zero');

	// Success is one hundred unless offer is lower than one of the precalculated price of "froggypricenegociator_configurations"
	var result = 'onehundred';
	for (i = 0; possible_values[i]; i++)
		if (froggypricenegociator_offer < froggypricenegociator_configurations[id_product_attribute][possible_values[i]])
			result = possible_values[i];

	// If chance of success is zero, we hide "Submit offer" button and we display a message
	if (result == 'zero')
	{
		$('#froggy-negociator-validation-step1-input-submit').hide();
		$('#froggy-negociator-validation-message-step1').text(froggypricenegociator_message_label['step1.too.low']);
	}
	else
	{
		// Else we show "Submit offer" button and hide delete error message
		$('#froggy-negociator-validation-step1-input-submit').show();
		$('#froggy-negociator-validation-message-step1').text('');
	}

	// Update progress bar
	if (result == 'zero') {
		$('.froggy-price-negociator-progress > .froggy-price-negociator-progress-bar').css({
			'width': '100%',
			'background-color': 'none'
		});
	} else if (result == 'twentyfive') {
		$('.froggy-price-negociator-progress > .froggy-price-negociator-progress-bar').css({
			'width': '25%',
			'background-color': '#f27011'
		});
	} else if (result == 'fifty') {
		$('.froggy-price-negociator-progress > .froggy-price-negociator-progress-bar').css({
			'width': '50%',
			'background-color': '#f2b01e'
		});
	} else if (result == 'seventyfive') {
		$('.froggy-price-negociator-progress > .froggy-price-negociator-progress-bar').css({
			'width': '75%',
			'background-color': '#ccf21b'
		});
	} else if (result == 'onehundred') {
		$('.froggy-price-negociator-progress > .froggy-price-negociator-progress-bar').css({
			'width': '100%',
			'background-color': '#53dc33'
		});
	}
}

function froggyPriceNegociatorGoToStep(step)
{
	// We hide step container and display the one corresponding to the step
	$('.froggy-negociator-modal-step').hide();
	$('#froggy-negociator-modal-step' + step).show();

	// We set the previous step as done in the breadcrumb
	$('#froggy-negociator-breadcrumb-step' + (step - 1)).removeClass('froggy-negociator-current-step');
	$('#froggy-negociator-breadcrumb-step' + (step - 1)).addClass('froggy-negociator-done-step');

	// We set the new step as current in the breadcrumb
	$('#froggy-negociator-breadcrumb-step' + step).removeClass('froggy-negociator-next-step');
	$('#froggy-negociator-breadcrumb-step' + step).addClass('froggy-negociator-current-step');
}

function froggyPriceNegociatorGetNewPriceAjax()
{
	$.ajax({
		type: 'POST',
		url: baseDir + 'modules/froggypricenegociator/ajax.php',
		data: {
			method: 'get.new.price',
			id_product: id_product,
			id_product_attribute: $('#idCombination').val(),
			offer: $('#froggy-negociator-input-offer').val()
		},
		success: function(data, textStatus, jqXHR) {

			data = JSON.parse(data);

			if (data.status == 'error')
			{
				$('#froggy-negociator-negociated-price').text('-');
				$('#froggy-negociator-validation-message-step2').removeClass('froggy-negociator-validation-confirmation').addClass('froggy-negociator-validation-error');
				$('#froggy-negociator-validation-message-step2').text(data.message);
			}
			else
			{
				$('#froggy-negociator-negociated-price').text(data.message);
				$('#froggy-negociator-negociated-price-step3').text(data.message);
				$('#froggy-negociator-validation-message-step2').removeClass('froggy-negociator-validation-error').addClass('froggy-negociator-validation-confirmation');
				$('#froggy-negociator-validation-message-step2').text(froggypricenegociator_message_label['step2.' + data.case]);

				$('#froggy-negociator-validation-message-step2').removeClass('step2.too.low');
				$('#froggy-negociator-validation-message-step2').removeClass('step2.already.negotiated');
				$('#froggy-negociator-validation-message-step2').removeClass('step2.good');
				$('#froggy-negociator-validation-message-step2').addClass('step2-' + data.case.replace('.', '-'));

				$('#froggy-negociator-modal-form-step2').fadeIn();
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
		}
	});
}


function froggyPriceNegociatorValidatePriceAjax()
{
	$('#froggy-negociator-validation-step2-input-submit').hide();
	$('#froggy-negociator-validation-step2-loader').show();

	$.ajax({
		type: 'POST',
		url: baseDir + 'modules/froggypricenegociator/ajax.php',
		data: {
			method: 'validate.price',
			id_product: id_product,
			id_product_attribute: $('#idCombination').val(),
			offer: $('#froggy-negociator-input-offer').val(),
			email: $('#froggy-negociator-input-email').val()
		},
		success: function(data, textStatus, jqXHR) {

			data = JSON.parse(data);

			froggyPriceNegociatorGoToStep(3);
			$('#froggy-negociator-validation-step2-input-submit').show();
			$('#froggy-negociator-validation-step2-loader').hide();

			$('#froggy-negociator-share-facebook').html($('#froggypricenegociator-facebook-share-preload').html());
            $('#froggy-negociator-share-twitter').html($('#froggypricenegociator-twitter-share-preload').html());

			// Update ajax cart if exists
			if ($('.ajax_cart_quantity').length) {

				// Two cases : Cart is empty or not empty
				if (!$('.ajax_cart_quantity').is(':visible')) {
					$('.ajax_cart_quantity').text(1);
					$('.ajax_cart_quantity').show();
					$('.ajax_cart_product_txt_s').show();
					$('.ajax_cart_no_product').hide();
				} else {
					var new_total_quantity = parseInt($('.ajax_cart_quantity').first().text()) + 1;
					$('.ajax_cart_quantity').text(new_total_quantity);
				}
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
		}
	});
}



/** FEATURE 1 : Display button with delay **/

function froggyPriceNegociatorDisplayButtonWithDelay()
{
	if (typeof FC_PN_ID_PRODUCT == 'undefined') return;

	var current_nb_views = localStorage.getItem('fc_pn_product_view_'+FC_PN_ID_PRODUCT) ? parseInt(localStorage.getItem('fc_pn_product_view_'+FC_PN_ID_PRODUCT)) : 0;
	// Increment number of views
	current_nb_views++;

	// If option "display button with a delay" is enabled
	if (FC_PN_DISPLAY_DELAYED > 0 && current_nb_views >= FC_PN_DISPLAY_DELAYED_PAGE)
	{
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

	// Save new number of view
	localStorage.setItem('fc_pn_product_view_'+FC_PN_ID_PRODUCT, current_nb_views);
}



/** FEATURE 2 : Dynamize modal **/

function froggyPriceNegociatorDynamizeModal()
{
	// Init : Empty reduction block, hide "Submit offer button" and retrieve product price
	froggyPriceNegociatorRefreshPrice(true);
	$('#froggy-negociator-input-offer').val('');
	$('#froggy-negociator-validation-step1-input-submit').hide();
	$('#froggy-negociator-validation-step2-input-submit').addClass('froggy-negociator-button-disabled');
	$('#froggy-negociator-modal-step1').show();
	$('#froggy-negociator-modal-step2').hide();
	$('#froggy-negociator-modal-form-step2').hide();
	$('#froggy-negociator-validation-step2-loader').hide();
	$('#froggy-negociator-modal-step3').hide();
	froggyPriceNegociatorCheckEmail();

	// Refresh price when we click on the negociate button
	$('#froggypricenegociator-button').click(function() {
		froggyPriceNegociatorRefreshPrice(true);
		froggyPriceNegociatorCalculReduction();
	});

	// When an offer is wrote
	$('#froggy-negociator-input-offer').keyup(function() {
		froggyPriceNegociatorRefreshPrice(false);
		froggyPriceNegociatorCalculReduction();
		froggyPriceNegociatorCalculSuccessInAjax();
	});

	// When an offer is submitted
	$('#froggy-negociator-validation-step1-input-submit').click(function() {
		froggyPriceNegociatorGoToStep(2);
		setTimeout(function() { froggyPriceNegociatorGetNewPriceAjax(); }, 1000)
		return false;
	});

	// Check e-mail format
	$('#froggy-negociator-input-email').keyup(function() { froggyPriceNegociatorCheckEmail(); });
	function froggyPriceNegociatorCheckEmail()
	{
		// Init
		var email = $('#froggy-negociator-input-email').val();
		var checkEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

		// If e-mail is good submit button for step 2 appear
		$('#froggy-negociator-input-email-error').hide();
		$('#froggy-negociator-validation-step2-input-submit').addClass('froggy-negociator-button-disabled');
		if (checkEmail.test(email))
			$('#froggy-negociator-validation-step2-input-submit').removeClass('froggy-negociator-button-disabled');
	}

	// When an offer is validated
	$('#froggy-negociator-validation-step2-input-submit').click(function() {
		if ($(this).hasClass('froggy-negociator-button-disabled'))
		{
			$('#froggy-negociator-input-email-error').show();
			return false;
		}
		froggyPriceNegociatorValidatePriceAjax();
		return false;
	});

	// When an offer is confirmed
	$('#froggy-negociator-validation-step3-input-submit').click(function() {
		window.location.href = $(this).parent().parent().attr('action');
		return false;
	});
}


/** Launch script **/

$(document).ready(function() {
	froggyPriceNegociatorDisplayButtonWithDelay();
	froggyPriceNegociatorDynamizeModal();
});



/** Handle attribute switch **/

$(document).on('click', '.color_pick', function(e){
	e.preventDefault();
	froggyPriceNegociatorDynamizeModal();
});

$(document).on('change', '.attribute_select', function(e){
	e.preventDefault();
	froggyPriceNegociatorDynamizeModal();
});

$(document).on('click', '.attribute_radio', function(e){
	e.preventDefault();
	froggyPriceNegociatorDynamizeModal();

});