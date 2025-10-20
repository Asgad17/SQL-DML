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