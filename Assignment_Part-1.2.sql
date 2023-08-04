use assignment;

# Question.5. Create the following tables. Use auto increment wherever applicable

# Question.5.(a). Create Product Table
# Answer.5.(a):
create table product (product_id int primary key auto_increment, 
product_name varchar(30) unique not null, 
description varchar(500), supplier_id int);
alter table product auto_increment = 100;
select * from product;

# Question.5.(b). Create Suppliers Table
# Answer.5.(b):
create table suppliers (supplier_id int primary key auto_increment, 
supplier_name varchar(25), location varchar(30));
alter table suppliers auto_increment = 1000;
select * from suppliers;

# Question.5.(c). Create Stock Table
# Answer.5.(c):
create table stock (id int primary key auto_increment, 
product_id int, balance_stock int,
foreign key(product_id) references product(product_id)
on delete set null);
alter table stock auto_increment = 2000;
select * from stock;

alter table product add foreign key(supplier_id) references suppliers(supplier_id)
on delete cascade;

####################################################################################################################
# Question.6. Enter some records into the three tables.
# Answer.6 :
insert into product(product_id, product_name, description) 
value(101, 'Grinder', 'A grinder, is one of power tools or machine tools used for grinding, it is a type of machining using an abrasive wheel as the cutting tool.'),
(102, 'TV', 'TV, is a telecommunication medium for transmitting moving images and sound. TV is a mass medium for advertising, entertainment, news, and sports.'),
(103, 'Speaker', 'Speakers are transducers that convert electromagnetic waves into sound waves. The speakers receive audio input from a device such as a computer or an audio receiver. This input may be either in analog or digital form.'),
(104, 'Smartwatch', 'A smartwatch is a digital watch that provides many other features besides timekeeping. Examples include monitoring your heart rate, tracking your activity, and providing reminders throughout the day.');

select * from product;

insert into suppliers(supplier_name, location) 
values('Sujata', 'India'),
	  ('Sony', 'Japan'),
      ('MI', 'China'),
      ('Oneplus', 'China');
select * from suppliers;

update product 
set supplier_id = 
case product_name 
when 'Grinder' then 1000
when 'TV' then 1001
when 'Speaker' then 1002
when 'Smartwatch' then 1003
end
where product_name in ('Grinder', 'TV', 'Speaker', 'Smartwatch');

insert into stock (product_id, balance_stock) 
values (101, 356),
	   (102, 432),
       (103, 210),
       (104, 400);
select * from stock;

#############################################################################################################
# Question.7. Modify the supplier table to make supplier name unique and not null.
# Answer.7 :
alter table suppliers modify supplier_name varchar(25) unique not null;

##############################################################################################################
# Question.8. Modify the emp table as follows

# Question.8.(a). Add a column called deptno
# Answer.8.(a):
select * from emp;
alter table emp add column deptno int after hire_date;

# Question.8.(b). Set the value of deptno in the following order
# Answer.8.(b):
alter table emp rename column emp_no to emp_id;
     
update emp set deptno =
case when emp_id % 2 = 0 then 20
	 when emp_id % 3 = 0 then 30
     when emp_id % 4 = 0 then 40
     when emp_id % 5 = 0 then 50
     else 10
 end;
 select * from emp;
 
#################################################################################################################### 
# Question.9. Create a unique index on the emp_id column.
# Answer.9 :
create unique index emp_id_uniq on emp(emp_id);

###################################################################################################################
/*
# Question.10. Create a view called emp_sal on the emp table by selecting the following fields 
in the order of highest salary to the lowest salary.
- emp_no, first_name, last_name, salary
*/
# Answer.10 :
select * from emp;
alter table emp rename column emp_id to emp_no;

create view emp_sal as select emp_no, first_name, last_name, salary from emp
order by salary desc;
select * from emp_sal;

#********************************************ASSIGNMENY_PART-1 Completed*****************************************************
 