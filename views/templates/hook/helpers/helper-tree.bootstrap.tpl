{**
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
 *}

<input type="button" id="category-tree-select-all-{$categories_tree_id|intval}" value="{l s='Select all' mod='froggytoolbarv2'}" class="btn btn-default" />
<input type="button" id="category-tree-unselect-all-{$categories_tree_id|intval}" value="{l s='Unselect all' mod='froggytoolbarv2'}" class="btn btn-default" />
<br>
{FroggyDisplaySafeHtml s=$categories_tree}

<script>
    $('#category-tree-select-all-{$categories_tree_id|intval}').click(function() {
       $('.categories-tree-checkbox-{$categories_tree_id|intval}').prop('checked', 'checked');
	});
	$('#category-tree-unselect-all-{$categories_tree_id|intval}').click(function() {
		$('.categories-tree-checkbox-{$categories_tree_id|intval}').prop('checked', '');
	});
</script>

<style>
    .froggy-categories-tree li { list-style-type: none }
</style>