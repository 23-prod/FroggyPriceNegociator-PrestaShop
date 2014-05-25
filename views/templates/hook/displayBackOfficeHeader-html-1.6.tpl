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
    var fc_pn_negociator_options = '<h3>{l s='Froggy price negociator' mod='froggypricenegociator'}</h3>' +

    {if $froggypricenegociator.FC_PN_ENABLE_GENERAL_OPTION eq '1'}
            '<div class="form-group">' +
            '<div class="col-lg-9 col-lg-offset-3">' +
            '<div class="alert alert-warning">' +
            '<p>{l s='The general negociation option has been enabled in the module configuration.' mod='froggypricenegociator'}<br>' +
            '{l s='All products (including this one) will have a maximum negociation of' mod='froggypricenegociator'} {$froggypricenegociator.FC_PN_GENERAL_REDUCTION}%.<br>' +
            '{l s='In that case, the minimum sell price will be' mod='froggypricenegociator'} <b><span id="froggypricenegociator_minimum_sell_price"></span></b>.</p>' +
            '</div>' +
            '</div>' +
            '</div>' +
    {/if}

            '<div class="form-group">' +
            '<label for="on_sale" class="control-label col-lg-3"></label>' +
            '<div class="col-lg-9">' +
            '<div class="checkbox">' +
            '<label for="froggypricenegociator-option" class="control-label froggypricenegociator-label">' +
            '<input type="checkbox" value="1" id="froggypricenegociator-option" name="froggypricenegociator_option" {if $froggypricenegociator.fpn_product->active}checked="checked"{/if}>' +
            '{l s='Enable price negociation button for this product' mod='froggypricenegociator'}' +
            '</label>' +
            '</div>' +
            '</div>' +
            '</div>' +

    {if $froggypricenegociator.FC_PN_TYPE eq 'PRICE_MINI'}
        '<div class="form-group">' +
                '<label for="froggypricenegociator-price-min" class="control-label col-lg-3 froggypricenegociator-label" id="froggypricenegociator-label-field-2">{l s='Minimum price sell:' mod='froggypricenegociator'}</label>' +
                '<div class="input-group col-lg-2">' +
                '<span class="input-group-addon"> {$froggypricenegociator.currency->sign}</span>' +
                '<input type="text" value="{$froggypricenegociator.fpn_product->price_min}" id="froggypricenegociator-price-min" name="froggypricenegociator_price_min" maxlength="14">' +
                '<span class="input-group-addon" id="froggypricenegociator-reduction-percent-max">- {$froggypricenegociator.fpn_product->reduction_percent_max}%</span>' +
                '<input type="hidden" id="froggypricenegociator-reduction-percent-max-hidden" name="froggypricenegociator_reduction_percent_max" value="{$froggypricenegociator.fpn_product->reduction_percent_max}" />' +
                '</div>' +
        '</div>';
    {else}
        '<div class="form-group">' +
                '<label for="froggypricenegociator-price-min" class="control-label col-lg-3 froggypricenegociator-label" id="froggypricenegociator-label-field-2">{l s='Percent:' mod='froggypricenegociator'}</label>' +
                '<div class="input-group col-lg-2">' +
                '<span class="input-group-addon">- %</span>' +
                '<input type="text" value="{$froggypricenegociator.fpn_product->reduction_percent_max}" id="froggypricenegociator-reduction-percent-max" name="froggypricenegociator_reduction_percent_max" maxlength="14">' +
                '<span class="input-group-addon" id="froggypricenegociator-price-min">{l s='In that case, the minimum sell price will be' mod='froggypricenegociator'} {$froggypricenegociator.fpn_product->price_min} {$froggypricenegociator.currency->sign}</span>' +
                '<input type="hidden" id="froggypricenegociator-price-min-hidden" name="froggypricenegociator_price_min" value="{$froggypricenegociator.fpn_product->price_min}" />' +
                '</div>' +
        '</div>';
    {/if}

</script>
