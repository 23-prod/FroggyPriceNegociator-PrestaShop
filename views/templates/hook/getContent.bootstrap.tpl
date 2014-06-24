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
	<h2>{l s='Froggy Price Negotiator' mod='froggypricenegociator'}</h2>
	<div class="panel">
		<legend><img src="{$froggypricenegociator.module_dir}logo.png" alt="" width="16" />{l s='Froggy Price Negotiator' mod='froggypricenegociator'}</legend>

		{if isset($froggypricenegociator.result) && $froggypricenegociator.result eq 'ok'}
			<div class="conf confirm">{l s='The new configuration has been saved!' mod='froggypricenegociator'}</div>
		{/if}

		<form method="POST" action="#">
			<div id="Froggy-price-negociator-admin-tab">
				<ul>
					<li><a href="#froggy-module-configuration"> {l s='Configurations' mod='froggypricenegociator'} </a></li>
					<li><a href="#froggy-module-option"> {l s='General options' mod='froggypricenegociator'} </a></li>
					<li><a href="#froggy-module-display"> {l s='Display options' mod='froggypricenegociator'} </a></li>
					<li><a href="#froggy-module-personalization"> {l s='Personalization' mod='froggypricenegociator'} </a></li>
				</ul>

				{*tab module configuration*}
				<div id="froggy-module-configuration">
					<h4>{l s='Mode configuration:' mod='froggypricenegociator'}</h4>

					<div class="form-group clearfix">
					<label class="col-lg-3">{l s='Enable price negotiation for all products:' mod='froggypricenegociator'}</label>
						<div class="col-lg-9">
							<input type="checkbox" id="FC_PN_ENABLE_GENERAL_OPTION" name="FC_PN_ENABLE_GENERAL_OPTION" value="1"{if $froggypricenegociator.FC_PN_ENABLE_GENERAL_OPTION} checked="checked"{/if} />
							<p class="help-block">{l s='Enable price negotiation button for all products (you won\'t have to set a configuration for each product).' mod='froggypricenegociator'}</p>
						</div>
					</div>

					<div id="fc-pn-general-reduction-block" class="form-group clearfix">
						<label class="col-lg-3">{l s='General reduction in percent:' mod='froggypricenegociator'}</label>
						<div class="col-lg-9">
							<input type="text" id="FC_PN_GENERAL_REDUCTION" name="FC_PN_GENERAL_REDUCTION" value="{$froggypricenegociator.FC_PN_GENERAL_REDUCTION}" /> %
							<p class="help-block">{l s='If you enabled the button for all products, you have to set a reduction in percent for all products.' mod='froggypricenegociator'}</p>
						</div>
					</div>

					<div id="fc-pn-type-block" class="form-group clearfix">
						<label class="col-lg-3">{l s='Reduction type:' mod='froggypricenegociator'}</label>
						<div class="col-lg-9">
							<select name="FC_PN_TYPE" id="FC_PN_TYPE">
								<option value="PRICE_MINI" {if $froggypricenegociator.FC_PN_TYPE eq 'PRICE_MINI'}selected="selected"{/if}>{l s='Define minimum price sell' mod='froggypricenegociator'}</option>
								<option value="PERCENT" {if $froggypricenegociator.FC_PN_TYPE eq 'PERCENT'}selected="selected"{/if}>{l s='Define maximum percent reduction' mod='froggypricenegociator'}</option>
							</select>
							<p class="help-block">{l s='Please look at the documentation for more details.' mod='froggypricenegociator'}</p>
						</div>
					</div>
				</div>
				{*tab module configuration*}

				{*tab module option*}
				<div id="froggy-module-option">
					<h4>{l s='General option:' mod='froggypricenegociator'}</h4>

					<div class="form-group clearfix">
						<label class="col-lg-3">{l s='Maximum quantity for negotiated product:' mod='froggypricenegociator'}</label>
						<div class="col-lg-9">
							<input type="text" name="FC_PN_MAX_QUANTITY_BY_PRODUCT" value="{$froggypricenegociator.FC_PN_MAX_QUANTITY_BY_PRODUCT}" />
							<p class="help-block">{l s='Limit the maximum quantity for negotiated products.' mod='froggypricenegociator'}</p>
						</div>
					</div>

					<div class="form-group clearfix">
						<label class="col-lg-3">{l s='Maximum negotiated products by cart:' mod='froggypricenegociator'}</label>
						<div class="col-lg-9">
							<input type="text" name="FC_PN_MAX_PRODUCT_BY_CART" value="{$froggypricenegociator.FC_PN_MAX_PRODUCT_BY_CART}" />
							<p class="help-block">{l s='Limit the number of negotiated products by cart.' mod='froggypricenegociator'}</p>
						</div>
					</div>

					<div class="form-group clearfix">
						<label class="col-lg-3">{l s='Compliant with promotions:' mod='froggypricenegociator'}</label>
						<div class="col-lg-9">
							<input type="checkbox" name="FC_PN_COMPLIANT_PROMO" value="1"{if $froggypricenegociator.FC_PN_COMPLIANT_PROMO} checked="checked"{/if} />
							<p class="help-block">{l s='Display price negotiation button on products in promotion.' mod='froggypricenegociator'}</p>
						</div>
					</div>

					<div class="form-group clearfix">
						<label class="col-lg-3">{l s='Compliant with new products:' mod='froggypricenegociator'}</label>
						<div class="col-lg-9">
							<input type="checkbox" name="FC_PN_COMPLIANT_NEW" value="1"{if $froggypricenegociator.FC_PN_COMPLIANT_NEW} checked="checked"{/if} />
							<p class="help-block">{l s='Display price negotiation button on new products.' mod='froggypricenegociator'}</p>
						</div>
					</div>

					<div class="form-group clearfix">
						<label class="col-lg-3">{l s='Compliant with discounts:' mod='froggypricenegociator'}</label>
						<div class="col-lg-9">
							<input type="checkbox" name="FC_PN_COMPLIANT_DISCOUNT" value="1"{if $froggypricenegociator.FC_PN_COMPLIANT_DISCOUNT} checked="checked"{/if} />
							<p class="help-block">{l s='Customers can use discount code with negotiated products.' mod='froggypricenegociator'}</p>
						</div>
					</div>

					<div class="form-group clearfix">
						<label class="col-lg-3">{l s='Disable price negotiation button for the following categories:' mod='froggypricenegociator'}</label>
						<div class="col-lg-9">
							{$froggypricenegociator.category_tree}
							<p class="help-block">{l s='If a product is associated to one of these categories, price negotiation button will be disabled.' mod='froggypricenegociator'}</p>
						</div>
					</div>

					<div class="form-group clearfix">
						<label class="col-lg-3">{l s='Disable price negotiation button for the following manufacturers:' mod='froggypricenegociator'}</label>
						<div class="col-lg-9">
							<p>
								<a href="#" onclick="$('#ids_manufacturers option').each(function() { $(this).attr('selected', 'selected'); $('#ids_manufacturers').focus(); }); return false;">{l s='Select all manufacturers' mod='froggypricenegociator'}</a> |
								<a href="#" onclick="$('#ids_manufacturers option').each(function() { $(this).attr('selected', false); $('#ids_manufacturers').focus(); }); return false;">{l s='Unselect all manufacturers' mod='froggypricenegociator'}</a>
							</p>
							<select id="ids_manufacturers" name="ids_manufacturers[]" style="border:1px solid #AAAAAA;width:400px;height:160px" multiple>
								{foreach from=$froggypricenegociator.manufacturers item='manufacturer'}
									<option value="{$manufacturer.id_manufacturer|intval}" {if in_array($manufacturer.id_manufacturer, $froggypricenegociator.selected_manufacturers)}selected="selected"{/if}>&nbsp;{$manufacturer.name|escape}</option>
								{/foreach}
							</select>
							<p class="help-block">
								{l s='If a product is associated to one of these brands, price negotiation button will be disabled.' mod='froggypricenegociator'}<br/>
								<b>{l s='Press CTRL in order to select many manufacturers.' mod='froggypricenegociator'}</b>
							</p>
						</div>
					</div>

					<div class="form-group clearfix">
						<label class="col-lg-3">{l s='Disable price negotiation button for the following customer groups:' mod='froggypricenegociator'}</label>
						<div class="col-lg-9">
							<p>
								<a href="#" onclick="$('#ids_groups option').each(function() { $(this).attr('selected', 'selected'); $('#ids_groups').focus(); }); return false;">{l s='Select all groups' mod='froggypricenegociator'}</a> |
								<a href="#" onclick="$('#ids_groups option').each(function() { $(this).attr('selected', false); $('#ids_groups').focus(); }); return false;">{l s='Unselect all groups' mod='froggypricenegociator'}</a>
							</p>
							<select id="ids_groups" name="ids_groups[]" style="border:1px solid #AAAAAA;width:400px;height:160px" multiple>
								{foreach from=$froggypricenegociator.groups item='group'}
									<option value="{$group.id_group|intval}" {if in_array($group.id_group, $froggypricenegociator.selected_groups)}selected="selected"{/if}>&nbsp;{$group.name|escape}</option>
								{/foreach}
							</select>
							<p class="help-block">
								{l s='Price negotiation button will be disabled for all customers in these groups.' mod='froggypricenegociator'}<br/>
								<b>{l s='Press CTRL in order to select many groups.' mod='froggypricenegociator'}</b>
							</p>
						</div>
					</div>
				</div>
				{*tab module option*}

				{*tab module display*}
				<div id="froggy-module-display">
					<div class="form-group clearfix">
						<label class="col-lg-3">{l s='Display price negotiation button after (seconds):' mod='froggypricenegociator'}</label>
						<div class="col-lg-9">
							<input type="text" name="FC_PN_DISPLAY_DELAYED" value="{$froggypricenegociator.FC_PN_DISPLAY_DELAYED}" />
							{l s='seconds and' mod='froggypricenegociator'}
							<input type="text" name="FC_PN_DISPLAY_DELAYED_PAGE" value="{$froggypricenegociator.FC_PN_DISPLAY_DELAYED_PAGE}" />
							{l s='view(s) of the product page.' mod='froggypricenegociator'}
							<p class="help-block">
								{l s='You can delay the display of the price negotiation button, it will permit to display the button when a customer hesitate to add a product to your cart.' mod='froggypricenegociator'}<br />
								<b>{l s='Put 0 in fields if you want disable this feature and show immediately the button for negotiation.' mod='froggypricenegociator'}</b>
							</p>
						</div>
					</div>
				</div>
				{*tab module display*}

				{*tab module personalization*}
				<div id="froggy-module-personalization">

					<div class="form-group clearfix">
						<label class="col-lg-3">{l s='Button style:' mod='froggypricenegociator'}</label>
						<div class="col-lg-9">
							<div class="float">
								<div class="col-lg-4 main-style-block">
									<h4>{l s='Main style' mod='froggypricenegociator'}</h4>
									<ul class="col-lg-12">
										<li><input class="button-choice button-choice-main" type="radio" name="button-style" value="froggy-price-negociator-button-front" checked="checked" id="radio-normal-style-button" />
											<label for="radio-normal-style-button">Normal</label></li>
										<li><input class="button-choice button-choice-main" type="radio" name="button-style" value="froggy-price-negociator-flat-button" id="radio-flat-style-button" />
											<label for="radio-flat-style-button">Flat</label></li>
										<li><input class="button-choice button-choice-main" type="radio" name="button-style" value="froggy-price-negociator-button-alert" id="radio-alert-style-button" />
											<label for="radio-alert-style-button">Alert</label></li>
									</ul>
								</div>
								<div class="col-lg-4 main-style-block">
									<h4>{l s='Advanced style' mod='froggypricenegociator'}</h4>
									<ul class="col-lg-6">
										<li class="button-choice-round-section">
											<b>{l s='Round style' mod='froggypricenegociator'}</b>
											<select class="button-choice button-choice-round" name="button-round"></select>
										</li>
										<li class="button-choice-color-section">
											<b>{l s='Color' mod='froggypricenegociator'}</b>
											<select class="button-choice button-choice-color" name="button-color"></select>
										</li>
									</ul>
								</div>
							</div>
							<div class="col-lg-4 main-style-block">
								<h4>{l s='Preview' mod='froggypricenegociator'}</h4>
								<a id="froggy-price-negociator-button-preview">{l s='Negotiate the price' mod='froggypricenegociator'}</a>
								<input type="hidden" name="FC_PN_DISPLAY_BUTTON" value="{$froggypricenegociator.FC_PN_DISPLAY_BUTTON}" />
							</div>
							<p class="help-block col-lg-12">{l s='The display when customer click on the price negotiation button.' mod='froggypricenegociator'}</p>
						</div>
					</div>

					<div class="form-group clearfix">
						<label class="col-lg-3">{l s='Display mode:' mod='froggypricenegociator'}</label>
						<div class="col-lg-9">
							<div class="col-lg-3 text-center style-box-front">
								<label>
									<img src="{$module_dir}views/img/fancy.png" />
									<p class="clearfix"><input type="radio" name="FC_PN_DISPLAY_MODE" value="FANCYBOX" {if $froggypricenegociator.FC_PN_DISPLAY_MODE eq 'FANCYBOX'}checked="checked"{/if}/> Fancybox (jQuery)</p>
								</label>
								<p class="clearfix"><a id="open-fancy" class="btn btn-default" href="#" data-text="{l s='This is a Fancybox' mod='froggypricenegociator'}">{l s='Preview' mod='froggypricenegociator'}</a></p>
							</div>
							<div class="col-lg-3 text-center style-box-front">
								<label>
									<img src="{$module_dir}views/img/reveal.png" />
									<p class="clearfix"><input type="radio" name="FC_PN_DISPLAY_MODE" value="REVEAL" {if $froggypricenegociator.FC_PN_DISPLAY_MODE eq 'REVEAL'}checked="checked"{/if}/> Reveal (Foundation)</p>
								</label>
								<p class="clearfix"><a class="btn btn-default" href="#" data-reveal-id="preview-reveal-modal">{l s='Preview' mod='froggypricenegociator'}</a></p>
								<div id="preview-reveal-modal" class="reveal-modal">
									<h2 class="title-modal">{l s='This is Reveal modal' mod='froggypricenegociator'}</h2>
									<a class="close-reveal-modal">&#215;</a>
								</div>
							</div>
							<p class="help-block col-lg-12">{l s='The display when customer click on the price negotiation button.' mod='froggypricenegociator'}</p>
						</div>
					</div>

				</div>
				{*tab module personalization*}
			</div>
		</div>
		<div class="form-group clearfix"><input type="submit" name="submitFroggyPriceNegociatorConfiguration" value="{l s='Save' mod='froggypricenegociator'}" name="froggypricenegociator_ft_form" class="btn btn-default pull-right" /></div>
	</form>
