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


        {foreach from=$froggyhelper.configuration.form key=form_key item=form}
            <h3>{$form.label}</h3>
            {foreach from=$form.fields item=field}
                <div class="form-group">
                    <label class="control-label col-lg-3" for="{$field.name}"> {$field.label}</label>
                    <div class="col-lg-9 ">
                        {if $field.type eq 'radio'}
                            <span class="switch prestashop-switch fixed-width-lg">
                                    <input type="radio" name="{$field.name}" id="{$field.name}_on" value="1" {if isset($field.value) && $field.value eq 1}checked="checked"{/if} />
                                    <label for="{$field.name}_on"> {l s='Yes' mod=$froggyhelper.module_name}</label>
                                    <input type="radio" name="{$field.name}" id="{$field.name}_off" value="0" {if !isset($field.value) || $field.value ne 1}checked="checked"{/if} />
                                    <label for="{$field.name}_off"> {l s='No' mod=$froggyhelper.module_name}</label>
                                    <a class="slide-button btn"></a>
                            </span>
                        {elseif $field.type eq 'text'}
							<input type="text" value="{if isset($field.value)}{$field.value|htmlentities}{/if}" name="{$field.name}" id="{$field.name}">
                        {/if}
                        <p class="help-block">{$field.desc}</p>
                    </div>
                    <br clear="left">
                </div>
            {/foreach}
        {/foreach}

		<div class="panel-footer">
			<button class="btn btn-default pull-right" name="{$froggyhelper.module_name}-submit" id="{$froggyhelper.module_name}-form-submit-btn" value="1" type="submit">
				<i class="process-icon-save"></i> {l s='Save' mod=$froggyhelper.module_name}
			</button>
		</div>
