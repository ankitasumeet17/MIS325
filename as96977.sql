select Title, P_name, BookType
from book 
    inner join publisher
    on book.pid = publisher.pid;

select Title, book.PID, p_state
from book 
inner join publisher
on book.pid = publisher.pid
where p_name = 'Star Publishing'
order by book.PID, p_state;

SELECT Title, BookType, First_Name, Last_Name
FROM BOOK B 
    JOIN BOOK_AUTHOR BA 
    ON B.ISBN =BA.ISBN
    JOIN AUTHOR A
    ON BA.AID =A.AID
    ORDER BY Title, Last_Name;
    
-- exercise 
select customer_first_name 

-- pg 8 triple join , ,in class exercise 
select Title, P_name, AID
from book b
    join publisher p
    on b.pid = p.pid
    join book_author ba
    on b.isbn = ba.isbn
order by P_name, Title, AID;

-- joining 4 tables
select customer_first_name, shipped_date, item_id
from customers_om C
    join orders O 
    on C.customer_id = O.customer_id 
    join order_details OD
    on O.order_id = OD.order_id
where shipped_date < '01-Jan-13'
order by shipped_date DESC;

-- EX pg.13 ,, in class 
select first_name || ' ' || last_name AS "author", a_city, AB.ISBN
from book_author AB -- left 
    right join author A -- right 
    on AB.aid = A.aid;
    
-- old joining method 
select title, P_name
from book, publisher
where book.PID = publisher.PID;

-- left outer join ,, publisher is left table (P_name is the column)
-- get every publisher name, some with null if not published a book
-- flip tables: get all books, with the correposning publishers 
select P_name, title
from publisher P
    left join book B
    on P.pid = B.pid;

select P_name, title
from book B
    left join publisher P
    on B.pid = P.pid;

-- right outer join ,, publisher is left table (P_name is the column)
-- filter it to be null
select P_name, title
from book B
    right join publisher P
    on B.pid = P.pid
where title is null;

-- full join example


-- USING
select Title, P_name
from book
    join Publisher using (PID)
where PID = 'P11';

-- self join 
select distinct p1.p_name, p1.p_state, p1.p_city
from publisher p1 join publisher p2 
on (p1.p_city = p2.p_city) and
    (p1.p_state = p2.p_state) and
    (p1.pid = p2.pid) 
order by p1.p_state, p1.p_city;

-- Coding string expressions w/ column alias
-- regardless of uppercase/lowercase, the alias output will be all uppercase 
SELECT 'ISBN is ' || ISBN || ' and book title is "' || TITLE || '".' AS INFORMATION
FROM BOOK;

-- arithmetic calculations using dual table
SELECT 'test dual' as "test string", 5-3*2 AS test_calculation, SYSDATE AS test_date
FROM Dual;

--ALL

-- TO_CHAR scalar function 
SELECT 'The book "' ||Title|| '" was published on '|| 
    TO_CHAR(pubdate, 'MM/DD/YYYY') AS SENTENCE
FROM BOOK;

-- ROWNUM
select *
from book
where rownum < 4;
-- <4 , <=3, rownum >= 1 and rownum <= 3, between 1 and 3 

select booktype, Title, ISBN
from book
order by 1, 2;

select distinct booktype, PID
from book;

select Title, PID
from book
where booktype = 'Children'
order by Title;

select Title, P_name, BookType
from book inner join publisher
on book.pid = publisher.pid;

select Title, book.PID, p_state
from book inner join publisher
on book.pid = publisher.pid
where p_name = 'Star Publishing'
order by book.PID, p_state;

SELECT Title, BookType, First_Name, Last_Name
FROM BOOK B 
    JOIN BOOK_AUTHOR BA 
    ON B.ISBN =BA.ISBN
    JOIN AUTHOR A
    ON BA.AID =A.AID
    ORDER BY Title, Last_Name;
    
/* exercise */
select customer_first_name 

/* pg 8 triple join , ,in class exercise */
select Title, P_name, AID
from book b
    join publisher p
    on b.pid = p.pid
    join book_author ba
    on b.isbn = ba.isbn
