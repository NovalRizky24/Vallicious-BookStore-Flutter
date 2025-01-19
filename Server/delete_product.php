<?php
include 'config.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Mengambil ID dari request POST dan memastikan bahwa ID merupakan integer
    $id = isset($_POST['id']) ? (int) $_POST['id'] : 0; // Ensure ID is set and cast to integer

    if ($id > 0) { // Check if ID is valid before querying the database
        $query = "DELETE FROM products WHERE id = $id";

        if (mysqli_query($conn, $query)) {
            echo json_encode(['status' => 'success', 'message' => 'Product deleted successfully']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Failed to delete product']);
        }
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Invalid product ID']);
    }
}
?>
