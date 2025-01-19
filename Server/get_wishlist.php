<?php
// Menyertakan file konfigurasi untuk koneksi ke database
include('config.php');

// Menambahkan header untuk memastikan respons sebagai JSON
header('Content-Type: application/json');

// Query untuk mengambil data wishlist
$sql = "SELECT w.id, w.user_id, w.product_id, w.created_at, p.name AS product_name 
        FROM wishlist w
        JOIN products p ON w.product_id = p.id";  // Misalkan ada tabel 'products' untuk nama produk
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Menyiapkan array untuk menyimpan data
    $wishlistData = array();
    
    while($row = $result->fetch_assoc()) {
        $wishlistData[] = $row;  // Menambahkan data ke array
    }

    // Mengembalikan data dalam format JSON yang lebih rapi
    echo json_encode($wishlistData, JSON_PRETTY_PRINT);
} else {
    echo json_encode(array("message" => "No wishlist found"), JSON_PRETTY_PRINT);
}

// Menutup koneksi
$conn->close();
?>
