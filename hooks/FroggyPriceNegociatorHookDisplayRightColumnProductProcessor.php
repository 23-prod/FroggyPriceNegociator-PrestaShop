<?php
/**
 * 2013-2015 Froggy Commerce
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
 * @copyright 2013-2015 Froggy Commerce
 * @license   Unauthorized copying of this file, via any medium is strictly prohibited
 */

class FroggyPriceNegociatorHookDisplayRightColumnProductProcessor extends FroggyHookProcessor
{
	public function display()
	{
		// Check if there is a possible negotiation on product
		$configurations = FroggyPriceNegociatorObject::getProductCombinationsNegociationSuccessChance((int)Tools::getValue('id_product'));

		$assign = array(
			'path_template_dir' => dirname(__FILE__).'/../views/templates/hook/',
			'module_dir' => $this->path,
			'configurations' => $configurations,
			'email' => (isset($this->context->customer->email) ? $this->context->customer->email : ''),
			'ps_version' => Tools::substr(_PS_VERSION_, 0, 3),
			'id_product' => (int)Tools::getValue('id_product'),
			'FC_PN_DISPLAY_MODE' => Configuration::get('FC_PN_DISPLAY_MODE'),
			'FC_PN_DISPLAY_DELAYED' => Configuration::get('FC_PN_DISPLAY_DELAYED'),
			'FC_PN_DISPLAY_DELAYED_PAGE' => Configuration::get('FC_PN_DISPLAY_DELAYED_PAGE'),
			'FC_PN_DISPLAY_BUTTON' => Configuration::get('FC_PN_DISPLAY_BUTTON'),
			'current_currency' => $this->context->currency
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
		if (!FroggyPriceNegociatorObject::isProductEligible($id_product, (int)$this->context->customer->id, (int)$this->context->cart->id))
			return '';

		// Return display
		return $this->display();
	}
}