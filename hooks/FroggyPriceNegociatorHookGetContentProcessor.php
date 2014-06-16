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
	public $configuration_result = '';
	public $configurations = array(
		'FC_PN_ENABLE_GENERAL_OPTION' => 'int',
		'FC_PN_GENERAL_REDUCTION' => 'float',
		'FC_PN_TYPE' => 'string',
		'FC_PN_MAX_QUANTITY_BY_PRODUCT' => 'int',
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
			$categories = Tools::getIsset('FC_PN_DISABLE_FOR_CATS') ? Tools::getValue('FC_PN_DISABLE_FOR_CATS') : '';
			if (Tools::getIsset('FC_PN_DISABLE_FOR_CATS') && is_array($categories)) {
				// Force Int conversion
				$categories = array_map('intval', $categories);
				Configuration::updateValue('FC_PN_DISABLE_FOR_CATS', implode(',', $categories));
			} else {
				Configuration::updateValue('FC_PN_DISABLE_FOR_CATS', '');
			}

			foreach ($this->configurations as $conf => $format)
			{
				if ($conf == 'FC_PN_DISABLE_FOR_CATS') continue; // Already saved before with a special treatment

				$value = Tools::getValue($conf);
				if ($format == 'int')
					$value = (int)$value;
				else if ($format == 'float')
					$value = (float)$value;
				Configuration::updateValue($conf, $value);
			}
			$this->configuration_result = 'ok';
		}
	}

	public function displayModuleConfiguration()
	{
		$assign = array();
		$assign['module_dir'] = $this->path;
		foreach ($this->configurations as $conf => $format)
			$assign[$conf] = Configuration::get($conf);
		$assign['result'] = $this->configuration_result;
		$assign['ps_version'] = substr(_PS_VERSION_, 0, 3);

		$selected_cat = explode(',', $assign['FC_PN_DISABLE_FOR_CATS']);
		// Translations are not automatic for the moment ;)
		if (version_compare(_PS_VERSION_,'1.5','>'))
		{
			if (Shop::getContext() == Shop::CONTEXT_SHOP)
			{
				$root_category = Category::getRootCategory();
				$root_category = array('id_category' => $root_category->id_category, 'name' => $root_category->name);
			}
			else
				$root_category = array('id_category' => '0', 'name' => $this->l('Root'));
			$helper = new Helper();
			$assign['category_tree'] = $helper->renderCategoryTree($root_category, $selected_cat, 'FC_PN_DISABLE_FOR_CATS');
		}
		else
		{
			$trads = array(
				'Home' => $this->l('Home'),
				'selected' => $this->l('selected'),
				'Collapse All' => $this->l('Collapse All'),
				'Expand All' => $this->l('Expand All'),
				'Check All' => $this->l('Check All'),
				'Uncheck All'  => $this->l('Uncheck All'),
				'search'  => $this->l('Search a category')
			);
			$assign['category_tree'] = Helper::renderAdminCategorieTree($trads, $selected_cat, 'FC_PN_DISABLE_FOR_CATS');
		}

		$this->smarty->assign($this->module->name, $assign);
		return $this->module->fcdisplay(__FILE__, 'getContent.tpl');
	}

	public function run()
	{
		$this->saveModuleConfiguration();
		return $this->displayModuleConfiguration();
	}
}