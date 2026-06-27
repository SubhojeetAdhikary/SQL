use company_db;

/*===================================================================== BASIC LEVEL ==================================================================================*/

# 1. Retrieve the names of employees who earn more than the average salary of all employees.

#Ans 

Select *
from Employee
where Salary > (select 
				Round(avg(salary),0) as Avg_Salary
				from Employee)
order by Salary desc;


# 2. Find the employees who belong to the department with the highest average salary.

# Ans

with Avg_Dep_Salary as
		(select 
        d.Department_ID,
        Department_Name,
		round(Avg(Salary),0) as Avg_Dep_Salary
		from
		Department d 
		left join employee e 
		on d.Department_id = e.Department_id
		group by Department_Name, d.Department_ID
		order by Avg_Dep_Salary desc
		limit 2)
select 
ad.*,
Emp_ID,
Name
from 
Employee e 
Right join Avg_Dep_Salary ad
on e.Department_ID = ad.Department_ID;


# 3. List all employees who have made at least one sale.

# Ans

select 
emp_id,
count(sales_amount) as No_of_sales
from sales
group by emp_ID;


# 4. Find the employee with the highest sale amount.

# Ans 

select
s.Emp_id,
name,
Sales_ID,
sales_amount
from sales s
left join employee e
on s.emp_id = e.emp_id
where sales_amount = (select 
					max(sales_amount)
                    from sales);


# 5. Retrieve the names of employees whose salaries are higher than Shubham’s salary. 

# Ans 

select
*
from employee
where salary > ( select salary
				from employee
				where name = "Shubham");


/*===================================================================== INTERMEDIATE LEVEL =============================================================================*/

# 1. Find employees who work in the same department as Abhishek.

# Ans

select 
Emp_Id,
Name ,
d.Department_id,
Department_name
from department d 
left join employee e 
on d.Department_id = e.Department_id
where D.Department_id = (select Department_id
							from employee
                            where Name = "Abhishek");
                            
                            
# 2. List departments that have at least one employee earning more than ₹60,000.

# Ans
                            
select 
D.Department_id,
Department_Name,
Emp_Id,
Name,
Salary
from department d 
left join employee e 
on d.Department_id = e.Department_Id
Where Salary > 60000;                           
                            
                            
# 3. Find the department name of the employee who made the highest sale.

# Ans

select 
e.Emp_Id,
Name,
Department_Name,
Sales_Id,
Sales_Amount
From Sales s 
Left Join employee e 
ON e.Emp_id = s.Emp_Id
Left Join Department d 
on d.Department_ID = e.department_id
Where Sales_Amount = ( Select Max(Sales_Amount)
						from Sales);
                            

# 4. Retrieve employees who have made sales greater than the average sale amount.

# Ans

Select * from Sales
Where Sales_Amount > ( Select round(Avg(Sales_Amount),0 )from Sales)
order by Sales_Amount desc;


# 5. Find the total sales made by employees who earn more than the average salary.

# Ans 

Select
Sum(Sales_Amount) as Total_Sales_by_more_than_Avg_Earners
from
(select 
e.Emp_ID,
Name,
Sales_amount
from Employee e 
left join Sales s 
on e.Emp_id = s.Emp_id
Where Salary > ( select Round(Avg(salary),2) from employee)) as Sales_Data;


/*===================================================================== ADVANCED LEVEL ================================================================================*/

# 1. Find employees who have not made any sales.

# Ans

Select
    e.emp_id,
    e.name
From employee e
Left Join sales s
    on e.emp_id = s.emp_id
Where s.emp_id Is Null;


# 2. List departments where the average salary is above ₹55,000.

# Ans

Select
D.Department_ID,
Department_Name,
Avg_Dept_Salary
from Department D 
Left Join 
		(select 
		Department_ID,
		Round(Avg(Salary),0) as Avg_Dept_Salary
		from Employee e
		group by Department_ID) as SD
On D.Department_Id = SD.Department_Id
Having Avg_Dept_Salary > 50000;


# 3. Retrieve department names where the total sales exceed ₹10,000.

# Ans

Select
d.Department_Id,
d.Department_Name,
ds.Total_Dept_Sales
From Department d
Join ( Select
		e.Department_Id,
		SUM(s.Sales_Amount) as Total_Dept_Sales
		From Employee e
		Join Sales s
		on e.Emp_Id = s.Emp_Id
		Group by e.Department_Id ) ds
on d.Department_Id = ds.Department_Id
Where ds.Total_Dept_Sales > 10000;


# 4. Find the employee who has made the second-highest sale.

# Ans

Select
e.Emp_Id,
e.Name,
s.Sales_Amount
From Employee e
Join Sales s
on e.Emp_Id = s.Emp_Id
Where s.Sales_Amount = (Select MAX(Sales_Amount)
						From Sales
						Where Sales_Amount < (
						Select MAX(Sales_Amount)
						From Sales));
                        

# 5. Retrieve the names of employees whose salary is greater than the highest sale amount recorded.

# Ans 

Select 
Emp_Id,
Name,
Salary
from Employee 
Where Salary > ( Select 
					max(Sales_Amount)
                    from Sales);




