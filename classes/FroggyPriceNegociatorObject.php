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
		$fields['price_min'] = (float)$this->price_min;
		$fields['reduction_percent_max'] = (float)$this->reduction_percent_max;
		$fields['active'] = (int)$this->active;
		$fields['date_add'] = pSQL($this->date_add);

		return $fields;
	}

	public static function getByIdProduct($id_product)
	{
		$id_fpn_product = Db::getInstance()->getValue('
		SELECT `id_fpn_product` FROM `'._DB_PREFIX_.'fpn_product`
		WHERE `id_product` = '.(int)$id_product);
		if ($id_fpn_product > 0)
			return new FroggyPriceNegociatorObject($id_fpn_product);
		return false;
	}
}