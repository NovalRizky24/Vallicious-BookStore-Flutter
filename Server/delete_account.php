<?php
// Menyertakan file konfigurasi untuk koneksi ke database
include('config.php');

if (isset($_GET['id'])) {
    $id = $_GET['id'];  // Mendapatkan id akun yang akan dihapus

    // Query untuk menghapus akun berdasarkan id
    $sql = "DELETE FROM login WHERE id = $id";

    if ($conn->query($sql) === TRUE) {
        echo json_encode(array("message" => "Akun berhasil dihapus"));
    } else {
        echo json_encode(array("message" => "Gagal menghapus akun"));
    }
} else {
    echo json_encode(array("message" => "ID tidak ditemukan"));
}

// Menutup koneksi
$conn->close();
?>
