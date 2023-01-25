/*
Name: Ankita Sumeet
Assignment Number: 2
Date: 2/9/21
Section:  your  class  section  (9:30 – 10:45)
*/

-- Q1: Statement to retrieve author's full name and full address of all authors born after March 1, 1982. Output sorted by DOB. 
select dob, first_name || ' ' || last_name AS "Full Name", a_address || ', ' || a_city || ', ' || a_state || ' ' || a_zip AS "Full Address"
from author
where dob > '01-March-1982'
order by dob;

-- Q2: Statement to retrieve publisher's name, state, book title and award. Output sorted by publisher's state, book title. 
select p_state, title, award, p_name
from publisher P
    join book B
    on P.pid = B.pid
order by p_state, title;

-- Q3: Statement to retrieve book's publication date, isbn, price, and author's first and last name. Output sorted by publication date.
select pubdate, book.isbn, price, first_name AS "FIRST", last_name AS "LAST"
from book 
    join book_author
    on book.isbn = book_author.isbn
    join author
    on author.aid = book_author.aid
order by pubdate;

-- Q4: Statement to retrieve author's city, aid, title, publisher's pid, and publisher's city. 
--     Output filtered by authors who reside in San Francisco or Amherst. Output sorted by author’s city, aid.
select a_city, BA.aid, title, P.pid, p_city
from publisher P
    join book B
    on P.pid = B.pid
    join book_author BA
    on B.isbn = BA.isbn
    join author A
    on BA.aid = A.aid
where a_city = 'San Francisco' or a_city = 'Amherst'
order by a_city, BA.aid;

-- Q5: Statement to retrieve customer id and order_id (using a left outer join) and identify which customers have placed an order before. 
select C.customer_id, O.order_id
from customers_om C
    left join orders O
    on C.customer_id = O.customer_id;
-- NULL determines which customer has not placed an order, so because there are no NULL values, we can conclude every customer has placed an order.

-- Q6: Statement to retrieve author's full name and book's isbn (using a left outer join) to identify which authors have not written a book. 
select first_name || ' ' || last_name AS "Full Name", BA.isbn
from author A
    left join book_author BA
    on A.aid = BA.aid;
-- Katie Williams and John Williams have not written a book.