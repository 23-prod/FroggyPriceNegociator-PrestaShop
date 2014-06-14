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

class FroggyPriceNegociatorHookDisplayRightColumnProductProcessor extends FroggyHookProcessor
{
	public function display()
	{
		$assign = array(
			'path_template_dir' => dirname(__FILE__).'/../views/templates/hook/',
			'module_dir' => $this->path,
			'FC_PN_DISPLAY_MODE' => Configuration::get('FC_PN_DISPLAY_MODE'),
			'FC_PN_DISPLAY_DELAYED' => Configuration::get('FC_PN_DISPLAY_DELAYED'),
		);
		$this->smarty->assign($this->module->name, $assign);
		return $this->module->fcdisplay(__FILE__, 'displayRightColumnProduct.tpl');
	}

	public function run()
	{
		// Retrieve product ID
		$id_product = (int)Tools::getValue('id_product');

		// Check product ID
		if ($id_product < 1)
			return '';

		// Check if product is eligible
		if (!FroggyPriceNegociatorObject::isProductEligible($id_product))
			return '';

		// Return display
		return $this->display();
	}
}