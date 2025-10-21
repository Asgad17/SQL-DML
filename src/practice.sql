CREATE TABLE publishers (
    id SERIAL PRIMARY KEY ,
    name VARCHAR
);

CREATE TABLE languages(
    id SERIAL PRIMARY KEY ,
    language VARCHAR
);

CREATE TYPE gender as enum ('Male', 'Female');

CREATE TABLE authors(
    id SERIAL PRIMARY KEY ,
    first_name VARCHAR,
    last_name VARCHAR,
    email VARCHAR,
    date_of_birth DATE,
    country VARCHAR,
    gender gender
);

CREATE TYPE genre as enum ('DETECTIVE', 'ROMANTIC', 'HORROR');

CREATE TABLE books(
    id SERIAL PRIMARY KEY ,
    name VARCHAR,
    country VARCHAR,
    published_year DATE,
    price NUMERIC,
    genre genre,
    publisher_id INT REFERENCES  publishers(id),
    language_id INT REFERENCES languages(id),
    author_id INT REFERENCES authors(id)
);

-- 1. Publishers
INSERT INTO publishers (name)
VALUES
    ('Penguin Random House'),
    ('HarperCollins'),
    ('Macmillan Publishers'),
    ('Simon & Schuster'),
    ('Hachette Livre');
-- 2. Languages
INSERT INTO languages (language)
VALUES
    ('English'),
    ('Russian'),
    ('French'),
    ('German'),
    ('Spanish');
-- 3. Authors
INSERT INTO authors (first_name, last_name, email, date_of_birth, country, gender)
VALUES
    ('Arthur', 'Conan Doyle', 'arthur.doyle@mail.com', '1859-05-22', 'United Kingdom', 'Male'),
    ('Agatha', 'Christie', 'agatha.christie@mail.com', '1890-09-15', 'United Kingdom', 'Female'),
    ('Stephen', 'King', 'stephen.king@mail.com', '1947-09-21', 'USA', 'Male'),
    ('Jane', 'Austen', 'jane.austen@mail.com', '1775-12-16', 'United Kingdom', 'Female'),
    ('Victor', 'Hugo', 'victor.hugo@mail.com', '1802-02-26', 'France', 'Male');
-- 4. Books
INSERT INTO books (name, country, published_year, price, genre, publisher_id, language_id, author_id)
VALUES
    ('Sherlock Holmes: The Hound of the Baskervilles', 'United Kingdom', '1902-04-01', 15.99, 'DETECTIVE', 1, 1, 1),
    ('Murder on the Orient Express', 'United Kingdom', '1934-01-01', 14.50, 'DETECTIVE', 2, 1, 2),
    ('It', 'USA', '1986-09-15', 19.99, 'HORROR', 3, 1, 3),
    ('Pride and Prejudice', 'United Kingdom', '1813-01-28', 12.99, 'ROMANTIC', 4, 1, 4),
    ('Les Misérables', 'France', '1862-04-03', 18.50, 'ROMANTIC', 5, 3, 5),
    ('The Shining', 'USA', '1977-01-28', 17.25, 'HORROR', 3, 1, 3),
    ('And Then There Were None', 'United Kingdom', '1939-11-06', 16.40, 'DETECTIVE', 2, 1, 2);

-- 1.Китептердин атын, чыккан жылын, жанрын чыгарыныз.
select name, published_year, genre from books;
-- 2.Авторлордун мамлекеттери уникалдуу чыксын.
select distinct country from authors;
-- 3.2020-2023 жылдардын арасындагы китептер чыксын.
select * from books where extract(YEAR FROM published_year) between  1900 and 1935;
-- 4.Детектив китептер жана алардын аттары чыксын.
select name, genre from books where genre = 'DETECTIVE';
-- 5.Автордун аты-жону author деген бир колонкага чыксын.
select concat(first_name,' ', last_name) as author from authors;
-- 6.Германия жана Франциядан болгон авторлорду толук аты-жону менен сорттоп чыгарыныз.
select concat(first_name,' ', last_name) as full_name, country from authors
where country in ('France', 'USA')
order by full_name;
-- 7.Романдан башка жана баасы 500 дон кичине болгон китептердин аты, олкосу, чыккан жылы, баасы жанры чыксын..
    select name, country, published_year, genre from books where genre not in ('ROMANTIC') and price < 500;
-- 8.Бардык кыз авторлордун биринчи 3 ну чыгарыныз.
    select * from authors where gender = 'Female' limit 3;
