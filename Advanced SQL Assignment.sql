
/*================================================================================================================================================================
Q1. What is a Common Table Expression (CTE), and how does it improve SQL query readability?
================================================================================================================================================================ */

# Ans

/* 

Common Table Expression (CTE):

A Common Table Expression (CTE) is a temporary result set created using the (WITH) clause that can be referenced within a single SQL query.

How it improves readability:

-- Breaks complex queries into smaller, logical parts.
-- Makes SQL code easier to read, understand, and maintain.
-- Reduces the need for deeply nested subqueries.

Example:

WITH EmployeeCTE AS (
    SELECT * FROM Employees
)
SELECT * FROM EmployeeCTE; 

*/


/*================================================================================================================================================================
Q2. Why are some views updatable while others are read-only? Explain with an example.
================================================================================================================================================================ */

# Ans

/*

- A view is updatable if it is based on a single table and does not contain complex features like JOIN, GROUP BY, DISTINCT, or aggregate functions.

- A view is read-only if it includes multiple tables (JOINs), aggregate functions (SUM, COUNT, etc.), GROUP BY, DISTINCT, or other complex operations that prevent SQL from identifying which underlying row to update.

Example:

Updatable View:
e.g.

CREATE VIEW EmployeeView AS
SELECT EmployeeID, EmployeeName
FROM Employees;

Read-only View:
e.g.

CREATE VIEW SalesSummary AS
SELECT DepartmentID, SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID;

The first view allows updates because it maps directly to a single table, while the second is read-only because it uses an aggregate function and GROUP BY

*/


/*================================================================================================================================================================
Q3. What advantages do stored procedures offer compared to writing raw SQL queries repeatedly?
================================================================================================================================================================ */

# Ans

/*

Stored procedures offer several advantages over writing raw SQL queries repeatedly:

--	Reusability: The same SQL logic can be executed multiple times without rewriting the code.
-- 	Better Performance: Stored procedures are precompiled by the database, which helps execute queries faster.
-- 	Improved Security: Users can be given permission to execute the procedure without direct access to the underlying tables.
-- 	Easier Maintenance: Any changes to the SQL logic need to be made only once in the stored procedure, reducing 
	maintenance effort and ensuring consistency across applications.

*/


/*================================================================================================================================================================
Q4. What is the purpose of triggers in a database? Mention one use case where a trigger is essential.
================================================================================================================================================================ */

# Ans

/*

A trigger is a special SQL program that automatically executes when a specific event, such as INSERT, UPDATE, or DELETE, occurs on a table. 
Its purpose is to enforce business rules, maintain data integrity, and automate database tasks.

Use Case:
An audit trigger automatically records changes to employee salary details in an audit table whenever a salary is updated, 
helping maintain a history of changes for security and compliance.

*/


/*================================================================================================================================================================
Q5. Explain the need for data modelling and normalization when designing a database.
================================================================================================================================================================ */

# Ans

/*

--	modelling helps organize data by defining tables, relationships, and constraints, 
	ensuring the database is structured efficiently and supports business requirements.

-- 	Normalization organizes data into related tables to reduce redundancy, eliminate data inconsistency, and improve data integrity.

Together, data modelling and normalization create a well-structured, efficient, and reliable database that is easier to maintain and query.

*/


CREATE DATABASE Sales_Info;
USE Sales_Info;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO Products VALUES
(1, 'Keyboard', 'Electronics', 1200),
(2, 'Mouse', 'Electronics', 800),
(3, 'Chair', 'Furniture', 2500),
(4, 'Desk', 'Furniture', 5500);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Sales VALUES
(1, 1, 4, '2024-01-05'),
(2, 2, 10, '2024-01-06'),
(3, 3, 2, '2024-01-10'),
(4, 4, 1, '2024-01-11');


/*================================================================================================================================================================
Q6. Write a CTE to calculate the total revenue for each product
	(Revenues = Price × Quantity), and return only products where  revenue > 3000
================================================================================================================================================================ */

# Ans

select * from Products;
select * from sales;

WITH RevenueTable AS (

SELECT 
ProductID,
Quantity
FROM sales) 

SELECT 
P.ProductID,
ProductName,
Price * Quantity as Revenue
FROM Products P 
LEFT JOIN RevenueTable RT
ON RT.ProductID = P.ProductID
WHERE Price * Quantity > 3000;


/*================================================================================================================================================================
Q7. Create a view named vw_CategorySummary that shows:
	Category, TotalProducts, AveragePrice.
================================================================================================================================================================ */

# Ans

CREATE VIEW vw_CategorySummary AS

SELECT
Category,
COUNT(ProductName) AS TotalProducts,
ROUND(AVG(Price),2) AS AveragePrice
FROM Products
GROUP BY Category;

SELECT * FROM vw_CategorySummary;


/*================================================================================================================================================================
Q8. Create an updatable view containing ProductID, ProductName, and Price.
	Then update the price of ProductID = 1 using the view
================================================================================================================================================================ */

# Ans 

CREATE VIEW Updatable_View AS

SELECT
ProductID,
ProductName,
Price
FROM Products;


UPDATE Updatable_View
SET Price = 1000
WHERE ProductID = 1 ;

SELECT * FROM Updatable_View;


/*================================================================================================================================================================
Q9. Create a stored procedure that accepts a category name and returns all products belonging to that category.
================================================================================================================================================================ */

# Ans

Delimiter //

CREATE PROCEDURE Product_Summary(In Category_Name Varchar(30))
BEGIN

SELECT
Category,
ProductName
FROM PRODUCTS
WHERE Category = Category_Name;

END//

Delimiter ;

CALL Product_Summary('Electronics');


/*================================================================================================================================================================
Q10. Create an AFTER DELETE trigger on the Product table that archives deleted product rows into a new 
	table ProductArchive. The archive should store ProductID, ProductName, Category, Price, and DeletedAt timestamp.
================================================================================================================================================================ */

# Ans

CREATE TABLE ProductArchive (
ProductID INT,
ProductName VARCHAR(100),
Category VARCHAR(100),
Price DECIMAL(10,2),
DeletedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


DELIMITER $$

CREATE TRIGGER trg_AfterDelete_Product
AFTER DELETE
ON Products
FOR EACH ROW
BEGIN

INSERT INTO ProductArchive
(	ProductID,
	ProductName,
	Category,
	Price,
	DeletedAt	)
VALUES
(	OLD.ProductID,
	OLD.ProductName,
	OLD.Category,
	OLD.Price,
	NOW()	);

END$$

DELIMITER ;

SHOW TRIGGERS FROM Sales_info;