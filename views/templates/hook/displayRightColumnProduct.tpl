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
	var FC_PN_DISPLAY_DELAYED = '{$froggypricenegociator.FC_PN_DISPLAY_DELAYED}';
    var froggypricenegociator_configurations = new Array();
    {foreach from=$froggypricenegociator.configurations key=id_product_attribute item=steps}
	    froggypricenegociator_configurations[{$id_product_attribute}] = new Array();
        {foreach from=$steps key=class item=price}
		    froggypricenegociator_configurations[{$id_product_attribute}]['{$class}'] = {$price};
        {/foreach}
    {/foreach}

	var froggypricenegociator_about_label = '{l s='about' mod='froggypricenegociator'}';
	var froggypricenegociator_message_label = new Array();
	froggypricenegociator_message_label['step1.too.high'] = '{l s='Your offer is superior to the current price of the product.' mod='froggypricenegociator'}';
	froggypricenegociator_message_label['step1.too.low'] = '{l s='Your offer is too low.' mod='froggypricenegociator'}';
	froggypricenegociator_message_label['step2.too.low'] = '{l s='Your offer was too low, here our final offer.' mod='froggypricenegociator'}';
	froggypricenegociator_message_label['step2.already.negotiated'] = '{l s='You already negotiated the price of this product, here the final offer.' mod='froggypricenegociator'}';
	froggypricenegociator_message_label['step2.good'] = '{l s='Your offer has been accepted!' mod='froggypricenegociator'}';
</script>

<a href="#" id="froggypricenegociator-button" data-reveal-id="myModal" title="{l s='Negotiate the price' mod='froggypricenegociator'}" class="button-12 froggy-price-negociator-button-front yellow radius">{l s='Negotiate the price' mod='froggypricenegociator'}</a>


<div id="myModal" class="reveal-modal">
	<div class="froggy-negociator-container-modal">
		<div class="froggy-negociator-breadcrumb-container">
			<ul>
				<li class="froggy-negociator-step-indicator froggy-negociator-current-step" id="froggy-negociator-breadcrumb-step1">
					1. {l s='Negotiation' mod='froggypricenegociator'}
				</li>
				<li class="froggy-negociator-step-indicator froggy-negociator-next-step" id="froggy-negociator-breadcrumb-step2">
					2. {l s='Validation' mod='froggypricenegociator'}
				</li>
				<li class="froggy-negociator-step-indicator froggy-negociator-next-step" id="froggy-negociator-breadcrumb-step3">
					3. {l s='Confirmation' mod='froggypricenegociator'}
				</li>
			</ul>
		</div>

		<div class="froggy-negociator-modal-step"id="froggy-negociator-modal-step1">

            <p class="froggy-negociator-title-modal">{l s='You do not have the budget?' mod='froggypricenegociator'}</p>
            <p class="froggy-negociator-subtitle-modal">{l s='How much you would pay for this product?' mod='froggypricenegociator'}</p>

            <form action="">

                <fieldset class="froggy-negociator-input-offer">
                    <input type="text" placeholder="{l s='Make an offer' mod='froggypricenegociator'}" id="froggy-negociator-input-offer"/>
                    <label for="froggy-negociator-input-offer">€</label>
                </fieldset>

                <fieldset class="froggy-negociator-progressbar-container">

                    <input type="radio" class="froggy-negociator-radio" name="progress" value="zero" id="froggy-negociator-zero" checked>
                    <input type="radio" class="froggy-negociator-radio" name="progress" value="five" id="froggy-negociator-five">
                    <input type="radio" class="froggy-negociator-radio" name="progress" value="twentyfive" id="froggy-negociator-twentyfive">
                    <input type="radio" class="froggy-negociator-radio" name="progress" value="fifty" id="froggy-negociator-fifty">
                    <input type="radio" class="froggy-negociator-radio" name="progress" value="seventyfive" id="froggy-negociator-seventyfive">
                    <input type="radio" class="froggy-negociator-radio" name="progress" value="onehundred" id="froggy-negociator-onehundred">

                    <p class="froggy-negociator-label-probability">{l s='Chance of success in your negotiation:' mod='froggypricenegociator'}</p>

                    <div class="progress">
                        <div class="progress-bar"></div>
                    </div>
                    <div class="froggy-negociator-comparaison-container">
                        <div class="froggy-negociator-price-info">
                            <p>{l s='Product price:' mod='froggypricenegociator'} <br/><span class="froggy-negociator-price-elements" id="froggy-negociator-product-price"></span></p>
                        </div>
                        <div class="froggy-negociator-price-info" id="froggy-negociator-product-price-reduction-info">
                            <p>{l s='Reduction:' mod='froggypricenegociator'} <br/> <span class="froggy-negociator-price-elements" id="froggy-negociator-product-price-reduction"></span></p>
                        </div>
                    </div>
                </fieldset>
                <fieldset class="froggy-negociator-validation-step1">
                    <input id="froggy-negociator-validation-step1-input-submit" type="submit" value="{l s='Submit my offer' mod='froggypricenegociator'}" />
                    <span id="froggy-negociator-validation-message-step1" class="froggy-negociator-validation-error"></span>
                </fieldset>

            </form>

		</div>


		<div class="froggy-negociator-modal-step" id="froggy-negociator-modal-step2">

			<p class="froggy-negociator-title-modal">{l s='Negotiated price' mod='froggypricenegociator'}</p>
			<p class="froggy-negociator-subtitle-modal" id="froggy-negociator-negociated-price"><img src="{$froggypricenegociator.module_dir}views/img/loader.gif" /></p>
			<p class="froggy-negociator-subtitle-modal" id="froggy-negociator-validation-message-step2"></p>

            <p class="froggy-negociator-subtitle-modal">{l s='Please fill your e-mail address to receive this offer by e-mail and add the product to your cart.' mod='froggypricenegociator'}</p>
			<p class="froggy-negociator-subtitle-modal"><u>{l s='This offer will be available for 24 hours only!' mod='froggypricenegociator'}</u></p>

			<form action="">

				<fieldset class="froggy-negociator-input-offer">
					<input type="text" placeholder="{l s='Your e-mail' mod='froggypricenegociator'}" id="froggy-negociator-input-email" />
				</fieldset>

				<fieldset class="froggy-negociator-validation-step1">
					<input id="froggy-negociator-validation-step2-input-submit" type="submit" value="{l s='Validate my e-mail' mod='froggypricenegociator'}" />
				</fieldset>

			</form>


        </div>

		<div class="froggy-negociator-modal-step" id="froggy-negociator-modal-step3">

			<p class="froggy-negociator-title-modal">{l s='Negotiated price' mod='froggypricenegociator'}</p>
			<p class="froggy-negociator-subtitle-modal" id="froggy-negociator-negociated-price-step3"></p>

			<form action="{$link->getPageLink('order')}">

				<fieldset class="froggy-negociator-validation-step1">
					<input id="froggy-negociator-validation-step3-input-submit" type="submit" value="{l s='Go to the cart' mod='froggypricenegociator'}" />
				</fieldset>

			</form>
		</div>

		{if $froggypricenegociator.FC_PN_DISPLAY_MODE eq 'REVEAL'}<a class="close-reveal-modal">&#215;</a>{/if}
	</div>
</div>