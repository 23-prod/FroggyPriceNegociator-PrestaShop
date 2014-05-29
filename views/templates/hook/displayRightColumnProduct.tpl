{*
* 2010 - 2014 Sellermania / Froggy Commerce / 23Prod SARL
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to team@froggy-commerce.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade your module to newer
* versions in the future.
*
*  @author Fabien Serny - Froggy Commerce <team@froggy-commerce.com>
*  @copyright	2010-2014 Sellermania / Froggy Commerce / 23Prod SARL
*  @version		1.0
*  @license		http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*}
{literal}
<style>
	.froggy-price-negociator-button-front{
	display: inline-block;
	text-align: center;
	padding: 10px 32px 12px;
	color: #fff;
	text-decoration: none;
	font-weight: bold;
	font-size: 14px; font-size: 1.4em;
	line-height: 1;
	font-family: "Helvetica Neue", "Helvetica", Arial, Verdana, sans-serif;
	position: relative;
	cursor: pointer;
	border: none;
	outline: none;
	margin: 0;
	-webkit-transition: background-color .15s ease-in-out;
	-moz-transition: background-color .15s ease-in-out;
	-o-transition: background-color .15s ease-in-out;
	text-shadow: 0px 2px 1px rgba(0, 0, 0, 0.3);
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	-ms-border-radius: 5px;
	-o-border-radius: 5px;
	border-radius: 5px;
	}
	.froggy-price-negociator-button-front.radius{
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	-ms-border-radius: 5px;
	-o-border-radius: 5px;
	border-radius: 5px;
	}
	.froggy-price-negociator-button-front.radius-big{
		-webkit-border-radius: 1000px;
		-moz-border-radius: 1000px;
		-ms-border-radius: 1000px;
		-o-border-radius: 1000px;
		border-radius: 1000px;
	}
	.froggy-price-negociator-button-front.red{
	background-color: #ed1c23;
	background-image: -webkit-linear-gradient(top, #ed1c23 0%, #891100 100%);
	background-image: -moz-linear-gradient(top, #ed1c23 0%, #891100 100%);
	background-image: -ms-linear-gradient(top, #ed1c23 0%, #891100 100%);
	background-image: -o-linear-gradient(top, #ed1c23 0%, #891100 100%);
	background-image: linear-gradient(top, #ed1c23 0%, #891100 100%);
	-webkit-box-shadow: inset 0px 0px 0px 1px rgba(255, 115, 100, 0.6), 0 1px 3px #333333;
	-moz-box-shadow: inset 0px 0px 0px 1px rgba(255, 115, 100, 0.6), 0 1px 3px #333333;
	-ms-box-shadow: inset 0px 0px 0px 1px rgba(255, 115, 100, 0.6), 0 1px 3px #333333;
	-o-box-shadow: inset 0px 0px 0px 1px rgba(255, 115, 100, 0.6), 0 1px 3px #333333;
	box-shadow: inset 0px 0px 0px 1px rgba(255, 115, 100, 0.6), 0 1px 3px #333333;
	border: 1px solid #951100;
	}


	.froggy-price-negociator-button-front:hover, .froggy-price-negociator-button-front:focus{ background-color: #ff0900;
	background-image: -webkit-gradient(linear, left top, left bottom, from(#ff0900 0%), to(#db504d 100%));
	/* Saf4+, Chrome */
	background-image: -webkit-linear-gradient(top, #ff0900 0%, #a20601 100%);
	background-image: -moz-linear-gradient(top, #ff0900 0%, #a20601 100%);
	background-image: -ms-linear-gradient(top, #ff0900 0%, #a20601 100%);
	background-image: -o-linear-gradient(top, #ff0900 0%, #a20601 100%);
	background-image: linear-gradient(top, #ff0900 0%, #a20601 100%);
	cursor: pointer;
	text-decoration: none;
	color:#fff;
	}
	.froggy-price-negociator-button-front:visited{color:#fff}




	/*I just made this background and wanted to save it here*/

	.button-1 {
		outline: none;
		font-family: 'helvetica neue' sans-serif;
		font-size: 1.6em;
		color: #fff;
		text-shadow: -1px -1px 1px rgba(0, 0, 0, 0.7), 1px 1px 1px rgba(255, 255, 255, 0.3);
		display: block;
		margin: 1.5em;
		padding: 16px 25px 18px 25px;
		cursor: pointer;
		background-color: #2e050c;
		background-image: linear-gradient(273deg, #eb4763 30%, #e6193c 40%);
		border: none;
		border-radius: 16px;
		text-align: center;
		box-shadow: inset 0px 0px 1px 1px rgba(138, 15, 36, 0.9), inset 0px 0px 2px 3px rgba(230, 25, 60, 0.9), inset 1px 1px 1px 4px rgba(255, 255, 255, 0.8), inset 0px 0px 2px 7px rgba(235, 71, 99, 0.8), inset 0px 0px 4px 10px rgba(230, 25, 60, 0.9), 4px 4px 4px 2px rgba(92, 10, 24, 0.55), 0px 0px 3px 2px rgba(184, 20, 48, 0.9), 0px 0px 2px 6px rgba(230, 25, 60, 0.9), -1px -1px 1px 6px rgba(255, 255, 255, 0.9), 0px 0px 2px 11px rgba(230, 25, 60, 0.9), 0px 0px 1px 12px rgba(184, 20, 48, 0.9), 1px 3px 14px 14px rgba(0, 0, 0, 0.4);
	}

	.button-1:hover{
		text-decoration:none;
	}
	.button-1:visited{color:#fff}
	.button-1:active {
		color: #d9d9d9;
		padding: 16px 25px 18px 25px;
		background-image: linear-gradient(273deg, #e6193c 50%, #e8304f 60%);
		box-shadow: inset 3px 4px 3px 2px rgba(92, 10, 24, 0.55), inset 0px 0px 1px 1px rgba(138, 15, 36, 0.9), inset -1px -1px 2px 3px rgba(230, 25, 60, 0.9), inset -2px -2px 1px 3px rgba(255, 255, 255, 0.8), inset 0px 0px 2px 7px rgba(235, 71, 99, 0.8), inset 0px 0px 3px 10px rgba(230, 25, 60, 0.9), 0px 0px 3px 2px rgba(184, 20, 48, 0.9), 0px 0px 2px 6px rgba(230, 25, 60, 0.9), -1px -1px 1px 6px rgba(255, 255, 255, 0.9), 0px 0px 2px 11px rgba(230, 25, 60, 0.9), 0px 0px 1px 12px rgba(184, 20, 48, 0.9), 1px 3px 14px 14px rgba(0, 0, 0, 0.4);
	}







</style>
{/literal}
<a href="#" title="Négocier le prix" class="button-1 ppfroggy-price-negociator-button-front red radius">Négocier le prix</a>