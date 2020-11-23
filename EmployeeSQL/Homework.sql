CREATE TABLE Employees (
	emp_no INTEGER PRIMARY KEY,
	emp_title TEXT NOT NULL,
	birthdate DATE NOT NULL,
	first_name TEXT NOT NULL,
	last_name TEXT NOT NULL,
	sex VARCHAR(1) NOT NULL,
	hire_date DATE NOT NULL
);
CREATE TABLE Titles (
	title_id TEXT PRIMARY KEY,
	title VARCHAR (20) NOT NULL
);
ALTER TABLE Employees
	ADD FOREIGN KEY (emp_title) 
		REFERENCES Titles(title_id)
		
CREATE TABLE Salaries (
	emp_no INTEGER PRIMARY KEY,
	salary INTEGER NOT NULL,
	CONSTRAINT fk_emp
    	FOREIGN KEY(emp_no) 
			REFERENCES Employees(emp_no)
);
CREATE TABLE Departments (
	dept_no TEXT PRIMARY KEY,
	dept_name TEXT NOT NULL
);
CREATE TABLE Dept_Emp (
	emp_no INTEGER REFERENCES Employees (emp_no),
	dept_no TEXT NOT NULL REFERENCES Departments (dept_no),
	CONSTRAINT emp_nodept_no PRIMARY KEY (emp_no, dept_no)
);
CREATE TABLE Dept_Manager(
	dept_no TEXT REFERENCES Departments (dept_no),
	emp_no INTEGER NOT NULL REFERENCES Employees (emp_no),
	CONSTRAINT dept_npemp_no PRIMARY KEY (dept_no, emp_no)
);

-- DROP TABLE IF EXISTS Employees
-- DROP TABLE IF EXISTS Titles
-- DROP TABLE IF EXISTS Salaries	
-- DROP TABLE IF EXISTS Departments
-- DROP TABLE IF EXISTS Dept_Emp
-- DROP TABLE IF EXISTS Dept_Manager

SELECT *
FROM Employees;
SELECT *
FROM Titles;
SELECT *
FROM Salaries;
SELECT *
FROM Departments;
SELECT *
FROM Salaries;
SELECT *
FROM Dept_Emp;
SELECT *
FROM Dept_Manager;



SELECT e.emp_no, last_name, sex, salary
FROM   employees e
       JOIN salaries s ON e.emp_no = s.emp_no;
       
SELECT  first_name, last_name, hire_date
FROM    employees
WHERE EXTRACT(YEAR FROM hire_date) = '1986';

--#1

SELECT e.emp_no, last_name, sex, salary
FROM   employees e
       JOIN salaries s ON e.emp_no = s.emp_no;


--#2

SELECT  first_name, last_name, hire_date
FROM    employees
WHERE EXTRACT(YEAR FROM hire_date) = '1986';


--#3

WITH departments_cte AS(
    SELECT *
    FROM departments
) 
, dept_man_cte AS(
    SELECT dm.dept_no, emp_no, dep.dept_name
    FROM dept_manager dm
        JOIN departments_cte dep ON dm.dept_no = dep.dept_no
)
SELECT  d.dept_no, dept_name, e.emp_no, last_name, first_name
FROM employees e
    JOIN dept_man_cte d ON e.emp_no = d.emp_no;
	
	
--#4

WITH departments_cte AS (
    SELECT *
    FROM departments
)
, dept_emp_cte AS (
    SELECT de.dept_no, dept_name, de.emp_no
    FROM dept_emp de
        JOIN departments_cte dep ON de.dept_no = dep.dept_no
)
SELECT e.emp_no, last_name, first_name, dept_name
FROM   employees e
       JOIN dept_emp_cte dect on e.emp_no = dect.emp_no;
	   
	   
--#5

SELECT first_name, last_name, sex
FROM   employees
WHERE  first_name = 'Hercules' 
       AND last_name LIKE 'B%';
	   
	   
--#6

WITH sales_cte AS (
    SELECT *
    FROM   departments
    WHERE  dept_no = 'd007'
)
, dept_emp_cte AS (
    SELECT emp_no, de.dept_no, dept_name
    FROM dept_emp de
        JOIN sales_cte sc ON de.dept_no = sc.dept_no
)
SELECT e.emp_no, last_name, first_name, dept_name
FROM employees e
    JOIN dept_emp_cte dem ON e.emp_no = dem.emp_no
	
	
--#7

WITH sales_dev_cte AS (
    SELECT *
    FROM   departments
    WHERE  dept_no = 'd007' OR dept_no = 'd005'
)
, dept_emp_cte AS (
    SELECT emp_no, de.dept_no, dept_name
    FROM dept_emp de
        JOIN sales_dev_cte sd ON de.dept_no = sd.dept_no
)
SELECT e.emp_no, last_name, first_name, dept_name
FROM employees e
    JOIN dept_emp_cte dem ON e.emp_no = dem.emp_no
	
	
--#8

SELECT last_name, COUNT(last_name) AS "occurances_of_last_name"
FROM employees
GROUP BY last_name
ORDER BY occurances_of_last_name DESC;