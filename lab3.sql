--Task 1
--A
select title from course
where dept_name = 'Biology' and credits > 3;

--B
select room_number from classroom
where building = 'Watson' or building = 'Painter';

--C
select course_id from course
where dept_name = 'Comp. Sci.';

--D
select course_id from section
where semester = 'Spring';

--E
select name from student
where tot_cred > 45 and tot_cred < 85;

--F
select course_id from course
where lower(right(title, 1)) in ('a', 'e', 'i', 'o', 'u', 'y');

--G
select prereq_id from prereq
where course_id = 'EE-181';

--Task 2
--A
select  dept_name, avg(salary) as avg_salary
from instructor group by dept_name
order by avg_salary ASC;

--B
select building
from section
group by building
order by count(*) desc
limit 1;

--C
select dept_name, count(*)
from course
group by dept_name
order by count(*);

--D
select id, name from student
where dept_name = 'Comp. Sci.' and tot_cred > 3;

--E
select id, name from instructor
where dept_name in(
    select dept_name
    from department
    where building = 'Taylor'
    );

--F
select name from instructor
where dept_name = 'Biology' or dept_name = 'Music' or dept_name = 'Phylosophy';

--G
select name from instructor
where id in(
    select id
    from teaches
    where year = '2018' and year != '2023'
    );

--Task 3
--A
select name from student
where dept_name = 'Comp. Sci.' and id in (
    select id
    from takes
    where grade = 'A' or grade ='A-'
    )
order by name;

--B
select name from instructor
where id in (
    select i_id
    from advisor
    where s_id in (
        select id
        from takes
        where grade > 'B'
        )
    );

--C
select dept_name from student
where id in(
    select id
    from takes
    where grade != 'F' and grade != 'C'
    );

--D
select name from instructor
where id in (
    select id
    from teaches
    where course_id in (
        select course_id
        from takes
        where grade != 'A' and grade != 'A-'
        )
    );

--E
select title from course
where course_id in(
    select course_id
    from section
    where time_slot_id in (
        select time_slot_id
        from time_slot
        where start_hr < 13
        )
    );