WITH max_min_salary AS (
	SELECT
		department,
		MIN(salary) AS min_salary,
		MAX(salary) AS max_salary
	FROM employees
	GROUP BY department
	)
SELECT
	percent_change2(max_salary, min_salary) AS percent_diff
FROM max_min_salary

EXPLAIN ANALYSE
SELECT
	department,
	AVG(salary) AS avg_salary
FROM employees_indexed
WHERE country IN ('Germany', 'France', 'Italy', 'Spain')
GROUP BY department
ORDER BY avg(salary);

SELECT
	first_name,
	last_name,
	department,
	salary,
	MIN(salary) OVER (PARTITION BY department) AS min_dept_salary,
	MAX(salary) OVER (PARTITION BY department) AS max_dept_salary
FROM employees
	