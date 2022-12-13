/*

	
-----------------------------------------------------------------------------------------------------------------------------------

											Database Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------
*/

DROP DATABASE IF EXISTS NEW_WHEELS;
CREATE DATABASE NEW_WHEELS;
USE new_wheels;

/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Tables Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [3] Creating the tables:

DROP TABLE IF EXISTS vehicle_t;                          
CREATE TABLE vehicles_t (
	SHIPPER_ID INTEGER,
    SHIPPER_NAME VARCHAR(50),
	SHIPPER_CONTACT_DETAILS VARCHAR(30),
	PRODUCT_ID INTEGER,
	VEHICLE_MAKER VARCHAR(60),
	VEHICLE_MODEL VARCHAR(60),
    VEHICLE_COLOR VARCHAR(60),
    VEHICLE_MODEL_YEAR INTEGER,
    VEHICLE_PRICE DECIMAL(14,2),
	QUANTITY INTEGER,
	DISCOUNT DECIMAL(4,2),
	CUSTOMER_ID VARCHAR(25),
    CUSTOMER_NAME VARCHAR(25),
    GENDER VARCHAR(15),
	JOB_TITLE VARCHAR(50),
	PHONE_NUMBER VARCHAR(20),
	EMAIL_ADDRESS VARCHAR(50),
	CITY VARCHAR(25),
	COUNTRY VARCHAR(40),
	STATE VARCHAR(40),
	CUSTOMER_ADDRESS VARCHAR(50),
	ORDER_DATE DATE,
    ORDER_ID VARCHAR(25),
	SHIP_DATE DATE,
	SHIP_MODE VARCHAR(25),
	SHIPPING VARCHAR(30),
	POSTAL_CODE INTEGER,
	CREDIT_CARD_TYPE VARCHAR(40),
	CREDIT_CARD_NUMBER BIGINT,
	CUSTOMER_FEEDBACK VARCHAR(20),
	QUARTER_NUMBER INTEGER,
    PRIMARY KEY (CUSTOMER_ID, ORDER_ID, SHIPPER_ID, PRODUCT_ID)
    );
    

 CREATE TABLE temp_t (
	SHIPPER_ID INTEGER,
    SHIPPER_NAME VARCHAR(50),
	SHIPPER_CONTACT_DETAILS VARCHAR(30),
	PRODUCT_ID INTEGER,
	VEHICLE_MAKER VARCHAR(60),
	VEHICLE_MODEL VARCHAR(60),
    VEHICLE_COLOR VARCHAR(60),
    VEHICLE_MODEL_YEAR INTEGER,
    VEHICLE_PRICE DECIMAL(14,2),
	QUANTITY INTEGER,
	DISCOUNT DECIMAL(4,2),
	CUSTOMER_ID VARCHAR(25),
    CUSTOMER_NAME VARCHAR(25),
    GENDER VARCHAR(15),
	JOB_TITLE VARCHAR(50),
	PHONE_NUMBER VARCHAR(20),
	EMAIL_ADDRESS VARCHAR(50),
	CITY VARCHAR(25),
	COUNTRY VARCHAR(40),
	STATE VARCHAR(40),
	CUSTOMER_ADDRESS VARCHAR(50),
	ORDER_DATE DATE,
    ORDER_ID VARCHAR(25),
	SHIP_DATE DATE,
	SHIP_MODE VARCHAR(25),
	SHIPPING VARCHAR(30),
	POSTAL_CODE INTEGER,
	CREDIT_CARD_TYPE VARCHAR(40),
	CREDIT_CARD_NUMBER BIGINT,
	CUSTOMER_FEEDBACK VARCHAR(20),
	QUARTER_NUMBER INTEGER,
    PRIMARY KEY (CUSTOMER_ID, ORDER_ID, SHIPPER_ID, PRODUCT_ID)
    );
    
    
CREATE TABLE new_wheels_customer_t (
	CUSTOMER_ID VARCHAR(25),
    CUSTOMER_NAME VARCHAR(25),
    GENDER VARCHAR(15),
	JOB_TITLE VARCHAR(50),
	PHONE_NUMBER VARCHAR(20),
	EMAIL_ADDRESS VARCHAR(50),
	CITY VARCHAR(25),
	COUNTRY VARCHAR(40),
	STATE VARCHAR(40),
	CUSTOMER_ADDRESS VARCHAR(50),
	POSTAL_CODE INTEGER,
	CREDIT_CARD_TYPE VARCHAR(40),
	CREDIT_CARD_NUMBER BIGINT,
    PRIMARY KEY (CUSTOMER_ID)
);


