CREATE TABLE IF NOT EXISTS `@PREFIX@fpn_product` (
  `id_fpn_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(10) unsigned NOT NULL,
  `id_product` int(10) unsigned NOT NULL,
  `id_product_attribute` int(10) unsigned NOT NULL,
  `price_min` decimal(20,6) NOT NULL,
  `reduction_percent_max` decimal(20,6) NOT NULL,
  `date_add` datetime DEFAULT NULL,
  `date_upd` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_fpn_product`),
  KEY `id_shop` (`id_shop`),
  KEY `id_product` (`id_product`),
  KEY `id_product_attribute` (`id_product_attribute`)
) ENGINE=@ENGINE@ DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


CREATE TABLE IF NOT EXISTS `@PREFIX@fpn_product_new_price` (
  `id_fpn_product_new_price` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(10) unsigned NOT NULL,
  `id_product` int(10) unsigned NOT NULL,
  `id_product_attribute` int(10) unsigned NOT NULL,
  `id_customer` int(10) unsigned NOT NULL,
  `id_discount` int(10) unsigned NOT NULL,
  `id_cart_rule` int(10) unsigned NOT NULL,
  `email` varchar(255) NOT NULL,
  `ip` varchar(32) NOT NULL,
  `product_price` decimal(20,6) NOT NULL,
  `customer_offer` decimal(20,6) NOT NULL,
  `price_min` decimal(20,6) NOT NULL,
  `new_price` decimal(20,6) NOT NULL,
  `reduction` decimal(20,6) NOT NULL,
  `date_expiration` datetime DEFAULT NULL,
  `date_add` datetime DEFAULT NULL,
  `date_upd` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_fpn_product_new_price`),
  KEY `id_shop` (`id_shop`),
  KEY `id_product` (`id_product`),
  KEY `id_product_attribute` (`id_product_attribute`),
  KEY `id_customer` (`id_customer`),
  KEY `email` (`email`)
) ENGINE=@ENGINE@ DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;
