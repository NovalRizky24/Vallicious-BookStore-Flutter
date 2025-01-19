<?php
include 'config.php';

$query = "SELECT * FROM products";
$result = mysqli_query($conn, $query);

$products = [];
while ($row = mysqli_fetch_assoc($result)) {
    $products[] = $row;
}

// Menyajikan output JSON dengan format yang rapi
header('Content-Type: application/json');
echo json_encode($products, JSON_PRETTY_PRINT);
?>