</fieldset>



<script type="text/javascript" src="{$froggypricenegociator.module_dir}views/js/getContent-common.js"></script>
<script type="text/javascript" src="{$froggypricenegociator.module_dir}views/js/jquery.responsiveTabs.min.js"></script>
<script type="text/javascript" src="{$froggypricenegociator.module_dir}views/js/jquery.reveal.js"></script>
<link type="text/css" rel="stylesheet" href="{$froggypricenegociator.module_dir}views/css/style-1.6.css" />
<link type="text/css" rel="stylesheet" href="{$froggypricenegociator.module_dir}views/css/responsive-tabs.css" />
<link type="text/css" rel="stylesheet" href="{$froggypricenegociator.module_dir}views/css/reveal.css" />
<link type="text/css" rel="stylesheet" href="{$froggypricenegociator.module_dir}views/css/buttons.css" />

<script type="text/javascript">
	var buttons = {
		"froggy-price-negociator-button-front": {
			"round": {
				"radius": "{l s='Normal'  mod='froggypricenegociator'}",
				"radius-big": "{l s='Important'  mod='froggypricenegociator'}"
			},
			"color": {
				"froggy-price-negociator-red": "{l s='Red'  mod='froggypricenegociator'}",
				"froggy-price-negociator-blue": "{l s='Blue'  mod='froggypricenegociator'}",
				"froggy-price-negociator-yellow": "{l s='Yellow'  mod='froggypricenegociator'}"
			}
		},
		"froggy-price-negociator-flat-button": {
			"round": { },
			"color": {
				"froggy-price-negociator-orange": "{l s='Orange'  mod='froggypricenegociator'}",
				"froggy-price-negociator-green": "{l s='Green'  mod='froggypricenegociator'}",
				"froggy-price-negociator-blue": "{l s='Blue'  mod='froggypricenegociator'}",
				"froggy-price-negociator-grey": "{l s='Grey'  mod='froggypricenegociator'}"
			}
		},
		"froggy-price-negociator-button-alert": {
			"round": { },
			"color": { }
		}
	};
</script>