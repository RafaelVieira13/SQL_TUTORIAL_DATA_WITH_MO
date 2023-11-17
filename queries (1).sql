-- SELECT statement

-- Select All the Table
SELECT  *
FROM employees;

SELECT *
FROM shops;

SELECT *
from suppliers;

select *
from locations;

-- Select Specific columns
SELECT employee_id, first_name, last_name
FROM employees;

SELECT employee_id, hire_date, salary
FROM employees;

--===================================================

-- WHERE clause + AND & OR

-- Select only the employees who make more than 50k
SELECT *
FROM employees
WHERE salary > 50000;

-- Select only the ememployees who work in Common Grounds coffeshop, it means coffeeshop_id = 1
SELECT *
FROM employees
WHERE coffeeshop_id = 1;

-- Select only the employees who work in Common Grounds and make more than 50k
SELECT *
FROM employees
WHERE salary > 50000 AND coffeeshop_id = 1;

-- Select only the employees who work in Common Grounds orake more than 50k
SELECT *
FROM employees
WHERE salary > 50000 OR coffeeshop_id = 1;

-- Select all the employees who work in Common Grounds, make more than 50k and are male
SELECT *
FROM employees
WHERE coffeeshop_id = 1
AND salary > 50000
AND gender = 'M';


--=======================================================

-- IN, NOT IN, IS NULL, BETWEEN

-- Select all rows from the suppliers table where the supplier is Beans and Barley
SELECT *
from suppliers
where supplier_name = 'Beans and Barley';

-- Select all rows from the suppliers table where the supplier is NOT Beans and Barley
SELECT *
FROM suppliers
WHERE NOT supplier_name = 'Beans and Barley';

SELECT *
FROM suppliers
WHERE supplier_name <> 'Beans and Barley';


-- Select all Robusta and Arabica coffee types
SELECT *
FROM suppliers
WHERE coffee_type IN ('Robusta','Arabica');

-- Select all coffee types that are not Robusta or Arabica
SELECT *
FROM suppliers
WHERE coffee_type Not IN ('Robusta','Arabica');

-- Select all employees with missing email addresses
SELECT *
FROM employees
WHERE email IS NULL;

-- Select all employees whose emails are not missing
SELECT *
FROM employees
WHERE NOT email IS NULL;

-- Select all employees who make between 35k and 50k
SELECT *
FROM employees
WHERE salary BETWEEN 35000 AND 50000;

--===========================================================

-- ORDER BY, LIMIT, DISTINCT, Renaming columns

-- Order by salary ascending 
SELECT *
FROM employees
ORder by salary asc ;

-- Order by salary descending 
select employee_id, first_name, last_name, salary
FROM employees
ORDER BY salary DESC;

-- Top 10 highest paid employees
select employee_id, first_name, last_name, gender, salary
FROM employees
ORDER BY salary DESC
LIMIT 10

-- Return all unique coffeeshop ids
SELECT DISTINCT coffeeshop_id
from shops;

-- Return all unique countries
SELECT DISTINCT country
FROM locations;

-- Renaming columns
SELECT 
	email,
	email AS email_address,
    hire_date,
	hire_date AS date_joined,
    salary,
	salary AS pay
from employees;


--=========================================================

-- EXTRACT
SELECT 
	hire_date,
	EXTRACT(YEAR FROM hire_date) AS year,
    EXTRACt(MONTH FROM hire_date) AS mONTH,
    extract(day from hire_date) AS DAY
FROM employees;

--=========================================================

-- UPPER, LOWER, LENGTH, TRIM

-- Uppercase first and last names
SELECT
	first_name,
    UPPER(first_name) AS first_name_upper,
    last_name,
    UPPER(last_name) AS last_name_upper
FROM employees;

-- Lowercase first and last names
SELECT
	first_name,
    LOWER(first_name) AS first_name_lower,
    LOWER(last_name) AS last_name_lower
FROM employees;

-- Return the email and the length of emails
SELECT
	email,
    LENGTH(email) AS email_length
FROM employees

-- TRIM (Remove all the white Spaces)
SELECT
    LENGTH('     HELLO     ') AS hello_with_spaces,
LENGTH('HELLO') AS hello_no_spaces,
    LENGTH(TRIM('     HELLO     ')) AS hello_trimmed;

--=========================================================

-- Concatenation, Boolean expressions, wildcards

-- Concatenate first and last names to create full names
SELECT 
	first_name,
    last_name,
	first_name || ' ' || last_name AS full_name
FROM employees

-- Concatenate columns to create a sentence
SELECT 
	first_name || ' ' || last_name || ' makes '|| salary
FROM employees

-- Boolean expressios
-- if the person makes less than 50k, then true, otherwise false
SELECT 
	first_name || ' ' ||last_name AS full_name,
    (salary < 50000) AS less_than_50K
FROM employees;

-- if the person is a female and makes less than 50k, then true, otherwise false
SELECT
	first_name || ' ' || last_name AS full_name,
    (salary < 50000 AND gender = 'F') AS less_than_50K_female
