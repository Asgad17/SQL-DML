CREATE TABLE Author (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE,
    nationality VARCHAR(50)
);

ALTER TABLE Author ADD COLUMN email VARCHAR(100);

ALTER TABLE Author DROP COLUMN nationality;

ALTER TABLE Author
    ADD CONSTRAINT unique_email UNIQUE (email),
ALTER COLUMN name SET NOT NULL;

ALTER TABLE Author ALTER COLUMN name TYPE TEXT;

ALTER TABLE Author RENAME TO Writers;

CREATE TABLE Book (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    published_year INT,
    author INT REFERENCES Writers(id)
);

INSERT INTO Writers (name, date_of_birth, email)
VALUES
    ('Джордж Оруэлл', '1903-06-25', 'orwell@gmail.com'),
    ('Джоан Роулинг', '1965-07-31', 'rowling@gmail.com');

INSERT INTO Book (name, published_year, author)
VALUES
    ('1984', 1949, 1),
    ('Скотный двор', 1945, 1),
    ('Гарри Поттер и философский камень', 1997, 2),
    ('Гарри Поттер и тайная комната', 1998, 2),
    ('Гарри Поттер и узник Азкабана', 1999, 2),
    ('Гарри Поттер и Кубок огня', 2000, 2);