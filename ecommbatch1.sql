-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 04, 2024 at 02:34 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecommbatch1`
--

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` float NOT NULL,
  `total_price` int NOT NULL,
  `status` int NOT NULL DEFAULT '0' COMMENT '0-cart|1-sold',
  `remarks` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `user_id`, `product_id`, `quantity`, `unit_price`, `total_price`, `status`, `remarks`, `created_at`, `updated_at`) VALUES
(1, 5, 41, 2, 2560, 5120, 0, NULL, '2024-11-16 15:58:24', '2024-11-16 15:58:24'),
(2, 7, 40, 1, 2220, 2220, 0, NULL, '2024-11-23 13:59:59', '2024-11-23 13:59:59'),
(3, 5, 45, 1, 3050, 3050, 0, NULL, '2024-11-23 14:19:51', '2024-11-23 14:19:51'),
(4, 5, 46, 1, 14670, 14670, 0, NULL, '2024-11-23 15:47:13', '2024-11-23 15:47:13'),
(5, 9, 41, 1, 2560, 2560, 1, NULL, '2024-12-03 15:36:19', '2024-12-03 15:36:19'),
(6, 9, 41, 1, 2560, 2560, 1, NULL, '2024-12-03 15:36:23', '2024-12-03 15:36:23'),
(7, 9, 41, 1, 2560, 2560, 1, NULL, '2024-12-03 15:36:25', '2024-12-03 15:36:25'),
(8, 9, 41, 1, 2560, 2560, 1, NULL, '2024-12-03 15:36:28', '2024-12-03 15:36:28');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int NOT NULL,
  `order_date` datetime NOT NULL,
  `payment_method` smallint NOT NULL,
  `account_no` varchar(25) NOT NULL,
  `user_id` int NOT NULL,
  `total_order` float NOT NULL,
  `delivery_fee` float NOT NULL,
  `total_amount` float NOT NULL,
  `remarks` varchar(500) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `order_date`, `payment_method`, `account_no`, `user_id`, `total_order`, `delivery_fee`, `total_amount`, `remarks`, `created_at`, `updated_at`) VALUES
