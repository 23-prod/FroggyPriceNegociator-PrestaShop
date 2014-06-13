{**
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
 * @author    Froggy Commerce <contact@froggy-commerce.com>
 * @copyright 2013-2014 Froggy Commerce
 * @license   Unauthorized copying of this file, via any medium is strictly prohibited
 *}

<fieldset id="froggypricenegociator_fieldset">
	<legend><img src="{$froggypricenegociator.module_dir}logo.png" alt="" width="16" />{l s='Froggy Price Negociator' mod='froggypricenegociator'}</legend>

    {if isset($froggypricenegociator.result) && $froggypricenegociator.result eq 'ok'}
        <div class="conf confirm">{l s='The new configuration has been saved!' mod='froggypricenegociator'}</div>
    {/if}

	<div id="Froggy-price-negociator-admin-tab">
		<ul>
			<li><a href="#froggy-module-configuration"> {l s='Configuration' mod='froggypricenegociator'} </a></li>
			<li><a href="#froggy-module-option"> {l s='Option' mod='froggypricenegociator'} </a></li>
			<li><a href="#froggy-module-display"> {l s='Display' mod='froggypricenegociator'} </a></li>
			<li><a href="#tab-4"> {l s='Button' mod='froggypricenegociator'} </a></li>
		</ul>

		{*tab module configuration*}
		<div id="froggy-module-configuration">
			<h3>{l s='Mode configuration:' mod='froggypricenegociator'}</h3>

			<label>{l s='Enable price negotiation button on all products:' mod='froggypricenegociator'}</label>
			<div class="margin-form">
				<input type="checkbox" id="FC_PN_ENABLE_GENERAL_OPTION" name="FC_PN_ENABLE_GENERAL_OPTION" value="1"{if $froggypricenegociator.FC_PN_ENABLE_GENERAL_OPTION} checked="checked"{/if} />
			<p class="preference_description">{l s='Enable price negotiation button for all products (you won\'t have to set a configuration for each product).' mod='froggypricenegociator'}</p>
			</div>

			<div id="fc-pn-general-reduction-block">
				<label>{l s='General reduction in percent:' mod='froggypricenegociator'}</label>
				<div class="margin-form">
					<input type="text" id="FC_PN_GENERAL_REDUCTION" name="FC_PN_GENERAL_REDUCTION" value="{$froggypricenegociator.FC_PN_GENERAL_REDUCTION}" /> %
					<p class="preference_description">{l s='If you enabled the button for all products, you have to set a reduction in percent for all products.' mod='froggypricenegociator'}</p>
				</div>
			</div>

			<div id="fc-pn-type-block">
				<label>{l s='Type reduction:' mod='froggypricenegociator'}</label>
				<div class="margin-form">
					<select name="FC_PN_TYPE" id="FC_PN_TYPE">
						<option value="PRICE_MINI" {if $froggypricenegociator.FC_PN_TYPE eq 'PRICE_MINI'}selected="selected"{/if}>{l s='Define price minimum' mod='froggypricenegociator'}</option>
						<option value="PERCENT" {if $froggypricenegociator.FC_PN_TYPE eq 'PERCENT'}selected="selected"{/if}>{l s='Define maximum percent' mod='froggypricenegociator'}</option>
					</select>
					<p class="preference_description">{l s='Please look at the documentation for more details.' mod='froggypricenegociator'}</p>
				</div>
			</div>
		</div>
		{*tab module configuration*}

		{*tab module option*}
		<div id="froggy-module-option">
			<h3>{l s='General option:' mod='froggypricenegociator'}</h3>

			<label>{l s='Max quantity by product:' mod='froggypricenegociator'}</label>
			<div class="margin-form">
				<input type="text" name="FC_PN_MAX_QUANTITY_BY_PRODUCT" value="{$froggypricenegociator.FC_PN_MAX_QUANTITY_BY_PRODUCT}" />
				<p class="preference_description">{l s='Limit the maximum quantity for negociated products.' mod='froggypricenegociator'}</p>
			</div>

			<label>{l s='Max product by cart:' mod='froggypricenegociator'}</label>
			<div class="margin-form">
				<input type="text" name="FC_PN_MAX_PRODUCT_BY_CART" value="{$froggypricenegociator.FC_PN_MAX_PRODUCT_BY_CART}" />
				<p class="preference_description">{l s='Limit the number of negociated products by cart.' mod='froggypricenegociator'}</p>
			</div>

			<label>{l s='Compliant with promotion:' mod='froggypricenegociator'}</label>
			<div class="margin-form">
				<input type="checkbox" name="FC_PN_COMPLIANT_PROMO" value="1"{if $froggypricenegociator.FC_PN_COMPLIANT_PROMO} checked="checked"{/if} />
				<p class="preference_description">{l s='Display price negotiation button on product in promotion.' mod='froggypricenegociator'}</p>
			</div>

			<label>{l s='Compliant with new products:' mod='froggypricenegociator'}</label>
			<div class="margin-form">
				<input type="checkbox" name="FC_PN_COMPLIANT_NEW" value="1"{if $froggypricenegociator.FC_PN_COMPLIANT_NEW} checked="checked"{/if} />
				<p class="preference_description">{l s='Display price negotiation button on new products.' mod='froggypricenegociator'}</p>
			</div>

			<label>{l s='Compliant with discounts:' mod='froggypricenegociator'}</label>
			<div class="margin-form">
				<input type="checkbox" name="FC_PN_COMPLIANT_DISCOUNT" value="1"{if $froggypricenegociator.FC_PN_COMPLIANT_DISCOUNT} checked="checked"{/if} />
				<p class="preference_description">{l s='Customers can use discount code with negociated products.' mod='froggypricenegociator'}</p>
			</div>

			<label>{l s='Disable price negotiation button for the following categories:' mod='froggypricenegociator'}</label>
			<div class="margin-form">
				<input type="text" name="FC_PN_DISABLE_FOR_CATS" value="{$froggypricenegociator.FC_PN_DISABLE_FOR_CATS}" />
				<p class="preference_description">{l s='If a product is associated to one of these categories, price negotiation button will be disabled.' mod='froggypricenegociator'}</p>
			</div>

			<label>{l s='Disable price negotiation button for the following brands:' mod='froggypricenegociator'}</label>
			<div class="margin-form">
				<input type="text" name="FC_PN_DISABLE_FOR_BRANDS" value="{$froggypricenegociator.FC_PN_DISABLE_FOR_BRANDS}" />
				<p class="preference_description">{l s='If a product is associated to one of these brands, price negotiation button will be disabled.' mod='froggypricenegociator'}</p>
			</div>

			<label>{l s='Disable price negotiation button for the following customers:' mod='froggypricenegociator'}</label>
			<div class="margin-form">
				<input type="text" name="FC_PN_DISABLE_FOR_CUSTS" value="{$froggypricenegociator.FC_PN_DISABLE_FOR_CUSTS}" />
				<p class="preference_description">{l s='Price negotiation button will be disabled for all these customers.' mod='froggypricenegociator'}</p>
			</div>
		</div>
		{*tab module option*}

		{*tab module display*}
		<div id="froggy-module-display">
			<div id="froggypricenegociator_options">
				<form method="POST" action="">
					<label>{l s='Display mode:' mod='froggypricenegociator'}</label>
					<div class="margin-form">
						<select name="FC_PN_DISPLAY_MODE">
							<option value="FANCYBOX" {if $froggypricenegociator.FC_PN_DISPLAY_MODE eq 'FANCYBOX'}selected="selected"{/if}>{l s='Fancybox (jQuery)' mod='froggypricenegociator'}</option>
							<option value="REVEAL" {if $froggypricenegociator.FC_PN_DISPLAY_MODE eq 'REVEAL'}selected="selected"{/if}>{l s='Reveal (Foundation)' mod='froggypricenegociator'}</option>
						</select>
					</div>
					<p class="preference_description">{l s='The display when customer click on the price negotiation button.' mod='froggypricenegociator'}</p>

					<label>{l s='Display price negotiation button after:' mod='froggypricenegociator'}</label>
					<div class="margin-form">
						<input type="text" name="FC_PN_DISPLAY_DELAYED" value="{$froggypricenegociator.FC_PN_DISPLAY_DELAYED}" /> s
						<p class="preference_description">{l s='You can delay the display of the price negotiation button, it will permit to display the button when a customer hesitate to add a product to your cart.' mod='froggypricenegociator'}</p>
					</div>

					<div class="center"><input type="submit" name="submitFroggyPriceNegociatorConfiguration" value="{l s='Save' mod='froggypricenegociator'}" name="froggypricenegociator_ft_form" class="button" /></div>
				</form>
			</div>
		</div>
		{*tab module display*}
	</div>

</fieldset>



<script type="text/javascript" src="{$froggypricenegociator.module_dir}views/js/getContent-common.js"></script>
<script type="text/javascript" src="{$froggypricenegociator.module_dir}views/js/jquery.responsiveTabs.min.js"></script>
<link type="text/css" rel="stylesheet" href="{$froggypricenegociator.module_dir}views/css/style-{$froggypricenegociator.ps_version}.css" />
<link type="text/css" rel="stylesheet" href="{$froggypricenegociator.module_dir}views/css/responsive-tabs.css" />
<script type="text/javascript">
	$('#Froggy-price-negociator-admin-tab').responsiveTabs({
		startCollapsed: 'accordion'
	});
</script>