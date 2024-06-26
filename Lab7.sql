create database Lab7;

create table dealer (
    id integer primary key ,
    name varchar(255),
    location varchar(255),
    commission float
);

INSERT INTO dealer (id, name, location, commission) VALUES (101, 'Oleg', 'Astana', 0.15);
INSERT INTO dealer (id, name, location, commission) VALUES (102, 'Amirzhan', 'Almaty', 0.13);
INSERT INTO dealer (id, name, location, commission) VALUES (105, 'Ademi', 'Taldykorgan', 0.11);
INSERT INTO dealer (id, name, location, commission) VALUES (106, 'Azamat', 'Kyzylorda', 0.14);
INSERT INTO dealer (id, name, location, commission) VALUES (107, 'Rahat', 'Satpayev', 0.13);
INSERT INTO dealer (id, name, location, commission) VALUES (103, 'Damir', 'Aktobe', 0.12);

create table client (
    id integer primary key ,
    name varchar(255),
    city varchar(255),
    priority integer,
    dealer_id integer references dealer(id)
);

INSERT INTO client (id, name, city, priority, dealer_id) VALUES (802, 'Bekzat', 'Satpayev', 100, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (807, 'Aruzhan', 'Almaty', 200, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (805, 'Али', 'Almaty', 200, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (808, 'Yerkhan', 'Taraz', 300, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (804, 'Aibek', 'Kyzylorda', 300, 106);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (809, 'Arsen', 'Taldykorgan', 100, 103);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (803, 'Alen', 'Shymkent', 200, 107);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (801, 'Zhandos', 'Astana', null, 105);

create table sell (
    id integer primary key,
    amount float,
    date timestamp,
    client_id integer references client(id),
    dealer_id integer references dealer(id)
);

INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (201, 150.5, '2021-10-05 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (209, 270.65, '2021-09-10 00:00:00.000000', 801, 105);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (202, 65.26, '2021-10-05 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (204, 110.5, '2021-08-17 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (207, 948.5, '2021-09-10 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (205, 2400.6, '2021-07-27 00:00:00.000000', 807, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (208, 5760, '2021-09-10 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (210, 1983.43, '2021-10-10 00:00:00.000000', 804, 106);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (203, 2480.4, '2021-10-10 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (212, 250.45, '2021-06-27 00:00:00.000000', 808, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (211, 75.29, '2021-08-17 00:00:00.000000', 803, 107);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (213, 3045.6, '2021-04-25 00:00:00.000000', 802, 101);

-- drop table client;
-- drop table dealer;
-- drop table sell;

--1
--a
select name from client where priority < 300;

--b
select * from client c
join dealer d on c.dealer_id = d.id;

--c
select d.name, c.name, c.city, c.priority, s.id as sale_id, s.date, s.amount
from dealer d
join client c on d.id = c.dealer_id
join sell s on d.id = s.dealer_id;

--d
select d.name, c.name
from dealer d
join client c on d.location = c.city;

--e
select s.id, s.amount, c.name, c.city
from client c
join sell s on c.id = s.client_id
where amount between 200 and 500;

--f
select d.name, count(c.dealer_id) as clients_number
from dealer d
join client c on d.id = c.dealer_id
group by d.name;

--g
select c.name, c.city, d.name, d.commission
from client c
join dealer d on d.id = c.dealer_id;

--h
select c.name, c.city, d.name, d.commission
from client c
join dealer d on d.id = c.dealer_id
where d.commission > 0.13;

--i
select c.name, c.city, s.id, s.date, s.amount, d.name, d.commission
from client c
join dealer d on d.id = c.dealer_id
join sell s on c.id = s.client_id;

--j
select c.name, c.priority, d.name, s.id, s.amount
from dealer d
join client c on d.id = c.dealer_id
join sell s on d.id = s.dealer_id
where s.amount > 2000 and c.priority is not null;


--2
--a
create view a as
select date,
       count(distinct client_id) as unique_clients,
       avg(amount) as average,
       sum(amount) as sum
from sell
group by date;

select * from a;

drop view a;

--b
create view b as
select date, sum(amount) as sum
from sell
group by date
order by sum desc
limit 5;

select * from b;

drop view b;

--c
create view c as
select dealer_id,
       count(*) as number_of_sales,
       avg(amount) as average,
       sum(amount) as sum
from sell
group by dealer_id;

select * from c;

drop view c;

--d
create view d as
select d.location,
       sum(s.amount * d.commission) as total_commission_earned
from sell s
join dealer d on d.id = s.dealer_id
group by d.location;

select * from d;

drop view d;

--e
create view e as
select d.location,
       count(*) as number_of_sales,
       avg(s.amount) as average,
       sum(s.amount) as sum
from sell s
join dealer d on d.id = s.dealer_id
group by d.location;

select * from e;

drop view e;

--f
create view f as
select c.city,
       count(*) as number_of_sales,
       avg(s.amount) as average,
       sum(s.amount) as sum
from sell s
join client c on s.client_id = c.id
group by c.city;

select * from f;

drop view f;

--g
create view g as
select distinct city
from(
    select c.city, sum(s.amount) as expense
    from client c
    join sell s on c.id = s.client_id
    group by c.city
    ) as city_expense
join(
    select d.location, sum(s.amount) as sales
    from dealer d
    join sell s on d.id = s.dealer_id
    group by d.location
    ) as city_sales on city_expense.expense > city_sales.sales;

select * from g;

drop view g;