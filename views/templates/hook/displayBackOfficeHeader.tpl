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
    var negociator_options = '<tr>' +
            '<td colspan="2"><div class="separation"></div></td></tr><tr>' +
            '<td colspan="2"><h4>{l s='Froggy price negociator' mod='froggypricenegociator'}</h4></td></tr><tr>' +
            '<td><label>&nbsp;</label></td>' +
            '<td><input type="checkbox" value="1" style="padding-top: 5px;" id="froggypricenegociator_option" name="froggypricenegociator_option" {if $froggypricenegociator.fpn_product->active}checked="checked"{/if}>&nbsp;' +
            '<label class="t" for="negociator_option">{l s='Enable price negociation button for this product' mod='froggypricenegociator'}</label></td>' +
            '</tr>' +
            '<tr>' +
            '<td><label>{l s='Minimum price sell:' mod='froggypricenegociator'}</label></td>' +
            '<td><input type="text" value="{$froggypricenegociator.fpn_product->price_min}" style="padding-top: 5px;" id="froggypricenegociator_price_min" name="froggypricenegociator_price_min">&nbsp;<span id="froggypricenegociator_percent_reduction_max">- {$froggypricenegociator.fpn_product->reduction_percent_max}%</span></td>' +
            '</tr>';
</script>
<script type="text/javascript" src="{$froggypricenegociator.module_dir}views/js/displayBackOfficeHeader-{$froggypricenegociator.ps_version}.js"></script>
<script type="text/javascript" src="{$froggypricenegociator.module_dir}views/js/displayBackOfficeHeader-common.js"></script>

