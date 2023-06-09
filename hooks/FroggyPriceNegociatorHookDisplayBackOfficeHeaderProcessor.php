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

class FroggyPriceNegociatorHookDisplayBackOfficeHeaderProcessor extends FroggyHookProcessor
{
    private $fpn_product;

    public function initProductNegociatorConfiguration()
    {
        // We load the current configuration for this product
        $this->fpn_product = FroggyPriceNegociatorObject::getByIdProduct((int)Tools::getValue('id_product'), (int)Tools::getValue('id_product_attribute'));
    }

    public function saveProductNegociatorConfiguration()
    {
        // Check if product form has been submit
        if (!Tools::isSubmit('submitAddproduct') && !Tools::isSubmit('submitAddproductAndStay') && !Tools::isSubmit('submitProductAttribute')) {
            return false;
        }

        // If fields are empty
        if (Tools::getValue('froggypricenegociator_option') == '' && Tools::getValue('froggypricenegociator_price_min') == '') {
            // And configuration exists, we delete it
            if (Validate::isLoadedObject($this->fpn_product)) {
                return $this->fpn_product->delete();
            }

            // else we return false
            return false;
        }

        // We store the configuration
        $this->fpn_product->id_shop = $this->context->shop->id;
        $this->fpn_product->id_product = (int)Tools::getValue('id_product');
        $this->fpn_product->id_product_attribute = (int)Tools::getValue('id_product_attribute');
        $this->fpn_product->price_min = (float)Tools::getValue('froggypricenegociator_price_min');
        $this->fpn_product->reduction_percent_max = (float)Tools::getValue('froggypricenegociator_reduction_percent_max');
        $this->fpn_product->active = (int)Tools::getValue('froggypricenegociator_option');

        // We update it
        if (Validate::isLoadedObject($this->fpn_product)) {
            return $this->fpn_product->update();
        }

        // Or add it
        return $this->fpn_product->add();
    }

    public function displayProductNegociatorConfiguration()
    {
        $assign = array(
            'path_template_dir' => dirname(__FILE__) . '/../views/templates/hook/',
            'module_dir' => $this->path,
            'ps_version' => Tools::substr(_PS_VERSION_, 0, 3),
            'currency' => $this->context->currency,
            'fpn_product' => $this->fpn_product,
            'combinations' => FroggyPriceNegociatorObject::getCombinationsByIdProduct((int)Tools::getValue('id_product')),
            'is_product_blacklisted' => (FroggyPriceNegociatorObject::isProductBlacklisted((int)Tools::getValue('id_product')) ? 1 : 0),
            'FC_PN_ENABLE_GENERAL_OPTION' => Configuration::get('FC_PN_ENABLE_GENERAL_OPTION'),
            'FC_PN_GENERAL_REDUCTION' => Configuration::get('FC_PN_GENERAL_REDUCTION'),
            'FC_PN_TYPE' => Configuration::get('FC_PN_TYPE'),
        );
        $this->smarty->assign($this->module->name, $assign);
        return $this->module->fcdisplay(__FILE__, 'displayBackOfficeHeader.tpl');
    }

    public function run()
    {
        // Retrieve get data
        $id_product = (int)Tools::getValue('id_product');
        $tab = Tools::strtolower(Tools::getValue('tab'));
        $controller = Tools::strtolower(Tools::getValue('controller'));

        // If we are not on Admin Products section, we exit
        if ($controller != 'adminproducts' && $tab != 'admincatalog') {
            return '';
        }

        // If we are not updating a product, we exit
        if ($id_product < 1) {
            return '';
        }

        $this->initProductNegociatorConfiguration();
        $this->saveProductNegociatorConfiguration();
        return $this->displayProductNegociatorConfiguration();
    }
}
