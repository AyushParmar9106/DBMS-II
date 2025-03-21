-- Create the Customers table
CREATE TABLE Customers (
    Customer_id INT PRIMARY KEY,                
    Customer_Name VARCHAR(250) NOT NULL,        
    Email VARCHAR(50) UNIQUE                    
);

-- Create the Orders table
CREATE TABLE Orders (
    Order_id INT PRIMARY KEY,                   
    Customer_id INT,                            
    Order_date DATE NOT NULL,                   
    FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id) 
);

--Part A
--1
BEGIN TRY
    DECLARE @num1 INT = 10, @num2 INT = 0, @result INT;
    SET @result = @num1 / @num2;
END TRY
BEGIN CATCH
    PRINT 'Error occurs that is - Divide by zero error.';
END CATCH;

--2
BEGIN TRY
    DECLARE @strValue VARCHAR(10) = 'ABC';
    DECLARE @intValue INT;
    SET @intValue = CAST(@strValue AS INT);
END TRY
BEGIN CATCH
    PRINT 'Error: Unable to convert string to integer.';
END CATCH;

--3
CREATE PROCEDURE PR_Calculation_SumWithErrorHandling
    @num1 NVARCHAR(50),
    @num2 NVARCHAR(50)
AS
BEGIN
    BEGIN TRY
        DECLARE @intNum1 INT = CAST(@num1 AS INT);
        DECLARE @intNum2 INT = CAST(@num2 AS INT);
        PRINT 'Sum is: ' + CAST(@intNum1 + @intNum2 AS VARCHAR(50));
    END TRY
    BEGIN CATCH
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR(10));
        PRINT 'Error Severity: ' + CAST(ERROR_SEVERITY() AS VARCHAR(10));
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS VARCHAR(10));
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END;

exec PR_Calculation_SumWithErrorHandling 8,2

--4
BEGIN TRY
        INSERT INTO Customers (Customer_id, Customer_Name, Email)
        VALUES (1, 'John Doe', 'john@example.com'); 
    END TRY
    BEGIN CATCH
        PRINT 'Primary Key Violation Error Occurred';
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
        PRINT 'Error Severity: ' + CAST(ERROR_SEVERITY() AS NVARCHAR(10));
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR(10));
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;

--5
CREATE or alter PROCEDURE PR_Customers_CheckCustomerId
    @CustomerId INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Customers WHERE Customer_id = @CustomerId)
    BEGIN
        THROW 50001, 'No Customer_id is available in database.', 1;
    END
    ELSE
    BEGIN
        PRINT 'Customer ID exists.';
    END
END

--Part � B
--6.
BEGIN TRY
    INSERT INTO Orders (Order_id, Customer_id, Order_date)
    VALUES (1, 999, GETDATE());
END TRY
BEGIN CATCH
    PRINT 'Foreign Key Violation Error Occurred: Invalid Customer_id.';
END CATCH;

--7.
CREATE PROCEDURE PR_DataValidation_CheckPositiveValue
    @value INT
AS
BEGIN
    IF @value < 0
    BEGIN
        THROW 50002, 'Invalid data: Value cannot be negative.', 1;
    END
    ELSE
    BEGIN
        PRINT 'Data is valid.';
    END
END;

exec PR_DataValidation_CheckPositiveValue -10

PR_DataValidation_CheckPositiveValue -2

--8.
CREATE PROCEDURE PR_Customers_UpdateEmailWithErrorHandling
    @CustomerId INT,
    @NewEmail VARCHAR(50)
AS
BEGIN
    BEGIN TRY
        UPDATE Customers
        SET Email = @NewEmail
        WHERE Customer_id = @CustomerId;
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred while updating email.';
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END;

--part c
--9.

CREATE PROCEDURE PR_Customers_InsertWithDuplicateCheck
    @CustomerId INT,
    @CustomerName VARCHAR(250),
    @Email VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Customers WHERE Customer_id = @CustomerId)
    BEGIN
        PRINT 'The Customer_id is already taken. Try another one.';
    END
    ELSE
    BEGIN
        INSERT INTO Customers (Customer_id, Customer_Name, Email)
        VALUES (@CustomerId, @CustomerName, @Email);

        PRINT 'Customer record inserted successfully.';
    END
END;

PR_Customers_InsertWithDuplicateCheck 2,'dgv','adfa'

--10.

CREATE PROCEDURE PR_Customers_HandleDuplicateEmail
    @CustomerId INT,
    @CustomerName VARCHAR(250),
    @Email VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Customers WHERE Email = @Email)
    BEGIN
        PRINT 'The Email is already taken. Try another one.';
    END
    ELSE
    BEGIN
        INSERT INTO Customers (Customer_id, Customer_Name, Email)
        VALUES (@CustomerId, @CustomerName, @Email);

        PRINT 'Customer record inserted successfully.';
    END
END;
PR_Customers_HandleDuplicateEmail 4,'dgv','ad4fa'
