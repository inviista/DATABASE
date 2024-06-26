create database lab6;

create table locations(
    location_id serial primary key,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12)
);

create table departments(
    department_id integer primary key,
    department_name varchar(50) unique,
    budget integer,
    location_id integer references locations
);

create table employees(
    employee_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    phone_number varchar(20),
    salary integer,
    department_id integer references departments
);

--3
insert into locations (street_address, postal_code, city, state_province) values
('123 Maple St', '12345', 'Anytown', 'StateA'),
('456 Oak St', '23456', 'Hometown', 'StateB'),
('789 Pine St', '34567', 'Moscow', 'StateC'),
('101 Apple Blvd', '45678', 'Yourtown', 'StateD'),
('202 Cherry Ave', '56789', 'Thistown', 'StateE');

insert into departments (department_id, department_name, budget, location_id) values
(30, 'Human Resources', 50000, 1),
(50, 'Finance', 75000, 2),
(60, 'Research and Development', 100000, 3),
(70, 'Marketing', 25000, 4),
(80, 'Information Technology', 125000, 5);

insert into employees (first_name, last_name, email, phone_number, salary, department_id) values
('John', 'Doe', 'johndoe@example.com', '555-1234', 50000, 30),
('Jane', 'Smith', 'janesmith@example.com', '555-2345', 60000, 50),
('Emily', 'Jones', 'emilyjones@example.com', '555-3456', 55000, 60),
('Michael', 'Brown', 'michaelbrown@example.com', '555-4567', 65000, 70),
('Jessica', 'Davis', 'jessicadavis@example.com', '555-5678', 70000, 80);

--4
select e.first_name, e.last_name, e.department_id, d.department_name
from employees e
join departments d on d.department_id = e.department_id;

--5
select e.first_name, e.last_name, e.department_id, d.department_name
from employees e
join departments d on
    d.department_id = e.department_id and
    (e.department_id = 30 or e.department_id = 80);

--6
select e.first_name, e.last_name, d.department_name, l.city, l.state_province
from employees e
join departments d on d.department_id = e.department_id
join locations l on d.location_id = l.location_id;

--7
select d.department_name, count(e.employee_id) as employees_number
from departments d
left join employees e on d.department_id = e.department_id
group by d.department_name;

--8
select e.first_name, e.last_name, e.department_id, d.department_name
from departments d
right join employees e on d.department_id = e.department_id;

--9
select e.last_name, e.first_name
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
where city = 'Moscow';

drop database lab6;