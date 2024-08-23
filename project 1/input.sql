INSERT INTO Department VALUES (1, 'HR', 'New York');
INSERT INTO Department VALUES (2, 'IT', 'San Francisco');

INSERT INTO Roles VALUES (1, 'Manager');
INSERT INTO Roles VALUES (2, 'Developer');

INSERT INTO Salaries VALUES (1, 70000);
INSERT INTO Salaries VALUES (2, 90000);

INSERT INTO OvertimeHours VALUES (1, 10);
INSERT INTO OvertimeHours VALUES (2, 20);

INSERT INTO Employees VALUES (1, 'John', 'Doe', 'M', '123 Main St', 'john.doe@example.com', 1, 1, 1, 1);
INSERT INTO Employees VALUES (2, 'Jane', 'Smith', 'F', '456 Oak St', 'jane.smith@example.com', 2, 2, 2, 2);


SELECT e.first_name, e.surname, e.gender, e.email, d.depart_name, d.depart_city, r.role, s.salary_pa, o.overtime_hours
FROM Employees e JOIN Department d ON e.depart_id = d.depart_id
JOIN Roles r ON e.role_id = r.role_id
JOIN Salaries s ON e.salary_id = s.salary_id
JOIN OvertimeHours o ON e.overtime_id = overtime_id