FROM employees;

-- Boolean expressions with wildcards (% subString)
-- if email has '.com', return true, otherwise false
SELECT
	email,
    (email like '%.com%') AS dotcom_flag
FROM employees;

-- return only government employees
SELECT 
	email,
    (email like '%.gov%') AS dotgov_flag
FROM employees;

--==========================================================

-- SUBSTRING, POSITION, COALESCE

-- SUBSTRING
-- Get the email from the 5th character
SELECT 
	email,
    SUBSTRING (email FROM 5)
FROM employees;

-- POSITION
-- Find the position of '@' in the email
SELECT 
	email,
    POSITION('@' IN email)
 FROM employees;

-- SUBSTRING & POSITION to find the email client
SELECT
	email,
    SUBSTRING(email FROM POSITION('@' IN email))
FROM employees;


SELECT
	email,
    SUBSTRING(email FROM POSITION('@' IN email) + 1)
FROM employees;

-- COALESCE to fill missing emails with custom value
SELECT 
	email,
    COALESCE(email, 'NO EMAIL PROVIDED')
FROM employees;

--===================================================

-- MIN, MAX, AVG, SUM, COUNT

-- Select the minimum salary
SELECT 
	MIN(salary) AS min_salary
FROM employees;

-- Select the maximum salary
SELECT 
	MAX(salary) AS max_salary
FROM employees;

-- Select difference between maximum and minimum salary
SELECT
	MAX(salary) - min(salary) as dif_max_min_salary
FROM employees;

-- Select the average salary
SELECT 
	AVG(salary) AS avg_salary
FROM employees;

-- Round average salary to nearest integer
SELECT 
	ROUND(AVG(salary),0) AS avg_salary
FROM employees;

-- Sum up the salaries
SELECT 
	SUM(salary) AS sum_salary
 FROM employees;

-- Count the number of entries
SELECT COUNT(*)
FROM employees;

SELECT COUNT(salary)
FROM employees;

SELECT COUNT(email)
FROM employees;

-- summary
SELECT 
	Max(salary) AS max_salary,
    ROUND(avg(salary), 0) as AVG_SALARY,
    min(SALARY) as min_salary,
    sum(SALARY) as total_salary,
    COUNT(*) as number_of_emp
FROM employees;

--=========================================================

-- GROUP BY & HAVING

-- Return the number of employees for each coffeeshop
SELECT 
	coffeeshop_id,
	COUNT(employee_id) AS number_employees 
FROM employees
GROUP BY coffeeshop_id;

-- Return the total salaries for each coffeeshop
SELECT
	coffeeshop_id,
    SUM(salary) AS total_salary
FROM employees
GROUP by coffeeshop_id;

-- Return the number of employees, the avg & min & max & total salaries for each coffeeshop
SELECT 
	coffeeshop_id,
    COUNT(*) AS numb_employees,
    ROUND(AVG(salary), 0) AS avg_salary,
    Min(salary) AS min_salary,
    MAX(salary) AS max_salary,
    SUM(salary) AS total_salary
from employees
group by coffeeshop_id
ORDER BY numb_employees DESC;

-- HAVING
-- After GROUP BY, return only the coffeeshops with more than 200 employees
SELECT 
	coffeeshop_id,
    COUNT(*) AS numb_employees,
    ROUND(AVG(salary), 0) AS avg_salary,
    Min(salary) AS min_salary,
    MAX(salary) AS max_salary,
    SUM(salary) AS total_salary
from employees
group by coffeeshop_id
HAVING COUNT(*) > 200
ORDER BY numb_employees DESC;

-- After GROUP BY, return only the coffeeshops with a minimum salary of less than 10k
SELECT 
	coffeeshop_id,
    COUNT(*) AS numb_employees,
    ROUND(AVG(salary), 0) AS avg_salary,
    Min(salary) AS min_salary,
    MAX(salary) AS max_salary,
    SUM(salary) AS total_salary
from employees
group by coffeeshop_id
HAVING MIN(salary) < 10000
ORDER BY numb_employees DESC;


--=========================================================

-- CASE, CASE with GROUP BY, and CASE for transposing data

-- CASE
-- If pay is less than 50k, then low pay, otherwise high pay
SELECT
	employee_id,
    first_name,
    last_name,
    salary,
    CASE
    	WHEN salary < 50000 THEN 'low pay'
        WHEN salary >= 50000 THEN 'high pay'
        ELSE 'no pay'
    END AS earn_class
FROM employees;


-- If pay is less than 20k, then low pay
-- if between 20k-50k inclusive, then medium pay
-- if over 50k, then high pay
SELECT 
	employee_id,
    first_name,
    last_name,
    salary,
    CASE
    	WHEN salary < 20000 THEN 'low pay'
        WHEN salary BETWEEN 20000 AND 50000 THEN 'medium pay'
        WHEN salary > 50000 THEN 'high pay'
        ELSE 'no pay'
     END as earn_class
 FROM employees
 ORDER BY salary DESC;

