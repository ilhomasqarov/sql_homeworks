SELECT *
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);
