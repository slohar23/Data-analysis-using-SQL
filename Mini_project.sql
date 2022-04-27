use classicmodels;
-- Total no of offices in each city (city, no of offices) --
select * from offices;
select city, count(distinct officeCode) from offices group by city; 
select * from offices where city = 'Boston';

-- Total no of employees in each job title -- 
select * from employees;
select jobTitle, count(distinct employeeNumber) from employees group by jobTitle;

-- Total no of customers in each state -- 
select * from customers;
select state, count(distinct customerNumber ) as total_cust from customers group by state order by total_cust desc;

-- Total no of orders for every order date --
select * from orders;
select orderDate, count(distinct orderNumber) from orders group by orderDate order by orderDate;
select year(orderDate) as year_day, month(orderDate) as year_mon, count(distinct orderNumber) 
from orders group by year_mon, year_day order by year_day, year_mon;


-- Customers paid more than $100 -- 
select * from payments;
select count(distinct amount) as total_transc_amt_100 , customerNumber from payments 
where amount > 100
group by customerNumber;

-- Total no of cheques per customer who paid more than $50 --
select count(distinct checkNumber), customerNumber from payments 
where amount > 50
group by customerNumber;

-- Total number of orders for each product where qty order greater than 2 -- 
select * from orderdetails;
select count(distinct productCode), orderNumber from orderdetails
where quantityOrdered > 2
group by orderNumber;

-- Total number of products, value of highest msrp, total no. of products qty for each vendor --
select * from products;
select count(distinct productName), productVendor,
max(msrp),
sum(quantityInStock)
from products
group by productVendor;
select * from products where productVendor = 'Autoart Studio Design'; 

select * from customers;
-- Do People with higher credit line order more no of times than people with lower credit line --
select o.orderNumber, c.customerNumber, c.creditLimit
from orders as o join customers as c
on o.customerNumber = c.customerNumber; -- joining tables: customers and orders on customer number --

select count(*) from 
(select * from (select o.orderNumber, c.customerNumber, c.creditLimit
from orders as o join customers as c
on o.customerNumber = c.customerNumber) as a 
where a.creditLimit > 30000) as b; -- checking for highest creditlimit --

select count(distinct a.orderNumber)/count(distinct a.customerNumber) as orders_per_people, a.creditLimit from 
(select o.orderNumber, c.customerNumber, c.creditLimit
from orders as o join customers as c
on o.customerNumber = c.customerNumber) as a -- checking for creditlimits on orders per person --
group by a.creditLimit
order by a.creditLimit desc