-- CASE & GROUP BY 
-- Return the count of employees in each pay category
SELECT a.pay_category, COUNT(*)
FROM(
	SELECT
		employee_id,
	    first_name || ' ' || last_name as full_name,
		salary,
    CASE
			WHEN salary < 20000 THEN 'low pay'
			WHEN salary BETWEEN 20000 and 50000 THEN 'medium pay'
			WHEN salary > 50000 THEN 'high pay'
			ELSE 'no pay'
		END as pay_category
	FROM employees
	ORDER BY salary DESC
) a
GROUP BY a.pay_category;

-- Transpose above
select 
	sum(case when salary < 20000 then 1 else 0 end) as low_pay,
    SUM(CASE WHEN salary BETWEEN 20000 AND 50000 THEN 1 ELSE 0 END) AS medium_pay,
    SUM(CASE when SALARY > 50000 then 1 else 0 end) as HIGH_PAY
from employees;

--================================================

-- JOIN

-- Inserting values just for JOIN exercises
INSERT INTO locations VALUES (4, 'Paris', 'France');
INSERT INTO shops VALUES (6, 'Happy Brew', NULL);

-- Checking the values we inserted
select * from shops;
SELECT * FROM locations;

-- "INNER JOIN" same as just "J0iN"
SELECT s.coffeeshop_name, l.city, l.country
FROM shops s
INNER JOIN locations l
ON s.city_id = l.city_id;

SELECT s.coffeeshop_name, l.city, l.country
FROM shops s
JOIN locations l
ON s.city_id = l.city_id;

-- LEFT JOIN
SELECT s.coffeeshop_name, l.city, l.country
FROM shops s
LEFT JOIN locations l
ON s.city_id = l.city_id;

-- RIGHT JOIN
SELECT s.coffeeshop_name, l.city, l.country
FROM shops s
RIGHT JOIN locations l
ON s.city_id = l.city_id;

-- FULL OUTER JOIN
SELECT s.coffeeshop_name, l.city, l.country
FROM shops s
FULL OUTER JOIN locations l
ON s.city_id = l.city_id;

-- Delete the values we created just for the JOIN exercises
DELETE FROM locations WHERE city_id = 4;
DELETE FROM shops WHERE coffeeshop_id = 6;

--========================================================

-- UNION (to stack data on top each other)

-- Return all cities and countries
SELECT city FROM locations
UNION
select country FROM locations;

-- UNION removes duplicates
SELECT country FROM locations
UNION
select country FROM locations;

-- UNION ALL keeps duplicates
SELECT country FROM locations
UNION ALL
select country FROM locations;

-- Return all coffeeshop names, cities and countrie
SELECT coffeeshop_name FROM shops
UNION
SELECT city FROM locations
UNION
SELECT country FROM locations;

--=================================================

-- Subqueries

-- Basic subqueries with subqueries in the FROM clause
SELECT *
FROM (SELECT * FROM employees WHERE coffeeshop_id IN (3,4)) a;

SELECT a.employee_id, a.first_name, A.last_name
FROM (SELECT * FROM employees WHERE coffeeshop_id IN (3,4)) a;

-- Basic subqueries with subqueries in the SELECT clause
SELECT
	first_name,
    last_name,
    salary,
    (SELECT MAX(salary) FROM employees LIMIT 1)
FROM employees;

SELECT
	first_name,
    last_name,
    salary,
    (select ROUND(AVG(salary),0) from employees limit 1)
from employees;

SELECT
	first_name,
    last_name,
    SALARY,
    (SELECT MIN(salary) FROM employees LIMIT 1)
 FROM employees;
 
 SELECT
	first_name,
    last_name,
    salary,
    salary - (select ROUND(AVG(salary),0) from employees limit 1)
from employees;

-- Subqueries in the WHERE clause
-- Return all US coffee shops
SELECT *
FROM shops
WHERE city_id IN
	(SELECT city_id FROM locations
     where COUNTRY = 'United States');
     
-- Return all employees who work in US coffee shops
SELECT *
FROM employees
WHERE coffeeshop_id IN ( -- US coffeeshop_id's
	SELECT coffeeshop_id 
	FROM shops
	WHERE city_id IN ( -- US city-id's
		SELECT city_id
		FROM locations
		WHERE country = 'United States'
	)
);

-- Return all employees who make over 35k and work in US coffee shops
SELECT *
FROM employees
WHERE salary > 35000 AND coffeeshop_id IN ( -- US coffeeshop_id's
	SELECT coffeeshop_id
	FROM shops
	WHERE city_id IN ( -- US city_id's
		SELECT city_id
		FROM locations
		WHERE country = 'United States'
	)
);

-- 30 day moving total pay
-- The inner query calculates the total_salary of employees who were hired "within" the 30-day period before the hire_date of the current employee
SELECT
	hire_date,
	salary,
	(
		SELECT SUM(salary)
		FROM employees e2
		WHERE e2.hire_date BETWEEN e1.hire_date - 30 AND e1.hire_date
	) AS pay_pattern
FROM employees e1
ORDER BY hire_date;