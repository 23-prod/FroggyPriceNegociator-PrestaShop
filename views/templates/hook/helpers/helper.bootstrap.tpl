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

<form enctype="multipart/form-data" method="POST" action="{$froggyhelper.form_url|escape:'html':'UTF-8'}">

	<input type="hidden" value="1" name="{$froggyhelper.module_name|escape:'html':'UTF-8'}-{$froggyhelper.configuration.key|escape:'html':'UTF-8'}-submit">

	<div id="fieldset-{$froggyhelper.module_name|escape:'html':'UTF-8'}-{$froggyhelper.configuration.key|escape:'html':'UTF-8'}" class="panel">
		<div class="panel-heading">
			<img alt="{$froggyhelper.configuration.label|escape:'html':'UTF-8'}" src="../modules/{$froggyhelper.module_name|escape:'html':'UTF-8'}/logo.gif"> {$froggyhelper.configuration.label|escape:'html':'UTF-8'}
		</div><br>

        {if isset($froggyhelper.configuration.list)}
            {include file="{$froggyhelper.templates_dir}/helper-list.bootstrap.tpl"}
        {/if}

        {if isset({$froggyhelper.configuration.form})}
            {include file="{$froggyhelper.templates_dir}/helper-form.bootstrap.tpl"}
        {/if}

	</div>

</form>