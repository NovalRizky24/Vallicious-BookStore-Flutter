-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 19, 2025 at 06:00 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vallory_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`id`, `username`, `password`, `role`) VALUES
(1, 'zaki', '$2y$10$nULuoUIcXqkoNOX.bc69P.3Tt9Dw1803ycE3RAEu/Ulm97exPecOi', 'user'),
(5, 'admin', '$2y$10$9WumNBzaEXz87ZW4p.9jQeJW4tpuWGQw0b0jn6xOx.Tw7NpVCLS4G', 'admin'),
(6, 'noval', '$2y$10$UOO7qzC24.q5EDbmz3SKUeyhr9i4keaGXjtGL/oTaNpp/5VfWJyiS', 'user'),
(7, 'rizky', '$2y$10$1L/FBsEW2Z7CSwJMOyDuherV5WwoFpTTGBlhgWHy.jsMXDZAjcPXe', 'user'),
(10, 'wongka', '$2y$10$kZeDXSSn26zhQ8SXw4uuZOMAJnWoXekGYuSuD5yXEwqS1l.8IB4Ji', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `category`, `image_url`, `created_at`) VALUES
(4, 'The Song of Achilles', 'Novel karya Madeline Miller tentang kisah cinta antara Achilles dan Patroclus dalam mitologi Yunani.', 140000.00, 'Fiction', 'https://cdn.gramedia.com/uploads/items/The_Song_of_Achilles_cov.jpg', '2025-01-18 16:02:07'),
(5, 'Bungo Stray Dogs 1', 'Volume pertama dari Bungo Stray Dogs, sebuah manga yang menggabungkan aksi dan dunia sastra Jepang.', 90000.00, 'Manga', 'https://cdn.gramedia.com/uploads/items/PK_Cover-Bungo_Stray_Dogs-01-INA.jpg', '2025-01-18 16:02:07'),
(6, 'Teh dan Pengkhianat', 'Novel thriller yang menceritakan kisah penuh pengkhianatan dan intrik seputar teh.', 95000.00, 'Fiction', 'https://cdn.gramedia.com/uploads/items/9786024811372_Cover_Teh_dan.jpg', '2025-01-18 16:02:07'),
(7, 'The Chronicles of Narnia #2: The Lion, the Witch and the Wardrobe', 'Buku kedua dari seri The Chronicles of Narnia, mengikuti petualangan anak-anak Pevensie di dunia Narnia.', 120000.00, 'Fiction', 'https://cdn.gramedia.com/uploads/items/Narnia_2_The_Lion_The_Witch_and_The_Wardrobe_cov_page-0001.jpg', '2025-01-18 16:02:07'),
(8, 'The Son Of Neptune – The Heroes Of Olympus', 'Buku kedua dari seri Heroes of Olympus, dengan protagonis baru dan mitologi Romawi yang kuat.', 130000.00, 'Fantasy', 'https://cdn.gramedia.com/uploads/items/9786023857333_The-Son-Of-Neptune---The-Heroes-Of-Olympus-2-Republish.jpg', '2025-01-18 16:02:07'),
(9, 'Charlie and The Chocolate Factory', 'Kisah klasik tentang Charlie dan petualangannya di pabrik cokelat Willy Wonka.', 110000.00, 'Children', 'https://cdn.gramedia.com/uploads/items/9786023853076_charlie_and_chocolate_factory.jpg', '2025-01-18 16:02:07'),
(10, 'The Bliss Bakery Trilogy #2: A Dash of Magic', 'Buku kedua dari trilogi The Bliss Bakery yang mengisahkan petualangan penuh sihir di dunia bakery.', 105000.00, 'Fiction', 'https://cdn.gramedia.com/uploads/items/9789794338117_The-Bliss-Bakery-Trilogy-2_A-Dash-of-Magic.jpg', '2025-01-18 16:02:07'),
(11, 'Alvaro Aurora', 'Novel yang mengisahkan perjalanan seorang pemuda bernama Alvaro untuk menemukan cahaya kehidupannya.', 115000.00, 'Fiction', 'https://cdn.gramedia.com/uploads/items/9786237191032.jpg', '2025-01-18 16:02:07'),
(12, 'Parable', 'Sebuah cerita yang mendalam dan memikat, yang menggabungkan elemen-elemen filosofi kehidupan dan kejadian sehari-hari dalam konteks narasi fiksi yang kuat.', 150000.00, 'Fiksi, Sastra', 'https://www.gramedia.com/blog/content/images/2024/10/Parable1.jpg', '2025-01-19 04:05:30'),
(13, 'Dru dan Kisah Lima Kerajaan', 'Mengisahkan petualangan seru seorang pahlawan muda dalam menjelajahi lima kerajaan yang penuh dengan tantangan, misteri, dan persahabatan.', 130000.00, 'Fantasi, Petualangan', 'https://www.gramedia.com/blog/content/images/2024/10/Dru-dan-Kisah-Lima-Kerajaan.jpg', '2025-01-19 04:05:30'),
(14, 'The Apothecary Diaries 12', 'Buku ke-12 dari serial yang mengisahkan kehidupan seorang apoteker wanita muda di dunia kuno yang penuh intrik dan rahasia.', 120000.00, 'Manga, Sejarah, Drama', 'https://www.gramedia.com/blog/content/images/2024/10/The-Apothecary-Diaries-12.jpg', '2025-01-19 04:05:30'),
(15, 'Look Back', 'Sebuah karya yang menggugah tentang penyesalan, pilihan hidup, dan perjalanan emosional seseorang dalam menghadapi kenyataan masa lalu.', 100000.00, 'Fiksi, Drama', 'https://www.gramedia.com/blog/content/images/2024/09/Look-Back-1.jpeg', '2025-01-19 04:05:30'),
(17, 'The Fragrant Flower Blooms With Dignity-Kaoru & Rin 1', 'Sebuah cerita tentang dua karakter yang saling menginspirasi dalam kehidupan mereka, dengan tema persahabatan dan pencapaian pribadi.', 130000.00, 'Manga, Drama, Romantis', 'https://www.gramedia.com/blog/content/images/2024/09/The-Fragrant-Flower-Blooms-With-Dignity-Kaoru---Rin-1-1.jpg', '2025-01-19 04:05:30'),
(18, 'Hidden Potential: Rahasia Mencapai Hal-Hal yang Lebih Besar', 'Buku motivasi yang mengungkapkan cara menemukan dan memaksimalkan potensi tersembunyi dalam diri, untuk meraih pencapaian yang lebih besar dalam kehidupan.', 170000.00, 'Motivasi, Self-help, Pengembangan Diri', 'https://www.gramedia.com/blog/content/images/2024/10/Hidden-Potential.jpg', '2025-01-19 04:05:30'),
(19, '3726 MDPL', 'Cerita inspiratif mengenai perjalanan mendaki gunung dengan tantangan fisik dan mental yang luar biasa tinggi, menggambarkan perjuangan dan pencapaian.', 100000.00, 'Motivasi, Petualangan, Self-help', 'https://www.gramedia.com/blog/content/images/2024/09/3726-MDPL-1.jpg', '2025-01-19 04:05:30');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `transaction_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `user_id`, `product_id`, `total_price`, `transaction_date`) VALUES
(28, 6, 5, 9000.00, '2025-01-19 04:20:50'),
(29, 1, 14, 120000.00, '2025-01-19 04:20:50'),
(30, 7, 11, 115000.00, '2025-01-19 04:21:42'),
(31, 10, 7, 120000.00, '2025-01-19 04:21:42'),
(32, 7, 11, 115000.00, '2025-01-19 04:21:45'),
(33, 10, 7, 120000.00, '2025-01-19 04:21:45'),
(34, 6, 8, 130000.00, '2025-01-19 04:22:11');

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wishlist`
--

INSERT INTO `wishlist` (`id`, `user_id`, `product_id`, `created_at`) VALUES
(2, 123, 3, '2025-01-19 02:33:01'),
(6, 123, 5, '2025-01-19 04:28:59'),
(7, 123, 12, '2025-01-19 04:29:06'),
(8, 123, 11, '2025-01-19 04:29:08'),
(9, 123, 13, '2025-01-19 04:29:09'),
(10, 123, 7, '2025-01-19 04:29:27'),
(11, 123, 17, '2025-01-19 04:29:34'),
(12, 123, 15, '2025-01-19 04:29:39'),
(14, 123, 4, '2025-01-19 04:30:05');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_wishlist` (`user_id`,`product_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `login` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
