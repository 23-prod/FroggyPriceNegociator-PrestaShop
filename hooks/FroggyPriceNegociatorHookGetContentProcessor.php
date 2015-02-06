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
		'FC_PN_DISABLE_FOR_CATS' => array('type' => 'multiple', 'field' => 'categoryBox'),
		'FC_PN_DISABLE_FOR_BRANDS' => array('type' => 'multiple', 'field' => 'ids_manufacturers'),
		'FC_PN_DISABLE_FOR_CUSTS' => array('type' => 'multiple', 'field' => 'ids_groups'),
		'FC_PN_DISPLAY_DELAYED' => 'int',
		'FC_PN_DISPLAY_DELAYED_PAGE' => 'int',
		'FC_PN_DISPLAY_MODE' => 'string',
		'FC_PN_DISPLAY_BUTTON' => 'string',
	);

	public function saveModuleConfiguration()
	{
		if (Tools::isSubmit('submitFroggyPriceNegociatorConfiguration'))
		{
			foreach ($this->configurations as $conf => $format)
			{
				if (is_array($format))
				{
					$value = '';
					if ($format['type'] == 'multiple')
					{
						$values = Tools::getIsset($format['field']) ? Tools::getValue($format['field']) : '';
						if (is_array($values))
						{
							$values = array_map('intval', $values);
							$value = implode(',', $values);
						}
					}
				}
				else
				{
					$value = Tools::getValue($conf);
					if ($format == 'int')
						$value = (int)$value;
					else if ($format == 'float')
						$value = (float)$value;
				}
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
		$assign['ps_version'] = Tools::substr(_PS_VERSION_, 0, 3);

		$assign['manufacturers'] = Manufacturer::getManufacturers();
		$assign['selected_manufacturers'] = explode(',', Configuration::get('FC_PN_DISABLE_FOR_BRANDS'));

		$assign['groups'] = Group::getGroups($this->context->language->id);
		$assign['selected_groups'] = explode(',', Configuration::get('FC_PN_DISABLE_FOR_CUSTS'));

		$selected_cat = explode(',', $assign['FC_PN_DISABLE_FOR_CATS']);

		$helper = new FroggyHelperTreeCategories();
		if (version_compare(_PS_VERSION_, '1.5', '>') && Shop::getContext() == Shop::CONTEXT_SHOP)
		{
			$category = Category::getRootCategory();
			$helper->setRootCategory($category->id_category);
		}
		else
			$helper->setRootCategory(1);

		$helper->setSelectedCategories($selected_cat);
		$helper->setAttributeName('categoryBox');
		$helper->setModule($this->module);
		if (version_compare(_PS_VERSION_, '1.5', '>'))
			$helper->setContext(Context::getContext());
		else
			$helper->setContext(FroggyContext::getContext());

		$assign['category_tree'] = $helper->render();

		$this->smarty->assign($this->module->name, $assign);
		return $this->module->fcdisplay(__FILE__, 'getContent.tpl');
	}

	public function run()
	{
		$this->saveModuleConfiguration();
		return $this->displayModuleConfiguration();
	}
}