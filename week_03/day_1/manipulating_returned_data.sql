SELECT
	id,
	first_name,
	last_name
FROM employees;

SELECT
	id,
	first_name,
	last_name,
	concat (first_name, ' ', last_name) AS full_name
FROM employees
WHERE first_name IS NOT NULL
AND last_name IS NOT NULL;

SELECT
	DISTINCT(department) AS department
FROM employees;

SELECT
	count(first_name) AS first_name_count
FROM employees;

SELECT
	count(*) AS first_name_count
FROM employees;

/*min and max salary*/

SELECT
	max(salary) AS max_salary,
	min(salary) AS min_salary
FROM employees;

/* avg salary in HR dept*/

SELECT
	avg(salary) AS avg_hr_salary
FROM employees
WHERE department = 'Human Resources';

/*total yearly spend on 2018 hires*/

SELECT
	sum(salary) AS total_salary_2018_starters
FROM employees
WHERE extract(YEAR FROM start_date) = 2018;

SELECT *
FROM employees
ORDER BY salary DESC, start_date;

SELECT *
FROM employees
ORDER BY last_name, first_name;

SELECT *
FROM employees
ORDER BY salary DESC NULLS last
LIMIT 1;

/*1. Get the details of the longest-serving employee of the corporation.*/

SELECT *
FROM employees
ORDER BY start_date
LIMIT 1;

/*2. Get the details of the highest paid employee of the corporation in Libya.*/

SELECT *
FROM employees
WHERE country = 'Libya'
ORDER BY salary DESC NULLS LAST
LIMIT 1;