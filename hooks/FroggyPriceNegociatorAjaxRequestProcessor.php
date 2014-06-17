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
		'get.new.price' => 'ajaxRequestGetNewPrice',
		'validate.price' => 'ajaxRequestValidatePrice',
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
				return (float)$data[$id_product.'-'.$id_product_attribute];
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
		return $this->module->{$this->methods[Tools::getValue('method')]}(array('ajaxController' => $this, 'price_min' => $price_min));
	}
}