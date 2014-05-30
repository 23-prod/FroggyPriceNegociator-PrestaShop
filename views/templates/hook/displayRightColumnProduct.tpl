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

<a href="#" id="froggypricenegociator-button" data-reveal-id="myModal" title="{l s='Negociate the price' mod='froggypricenegociator'}" class="button-12 froggy-price-negociator-button-front yellow radius">{l s='Negociate the price' mod='froggypricenegociator'}</a>


<div id="myModal" class="reveal-modal">
	<div class="froggy-negociator-container-modal">
		<p class="froggy-negociator-title-modal">Vous n'avez pas le budget ?</p>
		<p class="">quel est votre budget pour ce produit ?</p>

		<form action="">

			<fieldset class="froggy-negociator-input-offer">
				<input type="text" placeholder="Faite une offre"/>
			</fieldset>

			<fieldset>
				<input type="radio" class="radio" name="progress" value="five" id="five">
				<label for="five" class="label">5%</label>

				<input type="radio" class="radio" name="progress" value="twentyfive" id="twentyfive" checked>
				<label for="twentyfive" class="label">25%</label>

				<input type="radio" class="radio" name="progress" value="fifty" id="fifty">
				<label for="fifty" class="label">50%</label>

				<input type="radio" class="radio" name="progress" value="seventyfive" id="seventyfive">
				<label for="seventyfive" class="label">75%</label>

				<input type="radio" class="radio" name="progress" value="onehundred" id="onehundred">
				<label for="onehundred" class="label">100%</label>
				<p class="froggy-negociator-label-probability">Chance de succès :</p>
				<div class="progress">
					<div class="progress-bar"></div>
				</div>
				<div class="froggy-negociator-comparaison-container">
					<div class="froggy-negociator">
						<p>prix d'origine : <br/></p>
					</div>
					<div class="froggy-negociator">
						<p>Réduction possible : <br/> 1.50 € ( soit 4.5 % )</p>
					</div>
				</div>
			</fieldset>



		</form>
		{if $froggypricenegociator.FC_PN_DISPLAY_MODE eq 'REVEAL'}<a class="close-reveal-modal">&#215;</a>{/if}
	</div>
</div>