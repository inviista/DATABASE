
create database lab8;

--1
create table countries(
        name varchar(50)
);
create index idx1 on countries(name);

--2
create table departments(
        id serial primary key,
        budget double precision
);
create table employees(
        name varchar(50),
        surname varchar(50),
        salary double precision,
        department_id integer references departments(id)
);

insert into departments (budget) values
(100.0),
(150.0),
(200.0);

-- Insert three random values into the 'employees' table
insert into employees (name, surname, salary, department_id) values
('John', 'Doe', 50.0, 1),
('Jane', 'Smith', 600.0, 2),
('Bob', 'Johnson', 75.0, 3);
create index idx2 on employees(name, surname);

--3
create unique index idx3 on employees(salary)
where salary > 100 and salary < 200;

--4
create index idx4 on employees(name)
where substring(name from 1 for 4) = 'abcd';

--5

--a
create index idx5 on employees(department_id)
where salary < 100;
create index idx5_1 on departments(id)
where budget > 100;

--b
create table new_table as
select d.id, d.budget, e.name, e.surname, e.salary
from employees e
join departments d on e.department_id = d.id;
create index idx5_2 on new_table(id, salary, budget)
where salary < 100 and budget > 100;

drop database lab8;