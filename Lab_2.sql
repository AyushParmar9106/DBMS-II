-- Create Department Table 
CREATE TABLE Department ( 
DepartmentID INT PRIMARY KEY, 
DepartmentName VARCHAR(100) NOT NULL UNIQUE 
); 

-- Create Designation Table 
CREATE TABLE Designation ( 
DesignationID INT PRIMARY KEY, 
DesignationName VARCHAR(100) NOT NULL UNIQUE 
); 

-- Create Person Table 
CREATE TABLE Person ( 
PersonID INT PRIMARY KEY IDENTITY(101,1), 
FirstName VARCHAR(100) NOT NULL, 
LastName VARCHAR(100) NOT NULL, 
Salary DECIMAL(8, 2) NOT NULL, 
JoiningDate DATETIME NOT NULL, 
DepartmentID INT NULL, 
DesignationID INT NULL, 
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID), 
FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID) 
);
-------------------------------------------------------------
CREATE OR ALTER PROCEDURE PR_DEPARTMENT_INSERT
 
@DepartmentID INT, 
@DepartmentName VARCHAR(100)

AS BEGIN 
INSERT INTO Department VALUES (@DepartmentID,@DepartmentName)
END

EXEC PR_DEPARTMENT_INSERT 1,'ADMIN'
EXEC PR_DEPARTMENT_INSERT 2,'IT'
EXEC PR_DEPARTMENT_INSERT 3,'HR'
EXEC PR_DEPARTMENT_INSERT 4,'ACCOUNT'

SELECT * FROM DEPARTMENT
-------------------------------------------
CREATE OR ALTER PROCEDURE PR_Designation_INSERT
@DesignationID INT , 
@DesignationName VARCHAR(100)
AS BEGIN 
INSERT INTO Designation  VALUES (@DesignationID,@DesignationName)
END

EXEC PR_Designation_INSERT 11,'JOBBER'
EXEC PR_Designation_INSERT 12,'WELDER'
EXEC PR_Designation_INSERT 13,'CLERK'
EXEC PR_Designation_INSERT 14,'MANAGER'
EXEC PR_Designation_INSERT 15,'CEO'

SELECT * FROM Designation 
------------------------------------------------------
CREATE OR ALTER PROCEDURE PR_PERSON_INSERT

@FirstName VARCHAR(100) , 
@LastName VARCHAR(100) , 
@Salary DECIMAL(8, 2) , 
@JoiningDate DATETIME , 
@DepartmentID INT , 
@DesignationID INT 

AS BEGIN 
INSERT INTO Person  VALUES 
(@FirstName,@LastName,@Salary,
@JoiningDate,@DepartmentID,@DesignationID)
END


EXEC PR_PERSON_INSERT 'RAHUL','ANSHU',56000,'1990-01-01',1,12
EXEC PR_PERSON_INSERT 'HARDIK','HINSU',18000,'1990-09-25',2,11
EXEC PR_PERSON_INSERT 'BHAVIN','KAMANI',25000,'1991-05-14',NULL,11
EXEC PR_PERSON_INSERT 'BHOOMI','PATEL',39000,'2014-02-20',1,13
EXEC PR_PERSON_INSERT 'ROHIT','RAJGOR',17000,'1990-0723',2,15
EXEC PR_PERSON_INSERT 'PRIYA','MEHTA',25000,'1990-10-18',2,NULL
EXEC PR_PERSON_INSERT 'NEHA','TRIVEDI',18000,'2014-02-20',3,15

SELECT * FROM Person

---------------------------------------------------------------------
CREATE OR ALTER PROCEDURE PR_DEPARTMENT_DELETE 
@DepartmentID INT
AS BEGIN
DELETE FROM DEPARTMENT
WHERE DepartmentID = @DepartmentID
END

EXEC PR_DEPARTMENT_DELETE 1

SELECT * FROM Department

------------------------------------------
CREATE OR ALTER PROCEDURE PR_Designation_DELETE  
@DesignationID  INT
AS BEGIN
DELETE FROM Designation
WHERE DesignationID  = @DesignationID 
END

EXEC PR_Designation_DELETE 11

SELECT * FROM Designation
--------------------------------------------------
CREATE OR ALTER PROCEDURE PR_PERSON_DELETE  
@PERSONID  INT
AS BEGIN
DELETE FROM Person
WHERE PERSONID  = @PERSONID
END

EXEC PR_PERSON_DELETE 11

SELECT * FROM Person
----------------------------------------------------

CREATE OR ALTER PROCEDURE PR_UPDATE_DEPARTMENT
@DepartmentID INT, 
@DepartmentName VARCHAR(100)
AS BEGIN
UPDATE Department
SET DepartmentName=@DepartmentName WHERE DepartmentID = @DepartmentID
END

EXEC PR_UPDATE_DEPARTMENT 1,PEON
-----------------------------------------------------
CREATE OR ALTER PROCEDURE PR_UPDATE_DESIGNATION
@DesignationID INT , 
@DesignationName VARCHAR(100)
AS BEGIN
UPDATE Designation
SET DesignationID=@DesignationID WHERE DesignationName = @DesignationName
END

EXEC PR_UPDATE_DESIGNATION 15,'CEO'

-----------------------------------------------------------
CREATE OR ALTER PROCEDURE PR_UPDATE_PERSON
@FirstName VARCHAR(100) , 
@LastName VARCHAR(100)

AS BEGIN
UPDATE Person
SET FirstName=@FirstName WHERE LastName = @LastName
END
EXEC PR_UPDATE_PERSON 'RAHUL','RAHUL'

--------------------------------------------------------

