create database lab4;

create table Warehouses (
    code int primary key,
    location varchar(255),
    capacity int
);

create table Packs(
    code varchar(4),
    contents varchar(255),
    value real,
    warehouses int,

    foreign key (warehouses)
    references Warehouses(code)
);


INSERT INTO Warehouses(code, location, capacity) VALUES(1, 'Chicago', 3);
INSERT INTO Warehouses(code, location, capacity) VALUES(2, 'Rocks', 4);
INSERT INTO Warehouses(code, location, capacity) VALUES(3, 'New York', 7);
INSERT INTO Warehouses(code, location, capacity) VALUES(4, 'Los Angeles', 2);
INSERT INTO Warehouses(code, location, capacity) VALUES(5, 'San Francisko', 8);

INSERT INTO Packs(code, contents, value, warehouses) VALUES ('0MN7', 'Rocks', 180, 3);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('4H8P', 'Rocks', 250, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('4RT3', 'Scissors', 190, 4);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('7G3H', 'Rocks', 200, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('8JN6', 'Papers', 75, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('8Y6U', 'Papers', 50, 3);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('9J6F', 'Papers', 175, 2);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('LL08', 'Rocks', 140, 4);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('P0H6', 'Scissors', 125, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('P2T6', 'Scissors', 150, 2);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('TUSS', 'Papers', 90, 5);


--4
select * from Packs;

--5
select * from Packs
where value > 190;

--6
select distinct contents, code, value, warehouses
from Packs
order by contents;

--7
select w.code as warehouse_code,
    (select count(*) from Packs p where p.warehouses = w.code) as number_of_packs
from Warehouses w;

--8
select w.code as warehouse_code,
    (select count(*) from Packs p where p.warehouses = w.code) as number_of_packs
from Warehouses w
where (select count(*) from Packs p where p.warehouses = w.code) > 2;

--9
insert into Warehouses(code, location, capacity) values (6, 'Texas', 5);

--10
insert into Packs(code, contents, value, warehouses) values ('H5RT', 'Papers', 150, 2);

--11
with newPacks as(
    select code, value,
           row_number() over (order by value desc) as n
    from Packs
)
update Packs
set value = value * 0.82
where code = (select code from newPacks where n = 3);

--12
delete from Packs where value < 150;

--13
create table newPacks as
select * from Packs
where warehouses in (select code from Warehouses where location = 'Chicago');

delete from Packs
where warehouses in (select code from Warehouses where location = 'Chicago');

select * from newPacks;

drop table newPacks;

drop database lab4;

