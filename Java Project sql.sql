-- ====================================================
-- 1. DATABASE RESET
-- ====================================================
DROP DATABASE IF EXISTS lpu_food_db;
CREATE DATABASE lpu_food_db;
USE lpu_food_db;

-- ====================================================
-- 2. CREATE TABLES
-- ====================================================

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    reg_id VARCHAR(50) UNIQUE,
    password VARCHAR(50),
    role VARCHAR(20) DEFAULT 'CUSTOMER'
);

CREATE TABLE vendors (
    vendor_id INT PRIMARY KEY AUTO_INCREMENT,
    shop_name VARCHAR(100),
    username VARCHAR(50) UNIQUE,
    password VARCHAR(50),
    image_url VARCHAR(500),
    description VARCHAR(255),
    avg_rating DECIMAL(2,1) DEFAULT 4.5
);

CREATE TABLE menu_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    item_name VARCHAR(100),
    price DECIMAL(10,2),
    image_url VARCHAR(500),
    vendor_id INT,
    FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id) ON DELETE CASCADE
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    vendor_id INT,
    total_amount DECIMAL(10,2),
    payment_method VARCHAR(20),
    order_status VARCHAR(20) DEFAULT 'Pending',
    otp VARCHAR(10),
    rating INT DEFAULT 0,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id)
);

CREATE TABLE order_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    item_name VARCHAR(100),
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

-- ====================================================
-- 3. INSERT DATA: VENDORS (IMAGES RESTORED TO OLD WORKING ONES ✅)
-- ====================================================

INSERT INTO users (full_name, reg_id, password, role) VALUES ('LPU Admin', 'admin', 'admin', 'ADMIN');
INSERT INTO users (full_name, reg_id, password, role) VALUES ('Rahul Student', '112233', '123', 'CUSTOMER');