CREATE TABLE new_wheels_order_t (
	ORDER_ID VARCHAR(25),
    CUSTOMER_ID VARCHAR(25),
    SHIPPER_ID INTEGER,
	PRODUCT_ID INTEGER,
	QUANTITY INTEGER,
    VEHICLE_PRICE DECIMAL(14,2),
	ORDER_DATE DATE,
	SHIP_DATE DATE,
	DISCOUNT DECIMAL(4,2),
	SHIP_MODE VARCHAR(25),
	SHIPPING VARCHAR(30),
	CUSTOMER_FEEDBACK VARCHAR(20),
	QUARTER_NUMBER INTEGER,
    PRIMARY KEY (ORDER_ID)
);
 

CREATE TABLE new_wheels_shipper_t (
	SHIPPER_ID INTEGER,
	SHIPPER_NAME VARCHAR(50),
	SHIPPER_CONTACT_DETAILS VARCHAR(30),
    PRIMARY KEY (SHIPPER_ID)
);


CREATE TABLE new_wheels_product_t (
	PRODUCT_ID INTEGER,
	VEHICLE_MAKER VARCHAR(60),
	VEHICLE_MODEL VARCHAR(60),
	VEHICLE_COLOR VARCHAR(60),
	VEHICLE_MODEL_YEAR INTEGER,
	VEHICLE_PRICE DECIMAL(14,2),
    PRIMARY KEY (PRODUCT_ID)
);


/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Stored Procedures Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [4] Creating the Stored Procedures:

DELIMITER $$ 
CREATE PROCEDURE vehicles_p()
BEGIN
	INSERT INTO new_wheels.vehicles_t (
	SHIPPER_ID,
    SHIPPER_NAME,
	SHIPPER_CONTACT_DETAILS,
	PRODUCT_ID,
	VEHICLE_MAKER,
	VEHICLE_MODEL,
    VEHICLE_COLOR,
    VEHICLE_MODEL_YEAR,
    VEHICLE_PRICE,
	QUANTITY,
	DISCOUNT,
	CUSTOMER_ID,
    CUSTOMER_NAME,
    GENDER,
	JOB_TITLE,
	PHONE_NUMBER,
	EMAIL_ADDRESS,
	CITY,
	COUNTRY,
	STATE,
	CUSTOMER_ADDRESS,
	ORDER_DATE,
    ORDER_ID,
	SHIP_DATE,
	SHIP_MODE,
	SHIPPING,
	POSTAL_CODE,
	CREDIT_CARD_TYPE,
	CREDIT_CARD_NUMBER,
	CUSTOMER_FEEDBACK,
	QUARTER_NUMBER
)
SELECT * FROM new_wheels.temp_t; 
END;


CREATE PROCEDURE new_wheels_customer_p()
BEGIN
       INSERT INTO new_wheels_customer_t (
	CUSTOMER_ID,
    CUSTOMER_NAME,
    GENDER,
	JOB_TITLE,
	PHONE_NUMBER,
	EMAIL_ADDRESS,
	CITY,
	COUNTRY,
	STATE,
	CUSTOMER_ADDRESS,
	POSTAL_CODE,
	CREDIT_CARD_TYPE,
	CREDIT_CARD_NUMBER
 )
 SELECT DISTINCT
	CUSTOMER_ID,
    CUSTOMER_NAME,
    GENDER,
	JOB_TITLE,
	PHONE_NUMBER,
	EMAIL_ADDRESS,
	CITY,
	COUNTRY,
	STATE,
	CUSTOMER_ADDRESS,
	POSTAL_CODE,
	CREDIT_CARD_TYPE,
	CREDIT_CARD_NUMBER
FROM vehicles_t WHERE CUSTOMER_ID NOT IN (SELECT CUSTOMER_ID FROM new_wheels_customer_t);
END;


CREATE PROCEDURE new_wheels_order_p(qrtnum INTEGER)
BEGIN
       INSERT INTO new_wheels_order_t (
	ORDER_ID,
    CUSTOMER_ID,
    SHIPPER_ID,
	PRODUCT_ID,
	QUANTITY,
    VEHICLE_PRICE,
	ORDER_DATE,
	SHIP_DATE,
	DISCOUNT,
	SHIP_MODE,
	SHIPPING,
	CUSTOMER_FEEDBACK,
	QUARTER_NUMBER
 )
 SELECT DISTINCT 
	ORDER_ID,
    CUSTOMER_ID,
    SHIPPER_ID,
	PRODUCT_ID,
	QUANTITY,
    VEHICLE_PRICE,
	ORDER_DATE,
	SHIP_DATE,
	DISCOUNT,
	SHIP_MODE,
	SHIPPING,
	CUSTOMER_FEEDBACK,
	QUARTER_NUMBER 