-- 9.Почтасы .com мн буткон, аты 4 тамгадан турган, кыз авторлорду чыгарыныз.
    select * from authors where gender 'Female' and email like ('%.com') and length(first_name) = 4;
-- 10.Бардык олколорду жана ар бир олкодо канчадан автор бар экенин чыгаргыла.
    select country, count(*) from authors group by country;
-- 11.Уч автор бар болгон олколорду аты мн сорттоп чыгарыныз.
select country, count(*) as total_authors from authors group by country having count(*) = 3 order by country;
-- 11. Ар бир жанрдагы китептердин жалпы суммасын чыгарыныз
    select genre, sum(price) from books group by genre;
-- 12. Роман жана Детектив китептеринин эн арзан бааларын чыгарыныз
select genre, min(price) from books where genre in ('ROMANTIC', 'DETECTIVE') group by genre;
-- 13.История жана Биографиялык китептердин сандарын чыгарыныз
select genre, count(*) from books where genre in ('ROMANTIC', 'DETECTIVE') group by genre;
-- 14.Китептердин , издательстволордун аттары жана тили чыксын
    select b.name, p.name , l.language from books b
            join publishers p on b.publisher_id = p.id
            join languages l on b.language_id = l.id;
-- 15.Авторлордун бардык маалыматтары жана издательстволору чыксын, издательство болбосо null чыксын
    select a.*, p.name from authors a
        left join books b on b.author_id = a.id
        left join publishers p on p.id = b.publisher_id;
-- 16.Авторлордун толук аты-жону жана китептери чыксын, китеби жок болсо null чыксын.
    select concat(a.first_name, ' ', a.last_name) as full_name, b.name from authors a
        join books b on a.id = b.author_id;
-- 17.Кайсы тилде канча китеп бар экендиги ылдыйдан ойлдого сорттолуп чыксын.
    select l.language, count(b.*) from books b
            join languages l on b.language_id = l.id group by language order by language desc;
-- 18.Издательствонун аттары жана алардын тапкан акчасынын оточо суммасы тегеректелип чыгарылсын.
select p.name, round(avg(b.price),3) from publishers p
        join books b on p.id = b.publisher_id group by p.name;
-- 19.2010-2015 жылдардын арасындагы китептер жана автордун аты-фамилиясы чыксын.
    select concat(a.first_name, ' ', a.last_name) as full_name, b.name, b.published_year from authors a
            join books b on a.id = b.author_id where  extract(year from b.published_year) between 1900 and 1935;
-- 20.2010-2015 жылдардын арасындагы китептердин авторлорунун толук аты-жону жана алардын тапкан акчаларынын жалпы суммасы чыксын.
select concat(a.first_name, ' ' ,a.last_name) as full_name ,sum(b.price) from authors a
        join books b on a.id = b.author_id where extract(year from b.published_year) between 1900 and 1935 group by full_name;

/*PRIMARY KEY	Обеспечивает уникальность каждой записи и не допускает NULL	id INT
  PRIMARY KEY	Уникально идентифицирует каждую строку (например, id пользователя)
FOREIGN KEY	                Создает связь между таблицами
  FOREIGN KEY (user_id) REFERENCES users(id)	Поддерживает целостность между таблицами (например, связь заказов и клиентов)
UNIQUE	                    Запрещает дублирование значений в столбце	email VARCHAR(100) UNIQUE	Гарантирует, что значение в колонке не повторится (например, email)
NOT NULL	                Запрещает хранение NULL (пустых) значений	name VARCHAR(50) NOT NULL	Гарантирует наличие значения (например, имя не может быть пустым)
DEFAULT	                    Устанавливает значение по умолчанию, если не указано вручную	status VARCHAR(10) DEFAULT 'active'	Упрощает ввод данных, задавая стандартное значение
CHECK	                    Проверяет, соответствует ли значение условию	age INT CHECK (age >= 18)	Предотвращает ввод некорректных данных (например, возраст < 18)
AUTO_INCREMENT / SERIAL	    Автоматически увеличивает значение при добавлении записи	id SERIAL PRIMARY KEY	Упрощает создание уникальных идентификаторов
ON DELETE CASCADE	        Автоматически удаляет записи, связанные с удаляемой записью	FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE	Сохраняет целостность данных при удалении
   ON UPDATE CASCADE	    Обновляет связанные значения при изменении в родительской таблице	FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE	Поддерживает актуальные связи при изменениях ключей
    COMPOSITE KEY	        Составной ключ из нескольких колонок	PRIMARY KEY (student_id, course_id)	Используется для таблиц-связей (например, студент-курс)
    ENUM / CHECK ENUM	    Ограничивает набор возможных значений	gender VARCHAR(6) CHECK (gender IN ('Male', 'Female'))	Позволяет контролировать список допустимых данных
    INDEX	                Создает индекс для ускорения поиска (не constraint, но часто рядом)	CREATE INDEX idx_name ON users(name);	Ускоряет SELECT-запросы и фильтрацию*/


