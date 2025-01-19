<?php
// Include config.php for the database connection
include('config.php');

// Get data from POST request
$user_id = $_POST['user_id'];
$product_id = $_POST['product_id'];
$total_price = $_POST['total_price'];

// Prepare the SQL query to insert data into the transaction table
$sql = "INSERT INTO transaction (user_id, product_id, total_price, transaction_date) 
        VALUES (?, ?, ?, NOW())";

// Prepare the statement and bind the parameters
$stmt = $conn->prepare($sql);
$stmt->bind_param("iis", $user_id, $product_id, $total_price);

// Execute the query and check if it was successful
if ($stmt->execute()) {
    echo "Transaction successful";
} else {
    echo "Error: " . $stmt->error;
}

// Close the prepared statement and connection
$stmt->close();
$conn->close();
?>
