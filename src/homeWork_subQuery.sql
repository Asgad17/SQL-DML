CREATE TABLE devices(
    id SERIAL PRIMARY KEY ,
    product_name VARCHAR,
    product_company VARCHAR,
    price INT
);

INSERT INTO devices (product_name, product_company, price) VALUES
        ('iPhone 14', 'Apple', 1200),
        ('MacBook Pro', 'Apple', 2500),
        ('Galaxy S23', 'Samsung', 1100),
        ('ThinkPad X1', 'Lenovo', 1300),
        ('IdeaPad', 'Lenovo', 800),
        ('Pixel 7', 'Google', 900),
        ('Surface Laptop', 'Microsoft', 1500);

CREATE TABLE customers(
    id SERIAL PRIMARY KEY,
    name VARCHAR
);

INSERT INTO customers (name) VALUES
        ('Alice'),
        ('Bob'),
        ('Charlie'),
        ('Diana'),
        ('Eve');

CREATE TABLE cheques(
    id SERIAL PRIMARY KEY,
    devices_id INT REFERENCES devices(id),
    customers_id INT REFERENCES customers(id),
    price INT,
    dete_of_purchase DETE NOT NULL
);

INSERT INTO cheques (devices_id, customers_id, price, date_of_purchase) VALUES
        (1, 1, 1200, '2024-01-01'),
        (2, 1, 2500, '2024-01-15'),
        (3, 2, 1100, '2024-02-01'),
        (4, 3, 1300, '2024-03-05'),
        (5, 3, 800, '2024-03-06'),
        (2, 4, 2500, '2024-04-01'),
        (1, 5, 1200, '2024-05-10'),
        (6, 5, 900, '2024-06-12'),
        (3, 5, 1100, '2024-06-30'),
        (2, 2, 2500, '2024-07-01');

--1 Имена клиентов, купивших устройства дороже средней цены всех устройств
SELECT DISTINCT c.name FROM customers c
         JOIN cheques ch ON c.id = ch.customers_id
WHERE ch.price > (SELECT AVG(price) FROM devices);

--1 Компании, чьи устройства никогда не покупались
SELECT DISTINCT d.product_company FROM devices d
WHERE d.id NOT IN (SELECT devices_id FROM cheques);


--3 Устройства, которые покупались больше одного раза
SELECT d.product_name FROM devices d
WHERE d.id IN ( SELECT devices_id FROM cheques
    GROUP BY devices_id HAVING COUNT(*) > 1);


--4 Клиенты, купившие самое дорогое устройство
SELECT DISTINCT c.name FROM customers c
         JOIN cheques ch ON c.id = ch.customers_id
WHERE ch.devices_id IN (SELECT id FROM devices WHERE price = (SELECT MAX(price) FROM devices));


--5 Клиенты, купившие хотя бы одно устройство от компании "Apple"
SELECT DISTINCT c.name FROM customers c
WHERE c.id IN (SELECT ch.customers_id FROM cheques ch
             JOIN devices d ON ch.devices_id = d.id
    WHERE d.product_company = 'Apple');


--6 Клиенты, которые не купили ни одного устройства дешевле 500
SELECT name FROM customers
WHERE id NOT IN (SELECT ch.customers_idFROM cheques ch
             JOIN devices d ON ch.devices_id = d.id
    WHERE d.price < 500);

--7 Клиенты, чья общая сумма покупок больше средней суммы всех клиентов
SELECT c.name АROM customers c
         JOIN cheques ch ON c.id = ch.customers_id
GROUP BY c.name
HAVING SUM(ch.price) > (SELECT AVG(total) FROM (SELECT SUM(price) AS totalFROM cheques
        GROUP BY customers_id) t);

--8 Название самого часто покупаемого устройства
SELECT product_name FROM devices
WHERE id = (SELECT devices_id FROM cheques
    GROUP BY devices_id ORDER BY COUNT(*) DESC LIMIT 1);

--9 Устройства с ценой выше средней цены по компании
SELECT product_name, product_company, price
FROM devices d
WHERE price > (SELECT AVG(price)FROM devices d2
    WHERE d2.product_company = d.product_company);


--10 Клиенты, купившие устройства типа "LAPTOP"
SELECT DISTINCT c.name FROM customers c
WHERE c.id IN (SELECT customers_id FROM cheques ch
             JOIN devices d ON ch.devices_id = d.id
    WHERE LOWER(d.product_name) LIKE '%laptop%');


--11 CASE — комментарий по категории устройства
SELECT product_name, price, CASE
           WHEN price < 1000 THEN 'Бюджетное устройство'
           WHEN price BETWEEN 1000 AND 2000 THEN 'Средний класс'
           ELSE 'Премиум устройство'
           END AS category
FROM devices;

--12 Клиенты, покупавшие устройства только одной компании
SELECT c.name FROM customers c
         JOIN cheques ch ON c.id = ch.customers_id
         JOIN devices d ON ch.devices_id = d.id
GROUP BY c.name HAVING COUNT(DISTINCT d.product_company) = 1;

--13 Устройство, которое покупали все клиенты
SELECT d.product_name FROM devices d
WHERE d.id IN (SELECT devices_id FROM cheques
    GROUP BY devices_id HAVING COUNT(DISTINCT customers_id) = (SELECT COUNT(*) FROM customers));