/*1	CREATE TABLE	🏗 DDL (Data Definition Language)	Создать таблицу	CREATE TABLE users (id SERIAL PRIMARY KEY, name VARCHAR(50), age INT);
2	DROP TABLE	🏗 DDL	Удалить таблицу	DROP TABLE users;
3	ALTER TABLE	🏗 DDL	Изменить структуру таблицы	ALTER TABLE users ADD email VARCHAR(100);
4	INSERT INTO	✍️ DML (Data Manipulation Language)	Добавить данные	INSERT INTO users (name, age) VALUES ('Asgad', 22);
5	SELECT	🔍 DQL (Data Query Language)	Получить данные	SELECT name, age FROM users;
6	WHERE	🔍 DQL	Условие фильтрации данных	SELECT * FROM users WHERE age > 18;
7	UPDATE	✍️ DML	Изменить данные	UPDATE users SET age = 25 WHERE id = 1;
8	DELETE	✍️ DML	Удалить данные	DELETE FROM users WHERE id = 2;
9	ORDER BY	🔍 DQL	Сортировка результатов	SELECT * FROM users ORDER BY age DESC;
10	GROUP BY	🔍 DQL	Группировка данных	SELECT age, COUNT(*) FROM users GROUP BY age;
11	HAVING	🔍 DQL	Условие после группировки	SELECT age, COUNT() FROM users GROUP BY age HAVING COUNT() > 1;
12	JOIN	🔍 DQL	Объединение таблиц	SELECT u.name, o.amount FROM users u JOIN orders o ON u.id = o.user_id;
13	LEFT JOIN	🔍 DQL	Все из левой таблицы + совпавшие справа	SELECT u.name, o.amount FROM users u LEFT JOIN orders o ON u.id = o.user_id;
14	RIGHT JOIN	🔍 DQL	Все из правой таблицы + совпавшие слева	SELECT u.name, o.amount FROM users u RIGHT JOIN orders o ON u.id = o.user_id;
15	INNER JOIN	🔍 DQL	Только совпавшие записи	SELECT * FROM users u INNER JOIN orders o ON u.id = o.user_id;
16	UNION	🔍 DQL	Объединить результаты двух запросов	SELECT name FROM users UNION SELECT name FROM admins;
17	DISTINCT	🔍 DQL	Убрать дубликаты	SELECT DISTINCT age FROM users;
18	LIMIT / OFFSET	🔍 DQL	Ограничить кол-во строк / смещение	SELECT * FROM users LIMIT 5 OFFSET 10;
19	BETWEEN	🔍 DQL	Проверка диапазона	SELECT * FROM users WHERE age BETWEEN 18 AND 30;
20	LIKE	🔍 DQL	Поиск по шаблону	SELECT * FROM users WHERE name LIKE 'A%';
21	IN	🔍 DQL	Проверка на вхождение в набор	SELECT * FROM users WHERE age IN (18, 20, 25);
22	AS	🔍 DQL	Псевдоним столбца или таблицы	SELECT name AS username FROM users;
23	COUNT(), SUM(), AVG(), MIN(), MAX()	🔍 DQL	Агрегатные функции	SELECT COUNT(*) FROM users;
24	PRIMARY KEY	🏗 DDL	Уникальный идентификатор строки	id SERIAL PRIMARY KEY
25	FOREIGN KEY	🏗 DDL	Связь с другой таблицей	FOREIGN KEY (user_id) REFERENCES users(id)
26	DEFAULT	🏗 DDL	Значение по умолчанию	status VARCHAR(10) DEFAULT 'active'
27	NOT NULL	🏗 DDL	Поле не может быть пустым	name VARCHAR(50) NOT NULL
28	CHECK	🏗 DDL	Проверка условия для данных	age INT CHECK (age >= 18)
29	VIEW	🏗 DDL	Создание представления	CREATE VIEW adult_users AS SELECT * FROM users WHERE age >= 18;
30	INDEX	⚙️ DDL / Performance	Ускорение поиска по столбцу	CREATE INDEX idx_name ON users(name);*/

