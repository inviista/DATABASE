--1
CREATE DATABASE lab2;
--2
CREATE TABLE employees(
    birth_date date,
    first_name varchar(14),
    last_name varchar(16),
    gender char,
    hire_date date,
    emp_no integer primary key
);
--3
CREATE TABLE departments(
    dept_name varchar(40),
    dept_no char(4) primary key
);
--5
CREATE TABLE titles(
    emp_no integer,
    foreign key (emp_no)
                      references employees(emp_no),
    title varchar(50),
    from_date date,
    to_date date
);
--6
CREATE TABLE salaries(
    emp_no integer,
    foreign key (emp_no)
        references employees(emp_no),
    salary integer,
    from_date date,
    to_date date
);
--7
CREATE TABLE dept_emp (
    emp_no integer,
    foreign key (emp_no)
        references employees(emp_no),
    dept_no char(4),
    foreign key (dept_no)
        references departments(dept_no),
    from_date date,
    to_date date
);
--8
CREATE TABLE dept_manager (
    dept_no char(4),
    foreign key (dept_no)
        references departments(dept_no),
    emp_no integer,
    foreign key (emp_no)
        references employees(emp_no),
    from_date date,
    to_date date
);
--9
DROP TABLE employees;

DROP TABLE dept_emp;

DROP TABLE dept_manager;

DROP TABLE departments;

DROP TABLE salaries;

DROP TABLE titles;

--10
CREATE TABLE students(
    full_name varchar(50),
    age integer,
    birth_date date,
    gender char,
    average_grade double precision,
    nationality varchar(50),
    phone_number varchar(50),
    social_category varchar(50)
);
--11
create table instructors(
    full_name varchar(50),
    spoken_languages varchar(50),
    work_experience varchar(50),
    the_possibility_of_having_remote_lessons varchar(50)
);
--12
create table student_relatives(
    full_name varchar(50),
    address varchar(50),
    phone_number varchar(50),
    position varchar(50)
);
--13
create table student_social_data(
    school varchar(50),
    graduation_date date,
    address varchar(50),
    region varchar(50),
    country varchar(50),
    GPA double precision,
    honors varchar(50)
);

--14
--DML
insert into student_relatives(full_name, address, phone_number, position)
values
    ('Aldiyar Sadykov', 'Satbayev 7a', '+8 708 119 60 40', 'Junior developer');

update student_relatives
set position = 'Middle Developer'
where full_name = 'Aldiyar Sadykov';

select * from student_relatives;

delete from student_relatives
where full_name = 'Aldiyar Sadykov';

--15
--DDL
ALTER TABLE students
add age integer;

DROP table students;

DROP DATABASE lab2;