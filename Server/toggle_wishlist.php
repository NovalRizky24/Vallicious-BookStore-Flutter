<?php
header('Content-Type: application/json');
// Enable CORS if needed
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

// Sertakan file konfigurasi untuk koneksi database
include('config.php');

// Get POST data
$user_id = $_POST['user_id'];
$product_id = $_POST['product_id'];
$action = $_POST['action'];

// Validate input
if (!$user_id || !$product_id || !$action) {
    http_response_code(400);
    echo json_encode(["error" => "Missing required fields"]);
    exit;
}

if ($action === 'add') {
    $sql = "INSERT INTO wishlist (user_id, product_id) VALUES (?, ?)";
} else {
    $sql = "DELETE FROM wishlist WHERE user_id = ? AND product_id = ?";
}

$stmt = $conn->prepare($sql);
$stmt->bind_param("ii", $user_id, $product_id);

if ($stmt->execute()) {
    http_response_code(200);
    echo json_encode(["message" => "Success"]);
} else {
    http_response_code(500);
    echo json_encode(["error" => $conn->error]);
}

$stmt->close();
$conn->close();
?>
