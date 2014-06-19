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

class FroggyPriceNegociatorNewPriceObject extends ObjectModel
{
	public $id;

	/** @var integer Shop ID */
	public $id_shop;

	/** @var integer Product ID */
	public $id_product;

	/** @var integer Product Attribute ID */
	public $id_product_attribute;

	/** @var integer Customer ID */
	public $id_customer;

	/** @var integer Cart ID */
	public $id_cart;

	/** @var integer Discount ID */
	public $id_discount;

	/** @var integer Cart Rule ID */
	public $id_cart_rule;

	/** @var string email */
	public $email;

	/** @var string IP */
	public $ip;

	/** @var float Product Price */
	public $product_price;

	/** @var float Customer Price */
	public $customer_offer;

	/** @var float Minimum Price */
	public $price_min;

	/** @var float New Price */
	public $new_price;

	/** @var float Reduction */
	public $reduction;

	/** @var string Expiration Date */
	public $date_expiration;

	/** @var string Date */
	public $date_add;

	/** @var string Date */
	public $date_upd;

	/** @var integer Active */
	public $active;

	/**
	 * @see ObjectModel::$definition
	 */
	public static $definition = array(
		'table' => 'fpn_product_new_price',
		'primary' => 'id_fpn_product_new_price',
		'multilang' => false,
		'fields' => array(
			'id_shop' => 					array('type' => 1, 'validate' => 'isUnsignedId', 'required' => true),
			'id_product' => 				array('type' => 1, 'validate' => 'isUnsignedId', 'required' => true),
			'id_product_attribute' => 		array('type' => 1, 'validate' => 'isUnsignedId', 'required' => true),
			'id_customer' => 				array('type' => 1, 'validate' => 'isUnsignedId', 'required' => true),
			'id_cart' => 					array('type' => 1, 'validate' => 'isUnsignedId', 'required' => true),
			'id_discount' => 				array('type' => 1, 'validate' => 'isUnsignedId', 'required' => true),
			'id_cart_rule' => 				array('type' => 1, 'validate' => 'isUnsignedId', 'required' => true),
			'email' => 						array('type' => 3, 'validate' => 'isString', 'required' => true),
			'ip' => 						array('type' => 3, 'validate' => 'isString', 'required' => true),
			'product_price' => 				array('type' => 4, 'validate' => 'isPrice', 'required' => true),
			'customer_offer' => 			array('type' => 4, 'validate' => 'isPrice', 'required' => true),
			'price_min' => 					array('type' => 4, 'validate' => 'isPrice', 'required' => true),
			'new_price' => 					array('type' => 4, 'validate' => 'isPrice', 'required' => true),
			'reduction' => 					array('type' => 4, 'validate' => 'isPrice', 'required' => true),
			'date_expiration' => 			array('type' => 5, 'validate' => 'isDateFormat', 'copy_post' => false),
			'date_add' => 					array('type' => 5, 'validate' => 'isDateFormat', 'copy_post' => false),
			'date_upd' => 					array('type' => 5, 'validate' => 'isDateFormat', 'copy_post' => false),
			'active' => 					array('type' => 2, 'validate' => 'isBool'),
		),
	);
	/*	Can't use constant if we want to be compliant with PS 1.4
	 * 	const TYPE_INT = 1;
	 * 	const TYPE_BOOL = 2;
	 * 	const TYPE_STRING = 3;
	 * 	const TYPE_FLOAT = 4;
	 * 	const TYPE_DATE = 5;
	 * 	const TYPE_HTML = 6;
	 * 	const TYPE_NOTHING = 7;
	 */


	/*** Retrocompatibility 1.4 ***/

	protected 	$fieldsRequired = array('id_shop', 'id_product', 'id_cart', 'email', 'ip', 'new_price', 'active');
	protected 	$fieldsSize = array('id_shop' => 32, 'id_product' => 32, 'email' => 32, 'new_price' => 32);
	protected 	$fieldsValidate = array('id_shop' => 'isUnsignedInt', 'id_product' => 'isUnsignedInt', 'new_price' => 'isPrice', 'email' => 'isString');

	protected 	$table = 'fpn_product_new_price';
	protected 	$identifier = 'id_fpn_product_new_price';

	public function getFields()
	{
		if (version_compare(_PS_VERSION_, '1.5') >= 0)
			return parent::getFields();

		parent::validateFields();

		$fields['id_shop'] = (int)$this->id_shop;
		$fields['id_product'] = (int)$this->id_product;
		$fields['id_product_attribute'] = (int)$this->id_product_attribute;
		$fields['id_cart'] = (int)$this->id_cart;
		$fields['id_customer'] = (int)$this->id_customer;
		$fields['id_discount'] = (int)$this->id_discount;
		$fields['id_cart_rule'] = (int)$this->id_cart_rule;
		$fields['email'] = pSQL($this->email);
		$fields['ip'] = pSQL($this->ip);
		$fields['product_price'] = (float)$this->product_price;
		$fields['customer_offer'] = (float)$this->customer_offer;
		$fields['price_min'] = (float)$this->price_min;
		$fields['new_price'] = (float)$this->new_price;
		$fields['reduction'] = (float)$this->reduction;
		$fields['date_expiration'] = pSQL($this->date_expiration);
		$fields['date_add'] = pSQL($this->date_add);
		$fields['active'] = (int)$this->active;

		return $fields;
	}

	/*** End of Retrocompatibility 1.4 ***/

	public static function isPriceAlreadyNegociated($id_product, $id_cart)
	{
		$value = (int)Db::getInstance()->getValue('
		SELECT `id_fpn_product_new_price` FROM `'._DB_PREFIX_.'fpn_product_new_price`
		WHERE `id_product` = '.(int)$id_product.' AND `id_cart` = '.(int)$id_cart);
		if ($value > 0)
			return true;
		return false;
	}

	public static function getNewPricesByCartId($id_cart)
	{
		return Db::getInstance()->executeS('
		SELECT * FROM `'._DB_PREFIX_.'fpn_product_new_price`
		WHERE `id_cart` = '.(int)$id_cart);
	}

	public static function isNegociationReduction($id_reduction)
	{
		$id = (int)Db::getInstance()->getValue('
		SELECT `id_fpn_product_new_price`
		FROM `'._DB_PREFIX_.'fpn_product_new_price`
		WHERE `'.(version_compare(_PS_VERSION_, '1.5.0') >= 0 ? 'id_cart_rule' : 'id_discount').'` = '.(int)$id_reduction);
		if ($id > 0)
			return true;
		return false;
	}

	public static function refreshReductionAmount($id_reduction, $quantity, $reduction)
	{
		// Check if quantity is not higher than the limit configured
		if ($quantity > Configuration::get('FC_PN_MAX_QUANTITY_BY_PRODUCT'))
			$quantity = Configuration::get('FC_PN_MAX_QUANTITY_BY_PRODUCT');

		if (version_compare(_PS_VERSION_, '1.5.0') >= 0)
		{
			$cart_rule = new CartRule((int)$id_reduction);
			$cart_rule->reduction_amount = ($reduction * $quantity);
			$cart_rule->update();
		}
		else
		{
			$discount = new Discount((int)$id_reduction);
			$discount->value = ($reduction * $quantity);
			$discount->update();
		}
	}
}