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

$(document).ready(function() {

	$('#FC_PN_ENABLE_GENERAL_OPTION').click(function() {
		froggyPriceNegociatorConfigurationFormStatus();
	});

	froggyPriceNegociatorConfigurationFormStatus();

	$('#open-fancy').click(function(e) {
		e.preventDefault();

		$.fancybox({
			content: '<h2 class="title-modal">'+$('#open-fancy').data('text')+'</h2>',
			autoDimensions: false
		});
	});

	$('#Froggy-price-negociator-admin-tab').responsiveTabs({
		startCollapsed: 'accordion'
	});

	$('.button-choice-main').change(function() {
		froggyPriceNegociatorUpdateButtonOptions(false);
	});
	froggyPriceNegociatorUpdateButtonOptions(true);
});

function froggyPriceNegociatorUpdateButtonOptions(first_run)
{
	var elements = null;
	var explode = null;

	// Get current value
	if (first_run) {
		explode = $('input[name=FC_PN_DISPLAY_BUTTON]').val().split(' ');
		if (explode.length) {
			elements = buttons[explode[0]];
			$('.button-choice-main[value='+explode[0]+']').attr('checked', 'checked');
		}
	}

	// Else we get default values
	if (!elements) {
		elements = buttons[$('.button-choice-main:checked').val()];
	}

	for (key in elements) {
		$('.button-choice-'+key).html('');
		if (!$.isEmptyObject(elements[key])) {
			// Fill available options
			var options = elements[key];
			for (val in options) {
				$('.button-choice-'+key).append('<option value="'+val+'">'+options[val]+'</option>');
			}

			// Show options
			$('.button-choice-'+key+'-section').show();
		} else {
			// Hide useless options
			$('.button-choice-'+key+'-section').hide();
		}
	}

	// If configuration already available, we set button
	if (explode) {
		for (i in explode) {
			if (i > 0) {
				$('.button-choice option[value='+explode[i]+']').attr('selected', 'selected');
			}
		}
	}

	$('.button-choice').change(function() {
		froggyPriceNegociatorUpdateButtonPreview();
	});
	froggyPriceNegociatorUpdateButtonPreview();
}

function froggyPriceNegociatorUpdateButtonPreview()
{
	var $btn_preview = $('#froggy-price-negociator-button-preview');
	$btn_preview.attr('class', '');
	$('.button-choice:checked').each(function() {
		$btn_preview.addClass($(this).val());
	});
	$('select.button-choice').each(function() {
		$btn_preview.addClass($(this).val());
	});
	$('input[name=FC_PN_DISPLAY_BUTTON]').val($btn_preview.attr('class'));
}

function froggyPriceNegociatorConfigurationFormStatus()
{
	if ($('#FC_PN_ENABLE_GENERAL_OPTION').is(':checked'))
	{
		$('#fc-pn-type-block').hide();
		$('#fc-pn-general-reduction-block').fadeIn();
	}
	else
	{
		$('#fc-pn-general-reduction-block').hide();
		$('#fc-pn-type-block').fadeIn();
    }
}