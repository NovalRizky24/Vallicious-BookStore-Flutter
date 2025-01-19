<?php
include 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = $_POST['name'];
    $description = $_POST['description'];
    $price = $_POST['price'];
    $category = $_POST['category'];
    $imageName = '';

    if (isset($_FILES['image'])) {
        $image = $_FILES['image'];
        $targetDir = "Images/";
        $imageName = time() . "_" . basename($image['name']);
        $targetFilePath = $targetDir . $imageName;

        if (move_uploaded_file($image['tmp_name'], $targetFilePath)) {
            // File successfully uploaded
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Failed to upload image']);
            exit;
        }
    }

    // Insert data into the database
    $conn = new mysqli('localhost', 'username', 'password', 'database_name');
    if ($conn->connect_error) {
        die('Connection failed: ' . $conn->connect_error);
    }

    $stmt = $conn->prepare("INSERT INTO products (name, description, price, category, image_url) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("ssdss", $name, $description, $price, $category, $imageName);

    if ($stmt->execute()) {
        echo json_encode(['status' => 'success']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Failed to add product']);
    }

    $stmt->close();
    $conn->close();
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request']);
}
?>