FROM vehicles_t WHERE QUARTER_NUMBER = qrtnum;
END;


CREATE PROCEDURE new_wheels_product_p(qrtnum INTEGER)
BEGIN
       INSERT INTO new_wheels_product_t (
	PRODUCT_ID,
	VEHICLE_MAKER,
	VEHICLE_MODEL,
	VEHICLE_COLOR,
	VEHICLE_MODEL_YEAR,
	VEHICLE_PRICE
 )
 SELECT DISTINCT 
		PRODUCT_ID,
	VEHICLE_MAKER,
	VEHICLE_MODEL,
	VEHICLE_COLOR,
	VEHICLE_MODEL_YEAR,
	VEHICLE_PRICE
FROM vehicles_t WHERE QUARTER_NUMBER = qrtnum;
END;


CREATE PROCEDURE new_wheels_shipper_p(qrtnum INTEGER)
BEGIN
	INSERT INTO new_wheels_shipper_t (
	SHIPPER_ID,
	SHIPPER_NAME,
	SHIPPER_CONTACT_DETAILS
 )
 SELECT DISTINCT 
	SHIPPER_ID,
	SHIPPER_NAME,
	SHIPPER_CONTACT_DETAILS
FROM vehicles_t WHERE QUARTER_NUMBER = qrtnum;
END;





/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Data Ingestion
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [5] Ingesting the data:
-- Note: Revisit the video: Week-2: Data Modeling and Architecture: Ingesting data into the main table

TRUNCATE temp_t;

LOAD DATA LOCAL INFILE '/Users/golaolorun/Desktop/new_wheels_sales_qtr_4.csv'
INTO TABLE temp_t
FIELDS TERMINATED by ','
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CALL vehicles_p();
CALL new_wheels_customer_p();
CALL new_wheels_product_p(4);
CALL new_wheels_shipper_p(4);
CALL new_wheels_order_p(4);


/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Views Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [6] Creating the views:

DROP VIEW IF EXISTS veh_ord_cust_v;
CREATE VIEW veh_ord_cust_v AS
    SELECT
    cust.CUSTOMER_NAME,
	cust.CUSTOMER_ID,
	cust.CITY,
	cust.STATE,
	cust.CREDIT_CARD_TYPE,
	ord.ORDER_ID,
    ord.SHIPPER_ID,
	ord.PRODUCT_ID,
	ord.QUANTITY,
    ord.VEHICLE_PRICE,
	ord.ORDER_DATE,
	ord.SHIP_DATE,
	ord.DISCOUNT,
	ord.CUSTOMER_FEEDBACK,
	ord.QUARTER_NUMBER
FROM new_wheels_customer_t cust 
	INNER JOIN new_wheels_order_t ord
	    ON cust.CUSTOMER_ID = ord.CUSTOMER_ID;
 
 
DROP VIEW IF EXISTS veh_prod_cust_v;
CREATE VIEW veh_prod_cust_v AS
	SELECT
	cust.CUSTOMER_ID,
    cust.CUSTOMER_NAME,
    cust.CREDIT_CARD_TYPE,
	cust.STATE,
	ord.ORDER_ID,
    ord.CUSTOMER_FEEDBACK,
	prod.PRODUCT_ID,
	prod.VEHICLE_MAKER,
	prod.VEHICLE_MODEL,
	prod.VEHICLE_COLOR,
	prod.VEHICLE_MODEL_YEAR
FROM ((new_wheels_customer_t AS cust
	INNER JOIN new_wheels_order_t AS ord
	    ON cust.CUSTOMER_ID = ord.CUSTOMER_ID)
 	INNER JOIN new_wheels_product_t AS prod     
		ON ord.PRODUCT_ID = prod.PRODUCT_ID);



/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Functions Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [7] Creating the functions:

-- Create the function calc_revenue_f

DELIMITER $$  
CREATE FUNCTION calc_revenue_f (QUANTITY INTEGER, DISCOUNT DECIMAL, VEHICLE_PRICE DECIMAL) 
RETURNS DECIMAL
DETERMINISTIC  
BEGIN  
	DECLARE revenue INT;
		SET revenue = QUANTITY * (1-DISCOUNT) * VEHICLE_PRICE;
	RETURN (revenue);
