{**
 * 2013-2015 Froggy Commerce
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
 * @copyright 2013-2015 Froggy Commerce
 * @license   Unauthorized copying of this file, via any medium is strictly prohibited
 *}

<script>
    var froggypricenegociator_combinations = new Array();
    {foreach from=$froggypricenegociator.combinations key=kpnc item=pnc}
        {if $pnc.id_product_attribute gt 0}
        froggypricenegociator_combinations[{$kpnc|escape:'html':'UTF-8'}] = new Array("{$pnc.id_product_attribute|escape:'html':'UTF-8'}", "{$pnc.price_min|escape:'html':'UTF-8'}", "{$pnc.reduction_percent_max|escape:'html':'UTF-8'}", "{$pnc.active|escape:'html':'UTF-8'}");
        {/if}
    {/foreach}

    var fc_pn_negociator_label_product_attribute = '{l s='Enable price negotiation button for this product attribute' mod='froggypricenegociator' js=1}';
	var fc_pn_negociator_label_price_error = '{l s='Beware, the minimum price sell is superior to the final retail place.' mod='froggypricenegociator' js=1}';
    var fc_pn_negociator_options = '<h3 id="froggypricenegociator-title">{l s='Froggy Price Negotiator' mod='froggypricenegociator' js=1}</h3> \
    \
    {if $froggypricenegociator.is_product_blacklisted eq '1'}
			<div class="form-group"> \
            <div class="col-lg-9 col-lg-offset-3"> \
            <div class="alert alert-warning"> \
            <p>{l s='The product is not eligible for negotiation, the possible reasons are:' mod='froggypricenegociator' js=1}<br> \
            {l s='- One of the category associated to this product is blacklisted in the module configuration.' mod='froggypricenegociator' js=1}<br> \
            {l s='- The manufacturer associated to this product is blacklisted in the module configuration.' mod='froggypricenegociator' js=1}</p> \
            </div> \
            </div> \
            </div> \
    {elseif $froggypricenegociator.FC_PN_ENABLE_GENERAL_OPTION eq '1'}
            <div class="form-group"> \
            <div class="col-lg-9 col-lg-offset-3"> \
            <div class="alert alert-warning"> \
            <p>{l s='The general negotiation option has been enabled in the module configuration.' mod='froggypricenegociator' js=1}<br> \
            {l s='All products (including this one) will have a maximum negotiation of' mod='froggypricenegociator' js=1} {$froggypricenegociator.FC_PN_GENERAL_REDUCTION|escape:'html':'UTF-8'}%.<br> \
            {l s='In that case, the minimum sell price will be' mod='froggypricenegociator' js=1} <b><span id="froggypricenegociator-minimum-sell-price"></span></b>.</p> \
            </div> \
            </div> \
            </div> \
    {/if}
	        \
            <div class="form-group" id="froggypricenegociator-checkbox-details"> \
            <div class="col-lg-9"> \
            <div class="checkbox"> \
            <label for="froggypricenegociator-option" class="control-label froggypricenegociator-label"> \
            <input type="checkbox" value="1" id="froggypricenegociator-option" name="froggypricenegociator_option" {if $froggypricenegociator.fpn_product->active}checked="checked"{/if}> \
            <span id="froggypricenegociator-option-label">{l s='Enable price negotiation button for this product' mod='froggypricenegociator' js=1}</span> \
            </label> \
            </div> \
            </div> \
            </div> \
            \
    {if $froggypricenegociator.FC_PN_TYPE eq 'PRICE_MINI'}
        <div class="form-group" id="froggypricenegociator-details"> \
                <label for="froggypricenegociator-price-min" class="control-label col-lg-3 froggypricenegociator-label" id="froggypricenegociator-label-field-2">{l s='Minimum price sell:' mod='froggypricenegociator' js=1}</label> \
                <div class="input-group col-lg-2"> \
                <span class="input-group-addon"> {$froggypricenegociator.currency->sign|escape:'html':'UTF-8'}</span> \
                <input type="text" value="{$froggypricenegociator.fpn_product->price_min|escape:'html':'UTF-8'}" id="froggypricenegociator-price-min" name="froggypricenegociator_price_min" maxlength="14" style="min-width:100px"> \
                <span class="input-group-addon" id="froggypricenegociator-reduction-percent-max">- {$froggypricenegociator.fpn_product->reduction_percent_max|escape:'html':'UTF-8'}%</span> \
                <input type="hidden" id="froggypricenegociator-reduction-percent-max-hidden" name="froggypricenegociator_reduction_percent_max" value="{$froggypricenegociator.fpn_product->reduction_percent_max|escape:'html':'UTF-8'}" /> \
                </div> \
        </div>';
    {else}
        <div class="form-group" id="froggypricenegociator-details"> \
                <label for="froggypricenegociator-price-min" class="control-label col-lg-3 froggypricenegociator-label" id="froggypricenegociator-label-field-2">{l s='Percent:' mod='froggypricenegociator' js=1}</label> \
                <div class="input-group col-lg-2"> \
                <span class="input-group-addon">- %</span> \
                <input type="text" value="{$froggypricenegociator.fpn_product->reduction_percent_max|escape:'html':'UTF-8'}" id="froggypricenegociator-reduction-percent-max" name="froggypricenegociator_reduction_percent_max" maxlength="14" style="min-width:100px"> \
                <span class="input-group-addon" id="froggypricenegociator-price-min">{$froggypricenegociator.fpn_product->price_min|escape:'html':'UTF-8'} {$froggypricenegociator.currency->sign|escape:'html':'UTF-8'}</span> \
                <input type="hidden" id="froggypricenegociator-price-min-hidden" name="froggypricenegociator_price_min" value="{$froggypricenegociator.fpn_product->price_min|escape:'html':'UTF-8'}" /> \
                </div> \
        </div>';
    {/if}
</script>
