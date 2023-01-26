/*
Name: Ankita Sumeet, Jacob Tesch, Amanda Valle
Assignment Number: 4
Date: 3/16/21
Section:  your  class  section  (9:30 – 10:45)
*/

SET DEFINE OFF;
BEGIN
  --DROP TABLES
    execute immediate 'drop table Family_Room cascade constraints';
    execute immediate 'drop table Beach_Front cascade constraints';
    execute immediate 'drop table Friends_Family cascade constraints';
    execute immediate 'drop table Reservation cascade constraints';
    execute immediate 'drop table Basic_Room cascade constraints';
    execute immediate 'drop table Customer cascade constraints';   
EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('');
END;
/

--Start writing CREATE TABLE statements and INSERT TABLE statements
CREATE TABLE Customer
(
    CID                 CHAR(5)         PRIMARY KEY,
    F_NAME              VARCHAR2(50)    NOT NULL,
    L_NAME              VARCHAR(50)     NOT NULL, 
    C_ADDRESS           VARCHAR2(100)   NOT NULL,
    C_CITY              VARCHAR2(70)    NOT NULL,
    C_STATE             VARCHAR2(2)     DEFAULT 'TX',
    C_ZIP               VARCHAR(10)     NOT NULL,
    C_DOB               DATE,
    C_OCCUPATION        VARCHAR2(100)   NOT NULL,
    C_CREDIT_CARD_NUM   VARCHAR(19)     NOT NULL
);
COMMIT;

CREATE TABLE Basic_Room
(
    ROOM_NUMBER         CHAR(5)         PRIMARY KEY,
    ROOM_TYPE           VARCHAR(20)     DEFAULT 'Basic Room',
    ROOM_SIZE           VARCHAR(10)     NOT NULL,
    MAXIMUM_OCCUPANCY   NUMBER          NOT NULL
);
COMMIT;

CREATE TABLE Reservation
(
    RID                 CHAR(5)     NOT NULL,
    CID                 CHAR(5)     NOT NULL,
    ROOM_NUMBER         CHAR(5)     NOT NULL,
    BOOKING_DATE        DATE,
    ARRIVAL_DATE        DATE,
    DEPARTURE_DATE      DATE,
    STATUS              VARCHAR(15) DEFAULT 'Reserved',
CONSTRAINT Reservation_pk
    PRIMARY KEY (RID),
CONSTRAINT Reservation_fk_Customer
    FOREIGN KEY (CID) REFERENCES Customer (CID),
CONSTRAINT Reservation_fk_Basic_Room
    FOREIGN KEY (ROOM_NUMBER) REFERENCES Basic_Room (ROOM_NUMBER)
);
COMMIT;

CREATE TABLE Friends_Family
(
    FFID            CHAR(5)         NOT NULL,
    CID             CHAR(5)         NOT NULL,
    FIRST_NAME      VARCHAR(50)     NOT NULL,
    LAST_NAME       VARCHAR(50)     NOT NULL,
    DOB             DATE,
    RELATIONSHIP    VARCHAR(25)     NOT NULL,
CONSTRAINT Friends_Family_pk
    PRIMARY KEY (FFID),
CONSTRAINT Friends_Family_fk_Customer
    FOREIGN KEY (CID) REFERENCES Customer (CID)
);
COMMIT;    
    
CREATE TABLE Beach_Front
(
    ROOM_NUMBER     CHAR(5)         PRIMARY KEY,
    TURN_DOWN       VARCHAR(5)      NOT NULL,
    KITCHENETTE     VARCHAR(5)      NOT NULL,
CONSTRAINT Beach_Front_fk_Basic_Room
    FOREIGN KEY (ROOM_NUMBER) REFERENCES Basic_Room (ROOM_NUMBER)
);
COMMIT;

CREATE TABLE Family_Room
(
    ROOM_NUMBER     CHAR(5)         PRIMARY KEY,
    CRIB            VARCHAR2(5)     DEFAULT 'no',
CONSTRAINT Family_Room_fk_Basic_Room
    FOREIGN KEY (ROOM_NUMBER) REFERENCES Basic_Room (ROOM_NUMBER)
);
COMMIT;

insert into Customer
    (CID, F_NAME, L_NAME, C_ADDRESS, C_CITY, C_STATE, C_ZIP, C_DOB, C_OCCUPATION, C_CREDIT_CARD_NUM)
values
    ('C001', 'John', 'Rex', '11, Rose Street', 'Austin', 'TX', '78771', '12-MAR-71', 'nurse', '5489-xxxx-xxxx');
