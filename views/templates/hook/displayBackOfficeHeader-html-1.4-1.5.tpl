{*
* 2010 - 2014 Sellermania / Froggy Commerce / 23Prod SARL
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to team@froggy-commerce.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade your module to newer
* versions in the future.
*
*  @author Fabien Serny - Froggy Commerce <team@froggy-commerce.com>
*  @copyright	2010-2014 Sellermania / Froggy Commerce / 23Prod SARL
*  @version		1.0
*  @license		http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*}

<script>
    var froggypricenegociator_combinations = new Array();
    {foreach from=$froggypricenegociator.combinations key=kpnc item=pnc}
        {if $pnc.id_product_attribute gt 0}
            froggypricenegociator_combinations[{$kpnc}] = new Array("{$pnc.id_product_attribute}", "{$pnc.price_min}", "{$pnc.reduction_percent_max}", "{$pnc.active}");
        {/if}
    {/foreach}

    var fc_pn_negociator_label_product_attribute = '{l s='Enable price negociation button for this product attribute' mod='froggypricenegociator'}';
	var fc_pn_negociator_label_price_error = '{l s='Beware, the minimum price sell is superior to the final retail place.'}';
    var fc_pn_negociator_options = '{if $froggypricenegociator.ps_version eq '1.4'}<tr><td colspan="2"><hr style="width:100%;" id="froggypricenegociator-separator">{else}<div class="separation" id="froggypricenegociator-separator"></div>{/if}<table> \
        <tr><td colspan="2"><h4 id="froggypricenegociator-title">{l s='Froggy Price Negotiator' mod='froggypricenegociator'}</h4></td></tr> \
        {if $froggypricenegociator.is_product_blacklisted eq '1'}
            <tr><td colspan="2"> \
            <p>{l s='The product is not eligible for negotiation, the possible reasons are:' mod='froggypricenegociator'}<br> \
                {l s='- One of the category associated to this product is blacklisted in the module configuration.' mod='froggypricenegociator'}<br> \
                {l s='- The manufacturer associated to this product is blacklisted in the module configuration.' mod='froggypricenegociator'}</p> \
            </td></tr> \
        {else if $froggypricenegociator.FC_PN_ENABLE_GENERAL_OPTION eq '1'}
            <tr><td colspan="2"> \
            <p>{l s='The general negotiation option has been enabled in the module configuration.' mod='froggypricenegociator'}<br> \
                {l s='All products (including this one) will have a maximum negotiation of' mod='froggypricenegociator'} {$froggypricenegociator.FC_PN_GENERAL_REDUCTION}%.<br> \
                {l s='In that case, the minimum sell price will be' mod='froggypricenegociator'} <b><span id="froggypricenegociator-minimum-sell-price"></span></b>.</p> \
            </td></tr> \
        {/if}
        <tr id="froggypricenegociator-checkbox-details"> \
            <td class="col-left"><label>&nbsp;</label></td> \
            <td><input type="checkbox" value="1" style="padding-top: 5px;" id="froggypricenegociator-option" name="froggypricenegociator_option" {if $froggypricenegociator.fpn_product->active}checked="checked"{/if}>&nbsp; \
                <label id="froggypricenegociator-option-label" class="t froggypricenegociator-label" for="froggypricenegociator-option">{l s='Enable price negociation button for this product' mod='froggypricenegociator'}</label></td> \
            </tr> \
        {if $froggypricenegociator.FC_PN_TYPE eq 'PRICE_MINI'}
        <tr id="froggypricenegociator-details"> \
            <td class="col-left"><label class="froggypricenegociator-label" id="froggypricenegociator-label-field-2">{l s='Minimum price sell:' mod='froggypricenegociator'}</label></td> \
            <td> \
                <input type="text" value="{$froggypricenegociator.fpn_product->price_min}" style="padding-top: 5px;" id="froggypricenegociator-price-min" name="froggypricenegociator_price_min">&nbsp; \
                <span id="froggypricenegociator-reduction-percent-max">- {$froggypricenegociator.fpn_product->reduction_percent_max}%</span> \
                <input type="hidden" id="froggypricenegociator-reduction-percent-max-hidden" name="froggypricenegociator_reduction_percent_max" value="{$froggypricenegociator.fpn_product->reduction_percent_max}" /> \
                </td> \
            </tr> \
            {else}
        <tr id="froggypricenegociator-details"> \
            <td class="col-left"><label class="froggypricenegociator-label" id="froggypricenegociator-label-field-2">{l s='Percent:' mod='froggypricenegociator'}</label></td> \
            <td> \
                - <input type="text" value="{$froggypricenegociator.fpn_product->reduction_percent_max}" style="padding-top: 5px;" id="froggypricenegociator-reduction-percent-max" name="froggypricenegociator_reduction_percent_max"><span id="froggypricenegociator-reduction-percent-max-label">%, {l s='In that case, the minimum sell price will be' mod='froggypricenegociator'}</span>  \
                <b><span id="froggypricenegociator-price-min">{$froggypricenegociator.fpn_product->price_min}</span></b> \
                <input type="hidden" id="froggypricenegociator-price-min-hidden" name="froggypricenegociator_price_min" value="{$froggypricenegociator.fpn_product->price_min}" /> \
                </td> \
            </tr> \
        {/if}
        {if $froggypricenegociator.ps_version eq '1.4'}</table></td></tr>{/if}';
</script>