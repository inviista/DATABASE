create database lab10;

create table books (
  book_id integer primary key,
  title varchar,
  author varchar,
  price decimal,
  quantity integer
);

create table customers (
  customer_id integer primary key,
  name varchar,
  email varchar
);

create table orders (
  order_id serial primary key,
  book_id integer,
  customer_id integer,
  order_date date,
  quantity integer,
  foreign key (book_id) references books(book_id),
  foreign key (customer_id) references customers(customer_id)
);

insert into books (book_id, title, author, price, quantity) values
(1, 'Database 101', 'A. Smith', 40.00, 10),
(2, 'Learn SQL', 'B. Johnson', 35.00, 15),
(3, 'Advanced DB', 'C. Lee', 50.00, 5);


insert into customers (customer_id, name, email) values
(101, 'John Doe', 'johndoe@example.com'),
(102, 'Jane Doe', 'janedoe@example.com');

--1
begin;

insert into orders (book_id, customer_id, order_date, quantity)
values (1, 101, current_date, 2);

update books
set quantity = quantity - 2
where book_id = 1;

commit;

--2
begin;

do
$$
    begin
        if (select quantity from Books where book_id = 3) < 10 then
            rollback;
        end if;
    end
$$;

insert into orders (book_id, customer_id, order_date, quantity)
values (3, 102, current_date, 10);

update books
set quantity = quantity - 10
where book_id = 3;

commit;

--3
begin transaction isolation level read committed;
update Books set price = price + 10 where book_id = 1;

begin transaction isolation level read committed;
select price from Books where book_id = 1;

commit;

--4
begin;
update customers set email = 'new_email@example.com' where customer_id = 101;
commit;

select email from customers where customer_id = 101;

drop database lab10;