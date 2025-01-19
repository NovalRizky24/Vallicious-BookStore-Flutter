<?php
// Mengimpor konfigurasi koneksi
include('config.php');

// Query untuk mengambil data transaksi
$sql = "SELECT t.id, t.user_id, t.product_id, t.total_price, t.transaction_date, p.name AS product_name
        FROM transactions t
        JOIN products p ON t.product_id = p.id";
$result = $conn->query($sql);

$transactions = [];

if ($result->num_rows > 0) {
    // Mengambil data setiap baris dan memasukkan ke array
    while($row = $result->fetch_assoc()) {
        $transactions[] = [
            'id' => $row['id'],
            'user_id' => $row['user_id'],
            'product_id' => $row['product_id'],
            'product_name' => $row['product_name'],
            'total_price' => number_format($row['total_price'], 2),
            'transaction_date' => $row['transaction_date']
        ];
    }
} else {
    echo "0 hasil";
}

// Menampilkan data dalam format JSON yang rapi
header('Content-Type: application/json');
echo json_encode($transactions, JSON_PRETTY_PRINT);

// Menutup koneksi
$conn->close();
?>
