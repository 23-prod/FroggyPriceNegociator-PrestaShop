<?php
/**
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
 */

class FroggyPriceNegociatorHookDisplayHeaderProcessor extends FroggyHookProcessor
{
	public function includeMedia()
	{
		if (Tools::getValue('id_product') < 1)
			return true;

		$this->context->controller->addCss($this->path.'views/css/buttons.css');
		$this->context->controller->addCss($this->path.'views/css/modal.css');
		if (Configuration::get('FC_PN_DISPLAY_MODE') == 'REVEAL')
		{
			$this->context->controller->addCss($this->path.'views/css/reveal.css');
			$this->context->controller->addJs($this->path.'views/js/jquery.reveal.js');
		}
		else
			$this->context->controller->addJs($this->path.'views/js/jquery.fancybox.action.js');
		$this->context->controller->addJs($this->path.'views/js/displayRightColumnProduct.js');
	}

	public function checkCartContent()
	{
		// Retrocompatibility
		$nameVariable = (version_compare(_PS_VERSION_, '1.5.0') >= 0 ? 'id_cart_rule' : 'id_discount');
		$getMethod = (version_compare(_PS_VERSION_, '1.5.0') >= 0 ? 'getCartRules' : 'getDiscounts');
		$addMethod = (version_compare(_PS_VERSION_, '1.5.0') >= 0 ? 'addCartRule' : 'addDiscount');
		$deleteMethod = (version_compare(_PS_VERSION_, '1.5.0') >= 0 ? 'removeCartRule' : 'deleteDiscount');

		// First remove all negotiated reduction
		$reductions = $this->context->cart->{$getMethod}();
		foreach ($reductions as $reduction)
			if (FroggyPriceNegociatorNewPriceObject::isNegociationReduction($reduction[$nameVariable]))
				$this->context->cart->{$deleteMethod}($reduction[$nameVariable]);

		// Then retrieve products and negociated prices matching this cart
		$products = $this->context->cart->getProducts();
		$negociated_prices = FroggyPriceNegociatorNewPriceObject::getNewPricesByCartId($this->context->cart->id);

		// Add negociated price again
		foreach ($products as $product)
			foreach ($negociated_prices as $price)
				if ($price['id_product'] == $product['id_product'] && $price['id_product_attribute'] == $product['id_product_attribute'])
					$this->context->cart->{$addMethod}($price[$nameVariable]);
	}

	public function run()
	{
		$this->includeMedia();
		$this->checkCartContent();
	}
}