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
	var FC_PN_DISPLAY_DELAYED = '{if $froggypricenegociator.FC_PN_DISPLAY_DELAYED gt 0}{$froggypricenegociator.FC_PN_DISPLAY_DELAYED|escape:'html':'UTF-8'}{else}1{/if}';
	var FC_PN_DISPLAY_DELAYED_PAGE = '{$froggypricenegociator.FC_PN_DISPLAY_DELAYED_PAGE|escape:'html':'UTF-8'}';
	var FC_PN_ID_PRODUCT = '{$froggypricenegociator.id_product|escape:'html':'UTF-8'}';
    var froggypricenegociator_configurations = new Array();
    {foreach from=$froggypricenegociator.configurations key=id_product_attribute item=steps}
	    froggypricenegociator_configurations[{$id_product_attribute|escape:'html':'UTF-8'}] = new Array();
        {foreach from=$steps key=class item=price}
		    froggypricenegociator_configurations[{$id_product_attribute|escape:'html':'UTF-8'}]['{$class|escape:'html':'UTF-8'}'] = {$price|escape:'html':'UTF-8'};
        {/foreach}
    {/foreach}

	var froggypricenegociator_about_label = '{{l s='about' mod='froggypricenegociator' js=1}|stripslashes|addslashes|escape:'htmlall':'UTF-8'}';
	var froggypricenegociator_message_label = new Array();
	froggypricenegociator_message_label['step1.too.high'] = '{html_entity_decode({l s='Your offer is superior to the current price of the product.' mod='froggypricenegociator' js=1}|stripslashes|addslashes|escape:'htmlall':'UTF-8')}';
	froggypricenegociator_message_label['step1.too.low'] = '{html_entity_decode({l s='Your offer is too low.' mod='froggypricenegociator' js=1}|stripslashes|addslashes|escape:'htmlall':'UTF-8')}';
	froggypricenegociator_message_label['step2.too.low'] = '{html_entity_decode({l s='Your offer was too low, here our final offer.' mod='froggypricenegociator' js=1}|stripslashes|addslashes|escape:'htmlall':'UTF-8')}';
	froggypricenegociator_message_label['step2.already.negotiated'] = '{html_entity_decode({l s='You already negotiated the price of this product, here the final offer.' mod='froggypricenegociator' js=1}|stripslashes|addslashes|escape:'htmlall':'UTF-8')}';
	froggypricenegociator_message_label['step2.good'] = '{html_entity_decode({l s='Your offer has been accepted!' mod='froggypricenegociator' js=1}|stripslashes|addslashes|escape:'htmlall':'UTF-8')}';
</script>
<p class="container-button-netotiate-front">
	<a href="#froggy-negociator-modal" id="froggypricenegociator-button" data-reveal-id="froggy-negociator-modal" title="{l s='Negotiate the price' mod='froggypricenegociator'}" class="button-12 {$froggypricenegociator.FC_PN_DISPLAY_BUTTON|escape:'html':'UTF-8'}" style="display: none;">{l s='Negotiate the price' mod='froggypricenegociator'}</a>
</p>

