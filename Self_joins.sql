USE sql_hr;

-- Updating the reports_to column for the employee with employee_id 80529
UPDATE employees
SET reports_to = 84791 
WHERE employee_id = 80529;


-- The SELECT statement employs a LEFT JOIN operation to retrieve and display a list of employees along with their respective managers.
-- This query provides a clear overview of the updated reporting hierarchy, facilitating seamless communication and collaboration within the organization.
SELECT 
	e.employee_id, 
    CONCAT(e.first_name, " ", e.last_name) AS employee_name,
    CONCAT(mg.first_name, " ", mg.last_name) AS manager_name
FROM employees e
LEFT JOIN  employees mg 
	ON e.reports_to = mg.employee_id;
    
