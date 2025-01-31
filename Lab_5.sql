-- Creating PersonInfo Table
CREATE TABLE PersonInfo (
PersonID INT PRIMARY KEY,
PersonName VARCHAR(100) NOT NULL,
Salary DECIMAL(8,2) NOT NULL,
JoiningDate DATETIME NULL,
City VARCHAR(100) NOT NULL,
Age INT NULL,
BirthDate DATETIME NOT NULL
);

-- Creating PersonLog Table
CREATE TABLE PersonLog (
PLogID INT PRIMARY KEY IDENTITY(1,1),
PersonID INT NOT NULL,
PersonName VARCHAR(250) NOT NULL,
Operation VARCHAR(50) NOT NULL,
UpdateDate DATETIME NOT NULL,

);
drop table PersonLog
--create trigger [trigger_name] 
--[before | after]  
--{insert | update | delete}  
--on [table_name]  
--FOR EACH ROW
--BEGIN
--END

--CREATE TRIGGER prevent_table_creation
--ON DATABASE
--FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
--AS 
--BEGIN
--   PRINT 'you can not create, drop and alter table in this database';
--   ROLLBACK;
--END;

--part A
--1
alter trigger  tr_insert_PersonInfo
on PersonInfo
After insert,update,delete
As begin 
		print 'Your record is inserted'
End;
drop trigger tr_insert_PersonInfo

insert into PersonInfo values(3,'Ayush',150000,'2006-10-09','rajkot',18,'2002-09-02')

--2
create or Alter trigger  tr_Person_After_insert2
on PersonInfo
After insert
As begin 
	Declare @PersonID INT, @PersonName varchar(100)

	select  @PersonID = PersonID from inserted
	select @PersonName = PersonName FROM inserted

	insert into PersonLog(PersonId,PersonName,Operation,UpdateDate)
	Values(@PersonID,@PersonName,'Inserted',GETDATE())
End;
drop trigger tr_Person_After_insert2

insert into PersonInfo values(4,'Dev',150000,'2006-10-09','rajkot',18,'2002-09-02')



Select * from PersonInfo
Select * from PersonLog

create or Alter trigger  tr_Person_After_Update
on PersonInfo
After update
As begin 
	Declare @PersonID INT, @PersonName varchar(100)

	select  @PersonID = PersonID from inserted
	select @PersonName = PersonName FROM inserted

	insert into PersonLog(PersonId,PersonName,Operation,UpdateDate)
	Values(@PersonID,@PersonName,'Updated',GETDATE())
End;


update PersonInfo set PersonName='Raj' where PersonID=2


create or Alter trigger  tr_Person_After_Delete
on PersonInfo
After Delete
As begin 
	Declare @PersonID INT, @PersonName varchar(100)

	select  @PersonID = PersonID from inserted
	select @PersonName = PersonName FROM inserted

	insert into PersonLog(PersonId,PersonName,Operation,UpdateDate)
	Values(@PersonID,@PersonName,'Deleted',GETDATE())
End;

delete from PersonInfo where PersonID=2


--3

create or Alter trigger  tr_Person_After_insert2
on PersonInfo
Instead of insert
As begin 
	Declare @PersonID INT, @PersonName varchar(100)

	select  @PersonID = PersonID from inserted
	select @PersonName = PersonName FROM inserted

	insert into PersonLog(PersonId,PersonName,Operation,UpdateDate)
	Values(@PersonID,@PersonName,'Inserted',GETDATE())
End;


create or Alter trigger  tr_Person_After_Update
on PersonInfo
Instead of Update
As begin 
	Declare @PersonID INT, @PersonName varchar(100)

	select  @PersonID = PersonID from inserted
	select @PersonName = PersonName FROM inserted

	insert into PersonLog(PersonId,PersonName,Operation,UpdateDate)
	Values(@PersonID,@PersonName,'Updated',GETDATE())
End;


create or Alter trigger  tr_Person_After_Delete
on PersonInfo
Instead of Delete
As begin 
	Declare @PersonID INT, @PersonName varchar(100)

	select  @PersonID = PersonID from inserted
	select @PersonName = PersonName FROM inserted

	insert into PersonLog(PersonId,PersonName,Operation,UpdateDate)
	Values(@PersonID,@PersonName,'Deleted',GETDATE())
End;
drop trigger tr_Person_After_Delete
drop trigger tr_Person_After_Update
drop trigger tr_Person_After_insert2

--4
CREATE TRIGGER tr_Person_NameUpper_Inset
ON PersonInfo
AFTER INSERT
AS
BEGIN
	DECLARE @Uname VARCHAR(50)
	DECLARE @PersonID int

	select @Uname=PersonName from inserted
	select @PersonID=PersonID from inserted

	UPDATE PersonInfo
	SET PersonName=Upper(@Uname)
	WHERE PersonID=@PersonID
END

--5
Create TRIGGER tr_PersonInfo_PreventDuplicateName
ON PersonInfo
INSTEAD OF INSERT
AS
BEGIN
    INSERT INTO PersonInfo (PersonID, PersonName, Salary, JoiningDate, City, Age, BirthDate)
    SELECT 
        PersonID, 
        PersonName, 
        Salary, 
        JoiningDate, 
        City, 
        Age, 
        BirthDate
    FROM inserted
    WHERE PersonName NOT IN (SELECT PersonName FROM PersonInfo);
END;
select * from PersonInfo


insert into PersonInfo values(5,'Ayush',150000,'2006-10-09','rajkot',18,'2002-09-02')
--6.
CREATE TRIGGER tr_PersonInfo_PreventUnderage
ON PersonInfo
INSTEAD OF INSERT
AS
BEGIN

    INSERT INTO PersonInfo (PersonID, PersonName, Salary, JoiningDate, City, Age, BirthDate)
    SELECT 
        PersonID, 
        PersonName, 
        Salary, 
        JoiningDate, 
        City, 
        Age, 
        BirthDate
    FROM inserted
    WHERE Age >= 18;
END;


-------------------------------Part – B---------------------
--7.
CREATE TRIGGER tr_Person_CalculateAge
ON PersonInfo
AFTER INSERT
AS
BEGIN
    UPDATE PersonInfo
    SET Age = DATEDIFF(YEAR, i.BirthDate, GETDATE())
    FROM PersonInfo p
    JOIN inserted i ON p.PersonID = i.PersonID
END;

--8
CREATE TRIGGER tr_Person_LimitSalaryDecrease
ON PersonInfo
AFTER UPDATE
AS
BEGIN
    DECLARE @OldSalary DECIMAL(8,2), @NewSalary DECIMAL(8,2);
    
	SELECT @OldSalary = d.Salary, @NewSalary = i.Salary
    FROM deleted d
    JOIN inserted i ON d.PersonID = i.PersonID;

    IF @NewSalary < @OldSalary * 0.9
    BEGIN
        UPDATE PersonInfo
        SET Salary = @OldSalary
        WHERE PersonID IN (SELECT PersonID FROM inserted);
    END
END;

-------------------------Part – C-----------------------------------

--9.
CREATE TRIGGER tr_Person_UpdateJoiningDate
ON PersonInfo
AFTER INSERT
AS
BEGIN
    UPDATE PersonInfo
    SET JoiningDate = GETDATE()
    FROM PersonInfo p
    JOIN inserted i ON p.PersonID = i.PersonID
    WHERE i.JoiningDate IS NULL;
END;

--10.
CREATE TRIGGER tr_PersonLog_Delete
ON PersonLog
AFTER DELETE
AS
BEGIN
    PRINT 'Record deleted successfully from PersonLog';
END;




