insert into Customer
    (CID, F_NAME, L_NAME, C_ADDRESS, C_CITY, C_STATE, C_ZIP, C_DOB, C_OCCUPATION, C_CREDIT_CARD_NUM)
values
    ('C002', 'Dixie', 'Fire', '9, World Drive', 'Round Rock', 'TX', '78665', '12-MAR-98', 'doctor', '4897-xxxx-xxxx');
insert into Customer
    (CID, F_NAME, L_NAME, C_ADDRESS, C_CITY, C_STATE, C_ZIP, C_DOB, C_OCCUPATION, C_CREDIT_CARD_NUM)
values
    ('C003', 'Kevin', 'Wind', '87, High Street', '(null)', 'AL', '54789', '11-APR-85', 'teacher', '1234-xxxx-xxxx');
insert into Customer
    (CID, F_NAME, L_NAME, C_ADDRESS, C_CITY, C_STATE, C_ZIP, C_DOB, C_OCCUPATION, C_CREDIT_CARD_NUM)
values
    ('C004', 'Mary', 'Nice', '66, Crime Drive', '(null)', 'FL', '45745', '12-OCT-00', 'police', '6548-xxxx-xxxx');
insert into Customer
    (CID, F_NAME, L_NAME, C_ADDRESS, C_CITY, C_STATE, C_ZIP, C_DOB, C_OCCUPATION, C_CREDIT_CARD_NUM)
values
    ('C005', 'Ren', 'Hatsuki', '9875, Flower Street', '(null)', 'MS', '89456', '25-DEC-99', 'analyst', '4567-xxxx-xxxx');
insert into Customer
    (CID, F_NAME, L_NAME, C_ADDRESS, C_CITY, C_STATE, C_ZIP, C_DOB, C_OCCUPATION, C_CREDIT_CARD_NUM)
values
    ('C006', 'Sam', 'Rock', '11, Tech Drive', 'Pflugervile', 'TX', '78660', '08-MAY-65', 'engineer', '7894-xxxx-xxxx');
insert into Customer
    (CID, F_NAME, L_NAME, C_ADDRESS, C_CITY, C_STATE, C_ZIP, C_DOB, C_OCCUPATION, C_CREDIT_CARD_NUM)
values
    ('C007', 'Debby', 'Xia', '1234, Honey View', '(null)', 'CA', '78945', '30-SEP-89', 'consultant', '4578-xxxx-xxxx');
insert into Customer
    (CID, F_NAME, L_NAME, C_ADDRESS, C_CITY, C_STATE, C_ZIP, C_DOB, C_OCCUPATION, C_CREDIT_CARD_NUM)
values
    ('C008', 'Barbara', 'Water', '546, Last Drive', '(null)', 'CO', '45678', '12-NOV-54', 'professor', '6321-xxxx-xxxx');
COMMIT;

insert into Basic_Room
    (ROOM_NUMBER, ROOM_TYPE, ROOM_SIZE, MAXIMUM_OCCUPANCY)
values
    ('RN001', 'Basic Room', '65 m2', '2');
insert into Basic_Room
    (ROOM_NUMBER, ROOM_TYPE, ROOM_SIZE, MAXIMUM_OCCUPANCY)
values
    ('RN002', 'Family Room', '85 m2', '4');
insert into Basic_Room
    (ROOM_NUMBER, ROOM_TYPE, ROOM_SIZE, MAXIMUM_OCCUPANCY)
values
    ('RN003', 'Beach Room', '75 m2', '3');
insert into Basic_Room
    (ROOM_NUMBER, ROOM_TYPE, ROOM_SIZE, MAXIMUM_OCCUPANCY)
values
    ('RN004', 'Family Room', '75 m2', '3');
insert into Basic_Room
    (ROOM_NUMBER, ROOM_TYPE, ROOM_SIZE, MAXIMUM_OCCUPANCY)
values
    ('RN005', 'Basic Room', '65 m2', '2');
insert into Basic_Room
    (ROOM_NUMBER, ROOM_TYPE, ROOM_SIZE, MAXIMUM_OCCUPANCY)
values
    ('RN006', 'Beach Room', '85 m2', '4');
COMMIT;

insert into Reservation
    (RID, CID, Room_Number, Booking_Date, Arrival_Date, Departure_Date, Status)
values
    ('R001', 'C007', 'RN001', '06-JAN-21', '23-MAR-21', '25-MAR-21', 'Reserved');
insert into Reservation
    (RID, CID, Room_Number, Booking_Date, Arrival_Date, Departure_Date, Status)
values
    ('R002', 'C007', 'RN005', '07-JAN-21', '30-MAR-21', '01-APR-21', 'Reserved');
