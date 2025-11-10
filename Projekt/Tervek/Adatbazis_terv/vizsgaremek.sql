DROP DATABASE IF EXISTS kezmuvesek_webshop;
CREATE DATABASE kezmuvesek_webshop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE kezmuvesek_webshop;

CREATE TABLE roles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    role_id INT NOT NULL DEFAULT 1,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    avatar_url VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    email_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    wishlist_product_ids JSON NULL,
    FOREIGN KEY (role_id) REFERENCES roles(id)
) ENGINE=InnoDB;

CREATE TABLE artisans (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL UNIQUE,
    shop_name VARCHAR(100) NOT NULL,
    bio TEXT,
    specialty VARCHAR(100),
    location VARCHAR(100),
    profile_image_url VARCHAR(255),
    cover_image_url VARCHAR(255),
    is_approved BOOLEAN DEFAULT FALSE,
    approved_at TIMESTAMP NULL,
    approved_by INT NULL,
    rating_average DECIMAL(3,2) DEFAULT 0.00,
    total_sales INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (approved_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE artisan_social_links (
    id INT PRIMARY KEY AUTO_INCREMENT,
    artisan_id INT NOT NULL,
    platform VARCHAR(50) NOT NULL,
    url VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (artisan_id) REFERENCES artisans(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE addresses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    address_type ENUM('billing', 'shipping') NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    country VARCHAR(50) NOT NULL DEFAULT 'Magyarország',
    postal_code VARCHAR(10) NOT NULL,
    city VARCHAR(100) NOT NULL,
    address_line1 VARCHAR(255) NOT NULL,
    address_line2 VARCHAR(255),
    is_default BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    parent_id INT NULL,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    icon VARCHAR(50),
    image_url VARCHAR(255),
    sort_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    artisan_id INT NOT NULL,
    category_id INT NOT NULL,
    name VARCHAR(200) NOT NULL,
    slug VARCHAR(200) NOT NULL UNIQUE,
    description TEXT NOT NULL,
    short_description VARCHAR(500),
    price DECIMAL(10,2) NOT NULL,
    original_price DECIMAL(10,2) NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    sku VARCHAR(50) UNIQUE,
    weight DECIMAL(8,2),
    dimensions VARCHAR(100),
    material VARCHAR(100),
    care_instructions TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    is_featured BOOLEAN DEFAULT FALSE,
    view_count INT DEFAULT 0,
    tags JSON NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (artisan_id) REFERENCES artisans(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id)
) ENGINE=InnoDB;

CREATE TABLE product_images (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    alt_text VARCHAR(255),
    sort_order INT DEFAULT 0,
    is_primary BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE tags (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    slug VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE cart (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NULL,
    session_id VARCHAR(255) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE cart_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    price DECIMAL(10,2) NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cart_id) REFERENCES cart(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    order_number VARCHAR(50) NOT NULL UNIQUE,
    status ENUM('pending', 'processing', 'packaging', 'shipped', 'delivered', 'cancelled', 'refunded') NOT NULL DEFAULT 'pending',
    payment_status ENUM('pending', 'paid', 'failed', 'refunded') NOT NULL DEFAULT 'pending',
    payment_method ENUM('card', 'paypal', 'transfer', 'cash_on_delivery') NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    shipping_cost DECIMAL(10,2) NOT NULL,
    tax DECIMAL(10,2) DEFAULT 0.00,
    total DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'HUF',
    notes TEXT,
    shipping_address_id INT NOT NULL,
    billing_address_id INT NOT NULL,
    shipped_at TIMESTAMP NULL,
    delivered_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (shipping_address_id) REFERENCES addresses(id),
    FOREIGN KEY (billing_address_id) REFERENCES addresses(id)
) ENGINE=InnoDB;

CREATE TABLE order_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    artisan_id INT NOT NULL,
    product_name VARCHAR(200) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (artisan_id) REFERENCES artisans(id)
) ENGINE=InnoDB;

CREATE TABLE order_status_history (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    comment TEXT,
    changed_by INT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (changed_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE product_reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    user_id INT NOT NULL,
    order_id INT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    title VARCHAR(200),
    comment TEXT,
    is_verified_purchase BOOLEAN DEFAULT FALSE,
    is_approved BOOLEAN DEFAULT FALSE,
    approved_by INT NULL,
    helpful_user_ids JSON NULL,
    helpful_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE SET NULL,
    FOREIGN KEY (approved_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE review_images (
    id INT PRIMARY KEY AUTO_INCREMENT,
    review_id INT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (review_id) REFERENCES product_reviews(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE blog_categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE blog_posts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    author_id INT NOT NULL,
    category_id INT NULL,
    title VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    excerpt TEXT,
    content TEXT NOT NULL,
    featured_image_url VARCHAR(255),
    is_published BOOLEAN DEFAULT FALSE,
    published_at TIMESTAMP NULL,
    view_count INT DEFAULT 0,
    tag_ids JSON NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES users(id),
    FOREIGN KEY (category_id) REFERENCES blog_categories(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE blog_tags (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    slug VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE notifications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    type VARCHAR(50) NOT NULL,
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    link VARCHAR(255),
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE email_templates (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    subject VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    variables TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE newsletter_subscriptions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) NOT NULL UNIQUE,
    is_active BOOLEAN DEFAULT TRUE,
    subscribed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    unsubscribed_at TIMESTAMP NULL
) ENGINE=InnoDB;

CREATE TABLE settings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    setting_key VARCHAR(100) NOT NULL UNIQUE,
    setting_value TEXT,
    setting_type VARCHAR(50) DEFAULT 'string',
    description TEXT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE activity_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NULL,
    action VARCHAR(100) NOT NULL,
    table_name VARCHAR(100),
    record_id INT,
    old_values JSON,
    new_values JSON,
    ip_address VARCHAR(45),
    user_agent VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role_id);
CREATE INDEX idx_users_active ON users(is_active);
CREATE INDEX idx_artisans_approved ON artisans(is_approved);
CREATE INDEX idx_artisans_rating ON artisans(rating_average);
CREATE INDEX idx_products_artisan ON products(artisan_id);
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_slug ON products(slug);
CREATE INDEX idx_products_active ON products(is_active);
CREATE INDEX idx_products_featured ON products(is_featured);
CREATE INDEX idx_products_price ON products(price);
CREATE INDEX idx_orders_user ON orders(user_id);
CREATE INDEX idx_orders_number ON orders(order_number);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_created ON orders(created_at);
CREATE INDEX idx_reviews_product ON product_reviews(product_id);
CREATE INDEX idx_reviews_user ON product_reviews(user_id);
CREATE INDEX idx_reviews_rating ON product_reviews(rating);
CREATE INDEX idx_blog_posts_author ON blog_posts(author_id);
CREATE INDEX idx_blog_posts_published ON blog_posts(is_published, published_at);
CREATE INDEX idx_blog_posts_slug ON blog_posts(slug);

INSERT INTO roles (name, description) VALUES
('customer', 'Vásárló felhasználó'),
('artisan', 'Kézműves eladó'),
('admin', 'Platform adminisztrátor');

INSERT INTO users (role_id, email, password_hash, full_name, phone, is_active, email_verified) VALUES
(3, 'admin@kezmuvesek.hu', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Rendszeradminisztrátor', '+36301234567', TRUE, TRUE);

INSERT INTO users (role_id, email, password_hash, full_name, phone, email_verified) VALUES
(1, 'kovacs.jozsef@email.hu', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Kovács József', '+36301234568', TRUE),
(1, 'nagy.anna@email.hu', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Nagy Anna', '+36301234569', TRUE);

INSERT INTO users (role_id, email, password_hash, full_name, phone, email_verified) VALUES
(2, 'nagy.maria@email.hu', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Nagy Mária', '+36301234570', TRUE),
(2, 'kovacs.janos@email.hu', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Kovács János', '+36301234571', TRUE),
(2, 'toth.erzsebet@email.hu', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Tóth Erzsébet', '+36301234572', TRUE);

INSERT INTO artisans (user_id, shop_name, bio, specialty, location, is_approved, approved_at, approved_by, rating_average) VALUES
(4, 'Nagy Mária Keramikus', 'Több mint 20 éve foglalkozom kerámia készítéssel. Minden darab egyedi, kézzel készült és festett.', 'Kerámia', 'Budapest', TRUE, NOW(), 1, 4.8),
(5, 'Kovács János Műhelye', 'Hagyományos fazekas mester. Használati és dísztárgyak készítése.', 'Kerámia', 'Pécs', TRUE, NOW(), 1, 4.6),
(6, 'Tóth Erzsébet Alkotóműhely', 'Modern és hagyományos kerámia termékek. Egyedi megrendeléseket is vállalok.', 'Kerámia', 'Debrecen', TRUE, NOW(), 1, 4.9);

INSERT INTO categories (name, slug, description, icon, sort_order, is_active) VALUES
('Kerámia', 'keramia', 'Kézzel készített kerámia termékek', '🏺', 1, TRUE),
('Textil', 'textil', 'Kézzel készített textil termékek', '🧶', 2, TRUE),
('Fa termékek', 'fa-termekek', 'Kézzel faragott fa alkotások', '🪵', 3, TRUE),
('Ékszerek', 'ekszerek', 'Egyedi kézműves ékszerek', '💎', 4, TRUE),
('Élelmiszerek', 'elelmiszerek', 'Házi készítésű élelmiszerek', '🍯', 5, TRUE),
('Festmények', 'festmenyek', 'Kézzel festett művészeti alkotások', '🎨', 6, TRUE);

INSERT INTO categories (parent_id, name, slug, description, sort_order) VALUES
(1, 'Vázák', 'vazak', 'Dekoratív és használati vázák', 1),
(1, 'Csészék és bögrék', 'cseszek-bogrék', 'Kávés és teás csészék', 2),
(1, 'Tányérok', 'tanyerok', 'Kerámia tányérok és tálak', 3);

INSERT INTO products (artisan_id, category_id, name, slug, description, short_description, price, stock_quantity, sku, material, is_active, is_featured, tags) VALUES
(1, 1, 'Kézzel festett váza', 'kezzel-festett-vaza', 'Ez a gyönyörű, kézzel festett kerámia váza hagyományos magyar népi motívumokkal díszített. Minden darab egyedi, kézzel készült és festett, így garantáltan különleges dísze lesz otthonának. A váza magas hőfokon égetett agyagból készül, ami biztosítja tartósságát.', 'Egyedi, kézzel festett kerámia váza népi motívumokkal', 12900.00, 3, 'VAZ-001', 'Magas hőfokon égetett agyag', TRUE, TRUE, JSON_ARRAY('kezmuves','nepi','magyar')),
(2, 1, 'Kávéscsésze szett (4 db)', 'kavescsesze-szett-4db', 'Négy darabos kávéscsésze készlet, amely tökéletesen kiegészíti reggelije pillanatait. Minden csésze egyedi mintával készült, mégis harmonizálnak egymással. Kiváló ajándék kávérajongóknak.', 'Négy darabos egyedi mintázatú kávéscsésze készlet', 8500.00, 10, 'CSE-002', 'Kerámia', TRUE, TRUE, JSON_ARRAY('kezmuves','egyedi','ajandek')),
(3, 1, 'Kerámia tányér készlet', 'keramia-tanyer-keszlet', 'Hat darabos tányérkészlet, amely tartalmaz lapos tányérokat és mély tányérokat is. Modern dizájn találkozik a hagyományos kézműves minőséggel. Mosogatógépben mosható.', 'Hat darabos modern kerámia tányérkészlet', 24900.00, 5, 'TAN-003', 'Kerámia', TRUE, FALSE, JSON_ARRAY('kezmuves','modern')),
(1, 1, 'Dekoratív agyag tál', 'dekorativ-agyag-tal', 'Középméretű dekoratív tál, amely egyaránt használható praktikus célokra vagy pusztán díszként. Kék-fehér mintázattal díszítve, amely bármilyen lakberendezési stílussal illik.', 'Kék-fehér mintázatú dekoratív kerámia tál', 6900.00, 8, 'TAL-004', 'Agyag', TRUE, FALSE, JSON_ARRAY('kezmuves','hagyomanyos'));

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary) VALUES
(1, '/images/products/vaza-01.jpg', 'Kézzel festett váza fő kép', 1, TRUE),
(1, '/images/products/vaza-02.jpg', 'Kézzel festett váza oldalnézet', 2, FALSE),
(2, '/images/products/cseszek-01.jpg', 'Kávéscsésze szett fő kép', 1, TRUE),
(3, '/images/products/tanyerok-01.jpg', 'Kerámia tányér készlet', 1, TRUE),
(4, '/images/products/tal-01.jpg', 'Dekoratív agyag tál', 1, TRUE);

INSERT INTO tags (name, slug) VALUES
('kézműves', 'kezmuves'),
('népi', 'nepi'),
('magyar', 'magyar'),
('egyedi', 'egyedi'),
('ajándék', 'ajandek'),
('modern', 'modern'),
('hagyományos', 'hagyomanyos');

INSERT INTO addresses (user_id, address_type, full_name, phone, postal_code, city, address_line1, is_default) VALUES
(2, 'shipping', 'Kovács József', '+36301234568', '1051', 'Budapest', 'Szabadság tér 12.', TRUE),
(2, 'billing', 'Kovács József', '+36301234568', '1051', 'Budapest', 'Szabadság tér 12.', TRUE);

INSERT INTO orders (user_id, order_number, status, payment_status, payment_method, subtotal, shipping_cost, total, shipping_address_id, billing_address_id) VALUES
(2, 'ORD-20251101-001', 'delivered', 'paid', 'card', 12900.00, 1490.00, 14390.00, 1, 2),
(3, 'ORD-20251102-002', 'processing', 'paid', 'paypal', 8500.00, 1490.00, 9990.00, 1, 2);

INSERT INTO order_items (order_id, product_id, artisan_id, product_name, quantity, price, subtotal) VALUES
(1, 1, 1, 'Kézzel festett váza', 1, 12900.00, 12900.00),
(2, 2, 2, 'Kávéscsésze szett (4 db)', 1, 8500.00, 8500.00);

INSERT INTO product_reviews (product_id, user_id, order_id, rating, title, comment, is_verified_purchase, is_approved, approved_by, helpful_user_ids, helpful_count) VALUES
(1, 2, 1, 5, 'Gyönyörű munka!', 'Pontosan olyan szép, mint a képeken. A minőség kiváló, ajánlom mindenkinek!', TRUE, TRUE, 1, NULL, 0),
(2, 3, 2, 5, 'Tökéletes kávézáshoz', 'Nagyon szeretem ezeket a csészéket. Kényelmes a formájuk és gyönyörűek.', TRUE, TRUE, 1, NULL, 0);

INSERT INTO blog_categories (name, slug, description) VALUES
('Kézműves történetek', 'kezmuves-tortenetek', 'Kézművesek személyes történetei'),
('Készítési folyamatok', 'keszitesi-folyamatok', 'Hogyan készülnek a termékek'),
('Tippek és tanácsok', 'tippek-es-tanacsok', 'Hasznos információk kézműveseknek és vásárlóknak');

INSERT INTO blog_posts (author_id, category_id, title, slug, excerpt, content, is_published, published_at, tag_ids) VALUES
(4, 1, 'Hogyan lettem keramikus', 'hogyan-lettem-keramikus', 'Történetem arról, hogyan találtam meg az életem hivatását a kerámia készítésben.', 'Több mint 20 évvel ezelőtt egy véletlennek köszönhetően kerültem kapcsolatba a kerámia készítéssel. Azóta ez lett az életem legnagyobb szenvedélye...', TRUE, NOW(), JSON_ARRAY('kezmuves','tortenet')),
(5, 2, 'A tökéletes váza készítése', 'a-tokeletes-vaza-keszitese', 'Lépésről lépésre bemutatom, hogyan készül egy kézzel formált kerámia váza.', 'A váza készítés egy összetett folyamat, amely türelmet és gyakorlatot igényel. Ebben a bejegyzésben végigvezetem a teljes folyamaton...', TRUE, NOW(), JSON_ARRAY('keszites','oktat'));

INSERT INTO settings (setting_key, setting_value, setting_type, description) VALUES
('site_name', 'Kézműves Kincsek', 'string', 'Weboldal neve'),
('site_description', 'Egyedi kézműves termékek helyi alkotóktól', 'string', 'Weboldal leírása'),
('contact_email', 'info@kezmuvesek.hu', 'string', 'Kapcsolati email cím'),
('support_email', 'support@kezmuvesek.hu', 'string', 'Ügyfélszolgálat email'),
('default_shipping_cost', '1490', 'number', 'Alapértelmezett szállítási költség (Ft)'),
('free_shipping_threshold', '15000', 'number', 'Ingyenes szállítás feletti összeg (Ft)'),
('vat_rate', '27', 'number', 'ÁFA mérték (%)'),
('currency', 'HUF', 'string', 'Pénznem'),
('items_per_page', '20', 'number', 'Termékek száma oldalanként'),
('allow_guest_checkout', 'true', 'boolean', 'Vendég vásárlás engedélyezése'),
('maintenance_mode', 'false', 'boolean', 'Karbantartási mód'),
('artisan_approval_required', 'true', 'boolean', 'Kézműves jóváhagyás szükséges');

INSERT INTO email_templates (name, subject, body, variables) VALUES
('order_confirmation', 'Rendelés visszaigazolás - {{order_number}}', '<h2>Köszönjük a rendelését!</h2><p>Kedves {{customer_name}},</p><p>Rendelését sikeresen rögzítettük.</p><p><strong>Rendelésszám:</strong> {{order_number}}</p><p><strong>Összeg:</strong> {{total}} Ft</p>', 'order_number, customer_name, total'),
('order_shipped', 'Rendelése úton van - {{order_number}}', '<h2>Rendelése úton van!</h2><p>Kedves {{customer_name}},</p><p>Rendelését feladtuk.</p><p><strong>Rendelésszám:</strong> {{order_number}}</p><p><strong>Szállítási azonosító:</strong> {{tracking_number}}</p>', 'order_number, customer_name, tracking_number'),
('welcome', 'Üdvözöljük a Kézműves Kincsek oldalon!', '<h2>Üdvözöljük!</h2><p>Kedves {{name}},</p><p>Köszönjük, hogy regisztrált oldalunkon. Fedezze fel egyedi kézműves termékeinket!</p>', 'name'),
('artisan_approved', 'Kézműves profilja jóváhagyva', '<h2>Gratulálunk!</h2><p>Kedves {{name}},</p><p>Kézműves profilját jóváhagytuk. Most már értékesítheti termékeit platformunkon!</p>', 'name');

INSERT INTO newsletter_subscriptions (email, is_active) VALUES
('teszt1@email.hu', TRUE),
('teszt2@email.hu', TRUE);

INSERT INTO notifications (user_id, type, title, message, link) VALUES
(2, 'order', 'Rendelés leadva', 'Rendelése (#ORD-20251101-001) sikeresen leadva.', '/orders/1'),
(4, 'review', 'Új értékelés', 'Új értékelést kapott a "Kézzel festett váza" termékére.', '/artisan/reviews');

CREATE VIEW artisan_statistics AS
SELECT 
    a.id AS artisan_id,
    a.shop_name,
    u.full_name,
    COUNT(DISTINCT p.id) AS total_products,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COALESCE(SUM(oi.subtotal), 0) AS total_revenue,
    COALESCE(AVG(pr.rating), 0) AS average_rating,
    COUNT(DISTINCT pr.id) AS total_reviews
FROM artisans a
LEFT JOIN users u ON a.user_id = u.id
LEFT JOIN products p ON a.id = p.artisan_id
LEFT JOIN order_items oi ON a.id = oi.artisan_id
LEFT JOIN product_reviews pr ON p.id = pr.product_id AND pr.is_approved = TRUE
WHERE a.is_approved = TRUE
GROUP BY a.id, a.shop_name, u.full_name;

CREATE VIEW product_statistics AS
SELECT 
    p.id AS product_id,
    p.name,
    p.price,
    p.stock_quantity,
    a.shop_name AS artisan_name,
    c.name AS category_name,
    COUNT(DISTINCT oi.order_id) AS times_sold,
    COALESCE(SUM(oi.quantity), 0) AS total_quantity_sold,
    COALESCE(AVG(pr.rating), 0) AS average_rating,
    COUNT(DISTINCT pr.id) AS review_count,
    p.view_count
FROM products p
LEFT JOIN artisans a ON p.artisan_id = a.id
LEFT JOIN categories c ON p.category_id = c.id
LEFT JOIN order_items oi ON p.id = oi.product_id
LEFT JOIN product_reviews pr ON p.id = pr.product_id AND pr.is_approved = TRUE
WHERE p.is_active = TRUE
GROUP BY p.id, p.name, p.price, p.stock_quantity, a.shop_name, c.name, p.view_count;

CREATE VIEW monthly_sales_statistics AS
SELECT 
    DATE_FORMAT(o.created_at, '%Y-%m') AS month,
    COUNT(DISTINCT o.id) AS total_orders,
    COUNT(DISTINCT o.user_id) AS unique_customers,
    SUM(o.total) AS total_revenue,
    AVG(o.total) AS average_order_value,
    SUM(oi.quantity) AS total_items_sold
FROM orders o
LEFT JOIN order_items oi ON o.id = oi.order_id
WHERE o.payment_status = 'paid'
GROUP BY DATE_FORMAT(o.created_at, '%Y-%m')
ORDER BY month DESC;

DELIMITER $$
CREATE PROCEDURE update_product_rating(IN p_product_id INT)
BEGIN
    DECLARE avg_rating DECIMAL(3,2);
    SELECT COALESCE(AVG(rating), 0) INTO avg_rating
    FROM product_reviews
    WHERE product_id = p_product_id AND is_approved = TRUE;
    SELECT avg_rating AS new_rating;
END $$
CREATE PROCEDURE update_artisan_rating(IN p_artisan_id INT)
BEGIN
    DECLARE avg_rating DECIMAL(3,2);
    SELECT COALESCE(AVG(pr.rating), 0) INTO avg_rating
    FROM product_reviews pr
    INNER JOIN products p ON pr.product_id = p.id
    WHERE p.artisan_id = p_artisan_id AND pr.is_approved = TRUE;
    UPDATE artisans 
    SET rating_average = avg_rating 
    WHERE id = p_artisan_id;
    SELECT avg_rating AS new_rating;
END $$
CREATE PROCEDURE decrease_product_stock(IN p_product_id INT, IN p_quantity INT)
BEGIN
    DECLARE current_stock INT;
    SELECT stock_quantity INTO current_stock
    FROM products
    WHERE id = p_product_id;
    IF current_stock >= p_quantity THEN
        UPDATE products 
        SET stock_quantity = stock_quantity - p_quantity
        WHERE id = p_product_id;
        SELECT TRUE AS success, 'Készlet csökkentve' AS message;
    ELSE
        SELECT FALSE AS success, 'Nincs elegendő készlet' AS message;
    END IF;
END $$
CREATE PROCEDURE mark_review_helpful(IN p_review_id INT, IN p_user_id INT)
BEGIN
    DECLARE current_json JSON;
    DECLARE found_path VARCHAR(255);
    SELECT helpful_user_ids INTO current_json FROM product_reviews WHERE id = p_review_id FOR UPDATE;
    IF current_json IS NULL THEN
        UPDATE product_reviews
        SET helpful_user_ids = JSON_ARRAY(p_user_id),
            helpful_count = COALESCE(helpful_count, 0) + 1
        WHERE id = p_review_id;
    ELSE
        SET found_path = JSON_SEARCH(current_json, 'one', CAST(p_user_id AS CHAR));
        IF found_path IS NULL THEN
            UPDATE product_reviews
            SET helpful_user_ids = JSON_ARRAY_APPEND(helpful_user_ids, '$', p_user_id),
                helpful_count = COALESCE(helpful_count, 0) + 1
            WHERE id = p_review_id;
        END IF;
    END IF;
END $$
CREATE PROCEDURE unmark_review_helpful(IN p_review_id INT, IN p_user_id INT)
BEGIN
    DECLARE current_json JSON;
    DECLARE found_path VARCHAR(255);
    SELECT helpful_user_ids INTO current_json FROM product_reviews WHERE id = p_review_id FOR UPDATE;
    IF current_json IS NOT NULL THEN
        SET found_path = JSON_SEARCH(current_json, 'one', CAST(p_user_id AS CHAR));
        IF found_path IS NOT NULL THEN
            UPDATE product_reviews
            SET helpful_user_ids = JSON_REMOVE(helpful_user_ids, found_path),
                helpful_count = GREATEST(COALESCE(helpful_count,0) - 1, 0)
            WHERE id = p_review_id;
        END IF;
    END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER before_product_insert
BEFORE INSERT ON products
FOR EACH ROW
BEGIN
    IF NEW.slug IS NULL OR NEW.slug = '' THEN
        SET NEW.slug = LOWER(REPLACE(NEW.name, ' ', '-'));
    END IF;
    IF NEW.sku IS NULL OR NEW.sku = '' THEN
        SET NEW.sku = CONCAT('PRD-', LPAD(FLOOR(RAND()*999999), 6, '0'));
    END IF;
END $$
CREATE TRIGGER after_order_insert
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    INSERT INTO notifications (user_id, type, title, message, link)
    VALUES (
        NEW.user_id,
        'order',
        'Rendelés leadva',
        CONCAT('Rendelése (', NEW.order_number, ') sikeresen leadva. Összeg: ', NEW.total, ' Ft'),
        CONCAT('/orders/', NEW.id)
    );
END $$
CREATE TRIGGER after_review_approve
AFTER UPDATE ON product_reviews
FOR EACH ROW
BEGIN
    DECLARE v_artisan_id INT;
    IF NEW.is_approved = TRUE AND OLD.is_approved = FALSE THEN
        SELECT artisan_id INTO v_artisan_id
        FROM products
        WHERE id = NEW.product_id;
        CALL update_artisan_rating(v_artisan_id);
    END IF;
END $$
DELIMITER ;