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

class FroggyPriceNegociatorAjaxRequestValidatePriceProcessor extends FroggyHookProcessor
{
	public function getAttributesNameFromIdProductAttribute($id_product_attribute, $id_lang)
	{
		$names = Db::getInstance()->executeS('
		SELECT `name`
		FROM `'._DB_PREFIX_.'attribute_lang`
		WHERE `id_lang` = '.(int)$id_lang.' AND `id_attribute` IN (
			SELECT `id_attribute`
			FROM `'._DB_PREFIX_.'product_attribute_combination`
			WHERE `id_product_attribute` = '.(int)$id_product_attribute.'
		)');
		$name = '';
		foreach ($names as $n)
			$name .= ' '.$n['name'];
		return $name;
	}

	public function addReductionToCart($id_product, $id_product_attribute, $product, $price_reduction, $expiration_date)
	{
		$id_lang = (int)$this->context->language->id;
		if (version_compare(_PS_VERSION_, '1.5.0') >= 0)
		{
			$cart_rule = new CartRule();
			$cart_rule->name = array();
			$cart_rule->name[(int)Configuration::get('PS_LANG_DEFAULT')] = $this->module->l('Negotiated price for').' '.$product->name.$this->getAttributesNameFromIdProductAttribute($id_product_attribute, $id_lang);
			$cart_rule->name[$id_lang] = $this->module->l('Negotiated price for').' '.$product->name.$this->getAttributesNameFromIdProductAttribute($id_product_attribute, $id_lang);
			$cart_rule->id_customer = (int)$this->context->customer->id;
			$cart_rule->date_from = date('Y-m-d H:i:s');
			$cart_rule->date_to = $expiration_date;
			$cart_rule->quantity = 1;
			$cart_rule->quantity_per_user = 1;
			$cart_rule->priority = 1;
			$cart_rule->partial_use = 0;
			$cart_rule->code = date('ymdHis').'-'.(int)$id_product.'-'.$id_product_attribute.'-'.ip2long(Tools::getRemoteAddr());
			$cart_rule->minimum_amount = 0;
			$cart_rule->minimum_amount_tax = 0;
			$cart_rule->minimum_amount_currency = $this->context->currency->id;
			$cart_rule->minimum_amount_shipping = 0;
			$cart_rule->country_restriction = 0;
			$cart_rule->carrier_restriction = 0;
			$cart_rule->group_restriction = 0;
			$cart_rule->cart_rule_restriction = 0;
			$cart_rule->product_restriction = 1;
			$cart_rule->shop_restriction = 0;
			$cart_rule->free_shipping = 0;
			$cart_rule->reduction_percent = 0;
			$cart_rule->reduction_amount = $price_reduction;
			$cart_rule->reduction_tax = 0;
			$cart_rule->reduction_currency = $this->context->currency->id;
			$cart_rule->reduction_product = 0;
			$cart_rule->gift_product = 0;
			$cart_rule->gift_product_attribute = 0;
			$cart_rule->highlight = 0;
			$cart_rule->active = 1;
			$cart_rule->add();
			$this->context->cart->addCartRule((int)$cart_rule->id);
		}
		else
		{
			$discount = new Discount();
			$discount->id_customer = (int)$this->context->customer->id;
			$discount->id_group = 0;
			$discount->id_currency = $this->context->currency->id;
			$discount->id_discount_type = 2;
			$discount->name = date('ymdHis').'-'.(int)$id_product.'-'.$id_product_attribute.'-'.ip2long(Tools::getRemoteAddr());
			$discount->description = array();
			$discount->description[(int)Configuration::get('PS_LANG_DEFAULT')] = $this->module->l('Negotiated price for').' '.$product->name.$this->getAttributesNameFromIdProductAttribute($id_product_attribute, $id_lang);
			$discount->description[$id_lang] = $this->module->l('Negotiated price for').' '.$product->name.$this->getAttributesNameFromIdProductAttribute($id_product_attribute, $id_lang);
			$discount->value = $price_reduction;
			$discount->quantity = 1;
			$discount->quantity_per_user = 1;
			$discount->cumulable = 1;
			$discount->cumulable_reduction = 1;
			$discount->date_from = date('Y-m-d H:i:s');
			$discount->date_to = $expiration_date;
			$discount->minimal = 0;
			$discount->include_tax = 1;
			$discount->cart_display = 0;
			$discount->active = 1;
			$discount->add();
			$this->context->cart->addDiscount((int)$discount->id);
		}
	}

	/**
	 * Validate price
	 * @param float $price_min
	 * @return string json data
	 */
	public function run()
	{
		// Retrieve POST values
		$price_min = (float)$this->params['price_min'];
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
		$negociated_price = (float)$this->params['ajaxController']->getNegociatedPriceInCookie($id_product, $id_product_attribute);
		$price_reduction = $product_price - $negociated_price;
		$expiration_date = date('Y-m-d H:i:s', strtotime(date('Y-m-d H:i:s').' + 1 day'));


		// Add product to cart with discount
		$this->context->cart->updateQty(1, $id_product, $id_product_attribute);
		$this->addReductionToCart($id_product, $id_product_attribute, $product, $price_reduction, $expiration_date);


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
			'{order_url}' => $this->context->link->getPageLink('order'),
		);

		// Sending e-mails
		if (file_exists(dirname(__FILE__).'/../mails/'.$iso.'/reminder.txt') &&
			file_exists(dirname(__FILE__).'/../mails/'.$iso.'/reminder.html'))
				if (Mail::Send((int)Configuration::get('PS_LANG_DEFAULT'), 'reminder', Mail::l('Negotiated price', $id_lang), $templateVars, strval($email), NULL, strval(Configuration::get('PS_SHOP_EMAIL')), strval(Configuration::get('PS_SHOP_NAME')), NULL, NULL, dirname(__FILE__).'/../mails/'))
					return $this->params['ajaxController']->render('success', '');
		return $this->params['ajaxController']->render('error', '');
	}
}