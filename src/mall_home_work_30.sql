CREATE TABLE mall (
    id SERIAL PRIMARY KEY ,
    name VARCHAR NOT NULL ,
    address VARCHAR NOT NULL ,
    email VARCHAR UNIQUE,
    phone_number VARCHAR UNIQUE
);

INSERT INTO mall(name, address, email, phone_number)
VALUES ('Дордой Плаза', 'Ибраимова 115/2', 'dordoi@email.com', '+996 701 51-51-00'),
        ('Bishkek Park', 'Киевская 148', 'bishkek@email.com', '+996 (312) 31-20-31'),
        ('Asia Mall', 'п. Чынгыза Айтматова 3', 'asia@email.com', '+996 558-46-48-84');

CREATE TABLE boutiques (
    id SERIAL PRIMARY KEY ,
    number int NOT NULL ,
    square VARCHAR NOT NULL ,
    mall_id INT REFERENCES mall (id)
);

INSERT INTO  boutiques (number, square, mall_id)
VALUES  (1, '150m^2', 3),
        (2, '200m^2', 1),
        (3, '400m^2', 2),
        (4, '220m^2', 2),
        (5, '115m^2', 3);

CREATE TABLE brands (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50)
);

INSERT INTO brands (name, category) VALUES
    ('Nike', 'Одежда и обувь'),
    ('Zara', 'Модная одежда'),
    ('H&M', 'Одежда'),
    ('Starbucks', 'Кофейня'),
    ('Asia', 'Джинсовая одежда'),
    ('Kulikov', 'Super Market'),
    ('KFC', 'Ресторан'),
    ('Apple', 'Электроника');


CREATE TABLE boutique_brands (
    id SERIAL PRIMARY KEY,
    boutique_id INT REFERENCES boutiques(id),
    brand_id INT REFERENCES brands(id)
);

INSERT INTO boutique_brands (boutique_id, brand_id) VALUES
        (1, 1),
        (1, 2),
        (2, 3),
        (2, 5),
        (3, 4),
        (3, 7),
        (4, 8),
        (5, 6);


CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    brand_id INT REFERENCES brands(id),
    boutique_id INT REFERENCES boutiques(id),
    name VARCHAR(100),
    price DECIMAL(10,2),
    stock INT
);

INSERT INTO products (brand_id, boutique_id, name, price, stock) VALUES
        (1, 1, 'Nike Air Max 270', 150.00, 30),
        (2, 1, 'Zara Dress', 80.00, 50),
        (3, 2, 'H&M Hoodie', 55.00, 40),
        (5, 2, 'Asia', 120.00, 20),
        (4, 3, 'Latte Grande', 4.50, 200),
        (7, 3, 'KFC Bucket 10pcs', 12.99, 100),
        (8, 4, 'iPhone 15 Pro', 1300.00, 10),
        (6, 5, 'Kulikov', 350.00, 15);


CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100)
);

INSERT INTO customers (full_name, phone, email) VALUES
        ('Айбек Беков', '+996700111222', 'aibek@mail.com'),
        ('Камила Ахматова', '+996701333444', 'kamila@mail.com'),
        ('Жоомарт Токтосунов', '+996702555666', 'joomart@mail.com'),
        ('Анна Смирнова', '+996703777888', 'anna@mail.com'),
        ('Бакыт Асан уулу', '+996704999000', 'bakyt@mail.com');


CREATE TABLE purchases (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id),
    boutique_id INT REFERENCES boutiques(id),
    total_amount DECIMAL(10,2),
    purchase_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO purchases (customer_id, boutique_id, total_amount, purchase_date) VALUES
        (1, 1, 230.00, '2025-10-15 14:00:00'),
        (2, 3, 8.50, '2025-10-15 15:30:00'),
        (3, 4, 1300.00, '2025-10-16 12:00:00'),
        (4, 5, 350.00, '2025-10-16 17:10:00'),
        (5, 2, 175.00, '2025-10-17 18:00:00');

CREATE TABLE employees1 (
    id SERIAL PRIMARY KEY,
    boutique_id INT REFERENCES boutiques(id),
    full_name VARCHAR(100),
    position VARCHAR(50),
    salary DECIMAL(10,2)
);

INSERT INTO employees1 (boutique_id, full_name, position, salary) VALUES
        (1, 'Алина Ким', 'Продавец-консультант', 55000),
        (1, 'Егор Пак', 'Кассир', 48000),
        (2, 'Нурлан Беков', 'Менеджер', 70000),
        (3, 'Ольга Иванова', 'Бариста', 50000),
        (4, 'Эмиль Ким', 'Сервис-специалист', 90000),
        (5, 'Светлана Токтогулова', 'Продавец-консультант', 52000);


CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id),
    boutique_id INT REFERENCES boutiques(id),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT
);

INSERT INTO reviews (customer_id, boutique_id, rating, comment) VALUES
        (1, 1, 5, 'Крутые магазины, хороший выбор.'),
        (2, 3, 4, 'Кофе вкусный, но немного дорогой.'),
        (3, 4, 5, 'Обслуживание на уровне Apple!'),
        (4, 5, 4, 'Отличное качество и персонал.'),
        (5, 2, 5, 'Много одежды и хорошие цены.');

CREATE TABLE promotions (
    id SERIAL PRIMARY KEY,
    boutique_id INT REFERENCES boutiques(id),
    name VARCHAR(100),
    discount_percent INT,
    start_date DATE,
    end_date DATE
);

INSERT INTO promotions (boutique_id, name, discount_percent, start_date, end_date) VALUES
        (1, 'Осенняя распродажа', 20, '2025-10-10', '2025-10-25'),
        (2, 'Mid Season Sale', 30, '2025-10-15', '2025-11-01'),
        (3, 'Coffee Week', 15, '2025-10-12', '2025-10-20'),
        (4, 'Apple Days', 10, '2025-10-17', '2025-10-24'),
        (5, 'Outdoor Fest', 25, '2025-10-20', '2025-10-27');