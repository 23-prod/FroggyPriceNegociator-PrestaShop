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
    var fc_pn_is_product_blacklisted = '{$froggypricenegociator.is_product_blacklisted|escape:'html':'UTF-8'}';
    var fc_pn_enable_general_option = '{$froggypricenegociator.FC_PN_ENABLE_GENERAL_OPTION|escape:'html':'UTF-8'}';
    var fc_pn_general_reduction = '{$froggypricenegociator.FC_PN_GENERAL_REDUCTION|escape:'html':'UTF-8'}'
    var fc_pn_type = '{$froggypricenegociator.FC_PN_TYPE|escape:'html':'UTF-8'}'
    var fc_pn_currency_sign = '{$froggypricenegociator.currency->sign|escape:'html':'UTF-8'}';
</script>
{if $froggypricenegociator.ps_version eq '1.6'}
    {include file="{$froggypricenegociator.path_template_dir}/displayBackOfficeHeader-html-1.6.tpl"}
{else}
    {include file="{$froggypricenegociator.path_template_dir}/displayBackOfficeHeader-html-1.4-1.5.tpl"}
{/if}
<script type="text/javascript" src="{$froggypricenegociator.module_dir|escape:'html':'UTF-8'}views/js/displayBackOfficeHeader-{$froggypricenegociator.ps_version|escape:'html':'UTF-8'}.js"></script>
<script type="text/javascript" src="{$froggypricenegociator.module_dir|escape:'html':'UTF-8'}views/js/displayBackOfficeHeader-common.js"></script>
<link type="text/css" rel="stylesheet" href="{$froggypricenegociator.module_dir|escape:'html':'UTF-8'}views/css/displayBackOfficeHeader-{$froggypricenegociator.ps_version|escape:'html':'UTF-8'}.css" />