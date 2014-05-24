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

    {if isset($froggypricenegociator.result)}
        <div class="conf confirm">{l s='The new configuration has been saved!' mod='froggypricenegociator'}</div>
    {/if}


	<div id="froggypricenegociator_options">
        <form method="POST" action="">

            <h3>{l s='Mode configuration:' mod='froggypricenegociator'}</h3>
            <br>

            <label>{l s='Enable price negotiation button on all products:' mod='froggypricenegociator'}</label>
            <div class="margin-form"><input type="checkbox" name="FC_PN_ENABLE_GENERAL_OPTION" value="1"{if $froggypricenegociator.FC_PN_ENABLE_GENERAL_OPTION} checked="checked"{/if} /></div>
            <br><span>{l s='Enable price negotiation button for all products (you won\'t have to set a configuration for each product).' mod='froggypricenegociator'}</span>
            <br><br><br>

            <label>{l s='General reduction in percent:' mod='froggypricenegociator'}</label>
            <div class="margin-form"><input type="text" name="FC_PN_GENERAL_REDUCTION" value="{$froggypricenegociator.FC_PN_GENERAL_REDUCTION}" /> %</div>
            <span>{l s='If you enabled the button for all products, you have to set a reduction in percent for all products.' mod='froggypricenegociator'}</span>
            <br><br><br>

            <label>{l s='Type reduction:' mod='froggypricenegociator'}</label>
            <div class="margin-form">
                <select name="FC_PN_TYPE">
                    <option value="PRICE_MINI" {if $froggypricenegociator.FC_PN_TYPE eq 'PRICE_MINI'}selected="selected"{/if}>{l s='Define price minimum' mod='froggypricenegociator'}</option>
                    <option value="PERCENT" {if $froggypricenegociator.FC_PN_TYPE eq 'PERCENT'}selected="selected"{/if}>{l s='Define maximum percent' mod='froggypricenegociator'}</option>
                </select>
            </div>
            <span>{l s='Please look at the documentation for more details.' mod='froggypricenegociator'}</span>
            <br><br><br>

            <h3>{l s='General option:' mod='froggypricenegociator'}</h3>

            <label>{l s='Max product by cart:' mod='froggypricenegociator'}</label>
            <div class="margin-form"><input type="text" name="FC_PN_MAX_PRODUCT_BY_CART" value="{$froggypricenegociator.FC_PN_MAX_PRODUCT_BY_CART}" /></div>
            <span>{l s='Limit the number of negociated products by cart.' mod='froggypricenegociator'}</span>
            <br><br><br>

            <label>{l s='Compliant with promotion:' mod='froggypricenegociator'}</label>
            <div class="margin-form"><input type="checkbox" name="FC_PN_COMPLIANT_PROMO" value="1"{if $froggypricenegociator.FC_PN_COMPLIANT_PROMO} checked="checked"{/if} /></div>
            <span>{l s='Display price negotiation button on product in promotion.' mod='froggypricenegociator'}</span>
            <br><br><br>

            <label>{l s='Compliant with new products:' mod='froggypricenegociator'}</label>
            <div class="margin-form"><input type="checkbox" name="FC_PN_COMPLIANT_NEW" value="1"{if $froggypricenegociator.FC_PN_COMPLIANT_NEW} checked="checked"{/if} /></div>
            <span>{l s='Display price negotiation button on new products.' mod='froggypricenegociator'}</span>
            <br><br><br>

            <label>{l s='Compliant with discounts:' mod='froggypricenegociator'}</label>
            <div class="margin-form"><input type="checkbox" name="FC_PN_COMPLIANT_DISCOUNT" value="1"{if $froggypricenegociator.FC_PN_COMPLIANT_DISCOUNT} checked="checked"{/if} /></div>
            <span>{l s='Customers can use discount code with negociated products.' mod='froggypricenegociator'}</span>
            <br><br><br>

            <label>{l s='Disable price negotiation button for the following categories:' mod='froggypricenegociator'}</label>
            <div class="margin-form"><input type="text" name="FC_PN_DISABLE_FOR_CATS" value="{$froggypricenegociator.FC_PN_DISABLE_FOR_CATS}" /></div>
            <br><span>{l s='If a product is associated to one of these categories, price negotiation button will be disabled.' mod='froggypricenegociator'}</span>
            <br><br><br>

            <label>{l s='Disable price negotiation button for the following brands:' mod='froggypricenegociator'}</label>
            <div class="margin-form"><input type="text" name="FC_PN_DISABLE_FOR_BRANDS" value="{$froggypricenegociator.FC_PN_DISABLE_FOR_BRANDS}" /></div>
            <br><span>{l s='If a product is associated to one of these brands, price negotiation button will be disabled.' mod='froggypricenegociator'}</span>
            <br><br><br>

            <label>{l s='Disable price negotiation button for the following customers:' mod='froggypricenegociator'}</label>
            <div class="margin-form"><input type="text" name="FC_PN_DISABLE_FOR_CUSTS" value="{$froggypricenegociator.FC_PN_DISABLE_FOR_CUSTS}" /></div>
            <br><span>{l s='Price negotiation button will be disabled for all these customers.' mod='froggypricenegociator'}</span>
            <br><br><br>

            <label>{l s='Display mode:' mod='froggypricenegociator'}</label>
            <div class="margin-form">
                <select name="FC_PN_DISPLAY_MODE">
                    <option value="FANCYBOX" {if $froggypricenegociator.FC_PN_DISPLAY_MODE eq 'FANCYBOX'}selected="selected"{/if}>{l s='Fancybox (jQuery)' mod='froggypricenegociator'}</option>
                    <option value="REVEAL" {if $froggypricenegociator.FC_PN_DISPLAY_MODE eq 'REVEAL'}selected="selected"{/if}>{l s='Reveal (Foundation)' mod='froggypricenegociator'}</option>
                </select>
            </div>
            <span>{l s='The display when customer click on the price negotiation button.' mod='froggypricenegociator'}</span>
            <br><br><br>

            <label>{l s='Display price negotiation button after:' mod='froggypricenegociator'}</label>
            <div class="margin-form"><input type="text" name="FC_PN_DISPLAY_DELAYED" value="{$froggypricenegociator.FC_PN_DISPLAY_DELAYED}" /> s</div>
            <span>{l s='You can delay the display of the price negotiation button, it will permit to display the button when a customer hesitate to add a product to your cart.' mod='froggypricenegociator'}</span>
            <br><br><br>

            <label><input type="submit" name="submitFroggyPriceNegociatorConfiguration" value="{l s='Save' mod='froggypricenegociator'}" name="froggypricenegociator_ft_form" class="button" /></label>
        </form>
	</div>
</fieldset>

