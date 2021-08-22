/* Find the number of employees within each department of the corporation. */

SELECT
	department,
	count(id) AS num_employee
FROM employees
GROUP BY department;

/* How many employees in each department work either 0.25 or 0.5 FTE hours? */

SELECT
	department,
	count(id) AS num_employee_quarter_half_fte
FROM employees
WHERE fte_hours = 0.25 OR fte_hours = 0.5
GROUP BY department;

/* count(col_name) vs count(*) */

SELECT
	count(first_name) AS count_first,
	count(id) AS count_id,
	count(*) AS count_star
FROM employees;

/* Find the longest time served by any one employee in each department. */

SELECT
	department,
	round((EXTRACT(DAY FROM (now() - min(start_date)))/365)::numeric, 2) AS time_served
FROM employees
GROUP BY department;

/* How many employees in each department are enrolled in the pension scheme? */

SELECT
	department,
	count(pension_enrol) AS count_pension_enrolled
FROM employees
WHERE pension_enrol = TRUE
GROUP BY department;

/* Perform a breakdown by country of the number of employees that do not have a stored first name. */

SELECT
	country,
	count(*) AS missing_first_name
FROM employees
WHERE first_name IS NULL
GROUP BY country;

/* Show those departments in which at least 40 employees work either 0.25 or 0.5 FTE hours. */

SELECT
	department,
	COUNT(id) AS num_fte_quarter_half
FROM employees
WHERE fte_hours IN (0.25, 0.5)
GROUP BY department
HAVING COUNT(id) >= 40;

/* Show any countries in which the minimum salary amongst pension enrolled employees is less than 21,000 dollars */

SELECT 
	country
FROM employees
WHERE pension_enrol IS TRUE
GROUP BY country
HAVING MIN(salary) < 21000;

/* Show any departments in which the earliest start date amongst grade 1 employees is prior to 1991. */

SELECT
	department
FROM employees
WHERE grade = 1
GROUP BY department
HAVING EXTRACT(YEAR FROM MIN(start_date)) < 1991;

/* Find all the employees in Japan who earn over the company-wide average salary. */

SELECT *
FROM employees
WHERE 	country = 'Japan'
AND 	salary > (SELECT
					AVG(salary)
					FROM employees);
					
/* Find all the employees in Legal who earn less than the mean salary in that same department. */
				
SELECT *
FROM employees
WHERE department = 'Legal'
AND	salary < (	SELECT
					avg(salary)
				FROM employees
				WHERE department = 'Legal'
				);
			
/* Find all the employees in the United States who work the most common full-time equivalent hours across the corporation. */
/* Works, but can't resolve ties. */
			
SELECT *
FROM employees
WHERE country = 'United States'
AND fte_hours = (	SELECT
						mode()
					WITHIN GROUP (ORDER BY fte_hours)
					FROM employees
					);

EXPLAIN ANALYSE
SELECT * 
FROM employees
WHERE country = 'United States'
AND fte_hours IN (	SELECT
					fte_hours	
				 	FROM (	SELECT 
				 				fte_hours,
				 				RANK() OVER (ORDER BY count(*) DESC)
				 			FROM employees 
				 			GROUP BY fte_hours
				 			) AS fte_rank
				 	WHERE fte_rank.rank = 1
					);

EXPLAIN analyse
SELECT *
FROM employees
WHERE country = 'United States' AND fte_hours IN (
  SELECT fte_hours
  FROM employees
  GROUP BY fte_hours
  HAVING COUNT(*) = (
    SELECT MAX(count)
    FROM (
      SELECT COUNT(*) AS count
      FROM employees
      GROUP BY fte_hours
    ) AS temp
  )
);