CREATE DATABASE Students;
USE Students;

CREATE TABLE Student_Performance (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    course VARCHAR(30),
    score INT,
    attendance INT,
    mentor VARCHAR(50),
    join_date DATE,
    city VARCHAR(50)
);

INSERT INTO Student_Performance
(student_id, name, course, score, attendance, mentor, join_date, city)
VALUES
(101, 'Aarav Mehta', 'Data Science', 88, 92, 'Dr. Sharma', '2023-06-12', 'Mumbai'),
(102, 'Riya Singh', 'Data Science', 76, 85, 'Dr. Sharma', '2023-07-01', 'Delhi'),
(103, 'Kabir Khanna', 'Python', 91, 96, 'Ms. Nair', '2023-06-20', 'Mumbai'),
(104, 'Tanvi Patel', 'SQL', 84, 89, 'Mr. Iyer', '2023-05-30', 'Bengaluru'),
(105, 'Ayesha Khan', 'Python', 67, 81, 'Ms. Nair', '2023-07-10', 'Hyderabad'),
(106, 'Dev Sharma', 'SQL', 73, 78, 'Mr. Iyer', '2023-05-28', 'Pune'),
(107, 'Diya Verma', 'Tableau', 95, 98, 'Ms. Kapoor', '2023-06-15', 'Delhi'),
(108, 'Meera Pillai', 'Tableau', 82, 87, 'Ms. Kapoor', '2023-06-18', 'Kochi'),
(109, 'Nikhil Rao', 'Data Science', 79, 82, 'Dr. Sharma', '2023-07-05', 'Chennai'),
(110, 'Priya Desai', 'SQL', 92, 94, 'Mr. Iyer', '2023-05-27', 'Bengaluru'),
(111, 'Siddharth Jain', 'Python', 85, 90, 'Ms. Nair', '2023-07-02', 'Mumbai'),
(112, 'Sneha Kulkarni', 'Tableau', 74, 83, 'Ms. Kapoor', '2023-06-10', 'Pune'),
(113, 'Rohan Gupta', 'SQL', 89, 91, 'Mr. Iyer', '2023-05-25', 'Delhi'),
(114, 'Ishita Joshi', 'Data Science', 93, 97, 'Dr. Sharma', '2023-06-25', 'Bengaluru'),
(115, 'Yuvraj Rao', 'Python', 71, 84, 'Ms. Nair', '2023-07-12', 'Hyderabad');

SELECT * FROM Student_Performance;

/*==================================================================================================================================================================
Question 1 : Create a ranking of students based on score (highest first).
================================================================================================================================================================= */

# Ans

SELECT 
RANK()OVER(ORDER BY score desc ) as Student_Rank,
Student_id,
Name,
Score
FROM Student_Performance;


/*==================================================================================================================================================================
Question 2 : Show each student's score and the previous student’s score (based on score order).
================================================================================================================================================================= */

# Ans

SELECT 
Student_id,
Name,
Score,
LAG(Score) OVER(ORDER BY Score DESC ) AS Previous_Score
FROM Student_Performance;


/*==============================================================================================================================================================
Question 3 : Convert all student names to uppercase and extract the month name from join_date.
============================================================================================================================================================== */

# Ans

SELECT
Student_id,
UPPER(Name) Names,
MONTHNAME(Join_date) AS Month_Name
FROM Student_Performance;


/*==============================================================================================================================================================
Question 4 : Show each student's name and the next student’s attendance (ordered by attendance).
============================================================================================================================================================= */

# Ans

SELECT 
Student_id,
Name,
LEAD(Attendance) OVER(ORDER BY Attendance desc) Next_Student_Att
FROM Student_Performance;


/*================================================================================================================================================================
Question 5 : Assign students into 4 performance groups using NTILE().
================================================================================================================================================================ */

# Ans

SELECT
Student_id,
Name,
NTILE(4) OVER( ORDER BY Score DESC ) AS Group_Performance,
Score
FROM Student_Performance;


/*===============================================================================================================================================================
Question 6 : For each course, assign a row number based on attendance (highest first).
=============================================================================================================================================================== */

# Ans

SELECT
Student_id, 
Name,
Course,
Attendance,
ROW_NUMBER() OVER(PARTITION BY Course ORDER  BY Attendance DESC) AS Course_Row_Numb
FROM Student_Performance;


/*===============================================================================================================================================================
Question 7 : Calculate the number of days each student has been enrolled (from join_date to today). (Assume current date = '2025-01-01')
=============================================================================================================================================================== */

# Ans

SELECT
Student_id,
Name,
Course,
Join_Date,
DATEDIFF("2025-01-01", Join_date) AS Duration_Days
FROM Student_Performance;


/*===============================================================================================================================================================
Question 8 : Format join_date as “Month Year” (e.g., “June 2023”).
=============================================================================================================================================================== */

# Ans

SELECT
Student_id,
Name,
course,
DATE_FORMAT( Join_date, "%M %Y" ) AS Formated_Join_date
FROM Student_Performance;


/*===============================================================================================================================================================
Question 9 : Replace the city ‘Mumbai’ with ‘MUM’ for display purposes.
=============================================================================================================================================================== */

# Ans

SELECT
Student_id,
Name,
IF( City = "Mumbai", "Mum", City) AS City
FROM Student_Performance;


/*===============================================================================================================================================================
Question 10 : For each course, find the highest score using FIRST_VALUE().
=============================================================================================================================================================== */

# Ans

SELECT
Course,
Score,
FIRST_VALUE(score) OVER (PARTITION BY Course ORDER BY score DESC) AS Highest_score
FROM Student_Performance;