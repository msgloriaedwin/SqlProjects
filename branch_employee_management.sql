Use sqltraining;

-- =============================================
-- SCHEMA CREATION
-- =============================================

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    birth_day DATE,
    sex VARCHAR(1),
    salary INT,
    super_id INT,
    branch_id INT,
    FOREIGN KEY(super_id) REFERENCES employee(emp_id) ON DELETE SET NULL,
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE branch (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(40),
    mgr_id INT,
    mgr_start_date DATE,
    FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

CREATE TABLE client (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(40),
    branch_id INT,
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with (
    emp_id INT,
    client_id INT,
    total_sales INT,
    PRIMARY KEY(emp_id, client_id),
    FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
    FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
    branch_id INT,
    supplier_name VARCHAR(40),
    supply_type VARCHAR(40),
    PRIMARY KEY(branch_id, supplier_name),
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

-- =============================================
-- INSERT DATA
-- =============================================

INSERT INTO employee VALUES (100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);
INSERT INTO employee VALUES (101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);
INSERT INTO employee VALUES (102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, 2);

INSERT INTO branch VALUES (1, 'Corporate', 100, '2006-02-09');
INSERT INTO branch VALUES (2, 'Scranton', 102, '1992-04-06');

INSERT INTO client VALUES (400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES (401, 'Lackawanna County', 2);

INSERT INTO works_with VALUES (102, 400, 267000);
INSERT INTO works_with VALUES (102, 401, 15000);

INSERT INTO branch_supplier VALUES (2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES (2, 'Uni-ball', 'Writing Utensils');

-- =============================================
-- OPERATIONS
-- =============================================

-- Retrieve details of employees working in a specific branch
SELECT emp_id, first_name, last_name, salary
FROM employee
WHERE branch_id = 2
ORDER BY salary DESC
LIMIT 3;

-- List all suppliers for a specific branch
SELECT supplier_name, supply_type
FROM branch_supplier
WHERE branch_id = 2;

-- Retrieve sales records for a specific employee
SELECT emp_id, total_sales
FROM works_with
WHERE emp_id = 102;

-- Update the salary of an employee
UPDATE employee
SET salary = salary + 5000
WHERE emp_id = 102;

-- List all unique supply types available in the branch_supplier table
SELECT DISTINCT supply_type
FROM branch_supplier;

-- Count the total number of clients in the works_with table
SELECT COUNT(DISTINCT client_id) AS total_clients
FROM works_with;

-- Identify employees who earn more than a specific amount
SELECT emp_id, first_name, last_name, salary
FROM employee
WHERE salary > 80000
ORDER BY salary DESC;

-- =============================================
-- AGGREGATE FUNCTIONS
-- =============================================

-- Count the total number of employees
SELECT COUNT(emp_id) AS total_employees
FROM employee;

-- Calculate the total sales recorded in the 'works_with' table
SELECT SUM(total_sales) AS total_sales
FROM works_with;

-- Find the average salary of all employees
SELECT AVG(salary) AS average_salary
FROM employee;

-- Find the minimum and maximum sales recorded
SELECT MIN(total_sales) AS minimum_sales, MAX(total_sales) AS maximum_sales
FROM works_with;

-- =============================================
-- JOINS
-- =============================================

-- List all employees along with the branches they work for
SELECT employee.first_name, employee.last_name, branch.branch_name
FROM employee
INNER JOIN branch 
ON employee.branch_id = branch.branch_id;

-- List all branches and their employees (include branches without employees)
SELECT branch.branch_name, employee.first_name, employee.last_name
FROM branch
LEFT JOIN employee 
ON branch.branch_id = employee.branch_id;

-- List all employees and their branches (include employees without branches)
SELECT employee.first_name, employee.last_name, branch.branch_name
FROM employee
RIGHT JOIN branch 
ON employee.branch_id = branch.branch_id;

-- =============================================
-- UNION
-- =============================================

-- List of All Employees and Branches, Including Unassigned Managers and Unmanaged Branches

SELECT employee.emp_id, employee.first_name, branch.branch_name 
FROM employee 
LEFT JOIN branch 
ON employee.emp_id = branch.mgr_id 

UNION  

SELECT employee.emp_id, employee.first_name, branch.branch_name 
FROM employee 
RIGHT JOIN branch 
ON employee.emp_id = branch.mgr_id;

-- List all branch names and client names in one result set

SELECT branch.branch_name AS name, 'Branch' AS type
FROM branch

UNION

SELECT client.client_name AS name, 'Client' AS type
FROM client;






 
