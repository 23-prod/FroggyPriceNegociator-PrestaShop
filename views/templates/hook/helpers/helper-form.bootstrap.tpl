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

        {foreach from=$froggyhelper.configuration.form key=form_key item=form}
            <h3>{$form.label|escape:'html':'UTF-8'}</h3>
            {foreach from=$form.fields item=field}
                <div class="form-group">
                    <label class="control-label col-lg-3" for="{$field.name|escape:'html':'UTF-8'}"> {$field.label|escape:'html':'UTF-8'}</label>
                    <div class="col-lg-9 ">
                        {if $field.type eq 'radio'}
                            <span class="switch prestashop-switch fixed-width-lg">
                                    <input type="radio" name="{$field.name|escape:'html':'UTF-8'}" id="{$field.name|escape:'html':'UTF-8'}_on" value="1" {if isset($field.value) && $field.value eq 1}checked="checked"{/if} />
                                    <label for="{$field.name|escape:'html':'UTF-8'}_on"> {l s='Yes' mod='froggytoolbarv2'}</label>
                                    <input type="radio" name="{$field.name|escape:'html':'UTF-8'}" id="{$field.name|escape:'html':'UTF-8'}_off" value="0" {if !isset($field.value) || $field.value ne 1}checked="checked"{/if} />
                                    <label for="{$field.name|escape:'html':'UTF-8'}_off"> {l s='No' mod='froggytoolbarv2'}</label>
                                    <a class="slide-button btn"></a>
                            </span>
                        {elseif $field.type eq 'text'}
							<input type="text" value="{if isset($field.value)}{$field.value|htmlentities}{/if}" name="{$field.name}" id="{$field.name}">
                        {elseif $field.type eq 'select'}
							<select name="{$field.name|escape:'html':'UTF-8'}" id="{$field.name|escape:'html':'UTF-8'}">
                                {foreach from=$field.values key=option_label item=option_value}
                                    <option value="{$option_value}" {if isset($field.value) && $field.value eq $option_value}selected{/if}>{$option_label}</option>
                                {/foreach}
                            </select>
                        {elseif $field.type eq 'custom' && isset($field.html)}
                            {FroggyDisplaySafeHtml s=$field.html}
                        {/if}
                        {if isset($field.desc)}<p class="help-block">{$field.desc}</p>{/if}
                    </div>
                    <br clear="left">
                </div>
            {/foreach}
        {/foreach}

		<div class="panel-footer">
			<button class="btn btn-default pull-right" name="{$froggyhelper.module_name|escape:'html':'UTF-8'}-submit" id="{$froggyhelper.module_name|escape:'html':'UTF-8'}-form-submit-btn" value="1" type="submit">
				<i class="process-icon-save"></i> {l s='Save' mod='froggytoolbarv2'}
			</button>
		</div>
