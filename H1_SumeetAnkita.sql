/*
Name: Ankita Sumeet
Assignment Number: 1
Date: 1/29/21
Section:  your  class  section  (9:30 – 10:45)
*/

-- Q1:statement to retrieve all attributes of customers, sorted by zip, last name 
SELECT * 
FROM customers_om
ORDER BY customer_zip, customer_last_name;

-- Q2: statement to retrieve artist, title, unit price 
SELECT artist, title, unit_price
FROM items
ORDER BY 1,3;

-- Q3: statement to retrieve the concatenated order id / item id and order quantity 
SELECT order_id || '-' || item_id AS "ORDER#", order_qty
FROM order_details
ORDER BY ORDER#;
/* if there is no space between the alias, you do not need to add double quotations 
   use double hyphen for single line comment and slash-asterisk for double line comment */

-- Q4: retrieve non-duplicate information on state and zip of all customers 
SELECT DISTINCT customer_state, customer_zip
FROM customers_om
ORDER BY customer_state, customer_zip;
-- there are 10 total states  

-- Q5: retrieve customer state, customer city, and customer first and last name that are filtered by states Ohio and Iowa 
SELECT customer_state, customer_city, customer_first_name AS "First Name", customer_last_name AS "Last Name"
FROM customers_om
WHERE customer_state IN ('OH', 'IA') 
ORDER BY customer_state, customer_city;
-- to see all content of table use asterisk (*) 

-- Q6: concatenate the first and last names of customers, and order by cities with "Wa" in the name 
SELECT customer_first_name || ' ' || customer_last_name AS "customer", customer_city
FROM customers_om
WHERE customer_city LIKE 'Wa%'
ORDER BY "customer";

-- Q7: using dual table, output real name and date of doing so 
SELECT 'Ankita Sumeet' AS "My Name", SYSDATE AS "Date Output"
FROM Dual;

-- Q8: retrieve artist, order date, and customer name by joining 4 tables and filtering by title, date 
SELECT artist, order_date, customer_first_name || ' ' || customer_last_name AS "customer", title
FROM customers_om C
    JOIN orders O 
    ON C.customer_id = O.customer_id 
    JOIN order_details OD
    ON O.order_id = OD.order_id
    JOIN items I
    ON OD.item_id = I.item_id
WHERE title = 'Zone Out With Umami' AND order_date > '01-Feb-14'
ORDER BY artist, order_date;