-- NOTE: Vendor images restored to the ones that were working perfectly before.
INSERT INTO vendors (shop_name, username, password, image_url, description, avg_rating) VALUES 
('Kitchen Ette', 'kitchen', '123', 'https://tse4.mm.bing.net/th/id/OIP.IkWLSN9jJUcIhG5vy8IFcgHaEK?pid=Api&P=0&h=180', 'Authentic North Indian Thali & Parathas', 4.8),
('Canteen BH2', 'bh2', '123', 'https://images.unsplash.com/photo-1554118811-1e0d58224f24?auto=format&fit=crop&w=500&q=60', 'Student Hangout for Coffee & Snacks', 4.2),
('Belgian Waffle', 'waffle', '123', 'https://images.unsplash.com/photo-1568051243851-f9b136146e97?auto=format&fit=crop&w=500&q=60', 'Premium Waffles, Pancakes & Shakes', 4.9),
('Food Factory', 'foodfactory', '123', 'https://images.unsplash.com/photo-1552566626-52f8b828add9?auto=format&fit=crop&w=500&q=60', 'Multi-Cuisine: Chinese & Continental', 4.5),
('Tripti Eatery', 'tripti', '123', 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?auto=format&fit=crop&w=500&q=60', 'Homely Food, Rajma Chawal & Thalis', 4.6),
('Nescafe', 'nescafe', '123', 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?auto=format&fit=crop&w=500&q=60', 'Hot Coffee, Cold Coffee & Maggi', 4.7),
('Go Go Food', 'gogo', '123', 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=500&q=60', 'Quick Bites, Burgers & Fries', 4.3),
('Domino\'s Pizza', 'dominos', '123', 'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=500&q=60', 'Pizzas, Garlic Bread & Coke', 4.8),
('Subway', 'subway', '123', 'https://images.unsplash.com/photo-1509722747041-616f39b57569?auto=format&fit=crop&w=500&q=60', 'Healthy Subs, Salads & Wraps', 4.4),
('South Indian Corner', 'south', '123', 'https://tse2.mm.bing.net/th/id/OIP.J2G27DSt0KQoUtgm8mqQ5AHaEK?pid=Api&P=0&h=180', 'Dosa, Idli, Vada & Sambhar', 4.7),
('Fresh Juice Bar', 'juice', '123', 'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?auto=format&fit=crop&w=500&q=60', 'Fresh Fruit Juices & Thick Shakes', 4.6),
('Spicy Treat', 'spicy', '123', 'https://images.unsplash.com/photo-1585032226651-759b368d7246?auto=format&fit=crop&w=500&q=60', 'Spicy Rolls, Momos & Noodles', 4.5);


-- ====================================================
-- 4. INSERT DATA: MENU ITEMS (OLD WORKING + NEW SPECIFIC LINKS)
-- ====================================================

-- 1. KITCHEN ETTE (OLD CORRECT IMAGES ✅)
INSERT INTO menu_items (item_name, price, image_url, vendor_id) VALUES 
('Aloo Paratha', 45.00, 'https://tse4.mm.bing.net/th/id/OIP.Bysf1JumEPyu9AsYs6Y9ogHaE8?pid=Api&P=0&h=180', 1),
('Paneer Paratha', 60.00, 'https://tse4.mm.bing.net/th/id/OIP.wLI9-sD3bOB-AvUlD-U9fQHaFj?pid=Api&P=0&h=180', 1),
('Gobi Paratha', 50.00, 'https://tse3.mm.bing.net/th/id/OIP.dUWVNOoymaec9Zf0Gva3NwHaE8?pid=Api&P=0&h=180', 1),
('Mix Veg Paratha', 55.00, 'https://tse4.mm.bing.net/th/id/OIP.jYXetIa8Jl6XQkhKmzJ3rgHaEK?pid=Api&P=0&h=180', 1),
('Plain Thali', 120.00, 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=200', 1),
('Special Thali', 180.00, 'https://images.unsplash.com/photo-1514326640560-7d063ef2aed5?w=200', 1),
('Chole Bhature', 90.00, 'https://images.unsplash.com/photo-1626132647523-66f5bf380027?w=200', 1),
('Rajma Chawal', 80.00, 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=200', 1),
('Kadhi Chawal', 80.00, 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=200', 1),
('Paneer Bhurji', 100.00, 'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=200', 1),
('Dal Makhani', 140.00, 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=200', 1),
('Shahi Paneer', 160.00, 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=200', 1),
('Butter Naan', 30.00, 'https://images.unsplash.com/photo-1601050690597-df0568f70950?w=200', 1),
('Jeera Rice', 70.00, 'https://images.unsplash.com/photo-1516684732162-798a0062be99?w=200', 1),
('Gulab Jamun', 40.00, 'https://images.unsplash.com/photo-1589119908995-c6837fa14848?w=200', 1);

-- 2. CANTEEN BH2 (UPDATED WITH YOUR NEW LINKS ✅)
INSERT INTO menu_items (item_name, price, image_url, vendor_id) VALUES 
('Samosa (2 pcs)', 20.00, 'https://images.unsplash.com/photo-1601050690597-df0568f70950?w=200', 2),
('Bread Pakora', 20.00, 'https://images.unsplash.com/photo-1605888969139-445a6c3826b6?w=200', 2),
('Veg Puff', 25.00, 'https://images.unsplash.com/photo-1623653387945-2fd25214f8fc?w=200', 2),
('Masala Tea', 15.00, 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=200', 2),
('Hot Coffee', 20.00, 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=200', 2),
('Cold Coffee', 40.00, 'https://tse4.mm.bing.net/th/id/OIP.49vctP1l79oPAC6ImrG-JQHaLO?pid=Api&P=0&h=180', 2), -- NEW
('Veg Burger', 50.00, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=200', 2),
('Noodle Burger', 60.00, 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=200', 2),
('Cheese Sandwich', 60.00, 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=200', 2),
('Grilled Sandwich', 80.00, 'https://tse4.mm.bing.net/th/id/OIP.xdjJXiIAuEOY2n530xv0JwHaFj?pid=Api&P=0&h=180', 2), -- NEW
('Maggi Masala', 40.00, 'https://images.unsplash.com/photo-1612929633738-8fe44f7ec841?w=200', 2),
('Cheese Maggi', 60.00, 'https://images.unsplash.com/photo-1612929633738-8fe44f7ec841?w=200', 2),
('French Fries', 70.00, 'https://images.unsplash.com/photo-1573080496987-a199f8cd4054?w=200', 2),
('Paneer Patty', 35.00, 'https://tse3.mm.bing.net/th/id/OIP.QkknHlrYBdLMjkbF4Iw-KAHaEK?pid=Api&P=0&h=180', 2), -- NEW
('Choco Brownie', 50.00, 'https://images.unsplash.com/photo-1564355808539-22fda35bed7e?w=200', 2);

-- 3. BELGIAN WAFFLE (UPDATED WITH YOUR NEW LINKS ✅)
INSERT INTO menu_items (item_name, price, image_url, vendor_id) VALUES 
('Belgian Chocolate Waffle', 100.00, 'https://images.unsplash.com/photo-1568051243851-f9b136146e97?w=200', 3),
('Kitkat Crunch Waffle', 110.00, 'https://images.unsplash.com/photo-1562519796-78484dd00d31?w=200', 3),
('Cream & Cookies Waffle', 110.00, 'https://images.unsplash.com/photo-1558584724-0e4d32caee0a?w=200', 3),
('Nuclear Nutella Waffle', 120.00, 'https://images.unsplash.com/photo-1622283084930-b97662c2f703?w=200', 3),
('Caramello Waffle', 110.00, 'https://images.unsplash.com/photo-1598214886806-c87b84b7078b?w=200', 3),
('Butterscotch Waffle', 100.00, 'https://images.unsplash.com/photo-1622283084930-b97662c2f703?w=200', 3),
('Chocolate Overdose', 100.00, 'https://tse1.mm.bing.net/th/id/OIP.fa-o3ZKBO1hzUa7c3iiv6gHaFj?pid=Api&P=0&h=180', 3), -- NEW
('Dark & White Fantasy', 100.00, 'https://tse1.mm.bing.net/th/id/OIP.pB8-5_ZJ-ZFFHnM38MJxzwHaIT?pid=Api&P=0&h=180', 3), -- NEW
('Double Trouble', 110.00, 'https://images.unsplash.com/photo-1568051243851-f9b136146e97?w=200', 3),
('Trio of Chocolate', 120.00, 'https://images.unsplash.com/photo-1598214886806-c87b84b7078b?w=200', 3),
('Brownie Ice Cream', 60.00, 'https://images.unsplash.com/photo-1564355808539-22fda35bed7e?w=200', 3),
('Choco Lava Cake', 50.00, 'https://images.unsplash.com/photo-1624353365286-3f8d62daad51?w=200', 3),
('Vanilla Softy', 30.00, 'https://images.unsplash.com/photo-1560008581-09826d1de69e?w=200', 3),
('Mini Pancakes', 80.00, 'https://images.unsplash.com/photo-1598214886806-c87b84b7078b?w=200', 3),
('Oreo Shake', 60.00, 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=200', 3),
('Blueberry Shake', 70.00, 'https://images.unsplash.com/photo-1553177595-4de2bb0842b9?w=200', 3),
('Strawberry Shake', 60.00, 'https://images.unsplash.com/photo-1579954115545-a95591f28bfc?w=200', 3);

-- 4. FOOD FACTORY (UPDATED WITH YOUR NEW LINKS ✅)
INSERT INTO menu_items (item_name, price, image_url, vendor_id) VALUES 
('Butter Chicken', 250.00, 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=200', 4),
('Chicken Curry', 220.00, 'https://images.unsplash.com/photo-1588166524941-3bf61a9c41db?w=200', 4),
('Kadai Chicken', 240.00, 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=200', 4),
('Chicken Biryani', 180.00, 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=200', 4),
('Hyderabadi Biryani', 200.00, 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=200', 4),
('Egg Curry', 150.00, 'https://tse1.mm.bing.net/th/id/OIP.F6Axt030hMmv_KCEkW9YQgHaHa?pid=Api&P=0&h=180', 4), -- NEW
('Mutton Rogan Josh', 350.00, 'https://tse3.mm.bing.net/th/id/OIP.2UAR2hQS9B8wthZK2LAIOgHaEq?pid=Api&P=0&h=180', 4), -- NEW
('Tandoori Chicken (Half)', 250.00, 'https://images.unsplash.com/photo-1610057099443-fde8c4d50f91?w=200', 4),
('Chicken Tikka', 200.00, 'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=200', 4),
('Chilli Chicken', 190.00, 'https://images.unsplash.com/photo-1525059696034-4967a8e1dca2?w=200', 4),
('Chicken Fried Rice', 160.00, 'https://tse1.mm.bing.net/th/id/OIP.Sf8R1wVkgOZhprHKFm582gHaHa?pid=Api&P=0&h=180', 4), -- NEW
('Chicken Noodles', 150.00, 'https://images.unsplash.com/photo-1552611052-33e04de081de?w=200', 4),
('Chicken Momos', 120.00, 'https://tse2.mm.bing.net/th/id/OIP.p8517lSPNr1Yp086lxnLngHaE8?pid=Api&P=0&h=180', 4), -- NEW
('Chicken Roll', 100.00, 'https://images.unsplash.com/photo-1626082896492-766af4eb6501?w=200', 4),
('Fish Curry', 280.00, 'https://tse4.mm.bing.net/th/id/OIP.LHbsvSjI-nPalcjKqJL0xAHaJQ?pid=Api&P=0&h=180', 4), -- NEW
('Egg Bhurji', 80.00, 'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=200', 4);

-- 5. TRIPTI EATERY (UPDATED WITH YOUR NEW LINKS ✅)
INSERT INTO menu_items (item_name, price, image_url, vendor_id) VALUES 
('Deluxe Thali', 150.00, 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=200', 5),
('Mini Thali', 100.00, 'https://tse3.mm.bing.net/th/id/OIP.tJt4db5rBhCO3cnFQ6v89QHaHY?pid=Api&P=0&h=180', 5), -- NEW
('Rajma Chawal', 90.00, 'https://images.unsplash.com/photo-1604152135912-04a022e23696?w=200', 5),
('Kadhi Chawal', 90.00, 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=200', 5),
('Chole Rice', 90.00, 'https://images.unsplash.com/photo-1626132647523-66f5bf380027?w=200', 5),
('Dal Makhani Rice', 100.00, 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=200', 5),
('Aloo Paratha', 40.00, 'https://tse4.mm.bing.net/th/id/OIP.Bysf1JumEPyu9AsYs6Y9ogHaE8?pid=Api&P=0&h=180', 5),
('Gobi Paratha', 50.00, 'https://tse3.mm.bing.net/th/id/OIP.dUWVNOoymaec9Zf0Gva3NwHaE8?pid=Api&P=0&h=180', 5),
('Paneer Paratha', 60.00, 'https://tse4.mm.bing.net/th/id/OIP.wLI9-sD3bOB-AvUlD-U9fQHaFj?pid=Api&P=0&h=180', 5),
('Onion Paratha', 45.00, 'https://tse4.mm.bing.net/th/id/OIP.jYXetIa8Jl6XQkhKmzJ3rgHaEK?pid=Api&P=0&h=180', 5),
('Curd Rice', 80.00, 'https://images.unsplash.com/photo-1596560548464-f010549b84d7?w=200', 5),
('Sweet Lassi', 40.00, 'https://tse3.mm.bing.net/th/id/OIP.W0fJPxyo521T9yCuFHKVDAHaJ4?pid=Api&P=0&h=180', 5), -- NEW
('Salted Lassi', 35.00, 'https://tse1.mm.bing.net/th/id/OIP.tY4PTApGDGCPnglD_J_wEwHaLH?pid=Api&P=0&h=180', 5), -- NEW
('Tawa Roti', 10.00, 'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?w=200', 5),
('Jeera Rice', 70.00, 'https://images.unsplash.com/photo-1516684732162-798a0062be99?w=200', 5);

-- 6. NESCAFE LPU (UPDATED WITH YOUR NEW LINKS ✅)
INSERT INTO menu_items (item_name, price, image_url, vendor_id) VALUES 
('Classic Hot Coffee', 25.00, 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=200', 6),
('Hazelnut Coffee', 40.00, 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=200', 6),
('Cappuccino', 50.00, 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=200', 6),
('Latte', 50.00, 'https://images.unsplash.com/photo-1551024601-563773a907a9?w=200', 6),
('Cold Coffee', 60.00, 'https://tse4.mm.bing.net/th/id/OIP.49vctP1l79oPAC6ImrG-JQHaLO?pid=Api&P=0&h=180', 6), -- NEW
('Iced Tea', 50.00, 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=200', 6),
('Masala Maggi', 35.00, 'https://images.unsplash.com/photo-1612929633738-8fe44f7ec841?w=200', 6),
('Cheese Maggi', 50.00, 'https://images.unsplash.com/photo-1612929633738-8fe44f7ec841?w=200', 6),
('Veg Puff', 30.00, 'https://images.unsplash.com/photo-1623653387945-2fd25214f8fc?w=200', 6),
('Chocolate Muffin', 40.00, 'https://images.unsplash.com/photo-1607958996333-41aef7caefaa?w=200', 6),
('Donut', 50.00, 'https://images.unsplash.com/photo-1551024506-0bccd828d307?w=200', 6),
('Veg Burger', 60.00, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=200', 6),
('Sandwich', 70.00, 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=200', 6),
('Kitkat Shake', 90.00, 'https://images.unsplash.com/photo-1579954115545-a95591f28bfc?w=200', 6),
('Red Bull', 120.00, 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=200', 6);

-- 7. GO GO FOOD (UNCHANGED ✅)
INSERT INTO menu_items (item_name, price, image_url, vendor_id) VALUES 
('Aloo Tikki Burger', 50.00, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=200', 7),
('Veg Cheese Burger', 70.00, 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=200', 7),
('Crispy Chicken Burger', 100.00, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=200', 7),
('Maharaja Mac Veg', 120.00, 'https://images.unsplash.com/photo-1551782450-a2132b4ba21d?w=200', 7),
('Salted Fries', 60.00, 'https://images.unsplash.com/photo-1573080496987-a199f8cd4054?w=200', 7),
('Peri Peri Fries', 80.00, 'https://images.unsplash.com/photo-1573080496987-a199f8cd4054?w=200', 7),
('Cheesy Fries', 100.00, 'https://images.unsplash.com/photo-1585503913867-f32822a878bd?w=200', 7),
('Red Sauce Pasta', 120.00, 'https://images.unsplash.com/photo-1555949258-eb67b1ef0ceb?w=200', 7),
('White Sauce Pasta', 130.00, 'https://images.unsplash.com/photo-1612927601601-6638404737ce?w=200', 7),
('Veg Nuggets (6pcs)', 80.00, 'https://images.unsplash.com/photo-1562967914-608f82629710?w=200', 7),
('Chicken Nuggets (6pcs)', 110.00, 'https://images.unsplash.com/photo-1513456852971-30c0b8199d4d?w=200', 7),
('Cold Coffee with Ice Cream', 90.00, 'https://images.unsplash.com/photo-1555529733-0e670560f7e1?w=200', 7),
('Oreo Shake', 100.00, 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=200', 7),
('Virgin Mojito', 80.00, 'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=200', 7),
('Veg Wrap', 90.00, 'https://images.unsplash.com/photo-1626700051175-6818013e1d4f?w=200', 7);

-- 8. DOMINO'S PIZZA (UPDATED WITH YOUR NEW LINKS ✅)
INSERT INTO menu_items (item_name, price, image_url, vendor_id) VALUES 
('Margherita Pizza', 199.00, 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=200', 8),
('Farmhouse Pizza', 359.00, 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=200', 8),
('Peppy Paneer', 359.00, 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=200', 8),
('Mexican Green Wave', 399.00, 'https://tse4.mm.bing.net/th/id/OIP.XREz8rP6k8-K6IJ3ePDnsgHaE6?pid=Api&P=0&h=180', 8), -- NEW
('Veg Extravaganza', 450.00, 'https://images.unsplash.com/photo-1576458088443-04a19bb13da6?w=200', 8),
('Corn & Cheese', 250.00, 'https://tse2.mm.bing.net/th/id/OIP.azpf0bYEDK9Ip0NoWAQHMQHaDt?pid=Api&P=0&h=180', 8), -- NEW
('Paneer Makhani', 400.00, 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=200', 8),
('Chicken Golden Delight', 450.00, 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=200', 8),
('Non Veg Supreme', 500.00, 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=200', 8),
('Chicken Dominator', 550.00, 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=200', 8),
('Pepper Barbecue Chicken', 380.00, 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=200', 8),
('Garlic Breadsticks', 109.00, 'https://tse4.mm.bing.net/th/id/OIP.HJexKnU0N_b4rQmLPeh04wHaEK?pid=Api&P=0&h=180', 8), -- NEW
('Stuffed Garlic Bread', 159.00, 'https://tse1.mm.bing.net/th/id/OIP.2WKJL_G2pbzd8sr97emfuAHaLH?pid=Api&P=0&h=180', 8), -- NEW
('Choco Lava Cake', 99.00, 'https://images.unsplash.com/photo-1624353365286-3f8d62daad51?w=200', 8),
('Pepsi (500ml)', 60.00, 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=200', 8);

-- 9. SUBWAY (UPDATED WITH YOUR NEW LINKS ✅)
INSERT INTO menu_items (item_name, price, image_url, vendor_id) VALUES 
('Veggie Delite Sub', 150.00, 'https://images.unsplash.com/photo-1509722747041-616f39b57569?w=200', 9),
('Paneer Tikka Sub', 180.00, 'https://images.unsplash.com/photo-1626074353765-517a681e40be?w=200', 9),
('Corn & Peas Sub', 160.00, 'https://images.unsplash.com/photo-1509722747041-616f39b57569?w=200', 9),
('Aloo Patty Sub', 170.00, 'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?w=200', 9),
('Chicken Teriyaki Sub', 220.00, 'https://tse3.mm.bing.net/th/id/OIP.9madjt3llEHdo_1RNeyh_QHaJQ?pid=Api&P=0&h=180', 9), -- NEW
('Roasted Chicken Sub', 210.00, 'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?w=200', 9),
('Tuna Sub', 250.00, 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=200', 9),
('Veggie Salad', 180.00, 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=200', 9),
('Protein Salad', 200.00, 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=200', 9),
('Fruit Salad with Nuts', 250.00, 'https://tse2.mm.bing.net/th/id/OIP.RRFwgk47qgVkpMOPmJKNeAHaHa?pid=Api&P=0&h=180', 9), -- NEW
('Veggie Wrap', 150.00, 'https://images.unsplash.com/photo-1626700051175-6818013e1d4f?w=200', 9),
('Chicken Wrap', 190.00, 'https://images.unsplash.com/photo-1626700051175-6818013e1d4f?w=200', 9),
('Oatmeal Cookie', 50.00, 'https://tse3.mm.bing.net/th/id/OIP.11eAqfK9vfyR0C5NV-Hq9wHaFM?pid=Api&P=0&h=180', 9), -- NEW
('Water Bottle', 20.00, 'https://images.unsplash.com/photo-1548839140-29a749e1cf4d?w=200', 9),
('Iced Tea', 60.00, 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=200', 9);

-- 10. SOUTH INDIAN CORNER (OLD CORRECT IMAGES ✅)
INSERT INTO menu_items (item_name, price, image_url, vendor_id) VALUES 
('Masala Dosa', 80.00, 'https://tse4.mm.bing.net/th/id/OIP.QGTchqAKvCSgcKu0P7mhggHaFX?pid=Api&P=0&h=180', 10),
('Plain Dosa', 60.00, 'https://tse3.mm.bing.net/th/id/OIP.IGbrg4qdlfIdcMCqvouWNgHaFz?pid=Api&P=0&h=180', 10),
('Idli Sambar (2pcs)', 50.00, 'https://tse1.mm.bing.net/th/id/OIP.m4NHq2uiDi6N8ZM-RGseJAHaEo?pid=Api&P=0&h=180', 10),
('Vada Sambar', 60.00, 'https://tse1.mm.bing.net/th/id/OIP.-j-Dn_I9dZJi5J9lL6RN7gHaE8?pid=Api&P=0&h=180', 10),
('Onion Uttapam', 90.00, 'https://tse3.mm.bing.net/th/id/OIP.O91Km9zE-dOJC9oZj01khQHaEQ?pid=Api&P=0&h=180', 10),
('Mysore Masala Dosa', 100.00, 'https://tse4.mm.bing.net/th/id/OIP.QGTchqAKvCSgcKu0P7mhggHaFX?pid=Api&P=0&h=180', 10),
('Rava Dosa', 90.00, 'https://tse3.mm.bing.net/th/id/OIP.IGbrg4qdlfIdcMCqvouWNgHaFz?pid=Api&P=0&h=180', 10),
('Paneer Dosa', 110.00, 'https://tse4.mm.bing.net/th/id/OIP.QGTchqAKvCSgcKu0P7mhggHaFX?pid=Api&P=0&h=180', 10),
('Butter Masala Dosa', 100.00, 'https://tse3.mm.bing.net/th/id/OIP.IGbrg4qdlfIdcMCqvouWNgHaFz?pid=Api&P=0&h=180', 10),
('Filter Coffee', 30.00, 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=200', 10),
('Lemon Rice', 70.00, 'https://images.unsplash.com/photo-1516684732162-798a0062be99?w=200', 10),
('Curd Rice', 60.00, 'https://images.unsplash.com/photo-1596560548464-f010549b84d7?w=200', 10),
('Upma', 50.00, 'https://tse1.mm.bing.net/th/id/OIP.m4NHq2uiDi6N8ZM-RGseJAHaEo?pid=Api&P=0&h=180', 10),
('Paper Dosa', 70.00, 'https://tse4.mm.bing.net/th/id/OIP.QGTchqAKvCSgcKu0P7mhggHaFX?pid=Api&P=0&h=180', 10),
('Sambhar Vada', 60.00, 'https://tse1.mm.bing.net/th/id/OIP.-j-Dn_I9dZJi5J9lL6RN7gHaE8?pid=Api&P=0&h=180', 10);

-- 11. JUICE BAR (UNCHANGED ✅)
INSERT INTO menu_items (item_name, price, image_url, vendor_id) VALUES 
('Orange Juice', 60.00, 'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=200', 11),
('Mosambi Juice', 60.00, 'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=200', 11),
('Pineapple Juice', 70.00, 'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=200', 11),
('Watermelon Juice', 50.00, 'https://images.unsplash.com/photo-1589733955941-5eeaf752f6dd?w=200', 11),
('Pomegranate Juice', 80.00, 'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=200', 11),
('Apple Juice', 90.00, 'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=200', 11),
('Mixed Fruit Juice', 80.00, 'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=200', 11),
('Mango Shake', 70.00, 'https://images.unsplash.com/photo-1579954115545-a95591f28bfc?w=200', 11),
('Banana Shake', 50.00, 'https://images.unsplash.com/photo-1579954115545-a95591f28bfc?w=200', 11),
('Papaya Shake', 50.00, 'https://images.unsplash.com/photo-1579954115545-a95591f28bfc?w=200', 11),
('Strawberry Shake', 80.00, 'https://images.unsplash.com/photo-1579954115545-a95591f28bfc?w=200', 11),
('Kiwi Smoothie', 100.00, 'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=200', 11),
('Grape Juice', 70.00, 'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=200', 11),
('Beetroot Juice', 60.00, 'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=200', 11),
('Carrot Juice', 60.00, 'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=200', 11),
('Fresh Fruit Salad', 100.00, 'https://images.unsplash.com/photo-1519996521185-3bc50d5d7532?w=200', 11),
('Green Vegetable Salad', 80.00, 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=200', 11),
('Sprout Salad', 70.00, 'https://tse2.mm.bing.net/th/id/OIP.3695B5_6_6_6_6_6?pid=Api&P=0&h=180', 11),
('Corn Salad', 90.00, 'https://tse1.mm.bing.net/th/id/OIP.7415B5_6_6_6_6_6?pid=Api&P=0&h=180', 11),
('Russian Salad', 120.00, 'https://tse3.mm.bing.net/th/id/OIP.8525B5_6_6_6_6_6?pid=Api&P=0&h=180', 11);

-- 12. SPICY TREAT (UPDATED WITH YOUR NEW LINKS ✅)
INSERT INTO menu_items (item_name, price, image_url, vendor_id) VALUES 
('Veg Momos (Steamed)', 50.00, 'https://tse2.mm.bing.net/th/id/OIP._tgM80_g7K1ymkC1gpvxZAHaE8?pid=Api&P=0&h=180', 12),
('Fried Momos', 60.00, 'https://tse2.mm.bing.net/th/id/OIP.zhalUibOzma528ZcqCOLEAHaE4?pid=Api&P=0&h=180', 12),
('Paneer Momos', 70.00, 'https://tse4.mm.bing.net/th/id/OIP.oyaRq9NBT_LEC7HUt2zbIwHaEK?pid=Api&P=0&h=180', 12),
('Tandoori Momos', 90.00, 'https://tse3.mm.bing.net/th/id/OIP.7895B5_6_6_6_6_6?pid=Api&P=0&h=180', 12),
('Spring Roll', 60.00, 'https://tse1.mm.bing.net/th/id/OIP.n0maqdcL9N5oS8iMFOdJmQHaEK?pid=Api&P=0&h=180', 12),
('Veg Noodles', 70.00, 'https://images.unsplash.com/photo-1552611052-33e04de081de?w=200', 12),
('Hakka Noodles', 80.00, 'https://images.unsplash.com/photo-1552611052-33e04de081de?w=200', 12),
('Chilli Potato', 90.00, 'https://tse2.mm.bing.net/th/id/OIP.kOxLUY-dfnjiXJn4vJXviQHaG1?pid=Api&P=0&h=180', 12),
('Honey Chilli Potato', 100.00, 'https://tse2.mm.bing.net/th/id/OIP.kOxLUY-dfnjiXJn4vJXviQHaG1?pid=Api&P=0&h=180', 12),
('Veg Manchurian', 90.00, 'https://tse4.mm.bing.net/th/id/OIP.oyaRq9NBT_LEC7HUt2zbIwHaEK?pid=Api&P=0&h=180', 12),
('Fried Rice', 80.00, 'https://tse4.mm.bing.net/th/id/OIP.UOir4T77IIUeDtb5aJrJowHaLG?pid=Api&P=0&h=180', 12), -- NEW
('Veg Burger', 50.00, 'https://tse1.mm.bing.net/th/id/OIP.7415B5_6_6_6_6_6?pid=Api&P=0&h=180', 12),
('Cheese Burger', 70.00, 'https://tse3.mm.bing.net/th/id/OIP.8525B5_6_6_6_6_6?pid=Api&P=0&h=180', 12),
('Aloo Tikki Burger', 40.00, 'https://tse4.mm.bing.net/th/id/OIP.9635B5_6_6_6_6_6?pid=Api&P=0&h=180', 12),
('Cold Drink (Glass)', 20.00, 'https://tse2.mm.bing.net/th/id/OIP.1595B5_6_6_6_6_6?pid=Api&P=0&h=180', 12),
('Veg Wrap', 80.00, 'https://tse4.mm.bing.net/th/id/OIP.7535B5_6_6_6_6_6?pid=Api&P=0&h=180', 12);
USE lpu_food_db;
SET SQL_SAFE_UPDATES = 0;

-- =======================================================
-- UPDATING ONLY THE IMAGES YOU PROVIDED
-- =======================================================

-- Fresh Juice Bar (Salads)
UPDATE menu_items SET image_url = 'https://tse3.mm.bing.net/th/id/OIP.SlP8IRWp0tLE0EAV0jVdswHaHa?pid=Api&P=0&h=180' WHERE item_name = 'Fresh Fruit Salad';
UPDATE menu_items SET image_url = 'https://tse2.mm.bing.net/th/id/OIP.40nl6cMdKRQfJEFQAlQh8QHaHa?pid=Api&P=0&h=180' WHERE item_name = 'Sprout Salad';
UPDATE menu_items SET image_url = 'https://tse2.mm.bing.net/th/id/OIP.biKg5O1Kbv9PDGvPJRZargHaI8?pid=Api&P=0&h=180' WHERE item_name = 'Corn Salad';
UPDATE menu_items SET image_url = 'https://tse3.mm.bing.net/th/id/OIP.fk-0nP8eNT3EiY0e_eArJAHaHa?pid=Api&P=0&h=180' WHERE item_name = 'Russian Salad';

-- Spicy Treat (Momos, Burgers, Drinks, Wrap)
UPDATE menu_items SET image_url = 'https://tse3.mm.bing.net/th/id/OIP.tBZ2aMoqi8W9LEvd68x9rgHaE6?pid=Api&P=0&h=180' WHERE item_name = 'Tandoori Momos';
UPDATE menu_items SET image_url = 'https://tse3.mm.bing.net/th/id/OIP.3A7-WIOhI-AJDoae3mKWFAHaHa?pid=Api&P=0&h=180' WHERE item_name IN ('Veg Burger', 'Cheese Burger', 'Aloo Tikki Burger') AND vendor_id = 12;
UPDATE menu_items SET image_url = 'https://tse2.mm.bing.net/th/id/OIP.obyUm91cu_jAtnrJPxSAGwHaEi?pid=Api&P=0&h=180' WHERE item_name = 'Cold Drink (Glass)';
UPDATE menu_items SET image_url = 'https://tse4.mm.bing.net/th/id/OIP._QgtWkjyb2CQTg1idjNyRQHaHa?pid=Api&P=0&h=180' WHERE item_name = 'Veg Wrap' AND vendor_id = 12;

-- Canteen BH2 (Bread Pakora, Fries)
UPDATE menu_items SET image_url = 'https://tse3.mm.bing.net/th/id/OIP.PndoJsKClOCmrybI5T-THgHaHa?pid=Api&P=0&h=180' WHERE item_name = 'Bread Pakora';
UPDATE menu_items SET image_url = 'https://tse2.mm.bing.net/th/id/OIP.kOxLUY-dfnjiXJn4vJXviQHaG1?pid=Api&P=0&h=180' WHERE item_name = 'French Fries' AND vendor_id = 2; -- Using existing fries image as placeholder for now

-- Go Go Food (Fries)
UPDATE menu_items SET image_url = 'https://tse2.mm.bing.net/th/id/OIP.kOxLUY-dfnjiXJn4vJXviQHaG1?pid=Api&P=0&h=180' WHERE item_name IN ('Salted Fries', 'Cheesy Fries') AND vendor_id = 7; -- Using existing fries image as placeholder for now
UPDATE menu_items SET image_url = 'https://tse3.mm.bing.net/th/id/OIP.t38BcGHECsR5zhUG7sPwqQHaHa?pid=Api&P=0&h=180' WHERE item_name = 'Peri Peri Fries';

-- Belgian Waffle (Waffles)
UPDATE menu_items SET image_url = 'https://tse4.mm.bing.net/th/id/OIP._cJzgwiNdQbZwy2XPkdAVQHaHa?pid=Api&P=0&h=180' WHERE item_name = 'Kitkat Crunch Waffle';
UPDATE menu_items SET image_url = 'https://tse3.mm.bing.net/th/id/OIP.vIjQT-cklaaWJxRuXBcwLgHaE8?pid=Api&P=0&h=180' WHERE item_name = 'Cream & Cookies Waffle';
UPDATE menu_items SET image_url = 'https://tse3.mm.bing.net/th/id/OIP.z3nOyK9ils1KlBAOm7ki-gHaE_?pid=Api&P=0&h=180' WHERE item_name = 'Nuclear Nutella Waffle';
UPDATE menu_items SET image_url = 'https://tse2.mm.bing.net/th/id/OIP.BVcQQZK62q5TFFfOjydWigHaHa?pid=Api&P=0&h=180' WHERE item_name = 'Butterscotch Waffle';

-- Nescafe (Latte)
UPDATE menu_items SET image_url = 'https://tse2.mm.bing.net/th/id/OIP.bbIMytNKK5cph97RsJJiYAHaHa?pid=Api&P=0&h=180' WHERE item_name = 'Latte';

SET SQL_SAFE_UPDATES = 1;