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

class FroggyPriceNegociatorAjaxRequestProcessor extends FroggyHookProcessor
{
	private $methods = array(
		'get.new.price' => 'getNewPrice',
	);

	public function render($status, $message, $case = '')
	{
		return Tools::jsonEncode(array('status' => $status, 'message' => $message, 'case' => $case));
	}

	public function getNegociatedPriceInCookie($id_product, $id_product_attribute)
	{
		if (isset($this->context->cookie->froggypricenegociator))
		{
			$data = (array)Tools::jsonDecode($this->context->cookie->froggypricenegociator);
			if (isset($data[$id_product.'-'.$id_product_attribute]))
				return $data[$id_product.'-'.$id_product_attribute];
		}
		return false;
	}

	public function saveNegociatedPriceInCookie($id_product, $id_product_attribute, $price)
	{
		$data = array();
		if (isset($this->context->cookie->froggypricenegociator))
			$data = (array)Tools::jsonDecode($this->context->cookie->froggypricenegociator);
		$data[$id_product.'-'.$id_product_attribute] = $price;
		$this->context->cookie->froggypricenegociator = Tools::jsonEncode($data);
	}

	public function getNewPrice($price_min)
	{
		// Init
		$case = 'too.low';
		$offer = (float)Tools::getValue('offer');
		$id_product = (int)Tools::getValue('id_product');
		$id_product_attribute = (int)Tools::getValue('id_product_attribute');

		// If price has already been negotiated, we return the price
		if ($this->getNegociatedPriceInCookie($id_product, $id_product_attribute) !== false)
		{
			$case = 'already.negotiated';
			$price_min = $this->getNegociatedPriceInCookie($id_product, $id_product_attribute);
			return $this->render('success', $price_min, $case);
		}

		// Calculate new price
		if ($offer > $price_min)
		{
			$case = 'good';
			$price_min = $offer;
		}
		$price_min = Tools::displayPrice($price_min);

		// Save negotiated price in cookie
		$this->saveNegociatedPriceInCookie($id_product, $id_product_attribute, $price_min);

		// Render result
		return $this->render('success', $price_min, $case);
	}

	public function run()
	{
		// Check arguments
		if ((int)Tools::getValue('id_product') < 0 || (float)Tools::getValue('offer') < 0 || !isset($this->methods[Tools::getValue('method')]))
			return $this->render('error', $this->module->l('System error, please contact the merchant.'));

		// Check if there is a possible negotiation on specific id_product & id_product_attribute
		$price_min = FroggyPriceNegociatorObject::getProductMinimumPrice((int)Tools::getValue('id_product'), (int)Tools::getValue('id_product_attribute'));
		if ($price_min === false)
			return $this->render('error', $this->module->l('The negotiation for this product is not available.'));

		// Call method
		return $this->{$this->methods[Tools::getValue('method')]}($price_min);
	}
}