order by P_name, Title, AID;

-- SYSDATE , ROUND scalar functions 
SELECT TITLE, PUBDATE, ROUND(SYSDATE - PubDate) AS "Days Published"
FROM Book
ORDER BY "Days Published" DESC;

-- SUBSTR(column name, starting position, number of characters to return) scalar functions 
SELECT SUBSTR(TITLE, 1, 5) AS shortened 
FROM BOOK;

-- MOD scalar function (enter two numbers and it will divide them to produce the remainder)
SELECT MOD(18, 4)
FROM BOOK;

-- BETWEEN
SELECT Title, PubDate
FROM Book 
WHERE PubDate
BETWEEN '01-JAN-18' AND '01-DEC-18';

-- table
SET DEFINE OFF;
BEGIN
  --DROP TABLES
    EXECUTE IMMEDIATE 'DROP TABLE BOOK_ORDER_DETAIL';
    EXECUTE IMMEDIATE 'DROP TABLE BOOK_ORDER';
    EXECUTE IMMEDIATE 'DROP TABLE BOOK_CUSTOMER';
    
EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('');
END;
/

/* Type your DDL statements to create BOOK_CUSTOMER table below */
CREATE TABLE BOOK_CUSTOMER
(
    CID         CHAR(5),
    CFirstName  VARCHAR2(50)    NOT NULL,
    CLastName   VARCHAR2(50)    NOT NULL,
    CAddress    VARCHAR2(100)   NOT NULL,
    CCity       VARCHAR2(70)    NOT NULL,
    CState      VARCHAR2(2)     DEFAULT 'TX',
    CZip        VARCHAR2(10)    NOT NULL,
    CPhone      CHAR(12),
    CDOB        date,
    CONSTRAINT BOOK_CUSTOMER_pk PRIMARY KEY (CID)
)

CREATE TABLE B_ORDER
(
    OrderID     CHAR(8)     NOT NULL,
    OrderDate   DATE        
    CID         CHAR(5)     NOT NULL, 
    CONSTRAINT B_ORDER_pk PRIMARY KEY (OrderID)
);

-- ALTER COLUMNS
ALTER TABLE B_ORDER
ADD ShipDate DATE;


--ALTER CONSTRAINTS
ALTER TABLE B_ORDER
ADD CONSTRAINT B_ORDER_fk_BOOK_CUSTOMER
FOREIGN KEY (CID) REFERENCES BOOK_CUSTOMER(CID);

ALTER TABLE B_ORDER
MODIFY OrderDate
CONSTRAINT B_ORDER_OrderDate_nn NOT NULL;

--ADDITIONAL CONSTRAINTS
RENAME B_ORDER TO BOOK_ORDER;

-- many to many table 
--pk comes from book_order and book (composite primary key)
CREATE TABLE BOOK_ORDER_DETAIL
(
    OrderID     CHAR(8)         
    ISBN        CHAR(17),
    Quantity    NUMBER      CHECK (Quantity > 0 and Quantity < 7)
    CONSTRAINT BOOK_ORDER_DETAIL_pk PRIMARY KEY (OrderID,ISBN),
    CONSTRAINT BOOK_ORDER_DETAIL_fk_BOOK_ORDER
        FOREIGN KEY (OrderID) REFERENCES BOOK_ORDER (OrderID)
    CONSTRAINT BOOK_ORDER_DETAIL_fk_BOOK
        FOREIGN KEY (ISBN) REFERENCES BOOK (ISBN)
);

/* benefit of using column constraint for PK and FK:
    - table, easy to look up primary key
    - look up constraint based on name of constraint */
    
CREATE INDEX BOOK_CUSTOMER_CLastName_ix ON BOOK_CUSTOMER(CLastName);

CREATE SEQUENCE BOOK_ORDER_DETAIL_id_seq;

-- drop primary constraint 
ALTER TABLE BOOK_ORDER_DETAIL
DROP CONSTRAINT BOOK_ORDER_DETAIL_pk;

