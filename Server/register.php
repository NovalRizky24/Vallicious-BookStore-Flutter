<?php
// Database connection
include('config.php');

// Ambil data dari request POST
$username = $_POST['username'];
$password = $_POST['password']; // Pastikan untuk menghash password

// Hash password menggunakan bcrypt
$hashed_password = password_hash($password, PASSWORD_BCRYPT);

// Cek apakah username sudah terdaftar
$query = "SELECT * FROM login WHERE username = '$username'";
$result = mysqli_query($conn, $query);
if(mysqli_num_rows($result) > 0) {
    echo json_encode(["status" => "error", "message" => "Username sudah terdaftar"]);
} else {
    // Insert data ke database
    $insertQuery = "INSERT INTO login (username, password, role) VALUES ('$username', '$hashed_password', 'user')";
    if(mysqli_query($conn, $insertQuery)) {
        echo json_encode(["status" => "success", "message" => "Registrasi berhasil"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Gagal registrasi"]);
    }
}
?>
