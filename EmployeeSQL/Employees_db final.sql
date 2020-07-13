-- Drop table if exists
DROP TABLE departments;
DROP TABLE employees;
DROP TABLE dept_emp;
DROP TABLE dept_managers;
DROP TABLE salaries;
DROP TABLE titles;

-- Data Engineering
--Create tables
CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no")
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" Date   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no")
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL
);

CREATE TABLE "dept_managers" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL
);

CREATE TABLE "titles" (
    "emp_title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "emp_title_id")
);

-- View tables
SELECT * FROM departments
SELECT * FROM dept_emp
SELECT * FROM dept_managers
SELECT * FROM employees
SELECT * FROM salaries
SELECT * FROM titles

-- Data Analysis
--1. List the following details of each employee: employee number, last name, first name, sex, and salary
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
INNER JOIN salaries s
ON e.emp_no = s.emp_no;

--2. List first name, last name, and hire date for employees who were hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date >= '1986-01-01'
AND hire_date <= '1986-12-31';

--3. List the manager of each department with the following information: department number, 
--department name, the manager's employee number, last name, first name
SELECT d.dept_no, d.dept_name, f.emp_no, e.last_name, e.first_name
FROM departments d
INNER JOIN dept_emp f
ON d.dept_no = f.dept_no
INNER JOIN employees e
ON f.emp_no = e.emp_no;

--4. List the department of each employee with the following information: employee number, last name, 
--first name, and department name
SELECT e.emp_no, e.last_name, e.first_name, x.dept_name
FROM employees e
INNER JOIN dept_emp d
ON e.emp_no = d.emp_no
INNER JOIN departments x
ON d.dept_no = x.dept_no

--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name
SELECT e.emp_no, e.last_name, e.first_name, x.dept_name 
FROM employees e
INNER JOIN dept_emp d
ON e.emp_no = d.emp_no
INNER JOIN departments x
ON d.dept_no = x.dept_no
WHERE dept_name = 'Sales';

--7. List all employees in the Sales and Development departments, including their employee number, last name, 
--first name, and department name
SELECT e.emp_no, e.last_name, e.first_name, x.dept_name 
FROM employees e
INNER JOIN dept_emp d
ON e.emp_no = d.emp_no
INNER JOIN departments x
ON d.dept_no = x.dept_no
WHERE dept_name = 'Sales'
OR dept_name = 'Development';

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name
SELECT last_name, COUNT(last_name) 
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) desc;
