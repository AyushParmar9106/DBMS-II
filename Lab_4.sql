--PART-A
--1 Write a function to print "hello world"
CREATE OR ALTER FUNCTION FN_HELLO_WORLD()
RETURNS CHAR(11)
AS
BEGIN
 RETURN 'Hello World'
END
SELECT dbo.FN_HELLO_WORLD()

--2 Write a function which returns addition of two numbers
CREATE OR ALTER FUNCTION FN_ADD_TWO(@a int,@b int)
RETURNS INT
AS
BEGIN
	RETURN @a+@b
END

SELECT dbo.FN_ADD_TWO(60,10)

--3 Write a function to check whether the given number is ODD or EVEN.
CREATE OR ALTER FUNCTION FN_ODD_EVEN(@num int)
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @MSG VARCHAR(10)=''
	IF @num%2=0
		SET @MSG='EVEN'
	ELSE
		SET @MSG='ODD'
	RETURN @MSG
END
SELECT dbo.FN_ODD_EVEN(6)

--4 Write a function which returns a table with details of a person whose first name starts with B
CREATE OR ALTER FUNCTION FN_FNAME_STARTS_B()
RETURNS TABLE
AS
RETURN(
	SELECT * FROM PERSON WHERE FirstName like 'B%'
)
SELECT * FROM dbo.FN_FNAME_STARTS_B()

--5 Write a function which returns a table with unique first names from the person table
CREATE OR ALTER FUNCTION FN_UNIQUE_FNAME()
RETURNS TABLE
AS
	RETURN(
		SELECT DISTINCT FirstName from PERSON
)	
SELECT * FROM dbo.FN_UNIQUE_FNAME()

--6 Write a function to print number from 1 to N. (Using while loop)
CREATE OR ALTER FUNCTION FN_PRINT1ToN(@N INT)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @ANS VARCHAR(100)='',@i INT=1
	WHILE @i<=@N
	BEGIN
		SET @ANS = @ANS + ' '+cast(@i as varchar(1))
		SET @i=@i+1
	END
	RETURN @ANS
END
SELECT dbo.FN_PRINT1ToN(5)

--7 Write a function to find the factorial of a given integer.
CREATE OR ALTER FUNCTION FN_FACTORIAL(@NUM INT)
RETURNS INT
AS
BEGIN
	DECLARE @ANS INT=1,@i INT=1
	WHILE @i<=@NUM
	BEGIN
		SET @ANS = @ANS*@i
		SET @i=@i+1
	END
	RETURN @ANS
END
SELECT dbo.FN_FACTORIAL(6)

--PART-B
--8 Write a function to compare two integers and return the comparison result. (Using Case statement)
CREATE OR ALTER FUNCTION FN_COMPARE_TWO(@a INT,@b INT)
RETURNS VARCHAR(50)
AS
BEGIN
	RETURN (
		CASE
			WHEN @a>@b THEN 'First is greater than second'
			WHEN @a<@b THEN 'First is less than second'
			ELSE 'Both are equal'
		END
	)
END
SELECT dbo.FN_COMPARE_TWO(4,6)

--9 Write a function to print the sum of even numbers between 1 to 20
CREATE OR ALTER FUNCTION FN_SUM_EVEN()
RETURNS INT
AS
BEGIN
	DECLARE @i INT=2,@ANS INT=0
	WHILE @i<20
	BEGIN
		SET @ANS=@ANS+@i
		SET @i=@i+2
	END
	RETURN @ANS
END
SELECT dbo.FN_SUM_EVEN()

--10 Write a function that checks if a given string is a palindrome
CREATE OR ALTER FUNCTION FN_PALINDROME(@str VARCHAR(100))
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @MSG VARCHAR(50)=''
	IF @str=REVERSE(@str)
		SET @MSG='PALINDROME'
	ELSE
		SET @MSG='NOT A PALINDROME'
	RETURN @MSG
END
SELECT dbo.FN_PALINDROME('Ayush')

--PART-C
--11 Write a function to check whether a given number is prime or not
CREATE OR ALTER FUNCTION FN_PRIME(@num INT)
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @i int=2,@fact int=0,@msg varchar(50)=''
	while @i<=@num/2
	begin
		IF @num%@i=0
			SET @fact=1
			SET @i=@i+1
	end
	IF @fact=0
		set @msg = 'Is Prime'
	ELSE
		set @msg='Not Prime'
	RETURN @msg
END
select dbo.FN_PRIME(11)