(2, '2024-12-03 18:01:13', 1, '2312-2312-32131', 9, 10240, 50, 10290, NULL, '2024-12-03 18:01:13', '2024-12-03 18:01:13');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `product_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` int NOT NULL,
  `base_price` float NOT NULL,
  `stocks` int NOT NULL,
  `unit_price` float NOT NULL,
  `total_price` float NOT NULL,
  `image_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='product inventory';

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `product_name`, `product_description`, `category_id`, `base_price`, `stocks`, `unit_price`, `total_price`, `image_url`, `created_at`, `updated_at`) VALUES
(39, 'Trendsonic Frontier Igloo', 'Igloo IG30A White Dual Chamber Gaming ATX Case w/4x120mm Fan', 1, 2100, 5, 2490, 12450, 'public/uploads/products/92aff04a55121a69af1807f001f826df.webp', '2024-11-15 21:50:23', '2024-11-15 21:50:23'),
(40, 'FSP CMT212A TG', 'ATX Black Mid Tower Case w/ 4x120mm Fan', 1, 2060, 0, 2220, 11100, 'public/uploads/products/b50ef7ae584647f70648838b35a93740.webp', '2024-11-15 21:54:44', '2024-11-15 21:54:44'),
(41, 'Tecware Infinity M', ' Infinity M ARGB Dual Tempered Glass mATX Case w/ 3x120mm ARGB Fans', 1, 2200, 6, 2560, 25600, 'public/uploads/products/2ff7ea150532ebfe4fdba6d75a87b8a3.webp', '2024-11-15 21:55:38', '2024-11-15 21:55:38'),
(42, 'Cooler Master Masterbox', 'Masterbox NR200P White ITX Case MCB-NR200P-WGNN-S00', 1, 4000, 7, 4380, 30660, 'public/uploads/products/8a8af15ee66d22e31070da87f9e41364.webp', '2024-11-15 22:00:30', '2024-11-15 22:00:30'),
(43, 'Phanteks Eclipse', 'P360A AIR TG DRGB Black PH-EC360ATG_DBK01', 1, 3900, 4, 4200, 16800, 'public/uploads/products/21959068e5626d19da1832191529e811.webp', '2024-11-15 22:02:23', '2024-11-15 22:02:23'),
(44, 'Thermaltake V250 TG', 'ARGB BLACK Mid Tower ATX Case CA-1Q5-00M1WN-00 (w/ 3 x 120mm ARGB BLK + 1 x 120mm BLK Fan)\r\n', 1, 2900, 10, 3310, 33100, 'public/uploads/products/2bccb262ba9bee83f8b7688061ad85fa.webp', '2024-11-15 22:03:59', '2024-11-15 22:03:59'),
(45, 'Tecware Timber', 'High Airflow ATX TG Case w/ 4X120mm Fan', 1, 2500, 12, 3050, 36600, 'public/uploads/products/e173d04a55058c867905ea56ae5e0744.webp', '2024-11-15 22:05:20', '2024-11-15 22:05:20'),
(46, 'Intel Core i7-12700F', 'Processor 25M Cache, 3.60-4.90GHz 12-Core 20-Thread Boxed', 2, 13500, 5, 14670, 73350, 'public/uploads/products/f9985ff9ed07b71dbd88f022a80c3e2a.webp', '2024-11-15 22:06:55', '2024-11-15 22:06:55'),
(47, 'Intel Core i5-12400F', '12400F Processor 18M Cache, up to 4.40GHz Boxed', 2, 6400, 8, 6770, 54160, 'public/uploads/products/2424ada3314e3aa4b001d1d7052419e6.webp', '2024-11-15 22:14:54', '2024-11-15 22:14:54'),
(48, 'AMD Ryzen 5 7600', '(AM5) Processor 3.80-5.10GHZ 6-Core 12-Threads Boxed', 2, 10000, 8, 12075, 96600, 'public/uploads/products/e9945b057f5f66b7f6118890a4ee6aa9.webp', '2024-11-15 22:16:08', '2024-11-15 22:16:08'),
(49, 'AMD Ryzen 7 7800X3D', 'Ryzen 7 7800X3D 4.2-5.0GHz 8-Core 16Threads Processor Boxed', 2, 26000, 5, 26990, 134950, 'public/uploads/products/df2f96ed5918bf9164632151e80f193a.webp', '2024-11-15 22:19:08', '2024-11-15 22:19:08'),
(50, 'AMD Ryzen 7 5700X ', 'Ryzen 7 5700X 3.4-4.6GHZ 8-Core AM4 Processor Boxed', 2, 9600, 15, 10150, 152250, 'public/uploads/products/fafe8c12445747be1b5012398bcc61ed.webp', '2024-11-15 22:24:38', '2024-11-15 22:24:38'),
(51, 'ASRock RX 6600', 'RX 6600 CLW Challenger 8GB White Graphics Card RX6600 CLW 8G', 3, 13800, 5, 14290, 71450, 'public/uploads/products/28ea61690cc5a3a498b77e5e34f3361c.webp', '2024-11-15 22:27:13', '2024-11-15 22:27:13'),
(52, 'Asus RTX 3050', 'Asus RTX 3050 DUAL 6GB OC Graphics Card DUAL-RTX3050-O6G', 3, 10500, 5, 11250, 56250, 'public/uploads/products/011adf95b3d415d908f1feb423efd875.webp', '2024-11-15 22:28:42', '2024-11-15 22:28:42'),
(53, 'Asus RX 6600', 'Dual 8GB DUAL-RX6600-8G-V3 Graphics Card', 3, 13000, 5, 13690, 68450, 'public/uploads/products/7e7006952434ae65c501222ef314b491.webp', '2024-11-15 22:29:39', '2024-11-15 22:29:39'),
(54, 'MSI RTX 4060 TI', 'RTX 4060 TI 8GB Slim x GC30 Monster Hunter Edition Graphics Card', 3, 32000, 5, 32950, 164750, 'public/uploads/products/826302c256f149e51b37d167a4213c91.webp', '2024-11-15 22:30:49', '2024-11-15 22:30:49'),
(55, 'Crucial MX500 1TB', 'Crucial MX500 1TB 3D NAND SATA 2.5 Inch Internal SSD, up to 560 MBs 1000GB - CT1000MX500SSD1', 6, 4500, 15, 4950, 74250, 'public/uploads/products/7d829cadad43c0e74928695862d9ab50.webp', '2024-11-15 22:32:03', '2024-11-15 22:32:03'),
(56, 'Gigabyte SSD 1TB', 'Gigabyte SSD 1TB SATA 2.5&#039; GP-GSTFS31100TNTD', 7, 3300, 15, 3620, 54300, 'public/uploads/products/4ab2aa300533423d089c1f5d342ccaf2.webp', '2024-11-15 22:33:54', '2024-11-15 22:33:54'),
(57, 'Kingston A400 SSD', 'Kingston A400 SSD 960GB 2.5 Sata III SA400S37/960G', 7, 3000, 15, 3325, 49875, 'public/uploads/products/69658276bae86de86166238864bef347.webp', '2024-11-15 22:34:47', '2024-11-15 22:34:47'),
(58, 'Samsung 870 Evo SSD', 'Samsung 870 Evo SSD 500GB SATA MZ-77E500BW', 7, 3200, 12, 3570, 42840, 'public/uploads/products/2263f5a67e59adc4878c93d5f5b8e160.jpg', '2024-11-15 22:36:24', '2024-11-15 22:36:24'),
(59, 'Seagate 2TB Barracuda', 'Seagate 2TB Barracuda 256mb 7200rpm ST2000DM008 Hard Drive', 7, 3500, 12, 3830, 45960, 'public/uploads/products/3cb2ee62aef50c0f78909f2f8c7247d6.webp', '2024-11-15 22:37:16', '2024-11-15 22:37:16'),
(60, 'TeamGroup CX2 512GB', 'TeamGroup CX2 512GB 2.5&quot; Solid State Drive T253X6512G0C101', 7, 1800, 20, 1920, 38400, 'public/uploads/products/c45059ff263cd587a48781969e94b313.webp', '2024-11-15 22:38:11', '2024-11-15 22:38:11'),
(61, 'Asrock B550M Pro', 'Asrock B550M Pro SE microATX AM4 DDR4 Motherboard', 4, 5200, 10, 5580, 55800, 'public/uploads/products/b24a46ae7c9287a0c3fef1def0d94652.webp', '2024-11-15 23:23:21', '2024-11-15 23:23:21'),
(62, 'Asus Prime A520M-K', 'Asus Prime A520M-K (AM4) Motherboard', 4, 3500, 15, 3820, 57300, 'public/uploads/products/393ec43777bb32daf1b5c6b2b2c2c6ef.webp', '2024-11-15 23:24:32', '2024-11-15 23:24:32'),
(63, 'Asus TUF Gaming A620M', 'Asus TUF Gaming A620M-Plus WiFi (AM5) Motherboard', 4, 7800, 8, 8350, 66800, 'public/uploads/products/4780c44d1fa9d8b47d8e1057939cb3ca.webp', '2024-11-15 23:25:22', '2024-11-15 23:25:22'),
(64, 'Gigabyte B650 Aorus', 'Gigabyte B650 Aorus Elite AX ICE DDR5 (AM5) Motherboard', 4, 12000, 5, 13620, 68100, 'public/uploads/products/718550e0fafb76af6df50db74a029929.webp', '2024-11-15 23:26:07', '2024-11-15 23:26:07'),
(65, 'MSI PRO B650M', 'MSI PRO B650M-A WIFI DDR5 (AM5) Motherboard', 4, 11000, 11, 11485, 126335, 'public/uploads/products/11d57013a7b14af2d9589d2cb56bbed2.webp', '2024-11-15 23:27:02', '2024-11-15 23:27:02'),
(66, 'Corsair CX650 Bronze', 'Corsair CX650 Bronze 650W 80+ Power Supply CP-9020278-NA', 5, 3000, 10, 3295, 32950, 'public/uploads/products/127046c343414a3530d25aba2f66984e.webp', '2024-11-15 23:28:16', '2024-11-15 23:28:16'),
(67, 'Huntkey MVP K750', 'Huntkey MVP K750 750W 80 PLUS Gold Full-Modular Power Supply', 5, 3800, 8, 4095, 32760, 'public/uploads/products/70082c529cf042002a642c95947ec956.webp', '2024-11-15 23:29:13', '2024-11-15 23:29:13'),
(68, 'Seasonic Focus GM-650', 'Seasonic Focus GM-650 GOLD 650watts 80+ Semi Modular PSU SSR-650FM', 5, 4800, 7, 5190, 36330, 'public/uploads/products/b1572f21cd788f664ce98cd7d6c5ac9e.webp', '2024-11-15 23:30:05', '2024-11-15 23:30:05'),
(69, 'Seasonic Focus SGX-500', 'Seasonic Focus SGX-500 Gold 500watts SFX PSU 80+ Full Modular SSR-500SGX', 5, 4300, 12, 4670, 56040, 'public/uploads/products/38378dd6790a51b98fc058f0ab460793.webp', '2024-11-15 23:30:47', '2024-11-15 23:30:47'),
(70, 'Corsair Dominator 32G', 'Corsair Dominator Titanium RGB 32G 16Gx2 DDR5 Desktop Memory CMP32GX5M2X7200C34', 6, 10000, 4, 12530, 50120, 'public/uploads/products/3663855c0e6e6cb68e3b95b0b47a00b8.webp', '2024-11-15 23:31:46', '2024-11-15 23:31:46'),
(71, 'G.Skill Ripjaws V 16GB', 'G.Skill Ripjaws V 16GB Dual DDR4 3200Mhz CL16 F4-3200C16D-16GVKB', 6, 2000, 15, 2150, 32250, 'public/uploads/products/3f6b30119a271176770a53c54d9ec4d2.webp', '2024-11-15 23:32:37', '2024-11-15 23:32:37'),
(72, 'G.Skill Trident Z 16GB', 'G.Skill Trident Z Neo RGB 16GB Dual DDR4 3600Mhz CL18 F4-3600C18D-16GTZN', 6, 2800, 10, 3120, 31200, 'public/uploads/products/8b717d50a2d60a88632051d7f27fbce3.webp', '2024-11-15 23:33:18', '2024-11-15 23:33:18'),
(73, 'Kingston Fury Beast 16GB', 'Kingston Fury Beast 16GB 2x8G DDR4 3200MHz CL16 KF432C16BBK2/16', 3, 2000, 20, 2320, 46400, 'public/uploads/products/80d8f5f0d220cc011c38611b6ef0b54e.webp', '2024-11-15 23:35:59', '2024-11-15 23:35:59'),
(74, 'T-Force Vulcan 16GB', 'T-Force Vulcan TUF 16GB 2X8G DDR4 3600MHz Gaming Memory TLTYD416G3600HC18JDC01', 6, 1800, 50, 1950, 97500, 'public/uploads/products/410232c98fd8ba95bfdc94e34f52e551.webp', '2024-11-15 23:36:43', '2024-11-15 23:36:43');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `fullname` varchar(200) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(250) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `remarks` varchar(500) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fullname`, `username`, `password`, `is_admin`, `remarks`, `created_at`, `updated_at`) VALUES
(1, 'john cena', 'jcena2001', 'jcena2001', 0, NULL, '2024-10-12 15:56:02', '2024-10-12 15:56:02'),
(2, 'jason script', 'json2003', 'json2003', 0, NULL, '2024-10-14 16:44:33', '2024-10-14 16:44:33'),
(3, 'dummy', 'dummydoe', '1234', 0, NULL, '2024-10-19 14:20:06', '2024-10-19 14:20:06'),
(5, 'dummy joe', 'djoe2003', '$2y$10$lZqzLrF2HXFYja/HqpOcEeJGMfy1YH3CdUZ7b4bu.d13y8UrskCZC', 0, NULL, '2024-10-19 15:08:53', '2024-10-19 15:08:53'),
(7, 'admin', 'admin', '$2y$10$YPG71Y2G6ZXDd2uJvkRMi.ncKiYe/ISRB8/XsPQb0pV/IAfZjGdfi', 1, NULL, '2024-10-26 02:19:23', '2024-10-26 02:19:23'),
(8, 'reguser1', 'reguser1', '$2y$10$4czVTFLR3e/69RP2wNM4ru/7hRorINqCHOUPsvCS3N8wWvt6H/qMm', 0, NULL, '2024-11-23 14:44:11', '2024-11-23 14:44:11'),
(9, 'Miguel Andrei del Rosario', 'miguelandrei@sdca.edu.ph', '$2y$10$aQPV9chJkYiEdpPAnQzxlO.smrmBlOIjxDbES02faZ7pV8ktbYBXa', 0, NULL, '2024-12-03 15:35:55', '2024-12-03 15:35:55');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
