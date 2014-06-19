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

class FroggyPriceNegociatorHookActionCartSaveProcessor extends FroggyHookProcessor
{
	public function run()
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

		// Add authorized negociated price
		$negociated_prices_added_to_cart = array();
		foreach ($products as $product)
			foreach ($negociated_prices as $price)
				if ($price['id_product'] == $product['id_product'] && $price['id_product_attribute'] == $product['id_product_attribute'] && !isset($negociated_prices_added_to_cart[$product['id_product'].'-'.$product['id_product_attribute']]))
				{
					// Save to negotiated price added to cart to avoid trickery (doublon)
					$negociated_prices_added_to_cart[$product['id_product'].'-'.$product['id_product_attribute']] = true;

					// Check max negotiated product authorized by cart
					if (count($negociated_prices_added_to_cart) <= Configuration::get('FC_PN_MAX_PRODUCT_BY_CART'))
					{
						// Refresh reduction amount depending on cart quantity
						FroggyPriceNegociatorNewPriceObject::refreshReductionAmount($price[$nameVariable], $product['cart_quantity'], $price['reduction']);

						// Add reduction to the cart
						$this->context->cart->{$addMethod}($price[$nameVariable]);
					}
				}


		// If negotiated prices are not compliant with other discount and if there is at least one negotiated price in cart, we delete other discounts
		if (Configuration::get('FC_PN_COMPLIANT_DISCOUNT') != 1 && count($negociated_prices_added_to_cart) > 0)
			foreach ($reductions as $reduction)
				if (!FroggyPriceNegociatorNewPriceObject::isNegociationReduction($reduction[$nameVariable]))
					$this->context->cart->{$deleteMethod}($reduction[$nameVariable]);
	}
}