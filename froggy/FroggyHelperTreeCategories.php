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
defined('_PS_VERSION_') || require dirname(__FILE__).'/index.php';

class FroggyHelperTreeCategories
{
    private $id_lang;
    private $root_category_id;
    private $selected_categories;
    private $attribute_name;

    private $module;
    private $context;

    public function setLang($id)
    {
        $this->id_lang = $id;
    }

    public function setAttributeName($name)
    {
        $this->attribute_name = $name;
    }

    public function setRootCategory($id)
    {
        $this->root_category_id = $id;
    }

    public function setSelectedCategories($categories)
    {
        $this->selected_categories = $categories;
    }

    public function setModule($module)
    {
        $this->module = $module;
    }

    public function setContext($context)
    {
        $this->context = $context;
    }

    public function getLang()
    {
        return $this->id_lang;
    }

    public function getRootCategory()
    {
        return $this->root_category_id;
    }

    public function getAttributeName()
    {
        return $this->attribute_name;
    }

    public function render()
    {
        if (Tools::substr(_PS_VERSION_, 0, 3) == '1.4') {
            $categories = $this->getNestedCategories14($this->getRootCategory(), $this->getLang());
        } else {
            $categories = $this->getNestedCategories($this->getRootCategory(), $this->getLang());
        }
        $this->context->smarty->assign('categories_tree_id', rand());
        $this->context->smarty->assign('categories_tree', $this->renderTreeBranch($categories));
        return $this->module->fcdisplay(dirname(__FILE__).'/../../'.$this->module->name, 'helpers/helper-tree.tpl');
    }

    public function renderTreeBranch($categories)
    {
        $branches = array();
        foreach ($categories as $category) {
            $branches[] = array('name' => $category['name'], 'id_category' => $category['id_category'], 'checked' => (in_array($category['id_category'], $this->selected_categories) ? true : false), 'children' => (isset($category['children']) ? ' '.$this->renderTreeBranch($category['children']) : ''));
        }
        $this->context->smarty->assign('categories_tree_branches', $branches);
        $this->context->smarty->assign('categories_tree_attribute_name', $this->getAttributeName());
        return $this->module->fcdisplay(dirname(__FILE__).'/../../'.$this->module->name, 'helpers/helper-tree-branch.tpl');
    }

    public static function getNestedCategories14($root_category = null, $id_lang = false, $active = true, $groups = null, $use_shop_restriction = true, $sql_filter = '', $sql_sort = '', $sql_limit = '')
    {
        if (isset($root_category) && !Validate::isInt($root_category)) {
            die(Tools::displayError());
        }

        if (!Validate::isBool($active)) {
            die(Tools::displayError());
        }

        if (isset($groups) && Group::isFeatureActive() && !is_array($groups)) {
            $groups = (array)$groups;
        }

        $result = Db::getInstance()->executeS(
            'SELECT c.*, cl.*
            FROM `'._DB_PREFIX_.'category` c
            LEFT JOIN `'._DB_PREFIX_.'category_lang` cl ON c.`id_category` = cl.`id_category`
            '.(isset($groups) && Group::isFeatureActive() ? 'LEFT JOIN `'._DB_PREFIX_.'category_group` cg ON c.`id_category` = cg.`id_category`' : '').'
            '.(isset($root_category) ? 'RIGHT JOIN `'._DB_PREFIX_.'category` c2 ON c2.`id_category` = '.(int)$root_category.' AND c.`nleft` >= c2.`nleft` AND c.`nright` <= c2.`nright`' : '').'
            WHERE 1 '.$sql_filter.' '.($id_lang ? 'AND `id_lang` = '.(int)$id_lang : '').'
            '.($active ? ' AND c.`active` = 1' : '').'
            '.(isset($groups) && Group::isFeatureActive() ? ' AND cg.`id_group` IN ('.implode(',', $groups).')' : '').'
            '.(!$id_lang || (isset($groups) && Group::isFeatureActive()) ? ' GROUP BY c.`id_category`' : '').'
            '.($sql_sort != '' ? $sql_sort : ' ORDER BY c.`level_depth` ASC').'
            '.($sql_sort == '' && $use_shop_restriction ? ', c.`position` ASC' : '').'
            '.($sql_limit != '' ? $sql_limit : '')
        );

        $categories = array();
        $buff = array();

        if (!isset($root_category)) {
            $root_category = 1;
        }

        foreach ($result as $row) {
            $current = &$buff[$row['id_category']];
            $current = $row;

            if ($row['id_category'] == $root_category) {
                $categories[$row['id_category']] = &$current;
            } else {
                $buff[$row['id_parent']]['children'][$row['id_category']] = &$current;
            }
        }

        return $categories;
    }

    public static function getNestedCategories($root_category = null, $id_lang = false, $active = true, $groups = null, $use_shop_restriction = true, $sql_filter = '', $sql_sort = '', $sql_limit = '')
    {
        if (isset($root_category) && !Validate::isInt($root_category)) {
            die(Tools::displayError());
        }

        if (!Validate::isBool($active)) {
            die(Tools::displayError());
        }

        if (isset($groups) && Group::isFeatureActive() && !is_array($groups)) {
            $groups = (array)$groups;
        }

        $cache_id = 'Category::getNestedCategories_'.md5((int)$root_category.(int)$id_lang.(int)$active.(int)$active.(isset($groups) && Group::isFeatureActive() ? implode('', $groups) : ''));

        if (!Cache::isStored($cache_id)) {
            $result = Db::getInstance()->executeS(
                'SELECT c.*, cl.*
                FROM `'._DB_PREFIX_.'category` c
                '.($use_shop_restriction ? Shop::addSqlAssociation('category', 'c') : '').'
                LEFT JOIN `'._DB_PREFIX_.'category_lang` cl ON c.`id_category` = cl.`id_category`'.Shop::addSqlRestrictionOnLang('cl').'
                '.(isset($groups) && Group::isFeatureActive() ? 'LEFT JOIN `'._DB_PREFIX_.'category_group` cg ON c.`id_category` = cg.`id_category`' : '').'
                '.(isset($root_category) ? 'RIGHT JOIN `'._DB_PREFIX_.'category` c2 ON c2.`id_category` = '.(int)$root_category.' AND c.`nleft` >= c2.`nleft` AND c.`nright` <= c2.`nright`' : '').'
                WHERE 1 '.$sql_filter.' '.($id_lang ? 'AND `id_lang` = '.(int)$id_lang : '').'
                '.($active ? ' AND c.`active` = 1' : '').'
                '.(isset($groups) && Group::isFeatureActive() ? ' AND cg.`id_group` IN ('.implode(',', $groups).')' : '').'
                '.(!$id_lang || (isset($groups) && Group::isFeatureActive()) ? ' GROUP BY c.`id_category`' : '').'
                '.($sql_sort != '' ? $sql_sort : ' ORDER BY c.`level_depth` ASC').'
                '.($sql_sort == '' && $use_shop_restriction ? ', category_shop.`position` ASC' : '').'
                '.($sql_limit != '' ? $sql_limit : '')
            );

            $categories = array();
            $buff = array();

            if (!isset($root_category)) {
                $root_category = 1;
            }

            foreach ($result as $row) {
                $current = &$buff[$row['id_category']];
                $current = $row;

                if ($row['id_category'] == $root_category) {
                    $categories[$row['id_category']] = &$current;
                } else {
                    $buff[$row['id_parent']]['children'][$row['id_category']] = &$current;
                }
            }

            Cache::store($cache_id, $categories);
        }

        return Cache::retrieve($cache_id);
    }
}
