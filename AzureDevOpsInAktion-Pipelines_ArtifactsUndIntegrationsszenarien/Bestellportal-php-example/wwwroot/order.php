<?php
require __DIR__ . '/vendor/autoload.php';
use MahlzeitExpress\Menu;
use MahlzeitExpress\Order;

$orderSuccess  = false;
$selectedMeal  = null;

if (
    !empty($_POST['meal_id'])
    && !empty($_POST['customer_name'])
    && !empty($_POST['address'])
) {
    $mealId       = (int) $_POST['meal_id'];
    $customerName = trim($_POST['customer_name']);
    $address      = trim($_POST['address']);

    $menu         = new Menu();
    $selectedMeal = $menu->getMealById($mealId);

    if ($selectedMeal) {
        $order        = new Order($mealId, $customerName, $address);
        $orderSuccess = $order->save();
        $orderDetails = $order->getDetails();
    }
}

include __DIR__ . '/templates/header.php';
include __DIR__ . '/templates/order.php';
include __DIR__ . '/templates/footer.php';
