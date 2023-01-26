/*
Name: Ankita Sumeet
Assignment Number: 6
Date: 4/23/21
Section: 9:30 – 10:45
*/

-- Q1: Write PL/SQL block to output "I like this homework!". Use while loop to output statement 3 times and initialize variable to begin at 2. 

SET SERVEROUTPUT ON;

DECLARE
    
    i INTEGER := 2;

BEGIN 

    WHILE i <= 4 LOOP
    DBMS_OUTPUT.PUT_LINE('I like this homework!');
    i := i+1;
    END LOOP;
    
END;
/

-- Q2: Retrieve artist of the album 'Etcetera' using inner query and write an outer query to retrieve artist and unit_price. 

SELECT ARTIST, UNIT_PRICE
FROM ITEMS
WHERE ARTIST IN
    (SELECT ARTIST
    FROM ITEMS
    WHERE TITLE = 'Etcetera');
    
-- Q3: Rewrite the query above using JOIN and WHERE. Retrieve order_id, item_id, and order_qty without using a subquery.

SELECT OD.ORDER_ID, OD.ITEM_ID, OD.ORDER_QTY, ARTIST, UNIT_PRICE, TITLE
FROM ORDER_DETAILS OD
JOIN ITEMS I
ON I.ITEM_ID = OD.ITEM_ID
WHERE TITLE = 'Etcetera';

-- Q4: Retrieve all authors who have published total number of books more than the minimum number. Output AID and total book count grouped by AID. 

SELECT AID, COUNT(*)
FROM BOOK_AUTHOR 
HAVING COUNT(*)  >  (SELECT MIN(COUNT(ISBN))
                     FROM BOOK_AUTHOR
                     GROUP BY AID)
GROUP BY AID;

-- Q5: Declare a variable, give it a name, and make the type similar to book title. Select the only award-winning book and write an output statement. 

SET SERVEROUTPUT ON;

DECLARE

    bookTitle BOOK.TITLE%TYPE;

BEGIN 

    SELECT TITLE
    INTO bookTitle
    FROM BOOK
    WHERE AWARD != 'NULL';
    
    DBMS_OUTPUT.PUT_LINE( bookTitle || ' is the only award winning book in Mr. Bokom''s collections.');

EXCEPTION
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('An unexpected exception occurred.');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        
END;
/

-- Q6: Retrieve the total quantity of albums published by artist. Use CASE statement, substitution variable, and declare vaiable for total quantity. 

SET SERVEROUTPUT ON;

DECLARE

    totalQty NUMBER;

BEGIN 

    SELECT COUNT(*)
    INTO totalQty
    FROM ITEMS 
    WHERE ARTIST IN 
        (SELECT ARTIST
        FROM ITEMS
        WHERE ARTIST = '&artist');
        
    CASE totalQty
        WHEN 1 THEN 
            DBMS_OUTPUT.PUT_LINE('The artist has published one album.');
        WHEN 2 THEN
            DBMS_OUTPUT.PUT_LINE('The artist has published two albums.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('The artist has published more than two albums.');
    END CASE;
    
EXCEPTION 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('An unexpected exception occurred.');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);

END;
/