<div style="display:none">
	<div id="froggy-negociator-modal" class="reveal-modal">
		<div class="froggy-negociator-container-modal">

			{*HEADER STEP*}
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
			{*HEADER STEP*}


			{*STEP 1 MODAL*}
			<div class="froggy-negociator-modal-step" id="froggy-negociator-modal-step1">

				<p class="froggy-negociator-title-modal">{l s='You do not have the budget?' mod='froggypricenegociator'}</p>
				<p class="froggy-negociator-subtitle-modal">{l s='How much you would pay for this product?' mod='froggypricenegociator'}</p>

				<form action="">

					<fieldset class="froggy-negociator-input-offer">
						{if $froggypricenegociator.current_currency->format % 2 != 0}
							<label for="froggy-negociator-input-offer">{$froggypricenegociator.current_currency->sign|escape:'htmlall':'UTF-8'}</label>
						{/if}

						<input type="text" placeholder="{l s='Make an offer' mod='froggypricenegociator'}" id="froggy-negociator-input-offer" autocomplete="off" />

						{if $froggypricenegociator.current_currency->format % 2 == 0}
							<label for="froggy-negociator-input-offer">{$froggypricenegociator.current_currency->sign|escape:'htmlall':'UTF-8'}</label>
						{/if}
					</fieldset>

					<fieldset class="froggy-negociator-progressbar-container">



						<p class="froggy-negociator-label-probability">{l s='Chance of success in your negotiation:' mod='froggypricenegociator'}</p>

						<div class="froggy-price-negociator-progress">
							<div class="froggy-price-negociator-progress-bar"></div>
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
					<fieldset class="froggy-negociator-validation-step">
						<input id="froggy-negociator-validation-step1-input-submit" type="submit" value="{l s='Submit my offer' mod='froggypricenegociator'}" />
						<span id="froggy-negociator-validation-message-step1" class="froggy-negociator-validation-error"></span>
					</fieldset>

				</form>

			</div>
			{*STEP 1 MODAL*}


			{*STEP 2 MODAL*}
			<div class="froggy-negociator-modal-step" id="froggy-negociator-modal-step2">

				<p class="froggy-negociator-title-modal">{l s='Negotiated price' mod='froggypricenegociator'}</p>
				<p class="froggy-negociator-subtitle-modal" id="froggy-negociator-negociated-price"><img src="{$froggypricenegociator.module_dir|escape:'html':'UTF-8'}views/img/loader.gif" /></p>
				<p class="froggy-negociator-subtitle-modal" id="froggy-negociator-validation-message-step2"></p>

                <div id="froggy-negociator-modal-form-step2">
                    <p class="froggy-negociator-subtitle-modal">{l s='Please fill your e-mail address to receive this offer by e-mail and add the product to your cart.' mod='froggypricenegociator'}</p>
                    <p class="froggy-negociator-subtitle-modal"><u>{l s='This offer will be available for 24 hours only!' mod='froggypricenegociator'}</u></p>

                    <form action="">

                        <fieldset class="froggy-negociator-input-offer">
                            <input type="text" placeholder="{l s='Your e-mail' mod='froggypricenegociator'}" id="froggy-negociator-input-email" value="{$froggypricenegociator.email|escape:'html':'UTF-8'}" autocomplete="off" />
                        </fieldset>
                        <p id="froggy-negociator-input-email-error">{l s='Your email address seems to be wrong!' mod='froggypricenegociator'}</p>

                        <fieldset class="froggy-negociator-validation-step">
                            <input id="froggy-negociator-validation-step2-input-submit" type="submit" value="{l s='Validate my e-mail' mod='froggypricenegociator'}" />
							<p id="froggy-negociator-validation-step2-loader"><img src="{$froggypricenegociator.module_dir|escape:'html':'UTF-8'}views/img/loader.gif" /></p>
                        </fieldset>

                    </form>
				</div>

			</div>
			{*STEP 2 MODAL*}


			{*STEP 3 MODAL*}
			<div class="froggy-negociator-modal-step" id="froggy-negociator-modal-step3">

				<p class="froggy-negociator-title-modal">{l s='Negotiated price' mod='froggypricenegociator'}</p>
				<p class="froggy-negociator-subtitle-modal" id="froggy-negociator-negociated-price-step3"></p>
				<p class="froggy-negociator-subtitle-modal" id="froggy-negociator-validation-message-step3">{l s='Your negotiation offer has been sent to you by email, it will be available for 24 hours, it has been added to your cart too.' mod='froggypricenegociator'}</p>

				<form action="{if $froggypricenegociator.ps_version eq '1.4'}{$link->getPageLink('order.php')|escape:'htmlall':'UTF-8'}{else}{$link->getPageLink('order')|escape:'htmlall':'UTF-8'}{/if}">

					<fieldset class="froggy-negociator-validation-step">
						<input id="froggy-negociator-validation-step3-input-submit" type="submit" value="{l s='Go to the cart' mod='froggypricenegociator'}" />
					</fieldset>

				</form>
				<div id="froggy-negociator-share-container">
					<p class="froggy-negociator-share-intro">
						{l s='Your negocation is a success, share it!' mod='froggypricenegociator'}
					</p>
					<div class="froggy-negociator-share-link froggy-negociator-share-facebook">
						<div id="fb-root"></div>
						<script>
							{literal}
							(function(d, s, id) {
								var js, fjs = d.getElementsByTagName(s)[0];
								if (d.getElementById(id)) return;
								js = d.createElement(s); js.id = id;
								js.src = "//connect.facebook.net/fr_FR/sdk.js#xfbml=1&appId=251521804913383&version=v2.0";
								fjs.parentNode.insertBefore(js, fjs);
							}(document, 'script', 'facebook-jssdk'));
							{/literal}
						</script>
						<div class="fb-share-button" data-layout="button"></div>
					</div>
					<div class="froggy-negociator-share-link froggy-negociator-share-twitter">
						<a href="https://twitter.com/share" class="twitter-share-button" data-text="{l s='I just negociate the price of this product !' mod='froggypricenegociator'}" data-count="none">Tweet</a>
						<script>{literal}!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');{/literal}</script>
					</div>
					<p id="froggy-negociator-validation-step3-continue"><a href="" title="{l s='Continue to shop' mod='froggypricenegociator'}">{l s='Continue to shop' mod='froggypricenegociator'}</a></p>
				</div>
			</div>

			{if $froggypricenegociator.FC_PN_DISPLAY_MODE eq 'REVEAL'}<a class="close-reveal-modal">&#215;</a>{/if}
		</div>
		{*STEP 3 MODAL*}
	</div>
</div>