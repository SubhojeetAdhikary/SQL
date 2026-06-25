Use company_db;
select * from customers;
select * from employees;
select * from orders;
select * from payments;

/*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Question 1. Retrieve all customers who have placed at least one order
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
# Ans

select 
O.CustomerID,
CustomerName,
count(OrderID) as No_of_Orders
from Customers Cs
Right join Orders O 
on Cs.CustomerID = O.CustomerID
group by CustomerID;


/*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Question 2. Retrieve all customers and their orders, including customers who have not placed any orders.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
# Ans

select
Cs.CustomerID,
CustomerName,
OrderID
from Customers Cs
Left join Orders O 
on Cs.CustomerID = O.CustomerID;


/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Question 3. Retrieve all orders and their corresponding customers, including orders placed by unknown customers
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */ 
# Ans

select 
O.CustomerID,
CustomerName, 
OrderID
from Orders O 
Left Join Customers CS
on O.CustomerID = CS.CustomerID;


/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Question 4. Display all customers and orders, whether matched or not.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */
# Ans

Select *
from Customers cs
Left join Orders O 
on  cs.CustomerID = O.CustomerID

Union 

select*
from Customers cs
Right join Orders O 
on  cs.CustomerID = O.CustomerID;


/*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Question 5. Find customers who have not placed any orders
------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
#Ans

select
Cs.CustomerID,
CustomerName,
OrderID
from Customers Cs
left join Orders O 
on Cs.CustomerID = O.CustomerID
where OrderID is Null; 


/*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Question 6. Retrieve customers who made payments but did not place any orders.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
#Ans
select c.*,
PaymentID,
OrderID
from Customers c 
inner join payments p  
on c.CustomerID = p.CustomerID
left join Orders O 
on o.CustomerID = p.CustomerID
Where OrderID is Null;


/*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Question 7. Generate a list of all possible combinations between Customers and Orders
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
#Ans

# 1st Combination Where all unique values form both the table come together i.e. INNER JOIN 

select *
from Customers C 
Inner Join Orders O 
on C.CustomerID = O.CustomerID;

# 2nd Combination where all values from both the table come together whether it is unique or not i.e. OUTER JOIN

select *
from Customers C 
left Join Orders O 
on C.CustomerID = O.CustomerID

Union

select *
from Customers C 
Right Join Orders O 
on C.CustomerID = O.CustomerID;

# 3rd Combination where all values from the left table come with exact values present in the right table oherwise NULL i.e. LEFT JOIN
select *
from Customers C 
left Join Orders O 
on C.CustomerID = O.CustomerID;

# 4th Combination where all values from the Right table come with exact values present in the Left table oherwise NULL i.e. RIGHT JOIN
select *
from Customers C 
Right Join Orders O 
on C.CustomerID = O.CustomerID;


/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Question 8. Show all customers along with order and payment amounts in one table.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------ */
#Ans

select * from Orders O 
Left Join Payments P 
on P.CustomerID = O.CustomerId

Union

select * from Orders O 
Right Join Payments P 
on P.CustomerID = O.CustomerId;


/*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Question 9. Retrieve all customers who have both placed orders and made payments.
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
#Ans

select OrderID,
P.*
from Payments p 
left Join Orders o 
on p.customerID = o.customerID
where OrderID is not null;

