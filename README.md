# SqlProjects

# Branch and Employee Management System

## About the Project
This project demonstrates SQL skills using a database that simulates branch and employee management for a corporate organization. It includes:
- Employee management and hierarchy
- Client interactions
- Supplier relationships
- Sales tracking

## Features
- Operations: Basic queries to retrieve specific data.
- Aggregate Functions: Summarize data such as total sales and average salaries.
- Joins: Combine data from multiple tables for meaningful insights.

## Dataset
The database consists of five tables:
1. Employee: Details about employees, their supervisors, and their assigned branches.
2. Branch: Information about branches and their managers.
3. Client: Clients associated with branches.
4. Works_With: Tracks interactions between employees and clients, including total sales.
5. Branch_Supplier: Stores branch supplier information.

## Example Queries
1. List all branches and their employees (include branches without employees)
  
   SELECT branch.branch_name, employee.first_name, employee.last_name
   FROM branch
   LEFT JOIN employee 
   ON branch.branch_id = employee.branch_id;
