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
            froggypricenegociator_combinations[{$kpnc}] = new Array("{$pnc.id_product_attribute|escape:'html':'UTF-8'}", "{$pnc.price_min|escape:'html':'UTF-8'}", "{$pnc.reduction_percent_max|escape:'html':'UTF-8'}", "{$pnc.active|escape:'html':'UTF-8'}");
        {/if}
    {/foreach}

    var fc_pn_negociator_label_product_attribute = '{{l s='Enable price negotiation button for this product attribute' mod='froggypricenegociator' js=1}|stripslashes|addslashes}';
	var fc_pn_negociator_label_price_error = '{{l s='Beware, the minimum price sell is superior to the final retail place.' mod='froggypricenegociator' js=1}|stripslashes|addslashes}';
    var fc_pn_negociator_options = '{if $froggypricenegociator.ps_version eq '1.4'}<tr><td colspan="2"><hr style="width:100%;" id="froggypricenegociator-separator">{else}<div class="separation" id="froggypricenegociator-separator"></div>{/if}<table> \
        <tr><td colspan="2"><h4 id="froggypricenegociator-title">{{l s='Froggy Price Negotiator' mod='froggypricenegociator' js=1}|stripslashes|addslashes}</h4></td></tr> \
        {if $froggypricenegociator.is_product_blacklisted eq '1'}
            <tr><td colspan="2"> \
            <p>{{l s='The product is not eligible for negotiation, the possible reasons are:' mod='froggypricenegociator' js=1}|stripslashes|addslashes}<br> \
                {{l s='- One of the category associated to this product is blacklisted in the module configuration.' mod='froggypricenegociator' js=1}|stripslashes|addslashes}<br> \
                {{l s='- The manufacturer associated to this product is blacklisted in the module configuration.' mod='froggypricenegociator' js=1}|stripslashes|addslashes}</p> \
            </td></tr> \
        {else if $froggypricenegociator.FC_PN_ENABLE_GENERAL_OPTION eq '1'}
            <tr><td colspan="2"> \
            <p>{{l s='The general negotiation option has been enabled in the module configuration.' mod='froggypricenegociator' js=1}|stripslashes|addslashes}<br> \
                {{l s='All products (including this one) will have a maximum negotiation of' mod='froggypricenegociator' js=1}|stripslashes|addslashes} {$froggypricenegociator.FC_PN_GENERAL_REDUCTION}%.<br> \
                {{l s='In that case, the minimum sell price will be' mod='froggypricenegociator' js=1}|stripslashes|addslashes} <b><span id="froggypricenegociator-minimum-sell-price"></span></b>.</p> \
            </td></tr> \
        {/if}
        <tr id="froggypricenegociator-checkbox-details"> \
            <td class="col-left"><label>&nbsp;</label></td> \
            <td><input type="checkbox" value="1" style="padding-top: 5px;" id="froggypricenegociator-option" name="froggypricenegociator_option" {if $froggypricenegociator.fpn_product->active}checked="checked"{/if}>&nbsp; \
                <label id="froggypricenegociator-option-label" class="t froggypricenegociator-label" for="froggypricenegociator-option">{{l s='Enable price negotiation button for this product' mod='froggypricenegociator' js=1}|stripslashes|addslashes}</label></td> \
            </tr> \
        {if $froggypricenegociator.FC_PN_TYPE eq 'PRICE_MINI'}
        <tr id="froggypricenegociator-details"> \
            <td class="col-left"><label class="froggypricenegociator-label" id="froggypricenegociator-label-field-2">{{l s='Minimum price sell:' mod='froggypricenegociator' js=1}|stripslashes|addslashes}</label></td> \
            <td> \
                <input type="text" value="{$froggypricenegociator.fpn_product->price_min|escape:'html':'UTF-8'}" style="padding-top: 5px;" id="froggypricenegociator-price-min" name="froggypricenegociator_price_min">&nbsp; \
                <span id="froggypricenegociator-reduction-percent-max">- {$froggypricenegociator.fpn_product->reduction_percent_max|escape:'html':'UTF-8'}%</span> \
                <input type="hidden" id="froggypricenegociator-reduction-percent-max-hidden" name="froggypricenegociator_reduction_percent_max" value="{$froggypricenegociator.fpn_product->reduction_percent_max|escape:'html':'UTF-8'}" /> \
                </td> \
            </tr> \
            {else}
        <tr id="froggypricenegociator-details"> \
            <td class="col-left"><label class="froggypricenegociator-label" id="froggypricenegociator-label-field-2">{{l s='Percent:' mod='froggypricenegociator' js=1}|stripslashes|addslashes}</label></td> \
            <td> \
                - <input type="text" value="{$froggypricenegociator.fpn_product->reduction_percent_max|escape:'html':'UTF-8'}" style="padding-top: 5px;" id="froggypricenegociator-reduction-percent-max" name="froggypricenegociator_reduction_percent_max"><span id="froggypricenegociator-reduction-percent-max-label">%, {{l s='In that case, the minimum sell price will be' mod='froggypricenegociator' js=1}|stripslashes|addslashes}</span>  \
                <b><span id="froggypricenegociator-price-min">{$froggypricenegociator.fpn_product->price_min|escape:'html':'UTF-8'}</span></b> \
                <input type="hidden" id="froggypricenegociator-price-min-hidden" name="froggypricenegociator_price_min" value="{$froggypricenegociator.fpn_product->price_min|escape:'html':'UTF-8'}" /> \
                </td> \
            </tr> \
        {/if}
        {if $froggypricenegociator.ps_version eq '1.4'}</table></td></tr>{/if}';
</script>