END;


-- Create the function days_to_ship_f-

DROP FUNCTION IF EXISTS days_to_ship_f
DELIMITER $$
CREATE FUNCTION days_to_ship_f (ORDER_DATE date, SHIP_DATE date) 
RETURNS INTEGER
DETERMINISTIC
BEGIN  
	DECLARE shipping_days INT;
		SET shipping_days = datediff(SHIP_DATE, ORDER_DATE);
	RETURN (shipping_days);
END;



/*-----------------------------------------------------------------------------------------------------------------------------------
Note: 
After creating tables, stored procedures, views and functions, attempt the below questions.
Once you have got the answer to the below questions, download the csv file for each question and use it in Python for visualisations.
------------------------------------------------------------------------------------------------------------------------------------ 


-----------------------------------------------------------------------------------------------------------------------------------

                                                         Queries
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/
  
/*-- QUESTIONS RELATED TO CUSTOMERS
     [Q1] What is the distribution of customers across states?
     Hint: For each state, count the number of customers.*/

SELECT 
	STATE,
    COUNT(CUSTOMER_ID) AS no_of_customers
FROM veh_ord_cust_v
GROUP BY STATE
ORDER BY no_of_customers DESC

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q2] What is the average rating in each quarter?
-- Very Bad is 1, Bad is 2, Okay is 3, Good is 4, Very Good is 5.

Hint: Use a common table expression and in that CTE, assign numbers to the different customer ratings. 
      Now average the feedback for each quarter. 

Note: For reference, refer to question number 10. Week-2: Hands-on (Practice)-GL_EATS_PRACTICE_EXERCISE_SOLUTION.SQL. 
      You'll get an overview of how to use common table expressions from this question.*/

WITH RATING_BUCKET AS
(
	SELECT 
    QUARTER_NUMBER,
		CASE
			WHEN CUSTOMER_FEEDBACK = "VERY BAD" THEN 1
			WHEN CUSTOMER_FEEDBACK = "BAD" THEN 2
			WHEN CUSTOMER_FEEDBACK = "OKAY" THEN 3
			WHEN CUSTOMER_FEEDBACK = "GOOD" THEN 4
			WHEN CUSTOMER_FEEDBACK = "VERY GOOD" THEN 5
		END AS CUSTOMER_RATING_BUCKET
	FROM
		veh_ord_cust_v
)
SELECT 
	QUARTER_NUMBER,
	AVG(CUSTOMER_RATING_BUCKET) AS "AVERAGE_RATINGS"
FROM 
	RATING_BUCKET
GROUP BY 
	QUARTER_NUMBER;


  
-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q3] Are customers getting more dissatisfied over time?

Hint: Need the percentage of different types of customer feedback in each quarter. Use a common table expression and
	  determine the number of customer feedback in each category as well as the total number of customer feedback in each quarter.
	  Now use that common table expression to find out the percentage of different types of customer feedback in each quarter.
      Eg: (total number of very good feedback/total customer feedback)* 100 gives you the percentage of very good feedback.
      
Note: For reference, refer to question number 10. Week-2: Hands-on (Practice)-GL_EATS_PRACTICE_EXERCISE_SOLUTION.SQL. 
      You'll get an overview of how to use common table expressions from this question*/
      
WITH FEEDBACK_PER_CATEGORY AS
(
	SELECT 
        CUSTOMER_FEEDBACK,
		COUNT(CUSTOMER_FEEDBACK) AS TOTAL_FEEDBACK1
	FROM
		veh_ord_cust_v
	GROUP BY
		CUSTOMER_FEEDBACK
),
TOTAL_FEEDBACK_PER_QUARTER AS
(
	SELECT
    CUSTOMER_FEEDBACK,
    QUARTER_NUMBER, 
    COUNT(CUSTOMER_FEEDBACK) AS TOTAL_FEEDBACK2
    FROM
		veh_ord_cust_v
	GROUP BY
		QUARTER_NUMBER
)
SELECT 
	f.CUSTOMER_FEEDBACK,
    t.QUARTER_NUMBER,
    (f.TOTAL_FEEDBACK1/t.TOTAL_FEEDBACK2)*100 AS FEEDBACK_PERCENTAGE
FROM 
	FEEDBACK_PER_CATEGORY f
INNER JOIN
	TOTAL_FEEDBACK_PER_QUARTER t