/*SELECT	—	Основная команда для выборки данных	SELECT name, age FROM users;
WHERE	Фильтрация	Отбирает строки по условию	SELECT * FROM users WHERE age > 18;
ORDER BY	Сортировка	Сортирует результат по колонке	SELECT * FROM users ORDER BY age DESC;
GROUP BY	Группировка	Группирует строки по колонке	SELECT city, COUNT(*) FROM users GROUP BY city;
HAVING	Фильтр групп	Фильтрует группы после GROUP BY	SELECT city, COUNT() FROM users GROUP BY city HAVING COUNT() > 5;
DISTINCT	Уникальные значения	Убирает дубликаты	SELECT DISTINCT city FROM users;
LIMIT / OFFSET	Ограничение	Ограничивает количество строк и смещает выборку	SELECT * FROM users LIMIT 5 OFFSET 10;
INNER JOIN	Соединение	Только совпадающие строки из обеих таблиц	SELECT u.name, o.total FROM users u INNER JOIN orders o ON u.id=o.user_id;
LEFT JOIN	Соединение	Все из левой таблицы + совпадающие справа	SELECT u.name, o.total FROM users u LEFT JOIN orders o ON u.id=o.user_id;
RIGHT JOIN	Соединение	Все из правой таблицы + совпадающие слева	SELECT u.name, o.total FROM users u RIGHT JOIN orders o ON u.id=o.user_id;
FULL JOIN	Соединение	Все строки из обеих таблиц	SELECT u.name, o.total FROM users u FULL JOIN orders o ON u.id=o.user_id;
CROSS JOIN	Соединение	Декартово произведение	SELECT * FROM users CROSS JOIN orders;
COUNT()	Агрегат	Подсчет строк	SELECT COUNT(*) FROM users;
SUM()	Агрегат	Сумма значений	SELECT SUM(price) FROM orders;
AVG()	Агрегат	Среднее значение	SELECT AVG(age) FROM users;
MIN()	Агрегат	Минимум	SELECT MIN(age) FROM users;
MAX()	Агрегат	Максимум	SELECT MAX(age) FROM users;
ROUND()	Агрегат	Округление чисел	SELECT ROUND(AVG(salary), 2) FROM employees;
STRING_AGG()	Агрегат	Склейка строк	SELECT STRING_AGG(name, ', ') FROM users;
UPPER()	Строковая функция	Преобразование текста в верхний регистр	SELECT UPPER(name) FROM users;
LOWER()	Строковая функция	Преобразование текста в нижний регистр	SELECT LOWER(email) FROM users;
LENGTH()	Строковая функция	Длина строки	SELECT LENGTH(name) FROM users;
CONCAT()	Строковая функция	Объединение строк	SELECT CONCAT(first_name,' ',last_name) FROM users;
SUBSTRING()	Строковая функция	Извлечение подстроки	SELECT SUBSTRING(email FROM 1 FOR 5) FROM users;
REPLACE()	Строковая функция	Замена подстроки	SELECT REPLACE(email,'@gmail.com','@mail.com');
NOW()	Дата/время	Текущая дата и время	SELECT NOW();
CURRENT_DATE	Дата/время	Только текущая дата	SELECT CURRENT_DATE;
CURRENT_TIME	Дата/время	Только текущее время	SELECT CURRENT_TIME;
AGE()	Дата/время	Разница между датами	SELECT AGE(NOW(),'2000-01-01');
DATE_PART()	Дата/время	Извлечение части даты	SELECT DATE_PART('year', NOW());
EXTRACT()	Дата/время	Извлечение части даты	SELECT EXTRACT(MONTH FROM NOW());
TO_CHAR()	Дата/время	Форматирование даты	SELECT TO_CHAR(NOW(),'YYYY-MM-DD HH24:MI');
INTERVAL	Дата/время	Работа с интервалами	SELECT NOW() + INTERVAL '7 days';
DATE_TRUNC()	Дата/время	Обрезает дату до единицы	SELECT DATE_TRUNC('month', NOW());
CAST()	Дата/время	Преобразование типа	SELECT CAST('2025-10-21' AS DATE);*/