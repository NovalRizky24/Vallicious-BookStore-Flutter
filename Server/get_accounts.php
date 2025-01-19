<?php
// Menyertakan file konfigurasi untuk koneksi ke database
include('config.php');

// Menambahkan header untuk memastikan respons sebagai JSON
header('Content-Type: application/json');

// Query untuk mengambil data login
$sql = "SELECT id, username, role FROM login";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Menyiapkan array untuk menyimpan data
    $loginData = array();
    
    while($row = $result->fetch_assoc()) {
        $loginData[] = $row;  // Menambahkan data ke array
    }

    // Mengembalikan data dalam format JSON yang lebih rapi
    echo json_encode($loginData, JSON_PRETTY_PRINT);
} else {
    echo json_encode(array("message" => "No data found"), JSON_PRETTY_PRINT);
}

// Menutup koneksi
$conn->close();
?>
