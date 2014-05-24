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

class FroggyPriceNegociatorHookGetContentProcessor extends FroggyHookProcessor
{
	public $configurations = array(
		'FC_PN_ENABLE_GENERAL_OPTION' => 'int',
		'FC_PN_GENERAL_REDUCTION' => 'float',
		'FC_PN_TYPE' => 'string',
		'FC_PN_MAX_PRODUCT_BY_CART' => 'int',
		'FC_PN_COMPLIANT_PROMO' => 'int',
		'FC_PN_COMPLIANT_NEW' => 'int',
		'FC_PN_COMPLIANT_DISCOUNT' => 'int',
		'FC_PN_DISABLE_FOR_CATS' => 'string',
		'FC_PN_DISABLE_FOR_BRANDS' => 'string',
		'FC_PN_DISABLE_FOR_CUSTS' => 'string',
		'FC_PN_DISPLAY_DELAYED' => 'int',
		'FC_PN_DISPLAY_MODE' => 'string',
	);

	public function saveModuleConfiguration()
	{
		if (Tools::isSubmit('submitFroggyPriceNegociatorConfiguration'))
		{
			foreach ($this->configurations as $conf => $format)
			{
				$value = Tools::getValue($conf);
				if ($format == 'int')
					$value = (int)$value;
				else if ($format == 'float')
					$value = (float)$value;
				Configuration::updateValue($conf, $value);
			}
		}
	}

	public function displayModuleConfiguration()
	{

		$assign = array();
		$assign['module_dir'] = $this->path;
		foreach ($this->configurations as $conf => $format)
			$assign[$conf] = Configuration::get($conf);

		$this->smarty->assign($this->module->name, $assign);
		return $this->module->fcdisplay(__FILE__, 'getContent.tpl');
	}

	public function run()
	{
		$this->saveModuleConfiguration();
		return $this->displayModuleConfiguration();
	}
}