insert into Reservation
    (RID, CID, Room_Number, Booking_Date, Arrival_Date, Departure_Date, Status)
values
    ('R003', 'C002', 'RN003', '21-JAN-21', '30-JUN-21', '05-JUL-21', 'Reserved');
insert into Reservation
    (RID, CID, Room_Number, Booking_Date, Arrival_Date, Departure_Date, Status)
values
    ('R004', 'C003', 'RN002', '09-FEB-21', '12-MAR-21', '14-MAR-21', 'Reserved');
insert into Reservation
    (RID, CID, Room_Number, Booking_Date, Arrival_Date, Departure_Date, Status)
values
    ('R005', 'C004', 'RN006', '14-FEB-21', '01-MAR-21', '07-MAR-21', 'Reserved');
insert into Reservation
    (RID, CID, Room_Number, Booking_Date, Arrival_Date, Departure_Date, Status)
values
    ('R006', 'C006', 'RN004', '18-FEB-21', '18-MAY-21', '22-MAY-21', 'Reserved');
insert into Reservation
    (RID, CID, Room_Number, Booking_Date, Arrival_Date, Departure_Date, Status)
values
    ('R007', 'C008', 'RN006', '07-MAR-21', '07-MAR-21', '08-MAR-21', 'Reserved');
COMMIT;

insert into Friends_Family
    (FFID, CID, FIRST_NAME, LAST_NAME, DOB, RELATIONSHIP)
values
    ('FF001', 'C001', 'Jane', 'Jordan', '01-DEC-74', 'Wife');
insert into Friends_Family
    (FFID, CID, FIRST_NAME, LAST_NAME, DOB, RELATIONSHIP)
values
    ('FF002', 'C005', 'Antoine', 'Li', '05-SEP-00', 'Friend');
insert into Friends_Family
    (FFID, CID, FIRST_NAME, LAST_NAME, DOB, RELATIONSHIP)
values
    ('FF003', 'C006', 'Ismail', 'Berger', '29-JAN-80', 'Co-worker');
insert into Friends_Family
    (FFID, CID, FIRST_NAME, LAST_NAME, DOB, RELATIONSHIP)
values
    ('FF004', 'C002', 'Portia', 'Fire', '29-JAN-70', 'Mother');
COMMIT;

insert into Beach_Front
    (Room_Number, Turn_Down, Kitchenette)
values
    ('RN003', 'no', 'yes');
insert into Beach_Front
    (Room_Number, Turn_Down, Kitchenette)
values
    ('RN006', 'yes', 'yes');
COMMIT;

insert into Family_Room
    (ROOM_NUMBER, CRIB) 
values
    ('RN002', 'no');
insert into Family_Room
    (ROOM_NUMBER, CRIB) 
values
    ('RN004', 'yes');
COMMIT;

--Write your statement above this line.

SET DEFINE ON;

/* WHY DO WE DROP TABLES IN A PARTICULAR ORDER? 

If a table has a foreign key within its dataset, SQL will not allow 
us to drop this table due to the constraint. This is because another 
table owns this foreign key as its primary key. Therefore, we must
drop the tables that contain those foreign keys first. Only then can we drop 
the rest of the tables because dropping the table with the foreign key 
will also drop its constraints. */

/* QUESTION 1:
Write a SQL statement to retrieve customers DOB, full name, and full address who were born before
January 1st, 2020. Sort output by C_DOB. 

SELECT C_DOB, F_NAME || ' ' || L_NAME AS "Full Name", C_ADDRESS || ', ' || C_CITY || ', ' || C_STATE || ' ' || C_ZIP AS "Full Address"
FROM CUSTOMER
WHERE C_DOB < '01-JAN-2020'
ORDER BY C_DOB; */

/* WHAT ABOUT CREATING TABLE ORDER AND INSERTING DATA ORDER?

In order to create tables correctly, you must first start with your first
relationship table, in this case it would be Customer, and then work your way
down as the relationships of the tables calls for because you cannot have a 
foreign key be a primary key if that primary key does not exist first. 
Similarly, when inserting data it must be in order of the tables relationships
because you cannot insert data into a table that is yet to exist. This is like
dropping tables but in reverse. */

/* QUESTION 2:
Write a SQL statement to retrieve customers state, last name, and reservation status.
Sort the output on customers state, then last name. 
 
SELECT Customer.C_STATE, Customer.L_NAME, Reservation.STATUS
FROM CUSTOMER
    JOIN Reservation
    ON Customer.CID = Reservation.CID
ORDER BY CUSTOMER.C_STATE, Customer.L_NAME; */



