CREATE OR ALTER PROCEDURE PR_DEPARTMENT_SELECTBYPRIMARYKEY
@DID INT
AS
BEGIN
	SELECT * FROM Department WHERE DepartmentID=@DID
END

CREATE OR ALTER PROCEDURE PR_DESIGNATION_SELECTBYPRIMARYKEY
@DID INT
AS
BEGIN
	SELECT * FROM Designation WHERE DesignationID=@DID
END

CREATE OR ALTER PROCEDURE PR_PERSON_SELECTBYPRIMARYKEY
@PID INT
AS
BEGIN
	SELECT * FROM Person WHERE PersonID=@PID
END
-------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE PR_PERSON_JOIN
AS
BEGIN
	SELECT * FROM PERSON AS P JOIN DEPARTMENT
	AS DEP ON P.DepartmentID=DEP.DepartmentID JOIN DESIGNATION 
	AS desi ON p.designationID=desi.designationID
END

----------------------------------------------------------------
CREATE OR ALTER PROCEDURE PR_PERSON_FIRST_THREE
AS
BEGIN
	SELECT TOP 3 * FROM PERSON
END

--PART-B
--5 
CREATE OR ALTER PROCEDURE PR_DEPARTMENT_NAME
@DeptName varchar(100)
AS
BEGIN
	SELECT * FROM PERSON AS p JOIN DEPARTMENT AS d ON p.departmentID=d.departmentID WHERE d.DepartmentName=@DeptName
END

--6 
CREATE OR ALTER PROCEDURE PR_PERSON_DISPLAY
@DeptName varchar(100),
@DesName varchar(100)
AS
BEGIN
	SELECT FirstName,Salary,JoiningDate,DepartmentName FROM PERSON AS p join Department AS dep on p.DepartmentID=dep.DepartmentID join Designation AS desi on p.DesignationID=desi.DesignationID
	WHERE dep.departmentName=@DeptName AND desi.designationName=@DesName
END

--7 
CREATE OR ALTER PROCEDURE PR_PERSON_FIRSTNAME
@FName varchar(100)
AS
BEGIN
	SELECT * FROM Person AS p join department as dep on p.departmentID=dep.departmentID join designation as desi on p.designationID=desi.designationID
	where p.FirstName=@FName
END

--8
CREATE OR ALTER PROCEDURE PR_DEPARTMENT_MAX_MIN_SUM
AS
BEGIN
	SELECT dep.DepartmentName,MAX(p.SALARY),MIN(p.SALARY),SUM(p.SALARY) FROM Department AS dep JOIN Person AS p on p.DepartmentID=dep.DepartmentID
	group by dep.DepartmentName
END

--9
CREATE OR ALTER PROCEDURE PR_DESIGNATION_AVG_SUM
AS
BEGIN
	SELECT desi.DesignationName,AVG(p.salary),SUM(p.salary) FROM PERSON AS P JOIN DESIGNATION AS DESI ON P.DESIGNATIONID=DESI.DESIGNATIONID
	GROUP BY desi.DesignationName
END

--PART-C
--10
CREATE OR ALTER PROCEDURE PR_PERSON_COUNT
@DeptName varchar(100)
AS
BEGIN
	SELECT COUNT(p.PERSONID) FROM PERSON AS p JOIN Department AS dept on p.DepartmentID=dept.DepartmentID WHERE DepartmentName=@DeptName
END

--11
CREATE OR ALTER PROCEDURE PR_PERSON_SALARY
@Sal Decimal(8,2)
AS
BEGIN
	SELECT * FROM PERSON AS P JOIN DEPARTMENT AS DEP ON P.DEPARTMENTID=DEP.DEPARTMENTID JOIN DESIGNATION AS DESI ON P.DESIGNATIONID=DESI.DESIGNATIONID
	WHERE P.SALARY>@Sal
END

--12
CREATE OR ALTER PROCEDURE PR_DEPARTMENT_TOTAL_SAL
AS
BEGIN
	SELECT dep.DepartmentName, SUM(p.salary) AS TotalSalary FROM Department AS dep JOIN Person AS p ON dep.DepartmentID = p.DepartmentID GROUP BY dep.DepartmentName HAVING SUM(p.salary) = (SELECT MAX(DepartmentTotal) FROM (SELECT SUM(p.salary) AS DepartmentTotal FROM Department AS d JOIN Person AS p ON d.DepartmentID = p.DepartmentID GROUP BY d.DepartmentID) AS Subquery);

END

--13
CREATE OR ALTER PROCEDURE PR_DESIGNATION_LAST_TEN
@DesigName varchar(100)
AS
BEGIN
	SELECT p.FirstName,p.LastName,dep.DepartmentName FROM PERSON AS p join Department AS dep on p.DepartmentID=dep.DepartmentID join Designation AS desig on p.DesignationID=desig.DesignationID
	where year(getDate())-year(p.JoiningDate)<=10
END

--14
CREATE OR ALTER PROCEDURE PR_DEPARTMENT_NO_DESIGNATION
AS
BEGIN
	SELECT dep.DepartmentName,p.FirstName,p.LastName FROM DEPARTMENT AS dep JOIN PERSON AS p on dep.DepartmentID=p.DepartmentID where p.DesignationID IS NULL
END

--15
CREATE OR ALTER PROCEDURE PR_DEPARTMENT_AVG_SAL
AS
BEGIN
	SELECT dept.DepartmentName,avg(p.salary) FROM DEPARTMENT AS dept JOIN PERSON AS p ON dept.DepartmentID=p.DepartmentID group by dept.DepartmentName having avg(p.salary)>12000
END