CREATE DATABASE EmployeeDB;
USE EmployeeDB;

CREATE TABLE Department (
    depart_id INT PRIMARY KEY,
    depart_name VARCHAR(50),
    depart_city VARCHAR(50)
);

CREATE TABLE Roles (
    role_id INT PRIMARY KEY,
    role VARCHAR(50)
);

CREATE TABLE Salaries (
    salary_id INT PRIMARY KEY,
    salary_pa DECIMAL(10, 2)
);

CREATE TABLE OvertimeHours (
    overtime_id INT PRIMARY KEY,
    overtime_hours INT
);

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    surname VARCHAR(50),
    gender CHAR(1),
    address VARCHAR(100),
    email VARCHAR(100),
    depart_id INT,
    role_id INT,
    salary_id INT,
    overtime_id INT,
    FOREIGN KEY (depart_id) REFERENCES Department(depart_id),
    FOREIGN KEY (role_id) REFERENCES Roles(role_id),
    FOREIGN KEY (salary_id) REFERENCES Salaries(salary_id),
    FOREIGN KEY (overtime_id) REFERENCES OvertimeHours(overtime_id)
);
