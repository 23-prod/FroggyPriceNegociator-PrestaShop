<?php
/*
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
*  @author Froggy Commerce <contact@froggy-commerce.com>
*  @copyright  2013-2014 Froggy Commerce
*/

// Security
defined('_PS_VERSION_') || require dirname(__FILE__).'/index.php';

// Include Froggy Library
if (!class_exists('FroggyModule', false)) require_once _PS_MODULE_DIR_.'/froggypricenegociator/froggy/FroggyModule.php';

// Require Object Model
require_once _PS_MODULE_DIR_.'/froggypricenegociator/classes/FroggyPriceNegociatorObject.php';

class FroggyPriceNegociator extends FroggyModule
{
	/**
	 * Constructor
	 */
	public function __construct()
	{
		parent::__construct();

		$this->displayName = $this->l('Froggy Price Negociator');
		$this->description = $this->l('Display a price negociation button on product page for your customers');
	}

	/**
	 * Configuration method
	 * @return string $html
	 */
	public function getContent()
	{
		return $this->hookGetContent();
	}

	// Retrocompat 1.4
	public function hookExtraRight($params) { return $this->hookDisplayRightColumnProduct($params); }
	public function hookBackOfficeHeader($params) { return $this->hookDisplayBackOfficeHeader($params); }
}