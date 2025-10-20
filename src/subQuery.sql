CREATE TABLE hospitals(
    id SERIAL PRIMARY KEY ,
    name VARCHAR,
    address VARCHAR
);

create table departments(
    id serial primary key,
    department_name varchar,
    hospital_id int references hospitals(id)
);

create type gender as enum ('Male','Female');
create type specialization as enum ('DERMOTOLOGIST','CARDIOLOGIST','ALLERGIST', 'ORTOPEDIST', 'PSYCHIATRIST');

create table doctors(
    id serial primary key,
    first_name varchar,
    last_name varchar,
    experience int,
    email varchar,
    gender gender,
    specialization specialization,
    department_id int references departments(id)
);

create table patients(
    id serial primary key,
    first_name varchar,
    last_name varchar,
    phone_number varchar,
    email varchar,
    gender gender,
    hospital_id int references hospitals(id),
    doctor_id int references doctors(id)
);

insert into hospitals (id, name, address)
values (1, 'Red Centre', '10548 Reindahl Circle');

insert into departments (id, department_name, hospital_id)
values (1, 'Neurology', 1);
insert into departments (id, department_name, hospital_id)
values (2, 'Oncology', 1);
insert into departments (id, department_name, hospital_id)
values (3, 'Cardiology', 1);
insert into departments (id, department_name, hospital_id)
values (4, 'Emergency Health', 1);
insert into departments (id, department_name, hospital_id)
values (5, 'Anesthesiology', 1);
insert into departments (id, department_name, hospital_id)
values (6, 'Surgical', 1);
insert into departments (id, department_name, hospital_id)
values (7, 'Pediatric', 1);
insert into departments (id, department_name, hospital_id)
values (8, 'Psychical', 1);
insert into departments (id, department_name, hospital_id)
values (9, 'Intensive', 1);
insert into departments (id, department_name, hospital_id)
values (10, 'Nursery', 1);

insert into doctors (id, first_name, last_name, email, experience, gender, specialization, department_id)
values (1, 'Dulcy', 'Jerson', 'djerson0@amazon.com', 1, 'Female', 'DERMOTOLOGIST', 1);
insert into doctors (id, first_name, last_name, email, experience, gender, specialization, department_id)
values (2, 'Conrado', 'Placide', 'cplacide1@friendfeed.com', 2, 'Male', 'ALLERGIST', 2);
insert into doctors (id, first_name, last_name, email, experience, gender, specialization, department_id)
values (3, 'Durand', 'Dreghorn', 'ddreghorn2@utexas.edu', 3, 'Male', 'CARDIOLOGIST', 6);
insert into doctors (id, first_name, last_name, email, experience, gender, specialization, department_id)
values (4, 'Miller', 'Caddies', 'mcaddies3@barnesandnoble.com', 4, 'Male', 'DERMOTOLOGIST', 4);
insert into doctors (id, first_name, last_name, email, experience, gender, specialization, department_id)
values (5, 'Trevor', 'Avon', 'tavon4@arizona.edu', 5, 'Male', 'ORTOPEDIST', 4);
insert into doctors (id, first_name, last_name, email, experience, gender, specialization, department_id)
values (6, 'Marvin', 'Crix', 'mcrix5@bloomberg.com', 6, 'Male', 'CARDIOLOGIST', 5);
insert into doctors (id, first_name, last_name, email, experience, gender, specialization, department_id)
values (7, 'Vail', 'Baily', 'vbaily6@symantec.com', 7, 'Male', 'ALLERGIST', 4);
insert into doctors (id, first_name, last_name, email, experience, gender, specialization, department_id)
values (8, 'Yvette', 'Van Der Weedenburg', 'yvanderweedenburg7@ucsd.edu', 8, 'Female', 'PSYCHIATRIST', 5);
insert into doctors (id, first_name, last_name, email, experience, gender, specialization, department_id)
values (9, 'Mil', 'Gwillim', 'mgwillim8@nba.com', 4, 'Female', 'ORTOPEDIST', 2);
insert into doctors (id, first_name, last_name, email, experience, gender, specialization, department_id)
values (10, 'Angy', 'Minor', 'aminor9@auda.org.au', 10, 'Female', 'DERMOTOLOGIST', 5);
insert into doctors (id, first_name, last_name, email, experience, gender, specialization, department_id)
values (11, 'Cassey', 'De la Barre', 'cdelabarrea@biblegateway.com', 5, 'Female', 'ALLERGIST', 7);
insert into doctors (id, first_name, last_name, email, experience, gender, specialization, department_id)
values (12, 'Gaultiero', 'Goldie', 'ggoldieb@howstuffworks.com', 12, 'Male', 'CARDIOLOGIST', 6);
insert into doctors (id, first_name, last_name, email, experience, gender, specialization, department_id)
values (13, 'Susannah', 'Ryce', 'srycec@foxnews.com', 15, 'Female', 'PSYCHIATRIST', 8);
insert into doctors (id, first_name, last_name, email, experience, gender, specialization, department_id)
values (14, 'Eustacia', 'Caghy', 'ecaghyd@liveinternet.ru', 10, 'Female', 'DERMOTOLOGIST', 9);
insert into doctors (id, first_name, last_name, email, experience, gender, specialization, department_id)
values (15, 'Kariotta', 'Ferrettini', 'kferrettinie@phoca.cz', 15, 'Female', 'PSYCHIATRIST', 8);


