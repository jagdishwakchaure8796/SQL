#******************************************* ASSIGNMENT_PART-2 *******************************************************

use assignment;

# Question.1. select all employees in department 10 whose salary is greater than 3000. [table: employee]
# Answer.1 :
select * from employee;
select * from employee where deptno = 10 and salary>3000;

############################################################################################################################
/*
# Question.2. The grading of students based on the marks they have obtained is done as follows: [table: students]
	 40 to 50 -> Second Class
     50 to 60 -> First Class
     60 to 80 -> First Class
     80 to 100 -> Distinctions
*/
select * from students;
alter table students add column grade varchar(15);

update students set grade =
case when marks>40 and marks<50 then 'Second Class'
	 when marks>50 and marks<60 then 'First Class'
     when marks>60 and marks<80 then 'First Class'
     when marks>80 and marks<100 then 'Distinction'
     else 'Fail'
end;

# Question.2.(a). How many students have graduated with first class?
# Answer.2.(a):
select count(name) from students where grade in ('First Class') group by grade;

# Question.2.(b). How many students have obtained distinction? 
# Answer.2.(b):
select count(name) from students where grade in ('Distinction') group by grade;

###################################################################################################################################
# Question.3. Get a list of city names from station with even ID numbers only. Exclude duplicates from your answer.[table: station]
# Answer.3 :
select * from station;
select distinct id, city from station where id%2 = 0;

#################################################################################################################################
/*
Question.4. Find the difference between the total number of city entries in the table and 
the number of distinct city entries in the table. 
In other words, if N is the number of city entries in station, and 
N1 is the number of distinct city names in station, 
write a query to find the value of N-N1 from station. [table: station]
*/
# Answer.4 :
select * from station;
select (count(city) - count(distinct(city))) from station; 

#################################################################################################################################
# Question.5. Answer the following: [table: station]
/* 
Question.5.(a). Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. 
Your result cannot contain duplicates. [Hint: Use RIGHT() / LEFT() methods ]
*/
# Answer.5.(a) :
select distinct city from station 
where (city like 'a%') or (city like 'e%') or (city like 'i%') or (city like 'o%') or (city like 'u%');

/*
Question.5.(b). Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) 
as both their first and last characters. Your result cannot contain duplicates.
*/
# Answer.5.(b):
select distinct city from station 
where (city like 'a%' or city like 'e%' or city like 'i%' or city like 'o%' or city like 'u%') and 
(city like '%a' or city like '%e' or city like '%i' or city like '%o' or city like '%u');

/*
Question.5.(c). Query the list of CITY names from STATION that 
do not start with vowels. Your result cannot contain duplicates.
*/
# Answer.5.(c) :
select distinct(city) from station 
where (city not like 'a%') and (city not like 'e%') and (city  not like 'i%') and (city not like 'o%') and (city not like 'u%');

/*
Question.5.(d). Query the list of CITY names from STATION that either do not start with vowels 
or do not end with vowels. Your result cannot contain duplicates. 
*/
# Answer.5.(d) :
select distinct(city) from station 
where (city not like 'a%' and city not like 'e%' and city  not like 'i%' and city not like 'o%' and city not like 'u%') and 
(city not like '%a' and city not like '%e' and city  not like '%i' and city not like '%o' and city not like '%u');

#################################################################################################################################
/* 
Question.6. Write a query that prints a list of employee names having a salary 
greater than $2000 per month who have been employed for less than 36 months. 
Sort your result by descending order of salary. [table: emp]
*/
# Answer.6 :
select * from emp 
where salary>2000 and hire_date>= date_sub(current_date, interval 36 month) 
order by salary desc;

###############################################################################################################################
# Question.7. How much money does the company spend every month on salaries for each department? [table: employee]
# Answer.7 :

select * from employee;
select sum(salary) as 'Total_Salary', deptno from employee group by deptno;

##############################################################################################################################
# Question.8. How many cities in the CITY table have a Population larger than 100000. [table: city]
# Answer.8 :
select * from city;
select * from city where population>100000;

#############################################################################################################################
# Question.9. What is the total population of California? [table: city]
# Answer.9 :
select sum(population) as 'Total_Population', district from city where district = 'california';

############################################################################################################################
# Question.10. What is the average population of the districts in each country? [table: city]
# Answer.10 :
select * from city;

select avg(population), countrycode from city
where countrycode in ('NLD', 'USA', 'JPN')
group by countrycode;

############################################################################################################################
/*
Question.11. Find the ordernumber, status, customernumber, customername and comments 
for all orders that are ‘Disputed=  [table: orders, customers]
*/
# Answer.11 :
select* from orders;
select * from customers;

create view orders_customers as select orderNumber, status, customerNumber, comments from orders where status = 'Disputed';
select * from orders_customers;

select c.customerName, o.customerNumber, o.orderNumber, o.status, o.comments 
from customers c right join orders_customers o using(customerNumber);

#**************************************** ASSIGNMENT_PART - 2 Completed *************************************************

