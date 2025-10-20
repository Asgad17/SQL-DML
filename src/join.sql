create table courses
(
    id          serial primary key,
    course_name varchar,
    price       int
);
create table mentors
(
    id         serial primary key,
    first_name varchar,
    last_name  varchar,
    email      varchar,
    course_id  int references courses (id)
);

insert into courses (course_name, price)
VALUES ('Java Core', 180000),
       ('Js Core', 180000),
       ('English', 180000),
       ('Java Ad', 180000);


drop table mentors;
insert into mentors(first_name, last_name, email, course_id)
values
    ('Urmat','Taichikov','urmat@gmail.com',1),
    ('Aizat','Duisheeva','aizat@gmail.com',2),
    ('Aijamal','Asangazieva','aijamal@gmail.com',3),
    ('Nurisa','Mamiraim kyzy','nurisa@gmail.com',null);


select * from courses;
select * from mentors;

-- JOIN
select * from mentors join courses on courses.id = mentors.course_id;
-- Cross join
select * from mentors,courses;
-- Inner join
select * from mentors  join courses on courses.id = mentors.course_id;
select * from mentors m join courses  c on c.id = m.course_id;
-- Outer join  left ,right ,full
select * from mentors  left  join courses on courses.id = mentors.course_id;
select * from mentors  right join courses on courses.id = mentors.course_id;
select * from courses right join mentors on mentors.course_id = courses.id;
select * from courses full join mentors on mentors.course_id = courses.id