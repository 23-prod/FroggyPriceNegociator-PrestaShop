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

class FroggyPriceNegociatorObject extends ObjectModel
{
	public $id;

	/** @var integer Shop ID */
	public $id_shop;

	/** @var integer Product ID */
	public $id_product;

	/** @var integer Product Attribute ID */
	public $id_product_attribute;

	/** @var float Price min */
	public $price_min;

	/** @var float Reduction percent max */
	public $reduction_percent_max;

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
		'table' => 'fpn_product',
		'primary' => 'id_fpn_product',
		'multilang' => false,
		'fields' => array(
			'id_shop' => 					array('type' => 1, 'validate' => 'isUnsignedId', 'required' => true),
			'id_product' => 				array('type' => 1, 'validate' => 'isUnsignedId', 'required' => true),
			'id_product_attribute' => 		array('type' => 1, 'validate' => 'isUnsignedId', 'required' => true),
			'price_min' => 					array('type' => 4, 'validate' => 'isPrice', 'required' => true),
			'reduction_percent_max' => 		array('type' => 4, 'validate' => 'isFloat', 'required' => true),
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

	protected 	$fieldsRequired = array('id_shop', 'id_product', 'price_min', 'reduction_percent_max', 'active');
	protected 	$fieldsSize = array('id_shop' => 32, 'id_product' => 32, 'price_min' => 32, 'reduction_percent_max' => 32);
	protected 	$fieldsValidate = array('id_shop' => 'isUnsignedInt', 'id_product' => 'isUnsignedInt', 'price_min' => 'isPrice', 'reduction_percent_max' => 'isFloat');

	protected 	$table = 'fpn_product';
	protected 	$identifier = 'id_fpn_product';

	public function getFields()
	{
		if (version_compare(_PS_VERSION_, '1.5') >= 0)
			return parent::getFields();

		parent::validateFields();

		$fields['id_shop'] = (int)$this->id_shop;
		$fields['id_product'] = (int)$this->id_product;
		$fields['id_product_attribute'] = (int)$this->id_product_attribute;
		$fields['price_min'] = (float)$this->price_min;
		$fields['reduction_percent_max'] = (float)$this->reduction_percent_max;
		$fields['active'] = (int)$this->active;
		$fields['date_add'] = pSQL($this->date_add);

		return $fields;
	}

	/*** End of Retrocompatibility 1.4 ***/


	public function __construct($id = null, $id_lang = null, $id_shop = null)
	{
		$return = parent::__construct($id, $id_lang, $id_shop);
		$this->price_min = number_format($this->price_min, 2);
		$this->reduction_percent_max = number_format($this->reduction_percent_max, 2);
		return $return;
	}

	public static function isProductEligible($id_product)
	{
		if (Configuration::get('FC_PN_ENABLE_GENERAL_OPTION') == 1)
			return true;

		$id_fpn_product = Db::getInstance()->getValue('
		SELECT `id_fpn_product` FROM `'._DB_PREFIX_.'fpn_product`
		WHERE `id_product` = '.(int)$id_product.' AND `id_product_attribute` = 0 AND `active` = 1');
		if ($id_fpn_product > 0)
			return true;

		return false;
	}

	public static function getProductCombinationsNegociationSuccessChance($id_product)
	{
		// Get minimum price for each combination
		$combinations = array();
		$combinations[0] = self::getProductMinimumPrice($id_product, 0);
		$list = Db::getInstance()->executeS('SELECT `id_product_attribute` FROM `'._DB_PREFIX_.'product_attribute` WHERE `id_product` = '.(int)$id_product);
		foreach ($list as $l)
			$combinations[$l['id_product_attribute']] = self::getProductMinimumPrice($id_product, $l['id_product_attribute']);

		// Calcul negotiation chance of success
		foreach ($combinations as $id_product_attribute => $price_min)
			$combinations[$id_product_attribute] = array(
				'zero' => $price_min * 0.50,
				'five' => $price_min * 0.65,
				'twentyfive' => $price_min * 0.80,
				'fifty' => $price_min * 1,
				'seventyfive' => $price_min * 1.20,
			);

		return $combinations;
	}

	public static function getProductMinimumPrice($id_product, $id_product_attribute = 0)
	{
		// Get product current price
		$current_price = Product::getPriceStatic($id_product, true, $id_product_attribute);

		// Check if there is a general configuration
		if (Configuration::get('FC_PN_ENABLE_GENERAL_OPTION') == 1)
		{
			$percent_reduction = Configuration::get('FC_PN_GENERAL_REDUCTION');
			$price_min = $current_price * (100 - $percent_reduction) / 100;
			return $price_min;
		}

		// Check if there is a possible negotiation on specific id_product & id_product_attribute
		$fpno = FroggyPriceNegociatorObject::getByIdProduct((int)$id_product, (int)$id_product_attribute);
		if (!ValidateCore::isLoadedObject($fpno) || $fpno->active == 0)
		{
			// We free data
			unset($fpno);

			// Check if there is a possible negotiation on id_product in general
			$fpno = FroggyPriceNegociatorObject::getByIdProduct((int)$id_product);
		}

		// If no product configuration, we return false
		if (!ValidateCore::isLoadedObject($fpno) || $fpno->active == 0)
			return false;

		// Check type configuration and calculate minimum price
		if (Configuration::get('FC_PN_TYPE') == 'PRICE_MINI')
			$price_min = $fpno->price_min;
		else
		{
			$percent_reduction = $fpno->reduction_percent_max;
			$price_min = $current_price * (100 - $percent_reduction) / 100;
		}

		return $price_min;
	}

	public static function getByIdProduct($id_product, $id_product_attribute = 0)
	{
		$id_fpn_product = Db::getInstance()->getValue('
		SELECT `id_fpn_product` FROM `'._DB_PREFIX_.'fpn_product`
		WHERE `id_product` = '.(int)$id_product.'
		AND `id_product_attribute` = '.(int)$id_product_attribute);
		if ($id_fpn_product > 0)
			return new FroggyPriceNegociatorObject($id_fpn_product);
		return new FroggyPriceNegociatorObject();
	}

	public static function getCombinationsByIdProduct($id_product)
	{
		$result = Db::getInstance()->executeS('
		SELECT * FROM `'._DB_PREFIX_.'fpn_product`
		WHERE `id_product` = '.(int)$id_product);
		foreach ($result as $k => $v)
		{
			$result[$k]['price_min'] = number_format($result[$k]['price_min'], 2);
			$result[$k]['reduction_percent_max'] = number_format($result[$k]['reduction_percent_max'], 2);
		}
		return $result;
	}
}