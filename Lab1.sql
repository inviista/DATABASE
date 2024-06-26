--1
CREATE DATABASE lab1;
--2
CREATE TABLE  IF NOT EXISTS students(
    id serial,
    firstname varchar(50),
    lastname varchar(50)
);
DROP TABLE IF EXISTS students;
--3
ALTER TABLE students
ADD isadmin INTEGER;
--4
ALTER TABLE students
ALTER COLUMN isadmin type boolean
using isadmin::boolean;
--5
ALTER TABLE students
ALTER COlUMN isadmin SET DEFAULT false;
--6
ALTER TABLE students
ADD CONSTRAINT students PRIMARY KEY (id);
--7
CREATE TABLE IF NOT EXISTS tasks (
    id SERIAL PRIMARY KEY,
    name varchar(50),
    user_id integer
);
--8
DROP TABLE IF EXISTS tasks;
--9
DROP DATABASE lab1;
--



































