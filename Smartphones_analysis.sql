-- ============================
--  Smartphones Data Analysis
--  Author: Owais Khan
--  Date: 2025-08-08
-- ============================

USE data;
SHOW TABLES;

-- =================================
-- A. SELECT, WHERE, ORDER BY, GROUP BY
-- =================================

SELECT * from smartphones;

SELECT brand_name, model, price
FROM smartphones
WHERE price > 50000;

SELECT brand_name, model, price from smartphones order by price desc;

SELECT brand_name, COUNT(*) AS total_models, AVG(price) as avg_price FROM smartphones
GROUP BY brand_name
ORDER BY avg_price DESC;

-- =================================
-- B. JOINS
-- =================================
USE data;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(150),
    favorite_brand VARCHAR(50),
    location VARCHAR(100),
    age INT,
    purchase_year INT
);
INSERT INTO users (name, email, favorite_brand, location, age, purchase_year)
VALUES
('Ali Khan', 'ali@gmail.com', 'Apple', 'Delhi', 28, 2023),
('Sara Malik', 'sara@yahoo.com', 'Samsung', 'Mumbai', 34, 2024),
('John Doe', 'john@outlook.com', 'Xiaomi', 'Delhi', 22, 2022),
('Maryam Noor', 'maryam@gmail.com', 'Apple', 'Aligarh', 29, 2024),
('Bilal Ahmed', 'bilal@yahoo.com', 'Oppo', 'Agra', 40, 2023);

-- Find each user's chosen smartphone models
SELECT u.name, u.location, u.age, s.model, s.price
FROM users u
INNER JOIN smartphones s
    ON u.favorite_brand = s.brand_name;

-- Average smartphone price by user location
SELECT u.location, AVG(s.price) AS avg_price
FROM users u
INNER JOIN smartphones s
    ON u.favorite_brand = s.brand_name
GROUP BY u.location;

-- =================================
-- C. Subqueries
-- =================================
SELECT brand_name, model, price
FROM smartphones
WHERE price > (
    SELECT AVG(price)
    FROM smartphones
);

-- =================================
-- D. Aggregate Functions
-- =================================
SELECT SUM(price) AS total_price
FROM smartphones;

SELECT brand_name, AVG(price) AS avg_price
FROM smartphones
GROUP BY brand_name;

-- =================================
-- E. Create Views
-- =================================
CREATE VIEW expensive_smartphones AS
SELECT brand_name, model, price
FROM smartphones
WHERE price > 50000;

SELECT * FROM expensive_smartphones;

-- =================================
-- F. Index Optimization
-- =================================
CREATE INDEX idx_brand_price
ON smartphones(brand_name(50), price);
