CREATE TABLE Departments ( 
DepartmentID INT PRIMARY KEY, 
DepartmentName VARCHAR(100) NOT NULL UNIQUE, 
ManagerID INT NOT NULL, 
Location VARCHAR(100) NOT NULL 
); 
CREATE TABLE Employee ( 
EmployeeID INT PRIMARY KEY, 
FirstName VARCHAR(100) NOT NULL, 
LastName VARCHAR(100) NOT NULL, 
DoB DATETIME NOT NULL, 
Gender VARCHAR(50) NOT NULL, 
HireDate DATETIME NOT NULL, 
DepartmentID INT NOT NULL, 
Salary DECIMAL(10, 2) NOT NULL, 
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) 
); -- Create Projects Table 
CREATE TABLE Projects ( 
ProjectID INT PRIMARY KEY, 
ProjectName VARCHAR(100) NOT NULL, 
StartDate DATETIME NOT NULL, 
EndDate DATETIME NOT NULL, 
DepartmentID INT NOT NULL, 
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) 
); 
INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID, Location) 
VALUES  
(1, 'IT', 101, 'New York'), 
(2, 'HR', 102, 'San Francisco'), 
(3, 'Finance', 103, 'Los Angeles'), 
(4, 'Admin', 104, 'Chicago'), 
(5, 'Marketing', 105, 'Miami'); 
INSERT INTO Employee (EmployeeID, FirstName, LastName, DoB, Gender, HireDate, DepartmentID, 
Salary) 
VALUES  
(101, 'John', 'Doe', '1985-04-12', 'Male', '2010-06-15', 1, 75000.00), 
(102, 'Jane', 'Smith', '1990-08-24', 'Female', '2015-03-10', 2, 60000.00), 
(103, 'Robert', 'Brown', '1982-12-05', 'Male', '2008-09-25', 3, 82000.00), 
(104, 'Emily', 'Davis', '1988-11-11', 'Female', '2012-07-18', 4, 58000.00), 
(105, 'Michael', 'Wilson', '1992-02-02', 'Male', '2018-11-30', 5, 67000.00); 
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate, DepartmentID) 
VALUES  
(201, 'Project Alpha', '2022-01-01', '2022-12-31', 1), 
(202, 'Project Beta', '2023-03-15', '2024-03-14', 2), 
(203, 'Project Gamma', '2021-06-01', '2022-05-31', 3), 
(204, 'Project Delta', '2020-10-10', '2021-10-09', 4), 
(205, 'Project Epsilon', '2024-04-01', '2025-03-31', 5);

--part A
--1
CREATE OR ALTER PROCEDURE PR_Employee_A_1
@FName varchar(100)=NULL,
@LName varchar(100)=NULL
AS
BEGIN
SELECT EmployeeID,DoB,Gender,HireDate FROM Employee where FirstName=@FName or LastName=@LName
END

exec PR_Employee_A_1 'john','doe'
exec PR_Employee_A_1 'john',null
exec PR_Employee_A_1 '','smith'

--2
CREATE OR ALTER PROCEDURE PR_DEPARTMENT_NAME
@DName VARCHAR(100)
AS
BEGIN
	SELECT * FROM Employee where EmployeeID = (Select ManagerID from Departments where DepartmentName=@DName)
END

exec PR_DEPARTMENT_NAME 'Hr'

--3
CREATE OR ALTER PROCEDURE PR_PROJECT_NAME
@PName varchar(100),
@DName varchar(100)
AS
BEGIN
	SELECT * FROM PROJECTS WHERE ProjectName=@PName AND DepartmentID = (Select DepartmentID from Department where DepartmentName=@DName)
END

exec PR_PROJECT_NAME 'Project Alpha','IT'

--4
CREATE OR ALTER PROCEDURE PR_EMPLOYEES_SAL
@MinSal DECIMAL(10,2),
@MaxSal DECIMAL(10,2)
AS
BEGIN
SELECT * FROM Employee where Salary BETWEEN @MinSal AND @MaxSal
END

exec PR_EMPLOYEES_SAL 56000,80000

--5
CREATE OR ALTER PROCEDURE PR_EMPLOYEES_HIREDATE
@Date DATETIME
AS
BEGIN
	SELECT * FROM EMPLOYEE WHERE HireDate=@Date
END

exec PR_EMPLOYEES_HIREDATE '2010-06-15'

--PART-B
--6
CREATE OR ALTER PROCEDURE PR_EMPLOYEE_GENDER
@Gender CHAR(1)
AS
BEGIN
	SELECT * from Employee WHERE substring(Gender,1,1) = @Gender
END

--7
CREATE OR ALTER PROCEDURE PR_EMPLOYEE_FNAME_DNAME
@FName varchar(100)=null,
@DName varchar(100)=null
AS
BEGIN
	SELECT * FROM EMPLOYEE WHERE FirstName=@FName or DepartmentID=(SELECT DepartmentID from Departments where DepartmentName=@DName)
END

--8
CREATE OR ALTER PROCEDURE PR_DEPARTMENTS_LOCATION
@Location varchar(100)
AS
BEGIN
	SELECT * FROM DEPARTMENTS WHERE Location Like '%'+@Location+'%'
END

--PART-C
--9
CREATE OR ALTER PROCEDURE PR_PROJECT_FROM_TO_DATE
@FromDate Datetime,
@ToDate Datetime
AS
BEGIN
	select * FROM Projects WHERE StartDate=@FromDate AND EndDate=@ToDate
END

--10
CREATE OR ALTER PROCEDURE PR_PROJECT_DEPARTMENT
@PName varchar(100),
@Location varchar(100)
AS
BEGIN
	SELECT d.DepartmentName,e.FirstName,e.LastName,p.ProjectName,p.StartDate,p.EndDate FROM Projects as p join Departments as d on p.DepartmentID=d.DepartmentID join Employee as e on e.EmployeeID=d.ManagerID
	where p.ProjectName=@PName and d.Location=@Location
END