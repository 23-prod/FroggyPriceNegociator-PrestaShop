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
		'validate.price' => 'validatePrice',
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
			return $this->render('success', Tools::displayPrice($price_min), $case);
		}

		// Calculate new price
		if ($offer > $price_min)
		{
			$case = 'good';
			$price_min = $offer;
		}

		// Save negotiated price in cookie
		$this->saveNegociatedPriceInCookie($id_product, $id_product_attribute, $price_min);

		// Render result
		return $this->render('success', Tools::displayPrice($price_min), $case);
	}


	public function validatePrice($price_min)
	{
		// Retrieve POST values
		$email = Tools::htmlentitiesUTF8(Tools::getValue('email'));
		$offer = (float)Tools::getValue('offer');
		$id_product = (int)Tools::getValue('id_product');
		$id_product_attribute = (int)Tools::getValue('id_product_attribute');

		// Init
		$id_lang = (int)$this->context->language->id;
		$iso = Language::getIsoById($id_lang);
		$product = new Product((int)$id_product, true, $id_lang);
		$id_image = Product::getCover($id_product);
		$id_image = $id_image['id_image'];
		$product_url = $this->context->link->getProductLink($product);
		$product_image_url = $this->context->link->getImageLink($product->link_rewrite, $id_product.'-'.$id_image, 'large_default');
		$product_price = (float)Product::getPriceStatic($id_product, true, $id_product_attribute);
		$negociated_price = (float)$this->getNegociatedPriceInCookie($id_product, $id_product_attribute);
		$price_reduction = $product_price - $negociated_price;
		$expiration_date = date('Y-m-d H:i:s', strtotime(date('Y-m-d H:i:s').' + 1 day'));

		// Set templates vars
		$templateVars = array(
			'{product_name}' => $product->name,
			'{product_url}' => $product_url,
			'{product_description_short}' => $product->description_short,
			'{negociated_price}' => Tools::displayPrice($negociated_price),
			'{your_offer}' => Tools::displayPrice($offer),
			'{product_price}' => Tools::displayPrice($product_price),
			'{price_reduction}' => Tools::displayPrice($price_reduction),
			'{expiration_date}' => $expiration_date,
			'{product_image_url}' => $product_image_url,
			'{contact_url}' => $this->context->link->getPageLink('contact'),
		);

		if (file_exists(dirname(__FILE__).'/mails/'.$iso.'/reminder.txt') &&
			file_exists(dirname(__FILE__).'/mails/'.$iso.'/reminder.html'))
				Mail::Send((int)Configuration::get('PS_LANG_DEFAULT'), 'reminder', Mail::l('Negotiated price!', $id_lang), $templateVars, strval($email), NULL, strval(Configuration::get('PS_SHOP_EMAIL')), strval(Configuration::get('PS_SHOP_NAME')), NULL, NULL, dirname(__FILE__).'/mails/');

		return $this->render('success', '');
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