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

        {foreach from=$froggyhelper.configuration.form key=form_key item=form}
            <h3>{$form.label|escape:'htmlall':'UTF-8'}</h3>
            {foreach from=$form.fields item=field}
				<label for="{$field.name|escape:'htmlall':'UTF-8'}"> {$field.label|escape:'htmlall':'UTF-8'}</label>
				<div class="margin-form">
                    <div>
                        {if $field.type eq 'radio'}
                            <span class="switch prestashop-switch fixed-width-lg">
                                    <input type="radio" name="{$field.name|escape:'htmlall':'UTF-8'}" id="{$field.name|escape:'htmlall':'UTF-8'}_on" value="1" {if isset($field.value) && $field.value eq 1}checked="checked"{/if} />
                                    <label for="{$field.name|escape:'htmlall':'UTF-8'}_on"> {l s='Yes' mod='froggypricenegociator'}</label>
                                    <input type="radio" name="{$field.name|escape:'htmlall':'UTF-8'}" id="{$field.name|escape:'htmlall':'UTF-8'}_off" value="0" {if !isset($field.value) || $field.value ne 1}checked="checked"{/if} />
                                    <label for="{$field.name|escape:'htmlall':'UTF-8'}_off"> {l s='No' mod='froggypricenegociator'}</label>
                                    <a class="slide-button btn"></a>
                            </span>
                        {elseif $field.type eq 'text'}
							<input type="text" value="{if isset($field.value)}{$field.value|htmlentities}{/if}" name="{$field.name|escape:'htmlall':'UTF-8'}" id="{$field.name|escape:'htmlall':'UTF-8'}">
                        {elseif $field.type eq 'file'}
							<input type="file" name="{$field.name|escape:'htmlall':'UTF-8'}" id="{$field.name|escape:'htmlall':'UTF-8'}">
                        {elseif $field.type eq 'select'}
							<select name="{$field.name|escape:'htmlall':'UTF-8'}" id="{$field.name|escape:'htmlall':'UTF-8'}">
                                {foreach from=$field.values key=option_label item=option_value}
                                    <option value="{$option_value|escape:'htmlall':'UTF-8'}" {if isset($field.value) && $field.value eq $option_value}selected{/if}>{$option_label|escape:'htmlall':'UTF-8'}</option>
                                {/foreach}
                            </select>
                        {elseif $field.type eq 'custom' && isset($field.html)}
                            {FroggyDisplaySafeHtml s=$field.html}
                        {/if}
                        {if isset($field.desc)}<p class="help-block">{$field.desc|escape:'htmlall':'UTF-8'}</p>{/if}
                    </div>
                    <br clear="left">
                </div>
            {/foreach}
        {/foreach}

		<div class="margin-form">
			<button class="button" name="{$froggyhelper.module_name|escape:'htmlall':'UTF-8'}-submit" id="{$froggyhelper.module_name|escape:'htmlall':'UTF-8'}-form-submit-btn" value="1" type="submit">
				 {l s='Save' mod='froggypricenegociator'}
			</button>
		</div>
