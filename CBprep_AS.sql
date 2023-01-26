/*
Name: Ankita Sumeet
Date: 1/22/21
*/

/* Insert the missing statement to get all the columns from the Customers table */
select * from Customers; 

/* Write a statement that will select the City column from the Customers table */
select City from Customers;

/* Select all the different values from the Country column in the Customers table */
select distinct Country from Customers;

/* Select all records where the City column has the value "Berlin" */
select * from Customers 
where City = "Berlin";

/* Use the NOT keyword to select all records where City is NOT "Berlin" */
select * from Customers 
where not City = "Berlin";

/* Select all records where the CustomerID column has the value 32 */
select * from Customers 
where CustomerID = 32; 

/* Select all records where the City column has the value 'Berlin' and the PostalCode column has the value 12209 */
select * from Customers 
where City = "Berlin" and PostalCode = 12209;

/* Select all records where the City column has the value 'Berlin' or 'London' */
select * from Customers
where City = "Berlin" or City = "London";

/* Select all records from the Customers table, sort the result alphabetically by the column City (ASC = default) */
select * from Customers
order by City; 

/* Select all records from the Customers table, sort the result reversed alphabetically by the column City */
select * from Customers
order by City desc;

/* Select all records from the Customers table, sort the result alphabetically, first by the column Country, then, by the column City */
select * from Customers 
order by Country, City;

/* Insert a new record in the Customers table */
insert into Customers( 
CustomerName, 
Address, 
City, 
PostalCode,
Country)

values(
'John Doe',
'Highway 15',
'Nest',
'75024',
'Norway');

/* Select all records from the Customers where the PostalCode column is empty */
select * from Customers
where PostalCode is null;

/* Select all records from the Customers where the PostalCode column is NOT empty */
select * from Customers
where PostalCode is not null;

/* Set the value of the City columns to 'Oslo', but only the ones where the Country column has the value "Norway" */
update Customers
set City = 'Oslo'
where Country = 'Norway';

/* Update the City value and the Country value */
update Customers
set City = 'Oslo', Country = 'Norway'
where CustomerID = 32;

/* Delete all the records from the Customers table where the Country value is 'Norway' */
delete from Customers
where Country = 'Norway';

/* Delete all the records from the Customers table */
delete from Customers;


/* Use the MIN function to select the record with the smallest value of the Price column. */
select min(Price) from Products; 

/* Use an SQL function to select the record with the highest value of the Price column */
select max(Price) from Products;

/* Use the correct function to return the number of records that have the Price value set to 18 */
select count(*) from Products
where Price = '18';

/* Use an SQL function to calculate the average price of all products */
select avg(price) from Products;

/* Use an SQL function to calculate the sum of all the Price column values in the Products table */
select sum(Price) from Products;

/* Select all records where the value of the City column starts with the letter "a" */
select * from Products
where City like 'a%';

/* Select all records where the value of the City column ends with the letter "a" */
select * from Products
where City like '%a';

/* Select all records where the value of the City column contains the letter "a" */
select * fom Products
where City like '%a%';

/* Select all records where the value of the City column starts with letter "a" and ends with the letter "b" */
select * from Products
where City like 'a%b';

/* Select all records where the value of the City column does NOT start with the letter "a" */
select * from Products
where City not like 'a%';

/* Select all records where the second letter of the City is an "a" */
select * from Products 
where City like '_a%';

/* Select all records where the first letter of the City is an "a" or a "c" or an "s" */
select * from Products
where City like '[acs]%' 

/* Select all records where the first letter of the City starts with anything from an "a" to an "f" */
select * from Products
where City like '[a-f]%';

/* Select all records where the first letter of the City is NOT an "a" or a "c" or an "f" */
select * from Products 
where City like '[!a-f]%';

/* Select all the records where Country is either "Norway" or "France" */
select * from Customers
where Country in ('Nowrway', 'France');

/* Select all the records where Country is NOT "Norway" and NOT "France" */
select * from Customers
where Country not in ('Nowrway', 'France');

/* Select all the records where the value of the Price column is between 10 and 20 */
select * from Customers
where Price between 10 and 20;

/* Select all the records where the value of the Price column is NOT between 10 and 20 */
select * from Customers
where Price not between 10 and 20;

/* Select all the records where the value of the ProductName column is alphabetically between 'Geitost' and 'Pavlova' */
select * from Customer 
where ProductName between 'Geitost' and 'Pavlova';

/* When displaying the Customers table, make an ALIAS of the PostalCode column, the column should be called Pno instead */
select CustomerName, Address, PostalCode AS Pno
from Customers;

/* When displaying the Customers table, refer to the table as Consumers instead of Customers */
select * from Customers as Consumers;

/* Insert the missing parts in the JOIN clause to join the two tables Orders and Customers,
   using the CustomerID field in both tables as the relationship between the two tables. */
select * from Orders
left join Customers
ON Orders.CustomerID = Customers.CustomerID;

/* Choose the correct JOIN clause to select all records from the two tables where there is a match in both tables */


/* Select all */


-- Q1:statement to retrieve all attributes of customers, sorted by zip, last name 
select * from customers_om
order by c_zip, c_last name;

-- Q2: statement to retrieve artist, title, unit price 
select artist, title, unit price
from items;

