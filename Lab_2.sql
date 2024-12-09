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