insert into patients (id, first_name, last_name, email, phone_number, gender, hospital_id, doctor_id)
values (1, 'Lea', 'Witch', 'lwitch0@printfriendly.com', 7034943573, 'Female', 1, 3);
insert into patients (id, first_name, last_name, email, phone_number, gender, hospital_id, doctor_id)
values (2, 'Saraann', 'Seleway', 'sseleway1@discuz.net', 7042731563, 'Female', 1, 2);
insert into patients (id, first_name, last_name, email, phone_number, gender, hospital_id, doctor_id)
values (3, 'Thaxter', 'Bartley', 'tbartley2@reference.com', 5029541489, 'Male', 1, 3);
insert into patients (id, first_name, last_name, email, phone_number, gender, hospital_id, doctor_id)
values (4, 'Evvy', 'Mintoff', 'emintoff3@house.gov', 5047624512, 'Female', 1, 4);
insert into patients (id, first_name, last_name, email, phone_number, gender, hospital_id, doctor_id)
values (5, 'Fonsie', 'Fairholm', 'ffairholm4@dedecms.com', 5038828192, 'Male', 1, 5);
insert into patients (id, first_name, last_name, email, phone_number, gender, hospital_id, doctor_id)
values (6, 'Arda', 'Canadine', 'acanadine5@howstuffworks.com', 7069307149, 'Female', 1, 5);
insert into patients (id, first_name, last_name, email, phone_number, gender, hospital_id, doctor_id)
values (7, 'Elvira', 'Churchlow', 'echurchlow6@weebly.com', 7054337678, 'Female', 1, 3);
insert into patients (id, first_name, last_name, email, phone_number, gender, hospital_id, doctor_id)
values (8, 'Marty', 'Targetter', 'mtargetter7@vinaora.com', 5042600657, 'Male', 1, 2);
insert into patients (id, first_name, last_name, email, phone_number, gender, hospital_id, doctor_id)
values (9, 'Thaddeus', 'Scotts', 'tscotts8@chronoengine.com', 7054131954, 'Male', 1, 7);
insert into patients (id, first_name, last_name, email, phone_number, gender, hospital_id, doctor_id)
values (10, 'Freddy', 'Skilbeck', 'fskilbeck9@archive.org', 5057985117, 'Male', 1, 5);
insert into patients (id, first_name, last_name, email, phone_number, gender, hospital_id, doctor_id)
values (11, 'Kenn', 'Leif', 'kleifa@bloglovin.com', 7094159807, 'Male', 1, 6);
insert into patients (id, first_name, last_name, email, phone_number, gender, hospital_id, doctor_id)
values (12, 'Abdel', 'Lethebridge', 'alethebridgeb@wired.com', 7095010261, 'Male', 1, 8);
insert into patients (id, first_name, last_name, email, phone_number, gender, hospital_id, doctor_id)
values (13, 'Brandon', 'Jeaycock', 'bjeaycockc@booking.com', 5055207270, 'Male', 1, 4);
insert into patients (id, first_name, last_name, email, phone_number, gender, hospital_id, doctor_id)
values (14, 'Brew', 'Wloch', 'bwlochd@delicious.com', 7094319667, 'Male', 1, 2);
insert into patients (id, first_name, last_name, email, phone_number, gender, hospital_id, doctor_id)
values (15, 'Sonny', 'Labusch', 'slabusche@flickr.com', 5009884214, 'Female', 1, 8);

-- Queries:
-- 1. Найти всех пациентов, которые лечатся в отделении 'Surgical’
-- with join
    select * from patients p
        join doctors dc on p.doctor_id = dc.id
        join departments dp on dc.department_id = dp.id
        where dp.department_name = 'Surgical';
-- with subQuery
select * from patients p where doctor_id in
        (select doctors.id from doctors where department_id =
        (select departments.id from  departments where  department_name = 'Surgical'));
-- 2. Получить список всех отделений, где работает врач с именем 'John’

-- 3. Найти всех пациентов, у которых врач имеет стаж более 10 лет
-- with join
select * from patients p join doctors d on d.id = p.doctor_id
where experience > 10;
-- with subQuery
    select * from patients p where p.doctor_id in (select id from doctors where experience > 10);
-- 4. Получить список всех врачей и количество пациентов, которых они обслуживают
-- with join
    select d.first_name, count(p.id) from doctors d
        join patients p on d.id = p.doctor_id
        group by d.first_name;
-- with subQuery
    select d.first_name,
                        (select count(p.id) from patients p where p.id = p.doctor_id) from doctors d;
-- SQL(SubQuery,ENUM) 2
-- 5. По лучить список всех пациентов, которые не обслуживаются ни у одного врача

-- 6. Получить список всех врачей, которые не обслуживают ни одного пациента
-- 7. Получить список всех врачей, которые лечат пациентов старше 60 лет
-- 8. Найти всех пациентов, которые лечатся у врача с именем 'Anna' и фамилией 'Smith’
-- 9. Получить список всех врачей, работающих в отделении 'Intensive' и обслуживающих больше 3 пациентов
    select * from doctors d join departments dp on d.department_id = dp.id
    join (select  doctor_id, count(*) from patients group by doctor_id having count(*) > 1)
    p on d.id = p.doctor_id where department_name = 'Intensive';
-- 10. Получить список всех отделений, в которых пациенты лечатся у врачей с
-- опытом менее 5 лет
-- 11. Найти всех пациентов, у которых врач имеет специализацию
-- 'DERMOTOLOGIST’
-- 12. Получить количество врачей для каждой специализации
-- 13. Найти всех пациентов, обслуживаемых врачами с наименее
-- распространенной специализацией
-- 14. Найти всех пациентов, обслуживаемых врачами с специализацией
-- ‘CARDIOLOGIST’
-- 15. Получить список всех врачей, работающих в отделении 'Neurology' и
-- обслуживающих больше 3 пациентов