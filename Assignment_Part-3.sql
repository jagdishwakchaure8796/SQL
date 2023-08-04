#************************************ ASSIGNMENT_PART - 3 *********************************************

use assignment;

/*
Question.1. Write a stored procedure that accepts the month and year as inputs and 
prints the ordernumber, orderdate and status of the orders placed in that month. 
*/
# Answer(1): I have created stored procedure 'order_details'.
select * from orders;
/*
CREATE DEFINER=`root`@`localhost` PROCEDURE `order_details`(in o_year int, in o_month int)
BEGIN
select orderNumber, orderDate, status from orders
where year(orderDate) = o_year and month(orderDate) = o_month;
END
*/
call assignment.order_details(2005, 01); # Answer (1)

###########################################################################################################
/*
Question.2.(a). Write function that takes the customernumber as input and 
returns the purchase_status based on the following criteria . [table:Payments]
If the total purchase amount for the customer is < 25000 status = Silver, 
amount between 25000 and 50000, status = Gold if amount > 50000 Platinum
*/
# Answer. 2.(a) : I have created function 'purchase_status'.
select * from  payments;
/*
CREATE DEFINER=`root`@`localhost` FUNCTION `purchase_status`(customer_no int) RETURNS varchar(15) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
declare status varchar(15);
declare amt numeric;
set amt = (select sum(amount) from payments where customerNumber = customer_no);

if amt < 25000 then set status = 'Silver';
elseif amt between 25000 and 50000 then set status = 'Gold';
elseif amt >50000 then set status = 'Platinum';
END if;
RETURN status;
END
*/
select assignment.purchase_status(114);

# Question.2.(b). Write a query that displays customerNumber, customername and purchase_status from customers table.
select * from payments;
alter table payments add column purchase_status varchar(15) after amount;

update payments set purchase_status =
case when amount < 25000 then 'Silver'
	 when amount between 25000 and 50000 then 'Gold'
	 else 'Platinum'
end;
select * from payments;
select * from customers;

select c.customerNumber, c.customerName, p.purchase_status
from customers c left join payments p using (customerNumber); # Answer 2.(b)

############################################################################################################
/*
Question.3. Replicate the functionality of 'on delete cascade' and 'on update cascade' 
using triggers on movies and rentals tables. 
Note: Both tables - movies and rentals - don't have primary or foreign keys. 
Use only triggers to implement the above.
*/
# Answer (3) : I have created trigger 'on_delete_cascade' and 'on_update_cascade' on movies table.
/*
CREATE DEFINER=`root`@`localhost` TRIGGER `on_delete_cascade` AFTER DELETE ON `movies` FOR EACH ROW BEGIN
update rentals
set movieid = null
where movieid not in (select distinct id from movies);
END
*/
insert into movies (id, title, category) 
values (11, 'Spiderman', 'Action'), (12, 'Superhero', 'Animation');

insert into rentals (memid, first_name, last_name, movieid)
values (9, 'Leena', 'Wadibhasme', 11), (10, 'Avni', 'Wadibhasme', 12);

delete from movies where id = 12;

select * from movies;
select * from rentals;

/*
CREATE DEFINER=`root`@`localhost` TRIGGER `on_update_cascade` AFTER UPDATE ON `movies` FOR EACH ROW BEGIN
update rentals
set movieid = new_id where movieid = old_id;
END
*/
drop trigger on_update_cascade;
update rentals set movieid = 9 where movieid = 11;
update movies set id = 12 where title = 'Spiderman';

select * from movies;
select * from rentals;

########################################################################################################
# Question.4. Select the first name of the employee who gets the third highest salary. [table: employee]
# Answer (4) :
select * from employee;
select fname, salary from employee
order by salary desc limit 2,1;

########################################################################################################
/*
Question.5. Assign a rank to each employee  based on their salary. 
The person having the highest salary has rank 1. [table: employee]
*/
# Answer (5) :
select * from employee;
select * ,
dense_rank() over (order by salary desc) as 'Rank'
from employee;

#******************************* ASSIGNMENT_PART - 3 Completed ***********************************************