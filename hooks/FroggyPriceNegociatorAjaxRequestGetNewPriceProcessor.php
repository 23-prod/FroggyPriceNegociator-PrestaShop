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

class FroggyPriceNegociatorAjaxRequestGetNewPriceProcessor extends FroggyHookProcessor
{
	/**
	 * Get new price
	 * @param float $price_min
	 * @return string json data
	 */
	public function run()
	{
		// Init
		$case = 'too.low';
		$price_min = (float)$this->params['price_min'];
		$offer = (float)Tools::getValue('offer');
		$id_product = (int)Tools::getValue('id_product');
		$id_product_attribute = (int)Tools::getValue('id_product_attribute');

		// If price has already been negotiated, we return the price
		if ($this->params['ajaxController']->getNegociatedPriceInCookie($id_product, $id_product_attribute) !== false)
		{
			$case = 'already.negotiated';
			$price_min = $this->params['ajaxController']->getNegociatedPriceInCookie($id_product, $id_product_attribute);
			return $this->params['ajaxController']->render('success', Tools::displayPrice($price_min), $case);
		}

		// Calculate new price
		if ($offer > $price_min)
		{
			$case = 'good';
			$price_min = $offer;
		}

		// Save negotiated price in cookie
		$this->params['ajaxController']->saveNegociatedPriceInCookie($id_product, $id_product_attribute, $price_min);

		// Render result
		return $this->params['ajaxController']->render('success', Tools::displayPrice($price_min), $case);
	}
}