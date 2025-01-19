<?php
// Konfigurasi database
$servername = "localhost";
$username = "root"; // ganti dengan username database Anda
$password = ""; // ganti dengan password database Anda
$dbname = "vallory_db"; // ganti dengan nama database Anda

// Membuat koneksi ke database
$conn = new mysqli($servername, $username, $password, $dbname);

// Mengecek apakah koneksi berhasil
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
