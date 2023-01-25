/*
Name: Ankita Sumeet
Assignment Number: Ex2
Date: 2/2/21
Section: 9:30 – 10:45
*/

-- Q1:statement to retrieve customer first name, date shipped, and item id sorted by dates before 1/1/13 in descending order by date shipped
select customer_first_name, shipped_date, item_id
from customers_om C
    join orders O 
    on C.customer_id = O.customer_id 
    join order_details OD
    on O.order_id = OD.order_id
where shipped_date < '01-Jan-13'
order by shipped_date DESC;