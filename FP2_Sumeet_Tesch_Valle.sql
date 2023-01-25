/*
Name: Ankita Sumeet, Jacob Tesch, Amanda Valle
Assignment Number: Final Project 2
Date: 4/28/21
Section:  your  class  section  (9:30 – 10:45)
*/


-- Q1: Update days_borrowed column with the number of days a book was borrowed 
-- Q1: Write a SQL query to retrieve the title, type, and days_borrowed for books not borrowed in the standard 7 days 

UPDATE LTRANSACTION
SET DAYS_BORROWED = DATE_RETURNED - DATE_BORROWED;

SELECT TITLE, TYPE, DAYS_BORROWED
FROM LBOOK 
    JOIN LTRANSACTION 
    ON LBOOK.BID = LTRANSACTION.BID
WHERE DAYS_BORROWED <> 7
ORDER BY DAYS_BORROWED, TITLE;

-- Q2: Write a report that shows members who have not borrowed any books since they joined the library
-- Q2: Retrieve customer's first name, last name, and emails to prepare a book promotion 

SELECT F_NAME, L_NAME, C_EMAIL
FROM LMEMBER
WHERE MID IN ( SELECT MID FROM LMEMBER
                MINUS
              SELECT MID FROM LTRANSACTION );

-- Q3: Write an employee report that shows all full-time employees 
-- Q3: Display full name and hourly rate in the order of their last names 

SELECT F_NAME ||' ' || L_NAME AS "Full Name", ROUND(E_HRATE, 0) AS E_HRATE
FROM LEMPLOYEE 
WHERE E_STATUS = 'Full-Time'
ORDER BY L_NAME;

-- Q4: Create a non-updateable view LIB_V that contains... 
-- Q4: f_name, l_name, c_phone, c_email, and category of LMEMBER table   
-- Q4: TID, date_borrowed, date_due, and date_returned of LTRANSACTION table   
-- Q4: BID and title of LBOOK table

CREATE OR REPLACE VIEW LIB_V (F_NAME, L_NAME, C_PHONE, C_EMAIL, CATEGORY, TID, DATE_BORROWED, DATE_DUE, DATE_RETURNED, BID, TITLE) AS
SELECT LMEMBER.F_NAME, LMEMBER.L_NAME, LMEMBER.C_PHONE, LMEMBER.C_EMAIL, LMEMBER.CATEGORY, TID, DATE_BORROWED, DATE_DUE, DATE_RETURNED, LBOOK.BID, TITLE
FROM LEMPLOYEE 
    JOIN LMEMBER 
    ON LEMPLOYEE.EID = LMEMBER.EID 
    JOIN LTRANSACTION 
    ON LTRANSACTION.MID = LMEMBER.MID 
    JOIN LBOOK 
    ON LTRANSACTION.BID = LBOOK.BID
WITH READ ONLY;

-- Q5: Use LIB_V to create an overdue report that shows full name, category, title, date borrowed, date due, and number of days overdue 
-- Q5: Sort by number of days overdue and last name 
SELECT F_NAME ||' ' || L_NAME AS "Full Name", CATEGORY, TITLE, DATE_BORROWED, DATE_DUE, TO_DATE('31-MAR-21', 'DD-MM-YY') - DATE_DUE AS "Days Overdue"
FROM LIB_V
WHERE DATE_RETURNED IS NULL;

-- Q6: PL/SQL block that defines four variables, two separate SQL statements, and a decision making structure 

SET SERVEROUTPUT ON;

DECLARE

    NUM_IT_BOOKS NUMBER;
    NUM_SCIENCE_BOOKS NUMBER;
    IT_MORE NUMBER;
    SCIENCE_MORE NUMBER;
    
BEGIN

    SELECT COUNT(TYPE) INTO NUM_IT_BOOKS FROM LBOOK WHERE BID IN ( SELECT BID FROM LBOOK INTERSECT SELECT BID FROM LTRANSACTION ) AND TYPE = 'IT';
    SELECT COUNT(TYPE) INTO NUM_SCIENCE_BOOKS FROM LTRANSACTION JOIN LBOOK ON LBOOK.BID = LTRANSACTION.BID WHERE LTRANSACTION.BID IN (SELECT BID FROM LTRANSACTION INTERSECT SELECT BID FROM LBOOK ) AND TYPE = 'Science';
    
    IT_MORE := (NUM_IT_BOOKS - NUM_SCIENCE_BOOKS);
    SCIENCE_MORE := (NUM_SCIENCE_BOOKS - NUM_IT_BOOKS);
    
    IF NUM_IT_BOOKS > NUM_SCIENCE_BOOKS THEN 
        DBMS_OUTPUT.PUT_LINE( 'There is/are '|| IT_MORE || ' more IT book(s) borrowed than Science books!');
    ELSIF NUM_IT_BOOKS = NUM_SCIENCE_BOOKS THEN 
        DBMS_OUTPUT.PUT_LINE( 'There is an equal amount of IT and Science books borrowed!');
    ELSIF NUM_SCIENCE_BOOKS > NUM_IT_BOOKS THEN 
        DBMS_OUTPUT.PUT_LINE( 'There is/are '|| SCIENCE_MORE || ' more Science book(s) borrowed than IT books!');
    END IF;
    
EXCEPTION 

    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Unexpected error in the script');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

