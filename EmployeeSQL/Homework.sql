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

DROP TABLE IF EXISTS Employees
DROP TABLE IF EXISTS Titles
DROP TABLE IF EXISTS Salaries	
DROP TABLE IF EXISTS Departments
DROP TABLE IF EXISTS Dept_Emp
DROP TABLE IF EXISTS Dept_Manager

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