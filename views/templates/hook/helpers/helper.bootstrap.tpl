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
*  @author Froggy Commerce <contact@froggy-commerce.com>
*  @copyright  2013-2014 Froggy Commerce
*}

<form enctype="multipart/form-data" method="POST" action="{$froggyhelper.form_url}">

	<input type="hidden" value="1" name="{$froggyhelper.module_name}-{$froggyhelper.configuration.key}-submit">

	<div id="fieldset-{$froggyhelper.module_name}-{$froggyhelper.configuration.key}" class="panel">
		<div class="panel-heading">
			<img alt="{$froggyhelper.configuration.label}" src="../modules/{$froggyhelper.module_name}/logo.gif"> {$froggyhelper.configuration.label}
		</div><br>

        {if isset($froggyhelper.configuration.list)}
            {include file='./helper-list.bootstrap.tpl'}
        {/if}

        {if isset({$froggyhelper.configuration.form})}
            {include file='./helper-form.bootstrap.tpl'}
        {/if}

	</div>

</form>