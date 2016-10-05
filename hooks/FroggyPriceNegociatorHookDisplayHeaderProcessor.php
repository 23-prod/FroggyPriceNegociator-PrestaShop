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

class FroggyPriceNegociatorHookDisplayHeaderProcessor extends FroggyHookProcessor
{
    public function includeMedia()
    {
        if (Tools::getValue('id_product') < 1) {
            return true;
        }

        $this->context->controller->addCss($this->path . 'views/css/buttons.css');
        $this->context->controller->addCss($this->path . 'views/css/modal' . (version_compare(_PS_VERSION_, '1.6.0') >= 0 ? '-1.6' : '') . '.css');
        if (Configuration::get('FC_PN_DISPLAY_MODE') == 'REVEAL') {
            $this->context->controller->addCss($this->path . 'views/css/reveal.css');
            $this->context->controller->addJs($this->path . 'views/js/jquery.reveal.js');
        } else {
            $this->context->controller->addJs($this->path . 'views/js/jquery.fancybox.action.js');
            $this->context->controller->addJs($this->path . 'views/js/displayRightColumnProduct.js');
        }
    }

    public function run()
    {
        $this->includeMedia();
        $this->module->hookActionCartSave();
    }
}
