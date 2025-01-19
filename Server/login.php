<?php
// Database connection
include('config.php');

// Ambil data dari request POST
$username = $_POST['username'];
$password = $_POST['password'];

// Cek apakah username ada dalam database
$query = "SELECT * FROM login WHERE username = '$username'";
$result = mysqli_query($conn, $query);

if(mysqli_num_rows($result) > 0) {
    // Ambil data pengguna
    $user = mysqli_fetch_assoc($result);
    // Verifikasi password
    if(password_verify($password, $user['password'])) {
        echo json_encode([
            "status" => "success",
            "message" => "Login berhasil",
            "role" => $user['role']
        ]);
    } else {
        echo json_encode(["status" => "error", "message" => "Password salah"]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Username tidak ditemukan"]);
}
?>
