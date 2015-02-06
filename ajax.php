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

$configPath = '../../config/config.inc.php';
if (file_exists($configPath))
{
	include($configPath);
	$controller = new FrontController();
	$controller->init();

	if (file_exists(dirname(__FILE__).'/froggypricenegociator.php'))
	{
		include(dirname(__FILE__).'/froggypricenegociator.php');
		$fpn = new FroggyPriceNegociator();
		echo $fpn->ajaxRequest();
	}
	else
		die('Class module wasn\'t found');
}
else
	die('Config file is missing');
