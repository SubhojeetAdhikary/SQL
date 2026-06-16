
/* Q1. Create a new database named company_db and Create a table named employees with the following columns: 
employee_id int primary key, first_name varchar(50), last_name varchar(50), department varchar(50), salary int, hire_date date*/

# Ans	
# Creating a database as Company_db

create Database Company_db;
use Company_db;

# Creating a table employees

create  table employees
(employee_id int primary key,
first_name varchar(50),
last_name varchar(50),
department varchar(50),
salary int, 
hire_date date);

select * from employees;

/* Q2. Insert Data into Employees Table employees
Task: Insert the following sample records into the table. */

# Ans

insert into employees
values
(101, "Amit", "Sharma", "HR" , 50000, "2020-01-15"),
(102, "Riya", "Kapoor", "Sales", 75000, "2019-03-22"),
(103, "Raj", "Mehta", "IT", 90000, "2018-07-11"),
(104, "Neha", "Verma", "IT", 85000, "2021-09-01"),
(105, "Arjun", "Singh", "Finance", 60000, "2022-02-10");

select * from employees;

/* Q3. Display All Employee Records Sorted by Salary (Lowest to Highest)
Hint: Use the Order by clause on the salary column. */

#Ans

select * from employees
order by salary;

/* Q4. Show Employees Sorted by Department (A–Z) and Salary (High → Low) */

# Ans

select * from employees
order by department, salary desc; 

/* Q5. List All Employees in the IT Department, Ordered by Hire Date (Newest First) */

# Ans

select * from employees
order by hire_date;

/* Q6. Create and Populate a Sales Table
Task: Create a table sales to track sales data: */

# Ans

create table sales
(sales_id int primary key,
customer_name varchar(50),
amount int,
sale_date date);

insert into sales
values
(1, "Adity", 1500, "2024-08-01"),
(2, "Rohan", 2200, "2024-08-03"),
(3, "Aditi", 3500, "2024-09-05"),
(4, "Meena", 2700, "2024-09-15"),
(5, "Rohan", 4500, "2024-09-25");

update sales
set customer_name = "Aditi"
where sales_id = 1;

select * from sales;

/* Q7. Display All Sales Records Sorted by Amount (Highest → Lowest) */

# Ans

select * from sales
order by amount desc;

/* Q8. Show All Sales Made by Customer “Aditi” */

# Ans

select * from sales
where customer_name = "Aditi";

/* Q9. What is the Difference Between a Primary Key and a Foreign Key? */

# Ans

-- Difference Between Primary Key and Foreign Key

-- PRIMARY KEY
-- 1. Uniquely identifies each row in a table.
-- 2. Cannot contain NULL values.
-- 3. Cannot contain duplicate values.
-- 4. Only one Primary Key can exist in a table.

-- FOREIGN KEY
-- 1. Creates a relationship between two tables.
-- 2. References the Primary Key of another table.
-- 3. Can contain duplicate values.
-- 4. Can contain NULL values (unless restricted).
-- 5. A table can have multiple Foreign Keys.

-- Example:

#-- create table Departments 
 -- (Dept_ID int primary key,
 --  Dept_Name VARCHAR(50));

#-- create table Employees (
 -- Emp_ID int primary key,
 -- Name VARCHAR(50),
 -- Dept_ID INT,
 -- FOREIGN KEY (Dept_ID) REFERENCES Departments(Dept_ID));

-- Here:
-- Dept_ID in Departments = Primary Key
-- Dept_ID in Employees = Foreign Key

/* Q10. What Are Constraints in SQL and Why Are They Used? */

# Ans 
-- Constraints in SQL

-- Constraints are rules applied to columns or tables
-- to ensure data accuracy, consistency, and integrity.

-- Why are Constraints Used?
-- 1. To prevent invalid data entry.
-- 2. To maintain data integrity.
-- 3. To enforce business rules.
-- 4. To ensure data consistency across tables.

-- Common SQL Constraints:

-- NOT NULL
-- Prevents NULL values in a column.

-- UNIQUE
-- Prevents duplicate values in a column.

-- PRIMARY KEY
-- Uniquely identifies each row.
-- Combines UNIQUE + NOT NULL.

-- FOREIGN KEY
-- Creates a relationship between two tables.

-- CHECK
-- Ensures values meet a specific condition.

-- DEFAULT
-- Assigns a default value if no value is provided.

-- Example:

-- CREATE TABLE Employees (
--    Emp_ID INT PRIMARY KEY,
--    Name VARCHAR(50) NOT NULL,
--    Email VARCHAR(100) UNIQUE,
--    Salary INT CHECK (Salary > 0),
--    Department VARCHAR(50) DEFAULT 'General');

-- In this example:
-- PRIMARY KEY ensures unique employee IDs.
-- NOT NULL ensures Name is always provided.
-- UNIQUE prevents duplicate emails.
-- CHECK ensures Salary is greater than 0.
-- DEFAULT sets Department to 'General' if not specified.



