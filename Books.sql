CREATE TABLE BOOKS(
	Book_ID INT PRIMARY KEY,
	Title CHAR(100),
	Author CHAR(50),
	Genre  CHAR(50),
	Published_Year INT,
	Price NUMERIC(10,2),
	Stock INT

);

SELECT * FROM BOOKS;

COPY BOOKS(Book_ID,	Title,Author,Genre,Published_Year,Price,Stock)
FROM 'https://drive.google.com/file/d/1t25O_8IPfaAgJjwce8U9pxfLen0Ne1HF/view?usp=drive_link'
CSV HEADER;

DROP TABLE BOOKS;

CREATE TABLE CUSTOMERS(
	Customer_ID INT PRIMARY KEY,
	name CHAR(50),
	Email CHAR(50) UNIQUE,
	Phone CHAR(10) UNIQUE,
	City CHAR(50),
	Country CHAR(150)
);

SELECT * FROM CUSTOMERS;
 
COPY CUSTOMERS(Customer_ID,Name,Email,Phone,City,Country)
FROM 'https://drive.google.com/file/d/1x32xEcG17RcGhOj9SHIMVpRabD6XSV6T/view?usp=drive_link'
CSV HEADER;

DROP TABLE CUSTOMERS;

CREATE TABLE ORDERS(
	Order_ID INT PRIMARY KEY,
	Customer_ID INT ,
	Book_ID INT ,
	Order_Date DATE,
	Quantity INT ,
	Total_Amount NUMERIC (10,2)
);

SELECT * FROM ORDERS;

COPY ORDERS(Order_ID,Customer_ID,Book_ID,Order_Date,Quantity,Total_Amount)
FROM 'https://drive.google.com/file/d/1t25O_8IPfaAgJjwce8U9pxfLen0Ne1HF/view?usp=drive_link'
CSV HEADER;



-- Find Books genre='Fiction'
SELECT * FROM BOOKS WHERE genre='Fiction';

-- Find Books Published_Year>1950
SELECT * FROM books WHERE Published_Year>1950;

-- Find Customers from Canada
SELECT * FROM CUSTOMERS WHERE country='Canada';

-- Show ORDERS  Placeed in Nov 2023
SELECT * FROM ORDERS WHERE order_date<='2023-11-30' AND order_date>='2023-11-01' ;

--  sum of all books in Stock
SELECT SUM(Stock) FROM books as TOTAL_BOOKS;

-- Show Most expensive book
SELECT * FROM BOOKS ORDER BY Price DESC LIMIT 1;

-- Show Customers how ordered more thin 1 books
SELECT * FROM ORDERS WHERE Quantity>1;

-- Show add books amount>20
SELECT * FROM ORDERS WHERE Total_Amount>20;

-- List of  all Genres in books
SELECT DISTINCT Genre FROM BOOKS;

 -- Find lowest Stock in book
SELECT * FROM BOOKS ORDER BY Stock LIMIT 1;

-- Total Amount from all ORDERS
SELECT SUM(Total_Amount) from ORDERS;

-- Advance Questions : 

-- 	Retrieve the total number sold for etch genur 
SELECT SUM(o.Quantity),b.Genre AS Sold_booKs FROM ORDERS o
	JOIN BOOKS b ON o.Book_ID=b.Book_ID GROUP BY b.GENRE;
	
--  AVG Price of Genre='Fantasy'
SELECT AVG(Price) AS AVG_prige FROM BOOKS WHERE Genre='Fantasy';

-- List customers who have placed at least 2 ORDERS
SELECT c.name,o.Quantity  AS ORDERS_BOOKS FROM ORDERS o
	JOIN CUSTOMERS c ON c.Customer_ID=o.Customer_ID WHERE o.Quantity>=2 ORDER BY o.Quantity;

-- Show top most 3 EXpnsive Price of Genre='Fantasy'
SELECT * FROM BOOKS WHERE Genre='Fantasy' ORDER BY price DESC LIMIT 3;

-- Show the Totale Books of Sold by auther
SELECT b.Author ,SUM(o.Quantity) AS total_books_sould FROM ORDERS o
	JOIN BOOKS b ON b.Book_ID=o.Book_ID GROUP BY b.Author;

-- List the cities where customers who spent over $30 are located:

SELECT c.City ,o.Total_Amount  AS Total_Amount FROM ORDERS o
	JOIN CUSTOMERS c ON c.Customer_ID=o.Customer_ID  WHERE o.Total_Amount>30 ;
	
-- Find the customer who spent the most on orders:
SELECT c.Customer_ID,c.name ,SUM(o.Total_Amount)  AS Total_Amount FROM ORDERS o
	JOIN CUSTOMERS c ON c.Customer_ID=o.Customer_ID GROUP BY  c.Customer_ID,c.name 
	ORDER BY Total_Amount DESC LIMIT 1;
	
-- Calculate the stock remaining after fulfilling all orders:
SELECT SUM(b.Stock)-SUM(o.Quantity) AS remineing FROM ORDERS o
	JOIN BOOKS b ON b.Book_ID=o.Book_ID ;







