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
	public $id_lang;
	public $id_product;
	public $id_product_attribute;
	public $id_discount = 0;
	public $id_cart_rule = 0;
	public $email;
	public $product;
	public $product_price;
	public $customer_offer;
	public $price_min;
	public $new_price;
	public $reduction;
	public $date_expiration;

	public function init()
	{
		$this->id_lang = (int)$this->context->language->id;
		$this->id_product = (int)Tools::getValue('id_product');
		$this->id_product_attribute = (int)Tools::getValue('id_product_attribute');
		$this->email = Tools::htmlentitiesUTF8(Tools::getValue('email'));
		$this->product = new Product((int)$this->id_product, true, $this->id_lang);
		$this->product_price = (float)Product::getPriceStatic($this->id_product, true, $this->id_product_attribute);
		$this->customer_offer = (float)Tools::getValue('offer');
		$this->price_min = (float)$this->params['price_min'];
		$this->new_price = (float)$this->params['ajaxController']->getNegociatedPriceInCookie($this->id_product, $this->id_product_attribute);
		$this->reduction = round((float)($this->product_price - $this->new_price), 2);
		$this->date_expiration = date('Y-m-d H:i:s', strtotime(date('Y-m-d H:i:s').' + 1 day'));
	}


	public function getAttributesNameFromIdProductAttribute()
	{
		$names = Db::getInstance()->executeS('
		SELECT `name`
		FROM `'._DB_PREFIX_.'attribute_lang`
		WHERE `id_lang` = '.(int)$this->id_lang.' AND `id_attribute` IN (
			SELECT `id_attribute`
			FROM `'._DB_PREFIX_.'product_attribute_combination`
			WHERE `id_product_attribute` = '.(int)$this->id_product_attribute.'
		)');
		$name = '';
		foreach ($names as $n)
			$name .= ' '.$n['name'];
		return $name;
	}

	public function addReductionToCart()
	{
		if (version_compare(_PS_VERSION_, '1.5.0') >= 0)
		{
			$cart_rule = new CartRule();
			$cart_rule->name = array();
			$cart_rule->name[(int)Configuration::get('PS_LANG_DEFAULT')] = $this->module->l('Negotiated price for').' '.$this->product->name.$this->getAttributesNameFromIdProductAttribute();
			$cart_rule->name[$this->id_lang] = $this->module->l('Negotiated price for').' '.$this->product->name.$this->getAttributesNameFromIdProductAttribute();
			$cart_rule->id_customer = (int)$this->context->customer->id;
			$cart_rule->date_from = date('Y-m-d H:i:s');
			$cart_rule->date_to = $this->date_expiration;
			$cart_rule->quantity = 1;
			$cart_rule->quantity_per_user = 1;
			$cart_rule->priority = 1;
			$cart_rule->partial_use = 0;
			$cart_rule->code = date('ymdHis').'-'.(int)$this->id_product.'-'.$this->id_product_attribute.'-'.ip2long(Tools::getRemoteAddr());
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
			$cart_rule->reduction_amount = $this->reduction;
			$cart_rule->reduction_tax = 1;
			$cart_rule->reduction_currency = $this->context->currency->id;
			$cart_rule->reduction_product = 0;
			$cart_rule->gift_product = 0;
			$cart_rule->gift_product_attribute = 0;
			$cart_rule->highlight = 0;
			$cart_rule->active = 1;
			$cart_rule->add();
			$this->context->cart->addCartRule((int)$cart_rule->id);
			$this->id_cart_rule = (int)$cart_rule->id;
		}
		else
		{
			$discount = new Discount();
			$discount->id_customer = (int)$this->context->customer->id;
			$discount->id_group = 0;
			$discount->id_currency = $this->context->currency->id;
			$discount->id_discount_type = 2;
			$discount->name = date('ymdHis').'-'.(int)$this->id_product.'-'.$this->id_product_attribute.'-'.ip2long(Tools::getRemoteAddr());
			$discount->description = array();
			$discount->description[(int)Configuration::get('PS_LANG_DEFAULT')] = $this->module->l('Negotiated price for').' '.$this->product->name.$this->getAttributesNameFromIdProductAttribute();
			$discount->description[$this->id_lang] = $this->module->l('Negotiated price for').' '.$this->product->name.$this->getAttributesNameFromIdProductAttribute();
			$discount->value = $this->reduction;
			$discount->quantity = 1;
			$discount->quantity_per_user = 1;
			$discount->cumulable = 1;
			$discount->cumulable_reduction = 1;
			$discount->date_from = date('Y-m-d H:i:s');
			$discount->date_to = $this->date_expiration;
			$discount->minimal = 0;
			$discount->include_tax = 1;
			$discount->cart_display = 0;
			$discount->active = 1;
			$discount->add();
			$this->context->cart->addDiscount((int)$discount->id);
			$this->id_discount = (int)$discount->id;
		}
	}

	public function logNegociation()
	{
		$fpnnp = new FroggyPriceNegociatorNewPriceObject();
		$fpnnp->id_shop = $this->context->shop->id;
		$fpnnp->id_product = (int)$this->id_product;
		$fpnnp->id_product_attribute = (int)$this->id_product_attribute;
		$fpnnp->id_customer = (int)$this->context->customer->id;
		$fpnnp->id_cart = (int)$this->context->cart->id;
		$fpnnp->id_discount = (int)$this->id_discount;
		$fpnnp->id_cart_rule = (int)$this->id_cart_rule;
		$fpnnp->email = $this->email;
		$fpnnp->ip = Tools::getRemoteAddr();
		$fpnnp->product_price = (float)$this->product_price;
		$fpnnp->customer_offer = (float)$this->customer_offer;
		$fpnnp->price_min = (float)$this->price_min;
		$fpnnp->new_price = (float)$this->new_price;
		$fpnnp->reduction = (float)$this->reduction;
		$fpnnp->date_expiration = $this->date_expiration;
		$fpnnp->active = 1;
		$fpnnp->add();
	}


	public function sendReminderMail()
	{
		// Retrieve product informations
		$iso = Language::getIsoById($this->id_lang);
		$id_image = Product::getCover($this->id_product);
		$id_image = $id_image['id_image'];
		$picture_size = 'large'.'_'.'default';
		$product_url = $this->context->link->getProductLink($this->product);
		$product_image_url = $this->context->link->getImageLink($this->product->link_rewrite, $this->id_product.'-'.$id_image, $picture_size);

		// Set templates vars
		$templateVars = array(
			'{product_name}' => $this->product->name,
			'{product_url}' => $product_url,
			'{product_description_short}' => strip_tags($this->product->description_short),
			'{negociated_price}' => str_replace(' ', '&nbsp;', Tools::displayPrice($this->new_price)),
			'{your_offer}' => str_replace(' ', '&nbsp;', Tools::displayPrice($this->customer_offer)),
			'{product_price}' => str_replace(' ', '&nbsp;', Tools::displayPrice($this->product_price)),
			'{price_reduction}' => str_replace(' ', '&nbsp;', Tools::displayPrice($this->reduction)),
			'{expiration_date}' => Tools::displayDate($this->date_expiration, $this->id_lang, true),
			'{product_image_url}' => $product_image_url,
			'{contact_url}' => $this->context->link->getPageLink('contact'),
			'{order_url}' => $this->context->link->getPageLink('order'),
		);

		// Sending e-mails
		if (file_exists(dirname(__FILE__).'/../mails/'.$iso.'/reminder.txt') &&
			file_exists(dirname(__FILE__).'/../mails/'.$iso.'/reminder.html'))
			if (Mail::Send((int)Configuration::get('PS_LANG_DEFAULT'), 'reminder', $this->module->l('Negotiated price', $this->id_lang), $templateVars, $this->email, null, Configuration::get('PS_SHOP_EMAIL'), Configuration::get('PS_SHOP_NAME'), null, null, dirname(__FILE__).'/../mails/'))
				return $this->params['ajaxController']->render('success', '');
		return $this->params['ajaxController']->render('error', '');
	}


	/**
	 * Validate price
	 * @param float $price_min
	 * @return string json data
	 */
	public function run()
	{
		// Retrieve infos
		$this->init();

		// Check if product is eligible
		if (!FroggyPriceNegociatorObject::isProductEligible($this->id_product, (int)$this->context->customer->id, (int)$this->context->cart->id))
			return $this->params['ajaxController']->render('error', '');

		// If cart does not exist, we create it
		if (!Validate::isLoadedObject($this->context->cart))
		{
			$this->context->cart = new Cart();
			$this->context->cart->id_lang = $this->id_lang;
			$this->context->cart->id_currency = $this->context->currency->id;
			$this->context->cart->add();
			if ($this->context->cart->id)
				$this->context->cookie->id_cart = (int)$this->context->cart->id;
		}

		// Add product to cart with discount
		$this->context->cart->updateQty(1, $this->id_product, $this->id_product_attribute);
		$this->addReductionToCart();

		// Log negotiation
		$this->logNegociation();

		// Send mail
		return $this->sendReminderMail();
	}
}