ON
	t.CUSTOMER_FEEDBACK=f.CUSTOMER_FEEDBACK


-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q4] Which are the top 5 vehicle makers preferred by the customer.

Hint: For each vehicle make what is the count of the customers.*/
SELECT
	VEHICLE_MAKER,
	COUNT(CUSTOMER_ID) AS No_of_Cust
FROM
	veh_prod_cust_v
GROUP BY
	1
ORDER BY
	No_of_Cust DESC
LIMIT 5



-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q5] What is the most preferred vehicle make in each state?

Hint: Use the window function RANK() to rank based on the count of customers for each state and vehicle maker. 
After ranking, take the vehicle maker whose rank is 1.*/

WITH RNK AS
(SELECT 
	VEHICLE_MAKER,
    STATE,
	RANK() OVER (PARTITION BY STATE ORDER BY CUSTOMER_ID DESC) AS RANKING,
	CUSTOMER_ID
FROM
	veh_prod_cust_v)
SELECT 
	VEHICLE_MAKER,
    STATE,
    RANKING
FROM
	RNK
WHERE 
	RANKING=1





-- ---------------------------------------------------------------------------------------------------------------------------------

/*QUESTIONS RELATED TO REVENUE and ORDERS 

-- [Q6] What is the trend of number of orders by quarters?

Hint: Count the number of orders for each quarter.*/

SELECT 
	QUARTER_NUMBER,
    COUNT(ORDER_ID) AS No_of_Orders
FROM
	veh_ord_cust_v
GROUP BY
	1
ORDER BY
	No_of_Orders DESC;





-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q7] What is the quarter over quarter % change in revenue? 

Hint: Quarter over Quarter percentage change in revenue means what is the change in revenue from the subsequent quarter to the previous quarter in percentage.
      To calculate you need to use the common table expression to find out the sum of revenue for each quarter.
      Then use that CTE along with the LAG function to calculate the QoQ percentage change in revenue.
      
Note: For reference, refer to question number 5. Week-2: Hands-on (Practice)-GL_EATS_PRACTICE_EXERCISE_SOLUTION.SQL. 
      You'll get an overview of how to use common table expressions and the LAG function from this question.*/
      
WITH QoQ AS
(
	SELECT
		QUARTER_NUMBER,
        SUM((1-DISCOUNT)*VEHICLE_PRICE) AS REVENUE
	FROM
		veh_ord_cust_v
	GROUP BY 1
)
SELECT
	QUARTER_NUMBER,
    REVENUE,
    LAG(REVENUE) OVER (ORDER BY QUARTER_NUMBER) AS PREVIOUS_QUARTER_REVENUE,
    ROUND(((REVENUE - LAG(REVENUE) OVER (ORDER BY QUARTER_NUMBER))/LAG(REVENUE) OVER(ORDER BY QUARTER_NUMBER) * 100),2) AS "QUARTER OVER QUARTER REVENUE (%) CHANGE"
FROM
	QoQ;
      
      
      

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q8] What is the trend of revenue and orders by quarters?

Hint: Find out the sum of revenue and count the number of orders for each quarter.*/

SELECT 
	QUARTER_NUMBER,
	SUM((1-DISCOUNT)*VEHICLE_PRICE) AS REVENUE, 
	COUNT(ORDER_ID) AS NUMBER_OF_ORDERS
FROM
	veh_ord_cust_v
GROUP BY
	1
ORDER BY
	2;

-- ---------------------------------------------------------------------------------------------------------------------------------

/* QUESTIONS RELATED TO SHIPPING 
    [Q9] What is the average discount offered for different types of credit cards?

Hint: Find out the average of discount for each credit card type.*/

SELECT
	CREDIT_CARD_TYPE,
    ROUND(AVG(DISCOUNT), 2) AS AVERAGE_DISCOUNT
FROM
	veh_ord_cust_v
GROUP BY
	1
ORDER BY
	2 DESC;



-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q10] What is the average time taken to ship the placed orders for each quarters?
   Use days_to_ship_f function to compute the time taken to ship the orders.

Hint: For each quarter, find out the average of the function that you created to calculate the difference between the ship date and the order date.*/

SELECT
	QUARTER_NUMBER,
    AVG(days_to_ship_f(ORDER_DATE, SHIP_DATE)) AS Avg_Shipping_Time
FROM
	veh_ord_cust_v
GROUP BY
	QUARTER_NUMBER
ORDER BY
	1;



-- --------------------------------------------------------Done----------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------



