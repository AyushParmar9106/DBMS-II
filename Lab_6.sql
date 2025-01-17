--  Create the Products table 
CREATE TABLE Products ( 
Product_id INT PRIMARY KEY, 
Product_Name VARCHAR(250) NOT NULL, 
Price DECIMAL(10, 2) NOT NULL 
);

--  Insert data into the Products table 
INSERT INTO Products (Product_id, Product_Name, Price) VALUES 
(1, 'Smartphone', 35000), 
(2, 'Laptop', 65000), 
(3, 'Headphones', 5500), 
(4, 'Television', 85000), 
(5, 'Gaming Console', 32000); 

select * from Products

--PART A
--1
DECLARE 
	@Product_id INT,
	@Product_Name VARCHAR(250),
	@Price DECIMAL(10, 2);
DECLARE cursor_product cursor
	for select 
		Product_id,
		Product_Name,
		Price from Products;
Open cursor_product;
FETCH Next from cursor_product Into
	@Product_id,
	@Product_Name,
	@Price;
While @@FETCH_STATUS = 0
	BEGIN 
	PRINT cast(@Product_id as varchar) + '-' + @Product_Name  + '-' + 
	cast(@Price as varchar);
		FETCH NEXT From cursor_product Into
			@Product_id,
			@Product_Name,
			@Price;
	END;
Close cursor_product;
DEALLOCATE cursor_product;

--2
DECLARE 
	@Product_id INT,
	@Product_Name VARCHAR(250);
DECLARE Product_Cursor_Fetch  cursor
	for select 
		Product_id,
		Product_Name
		from Products;
Open Product_Cursor_Fetch;
FETCH Next from Product_Cursor_Fetch Into
	@Product_id,
	@Product_Name;
While @@FETCH_STATUS = 0
	BEGIN 
	PRINT cast(@Product_id as varchar) + '_' + @Product_Name ;
		FETCH NEXT From Product_Cursor_Fetch Into
			@Product_id,
			@Product_Name;
	END;
Close Product_Cursor_Fetch;
DEALLOCATE Product_Cursor_Fetch;

--3
Declare 
	@Product_id INT,
	@Product_Name VARCHAR(250),
	@Price DECIMAL(10, 2);
Declare cursor_price_above_30000 cursor
 for select 
		Product_id,
		Product_Name,
		Price from Products
		where Price>30000;
open cursor_price_above_30000;
fetch next from  cursor_price_above_30000 Into 
		@Product_id,
	@Product_Name,
	@Price;
While @@FETCH_STATUS = 0
	BEGIN 
	PRINT cast(@Product_id as varchar) + '-' + @Product_Name  + '-' + 
	cast(@Price as varchar);
		FETCH NEXT From cursor_price_above_30000 Into
			@Product_id,
			@Product_Name,
			@Price;
	END;
close cursor_price_above_30000;
Deallocate cursor_price_above_30000;

--4
DECLARE 
	@Product_id INT,
	@Product_Name VARCHAR(250),
	@Price DECIMAL(10, 2);
DECLARE Product_CursorDelete cursor
	for select  
		Product_id,
		Product_Name,
		Price from Products;
Open Product_CursorDelete;
FETCH Next from Product_CursorDelete Into
	@Product_id,
	@Product_Name,
	@Price;
While @@FETCH_STATUS = 0
	BEGIN 
	delete from Products where Product_id=@Product_id;
	FETCH NEXT From Product_CursorDelete Into
			@Product_id,
			@Product_Name,
			@Price;
	END;
Close Product_CursorDelete;
DEALLOCATE Product_CursorDelete;

--part b
--1
DECLARE 
	@Product_id INT,
	@Product_Name VARCHAR(250),
	@Price DECIMAL(10, 2);
DECLARE Product_CursorUpdate cursor
	for select  
		Product_id,
		Product_Name,
		Price from Products;
Open Product_CursorUpdate;
FETCH Next from Product_CursorUpdate Into
	@Product_id,
	@Product_Name,
	@Price;
While @@FETCH_STATUS = 0
	BEGIN 
	update Products set Price = Price + Price*0.10 
	where Product_id=@Product_id;
	PRINT cast(@Product_id as varchar) + '-' + @Product_Name  + '-' + 
	cast(@Price as varchar);
	
	FETCH NEXT From Product_CursorUpdate Into
			@Product_id,
			@Product_Name,
			@Price;
	END;
Close Product_CursorUpdate;
DEALLOCATE Product_CursorUpdate;
select * from Products

--2
DECLARE 
	@Product_id INT,
	@Product_Name VARCHAR(250),
	@Price DECIMAL(10, 0);
DECLARE cursor_priceround cursor
	for select 
		Product_id,
		Product_Name,
		Price from Products;
Open cursor_priceround;
FETCH Next from cursor_priceround Into
	@Product_id,
	@Product_Name,
	@Price;
While @@FETCH_STATUS = 0
	BEGIN 
	update Products set Price = round(Price,5) 
	where Product_id=@Product_id;
		FETCH NEXT From cursor_priceround Into
			@Product_id,
			@Product_Name,
			@Price;
	END;
Close cursor_priceround;
DEALLOCATE cursor_priceround;

--part c
--  Create the Products table 
CREATE TABLE NewProducts ( 
Product_id INT , 
Product_Name VARCHAR(250) , 
Price DECIMAL(10, 2)  
);
DROP TABLE NewProducts

--  Insert data into the Products table 
INSERT INTO NewProducts (Product_id, Product_Name, Price) VALUES 
(1, 'Smartphone', 35000), 
(2, 'Laptop', 65000), 
(3, 'Headphones', 5500), 
(4, 'Television', 85000), 
(5, 'Gaming Console', 32000); 

--1
declare 
	@Product_id INT,
	@Product_Name VARCHAR(250),
	@Price DECIMAL(10, 2)
declare Product_Cursorinsert cursor
for select
		Product_id , 
		Product_Name, 
		Price
	from
		Products
		;
	open Product_Cursorinsert;
fetch next from Product_Cursorinsert into
		@Product_id, 
		@Product_Name, 
		@Price ;
while @@FETCH_STATUS = 0
	begin
		if @Product_Name='laptop'
		insert into NewProducts values (@Product_id, @Product_Name, @Price);
		fetch next from Product_Cursorinsert into
		@Product_id, 
		@Product_Name, 
		@Price
	end;
close Product_Cursorinsert;
deallocate Product_Cursorinsert;

select * from Products

truncate table NewProducts

--2
DECLARE @Product_id INT,
		@Product_Name VARCHAR(250),
		@Price DECIMAL(10, 2)

DECLARE Product_Cursor_INSERT_NEW CURSOR 
FOR SELECT Product_id,Product_Name,Price 
	FROM Products
	WHERE Price >= 50000
OPEN  Product_Cursor_INSERT_NEW
FETCH NEXT FROM Product_Cursor_INSERT_NEW INTO 
	@Product_id,
	@Product_Name,
	@Price
WHILE @@FETCH_STATUS = 0
	BEGIN 
		INSERT INTO NewProducts(Product_id,Product_Name,Price)
		VALUES
		(@Product_id,@Product_Name,@Price)
		DELETE FROM Products
		WHERE Product_id = @Product_id
		FETCH NEXT FROM Product_Cursor_INSERT_NEW INTO 
			@Product_id,
			@Product_Name,
			@Price
	END
CLOSE Product_Cursor_INSERT_NEW
DEALLOCATE Product_Cursor_INSERT_NEW
se