-- add new column w primary constraint
ALTER TABLE BOOK_ORDER_DETAIL
ADD BOD_ID NUMBER PRIMARY KEY;

ALTER TABLE table_name
DISABLE CONSTRAINT constraint_name;

SELECT * 
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'BOOK_CUSTOMER';

INSERT INTO BOOK_CUSTOMER    
    (CID, CFirstName, CLastName, CAddress, CCity, CZip, CState,CPhone, CDOB)
VALUES 
    ('B101', 'Mary', 'William', '123 Apple St', 'Austin', '78788', DEFAULT, '512-555-3322', NULL);
COMMIT;

INSERT INTO BOOK_CUSTOMER
VALUES ('B102', 'John', 'Jacobson', '234 Pear St', 'San Francisco', 'CA', '94102', NULL, '02-Feb-1998');

SELECT * 
FROM BOOK_CUSTOMER;

INSERT INTO book_order
VALUES ('OR01', SYSDATE, 'B101', NULL);

-- create table using embedded select statement and then compare using select *
CREATE TABLE book_copy AS
SELECT * 
from BOOK 
WHERE BookType= 'Children';

SELECT * 
from book_copy; 

CREATE TABLE PUBLISHER_copy AS
SELECT * 
from PUBLISHER;

select *
from PUBLISHER;

select *
from PUBLISHER_copy;

INSERT INTO book_copy (ISBN, TITLE, PID, PUBDATE, BOOKTYPE, PRICE)
SELECT ISBN, TITLE, PID, PUBDATE, BOOKTYPE, PRICE
FROM BOOK
WHERE BookType = 'Self-help';

update book_copy
set BookType = 'Humor'
where isbn = '789-7-789012-78-7';

select * from book_copy;

update book_copy
set BookType = 'Humor';

rollback;

update book_copy
set BookType = 'Humor'
where isbn = '789-7-789012-78-7';

select * from book_copy;

CREATE VIEW CUSTOMER_V AS
SELECT * FROM CUSTOMER;

SELECT * FROM CUSTOMER_V;

SELECT F_NAME, L_NAME, C_STATE
FROM CUSTOMER_V;

CREATE VIEW BOOK_V (ISBN, "Book Title", PUBDATE, "BOOK TYPE") AS
    SELECT ISBN, TITLE, PUBDATE, BOOKTYPE
    FROM BOOK
    WHERE BOOKTYPE = 'Children';
    
SELECT * FROM BOOK_V;

SELECT * FROM ORDERS;

CREATE VIEW ORDER_V ("ORDER ID", "CUSTOMER ID", "ORDER DATE", "SHIPPED DATE") AS
    SELECT ORDER_ID, CUSTOMER_ID, ORDER_DATE, SHIPPED_DATE
    FROM ORDERS
    WHERE ORDER_DATE BETWEEN '01-JAN-2013' AND '31-DEC-2013';

SELECT * FROM ORDER_V;

SELECT ISBN, TITLE
FROM BOOK_COPY;

SELECT ISBN, TITLE
FROM BOOK;

SELECT ISBN, TITLE
FROM BOOK -- 7 ROWS
INTERSECT 
SELECT ISBN, TITLE
FROM BOOK_COPY; -- 3 ROWS


SELECT ISBN, TITLE
FROM BOOK_COPY -- 3 ROWS
MINUS
SELECT ISBN, TITLE
FROM BOOK; -- 7 ROWS
-- RESULT: 0 ROWS

-- Which column has the larger number?
SELECT COUNT(DISTINCT CUSTOMER_ID) AS "Unique Customers", COUNT(ORDER_ID) AS "Number of Orders"
FROM ORDERS
WHERE ORDER_DATE >= '01-JAN-2014'; 

select f_name, l_name, c_dob
from customer;

select count(order_date)
from orders;

where customer_id in (select customer_id from customers_om where customer_state = 'NY');

SELECT customer_ID, count(order_date)
FROM orders 
ORDER BY customer_id;






















































