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
		'calculate.chance.success' => 'CalculateChanceSuccess',
		'get.new.price' => 'getNewPrice',
	);

	public function CalculateChanceSuccess(FroggyPriceNegociatorObject $fpno)
	{
		if (rand() % 2)
			return 'seventyfive';
		return 'five';
	}


	public function error($error)
	{
		return Tools::jsonEncode(array('error' => $error));
	}

	public function run()
	{
		// Check arguments
		if ((int)Tools::getValue('id_product') < 0 || (float)Tools::getValue('offer') < 0 || !isset($this->methods[Tools::getValue('method')]))
			return $this->error($this->module->l('System error, please contact the merchant.'));

		// Check if there is a possible negotiation on specific id_product & id_product_attribute
		$fpno = FroggyPriceNegociatorObject::getByIdProduct((int)Tools::getValue('id_product'), (int)Tools::getValue('id_product_attribute'));
		if (!Validate::isLoadedObject($fpno))
		{
			// Check if there is a possible negotiation on general id_product
			$fpno = FroggyPriceNegociatorObject::getByIdProduct((int)Tools::getValue('id_product'));
			if (!Validate::isLoadedObject($fpno))
				return $this->error($this->module->l('The negotiation for this product is not available.'));
		}

		// Call method
		return $this->{$this->methods[Tools::getValue('method')]}($fpno);
	}
}