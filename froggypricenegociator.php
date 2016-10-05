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

/*
 * Security
 */
defined('_PS_VERSION_') || require dirname(__FILE__) . '/index.php';

/*
 * Include Froggy Library
 */
if (!class_exists('FroggyModule', false)) {
    require_once _PS_MODULE_DIR_ . '/froggypricenegociator/froggy/FroggyModule.php';
}

/*
 * Require Object Model
 */
require_once _PS_MODULE_DIR_ . '/froggypricenegociator/classes/FroggyPriceNegociatorObject.php';
require_once _PS_MODULE_DIR_ . '/froggypricenegociator/classes/FroggyPriceNegociatorNewPriceObject.php';

class FroggyPriceNegociator extends FroggyModule
{
    /**
     * Constructor
     */
    public function __construct()
    {
        $this->name = 'froggypricenegociator';
        $this->version = '1.0.23';
        $this->author = 'Froggy Commerce';
        $this->tab = 'front_office_features';

        parent::__construct();

        $this->displayName = $this->l('Froggy Price Negotiator');
        $this->description = $this->l('Display a price negotiation button on product page for your customers');
        $this->module_key = 'a928c2276f3debc7d93b667f730d130a';
    }

    /**
     * Configuration method
     * @return string $html
     */
    public function getContent()
    {
        return $this->hookGetContent();
    }

    public function enable($force_all = false)
    {
        if (Tools::getValue('enable') == 1) {
            FroggyPriceNegociatorNewPriceObject::enableDisableNegociatedReduction(1);
        }
        return parent::enable($force_all);
    }

    public function disable($force_all = false)
    {
        FroggyPriceNegociatorNewPriceObject::enableDisableNegociatedReduction(0);
        return parent::disable($force_all);
    }

    public function uninstall()
    {
        FroggyPriceNegociatorNewPriceObject::enableDisableNegociatedReduction(0);
        return parent::uninstall();
    }

    /*
     * Retrocompat 1.4
     */
    public function hookHeader($params)
    {
        return $this->hookDisplayHeader($params);
    }

    public function hookCart($params)
    {
        return $this->hookActionCartSave($params);
    }

    public function hookExtraRight($params)
    {
        return $this->hookDisplayRightColumnProduct($params);
    }

    public function hookBackOfficeHeader($params)
    {
        return $this->hookDisplayBackOfficeHeader($params);
    }

    /*
     * Compat 1.6
     */
    public function hookDisplayProductButtons($params)
    {
        return $this->hookDisplayRightColumnProduct($params);
    }
}
