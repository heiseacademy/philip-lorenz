<?php
require __DIR__ . '/vendor/autoload.php';
use MahlzeitExpress\Menu;

$menu  = new Menu();
$meals = $menu->getMeals();

include __DIR__ . '/templates/header.php';
include __DIR__ . '/templates/menu.php';
include __DIR__ . '/templates/footer.php';
