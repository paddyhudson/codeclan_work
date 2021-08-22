SELECT * FROM employees;

SELECT *
FROM employees
WHERE country != 'Brazil'

SELECT *
FROM employees
WHERE country = 'China'
AND start_date >= '2019-01-01'
AND start_date <= '2019-12-31';

SELECT *
FROM employees
WHERE country = 'China'
AND (start_date >= '2019-01-01'
OR pension_enrol = TRUE);

SELECT *
FROM employees
WHERE fte_hours BETWEEN 0.25 AND 0.5;

SELECT *
FROM employees
WHERE EXTRACT(YEAR FROM start_date) != 2017;

/* this works*/

SELECT *
FROM employees
WHERE extract(YEAR FROM start_date) = 2016
AND fte_hours >= 0.5;

/*this doesn't!*/

SELECT *
FROM employees
WHERE (start_date BETWEEN '2016-01-01' AND '2016-12-31')
AND fte_hours >= 0.5;

SELECT * 
FROM employees
WHERE (start_date BETWEEN '2016-01-01' AND '2016-12-31') AND fte_hours >= 0.5;

SELECT *
FROM employees
WHERE country IN ('Spain', 'South Africa', 'Ireland', 'Germany');

SELECT *
FROM employees
WHERE country = 'Greece'
AND last_name LIKE 'Mc%';

SELECT *
FROM employees
WHERE last_name LIKE '%ere%';

/* Find all employees having ‘a’ as the second letter of their first names. */

SELECT *
FROM employees
WHERE first_name LIKE '_a%';

/* Find all employees for whom the second letter of their last name is ‘r’ or ‘s’, and the third letter is ‘a’ or ‘o’. */

SELECT *
FROM employees
WHERE last_name ~ '^.[rs][ao]'

SELECT *
FROM employees
WHERE email IS NULL;

SELECT *
FROM employees
WHERE email IS NOT NULL;