-- Q3: statement to retrieve the concatenated order id / item id and order quantity 
select order_id || '-' || item_id AS "ORDER #", order quantity
from order_details;
/* if there is no space between the alias, you do not need to add double quotations 
   use double hyphen for single line comment and slash-asterisk for double line comment */

-- Q4: retrieve non-duplicate information on state and zip of all customers 
select distinct c_state, c_zip
from customers_om;
/* there are 10 total states , optional order by */ 

-- Q5: retrieve customer state, customer city, and customer first and last name that are filtered by states Ohio and Iowa 
select c_state, c_city, c_first ||' '|| c_last as "c_name"
from customers_om
where state in ('Ohio', 'Iowa');
/* to see all content of table use asterisk (*) */

-- Q6: concatenate the first and last names of customers, and order by cities with "Wa" in the name 
select c_first ||' '|| c_last as "c_name"
from customers_om
where city like 'Wa%'
order by customer;

-- Q7: using dual table, output real name and date of doing so 
SELECT 'Ankita Sumeet' AS "My Name", SYSDATE AS "Date Output"
FROM Dual;

-- Q8: retrieve artist, order date, and customer name by joining 4 tables and filtering by title, date 
select c_artist, c_orderdate, c_first || ' ' || c_last AS c_name
from customers_om C
    join orders O
    on C.cID = O.cID
    join order_details OD
    on O.o_ID = OD.o_ID
    join items I
    on OD.item_id = I.item_id
where i_title = 'In the Zone' and order_date > '01-Feb-14'
order by i_title, i_date;

-- Q6: Statement to retrieve author's full name and book's isbn (using a left outer join) to identify which authors have not written a book. 
select first_name || ' ' || last_name AS "Full Name", BA.isbn
from author A
    left join book_author BA
    on A.aid = BA.aid;
    
-- Q2: Create a copy of CUSTOMERS_OM table and call it CUSTOMERS_HW5 but only select those customers who reside outside of CA.
CREATE TABLE CUSTOMERS_HW5 AS
SELECT * FROM CUSTOMERS_OM
WHERE NOT CUSTOMER_STATE = 'CA';

-- Q9: Write a “summary” report that lists titles and show the average quantity ordered for each title in CA.  Write a similar report for NY and combine them into one statement. 
-- use UNION 
SELECT Title, AVG(ORDER_QTY), 'California' AS "STATE NAME Constant"
FROM CUSTOMER_ORDER_ITEMS_V
WHERE ST = 'CA'
GROUP BY Title
UNION
SELECT Title, AVG(ORDER_QTY), 'New York' AS "STATE NAME Constant" 
FROM CUSTOMER_ORDER_ITEMS_V
WHERE ST = 'NY'
GROUP BY Title;

-- Q11: Orders placed in 2014, showing customer state, city, total quantity, total sales, and average sales per unit and rounded to two decimal places.   
SELECT CUSTOMERS_OM.customer_state AS ST, CUSTOMERS_OM.customer_city AS City, 
SUM(ORDER_QTY) AS "Total Quantity", SUM(ORDER_QTY * Unit_Price) AS "Total Price", 
ROUND((SUM(ORDER_QTY * Unit_Price)/SUM(ORDER_QTY)), 2) AS "Average Price Per Unit"                          
FROM CUSTOMERS_OM
JOIN ORDERS
ON CUSTOMERS_OM.customer_id = ORDERS.customer_id
JOIN ORDER_DETAILS
ON ORDERS.order_id = ORDER_DETAILS.order_id
JOIN items
ON ORDER_DETAILS.item_id = items.item_id
WHERE order_date BETWEEN '01-JAN-14' AND '31-DEC-14'
HAVING SUM(ORDER_QTY * UNIT_PRICE) > 30
GROUP BY CUSTOMERS_OM.customer_state, CUSTOMERS_OM.customer_city
ORDER BY CUSTOMERS_OM.customer_state;

-- limit
select * from customers limit 5;
-- only select 4th 5th row
select * from customers limit 2 offset 3;

-- distinct
select distinct c_state, c_zip
from customers_om;

-- count
select count(*) from Products
where Price = '18';

-- Create table
CREATE TABLE CUSTOMERS_HW5 AS
SELECT * FROM CUSTOMERS_OM
WHERE NOT CUSTOMER_STATE = 'CA';

-- HAVING only used after group by for that aggregate function

-- Normalization reduces redundancy 

-- common records from tables
Select studentID from student INTERSECT Select StudentID from Exam

select c_state, c_city, sum(order_q), sum(sales), avg(sales)
from customers_om C
join orders_om O
on C.orderid = O.orderid
where o_date between '01-JAN-14' AND '31-DEC-14'
having sum (sales) > 30
group by customers_om.c_state, customers_om.c_city
order by customers_om.c_state

/* Update the City value and the Country value */
update Customers
set City = 'Oslo', Country = 'Norway'
where CustomerID = 32;

/* Delete all the records from the Customers table where the Country value is 'Norway' */
delete from Customers
where Country = 'Norway';

-- L/R joins fetch all matched data from the respective side, but all unmatched data is lost
-- full outer joins merges the two tables 

-- 1NF must contain only single attributes (same names but w diff ID numbers)

