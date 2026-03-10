SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- 1. A Kategóriák tábla (categories)
CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `categories` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Kerámiák', 'Kézzel készített egyedi kerámia bögrék és tálak.', NOW(), NOW()),
(2, 'Ékszerek', 'Egyedi tervezésű nyakláncok és karkötők.', NOW(), NOW()),
(3, 'Fából készült', 'Fából faragott dísztárgyak és használati eszközök.', NOW(), NOW());

-- 2. A Termékek tábla (products)
CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` int(11) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_category_id_foreign` (`category_id`),
  CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `products` (`id`, `category_id`, `name`, `description`, `price`, `image_url`, `created_at`, `updated_at`) VALUES
(1, 1, 'Kék mázas bögre', 'Fél literes, kézzel festett kék mázas kerámia bögre.', 4500, 'kek_bogre.jpg', NOW(), NOW()),
(2, 1, 'Levendulás müzlis tál', 'Levendula mintával díszített, korongozott tál.', 5200, 'levendula_tal.jpg', NOW(), NOW()),
(3, 2, 'Gyöngyház nyaklánc', 'Elegáns nyaklánc valódi gyöngyház berakással.', 8900, 'gyongyhaz_nyaklanc.jpg', NOW(), NOW()),
(4, 3, 'Faragott fa ékszerdoboz', 'Diófából készült aprólékosan faragott ékszerdoboz.', 12500, 'fa_doboz.jpg', NOW(), NOW());

-- 3. A Felhasználók tábla (users)
CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` (`id`, `name`, `email`, `password`, `created_at`, `updated_at`) VALUES
(1, 'Kézműves Admin', 'admin@webshop.hu', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NOW(), NOW());

-- 4. A Rendelések tábla (orders)
CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(255) NOT NULL,
  `customer_email` varchar(255) NOT NULL,
  `shipping_address` text NOT NULL,
  `total_amount` int(11) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `orders` (`id`, `customer_name`, `customer_email`, `shipping_address`, `total_amount`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Kovács János', 'janos.kovacs@email.hu', '1055 Budapest, Kossuth tér 1.', 9700, 'completed', NOW(), NOW()),
(2, 'Nagy Éva', 'eva.nagy@email.hu', '6720 Szeged, Dóm tér 2.', 12500, 'pending', NOW(), NOW());

-- 5. A Rendelési tételek tábla (order_items)
CREATE TABLE `order_items` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_items_order_id_foreign` (`order_id`),
  KEY `order_items_product_id_foreign` (`product_id`),
  CONSTRAINT `fk_order_items_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_order_items_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `unit_price`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 4500, NOW(), NOW()), 
(2, 1, 2, 1, 5200, NOW(), NOW()), 
(3, 2, 4, 1, 12500, NOW(), NOW()); 

COMMIT;