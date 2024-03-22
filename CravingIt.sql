CREATE TABLE [Suppliers] (
  [Supplier ID] INT identity (1,1),
  [CompanyName] nvarchar(100),
  [ProductName] nvarchar(50),
  [Description] nvarchar(50),
  [Price] money,
  PRIMARY KEY ([Supplier ID])
);

CREATE TABLE [Products] (
  [Product ID] int identity (5000,2),
  [Supplier ID] INT,
  [BrandName] nvarchar(100),
  [Description] nvarchar(50),
  [Price] float,
  [StockQuantity] INT,
  PRIMARY KEY ([Product ID]),
  CONSTRAINT [FK_Products.Supplier ID]
    FOREIGN KEY ([Supplier ID])
      REFERENCES [Suppliers]([Supplier ID])
);

CREATE TABLE [Departmants] (
  [Department ID] INT identity (1,1),
  [Department Name] nvarchar(50),
  [Department Manager] nvarchar(100),
  [Department Floor] INT,
  PRIMARY KEY ([Department ID])
);

CREATE TABLE [Inventory] (
  [Inventory ID] INT identity (1,1),
  [Department ID] INT,
  [Product ID] INT,
  [current stock level] INT,
  [stock threshold] INT,
  PRIMARY KEY ([Inventory ID]),
  CONSTRAINT [FK_Inventory.Product ID]
    FOREIGN KEY ([Product ID])
      REFERENCES [Products]([Product ID]),
  CONSTRAINT [FK_Inventory.Department ID]
    FOREIGN KEY ([Department ID])
      REFERENCES [Departmants]([Department ID])
);

CREATE TABLE [Gender] (
  [Gender ID] char(1),
  [Gender Description] varchar(50),
  PRIMARY KEY ([Gender ID])
);

CREATE TABLE [Employee] (
  [Employee ID] int identity (1,1),
  [Department ID] int,
  [Gender ID] char(1),
  [Position] nvarchar(50),
  [Name] nvarchar(50),
  [Surname] nvarchar(50),
  [DOB] Date,
  [EirCode] nvarchar(8),
  PRIMARY KEY ([Employee ID]),
  CONSTRAINT [FK_Employee.Gender ID]
    FOREIGN KEY ([Gender ID])
      REFERENCES [Gender]([Gender ID]),
  CONSTRAINT [FK_Employee.Department ID]
    FOREIGN KEY ([Department ID])
      REFERENCES [Departmants]([Department ID])
);

CREATE TABLE [Company Rep] (
  [Email ID] INT identity (1,1),
  [Supplier ID] INT,
  [Name] nvarchar(50),
  [Company Name] nvarchar(50),
  [Phone] nvarchar(20),
  PRIMARY KEY ([Email ID]),
  CONSTRAINT [FK_Company Rep.Supplier ID]
    FOREIGN KEY ([Supplier ID])
      REFERENCES [Suppliers]([Supplier ID])
);

CREATE TABLE [Sales] (
  [Sales ID] int identity (1,1),
  [Department ID] INT,
  [Product ID] INT,
  [Quantity] INT,
  [Sale date] date,
  [End bill] money,
  PRIMARY KEY ([Sales ID]),
  CONSTRAINT [FK_Sales.Product ID]
    FOREIGN KEY ([Product ID])
      REFERENCES [Products]([Product ID]),
  CONSTRAINT [FK_Sales.Department ID]
    FOREIGN KEY ([Department ID])
      REFERENCES [Departmants]([Department ID])
);

--Had to drop table because data type was different
--Used int in Gender, changed to Char(1). (fixed now)
Drop table Gender;

--Check table structure
select * from [Departmants];

-- start inserting data

-- data for Departments
INSERT INTO Departmants( [Department Name], [Department Manager], [Department Floor])
VALUES('Restaurant', 'Joe Blogs', '1'),
('Food Hall', 'Mary Lu', '0'),
('Events', 'Conor Clark', '-1'),
('HR', 'Claire Queen', '2');
--Check table data
select * from [Departmants];

--Deleting rows 5,6,7,8 they where duplicates.
delete from Departmants
where [Department ID] = 8;

-- data for Gender
INSERT INTO Gender([Gender ID], [Gender Description])
VALUES('M','Male'),
('F','Female'),
('O','Other'),
('N','Not Disclosed');
--Check table data
select * from [Gender];

--Data for Employee
--Data for Restaurant == ID 1 | floor 1
INSERT INTO Employee([Department ID], [Gender ID], Position, Name, Surname, DOB, EirCode)
VALUES ('1', 'F', 'Manager', 'Mary', 'Lu', '1982/12/05', 'DO3X458'),
('1', 'O', 'Duty Manager', 'Ron', 'Dune', '1992/10/15', 'DO8S488'),
('1', 'O', 'Cashier', 'Dan', 'Riz', '2002/03/03', 'DO1T558'),
('1', 'M', 'Cashier', 'Jennifer', 'Blogs', '2000/01/10', 'DO3X4TT1'),
('1', 'F', 'Wine Specialist', 'Laura', 'Whelan', '1998/10/12', 'DO3X42R3'),
('1', 'N', 'Cleaner', 'Carmen', 'Rodrigues', '1996/11/17', 'DO6H158');

--Data for FoodHall == ID 2 | floor 0
INSERT INTO Employee([Department ID], [Gender ID], Position, Name, Surname, DOB, EirCode)
VALUES ('2', 'M', 'Manager', 'Joe', 'Blogs', '1982/09/05', 'DO3X458'),
('2', 'O', 'Bar Manager', 'Mike', 'Oyshee', '1992/09/15', 'DO8S488'),
('2', 'O', 'Floor Manager', 'Jonna', 'Riz', '2002/03/03', 'DO1T558'),
('2', 'M', 'Waiter', 'Ron', 'Blogs', '2000/01/10', 'DO3X4TT1'),
('2', 'F', 'Bartender', 'Moone', 'Whelan', '1998/10/04', 'DO3X42R3'),
('2', 'N', 'Waiter', 'Dee', 'Rodrigues', '1996/11/05', 'DO6H158');

--Msg 547, Level 16, State 0, Line 139
--The INSERT statement conflicted with the FOREIGN KEY constraint "FK_Employee.Department ID". 
--The conflict occurred in database "CravingIT", table "dbo.Departmants", column 'Department ID'.

--That error occured bcuz I used the wrong ID, 0 refers to the shop floor, the department id is 2.

--Data for Events == ID 3 | floor -1
INSERT INTO Employee([Department ID], [Gender ID], Position, Name, Surname, DOB, EirCode)
VALUES ('3', 'M', 'Manager', 'Conor', 'Clark', '1982/09/05', 'DO3X458'),
('3', 'O', 'Bar Manager', 'Paddy', 'Quiin', '1992/09/15', 'DO8S488'),
('3', 'O', 'Floor Manager', 'Rebbeca', 'Riz', '2002/03/03', 'DO1T558'),
('3', 'M', 'Waiter', 'Greg', 'Blogs', '2000/01/10', 'DO3X4TT1'),
('3', 'F', 'Host', 'Roberta', 'Whelan', '2003/10/04', 'DO3X42R3'),
('3', 'N', 'Waiter', 'Martina', 'Rodrigues', '1996/11/05', 'DO6H158');

--Check table data
select * from [Employee];

--Data for Events == ID 4 | floor -1
INSERT INTO Employee([Department ID], [Gender ID], Position, Name, Surname, DOB, EirCode)
VALUES ('4', 'F', 'HR Manager', 'Claire', 'Claire Queen', '1982/09/05', 'DO3X458'),
('4', 'O', 'Account', 'Patrick', 'Quiin', '1992/09/15', 'DO8GT68'),
('4', 'O', 'Account', 'Beca', 'Riz', '2002/03/03', 'DO1T558'),
('4', 'M', 'HR', 'Jorge', 'Blogs', '2000/01/10', 'DO7H5T1'),
('4', 'F', 'Talent Acquisition', 'Beta', 'Fernandes', '2003/10/04', 'DO3FF98'),
('4', 'N', 'Talent Acquisition', 'Mar', 'Rodrigues', '1996/11/05', 'DO5FF58');

--Check table data
select * from [Employee];

--Data for Suppliers
INSERT INTO Suppliers(CompanyName, ProductName, Description, Price)
values('Butlers','Chocolate','Chocolate','0'),
('Buongiorno','Pasta','Italian Food','0'),
('Colgate','ToothPaste','Total White','0'),
('Axe','Deodorant','Cleanesses','0'),
('Nescaf�','Coffee','Instant Coffee','0'),
('Oreo', 'Sweets', 'Cake','0'),
('FreshChicken', 'Chicken', 'Chicken Breast' ,'0')

--Price set to zero in case they start charging for delivery

-- ADDED WRONG DATA IN THE WRONG TABLE THAT WAS SUPPOSED TO BE PRODUTCS, SO DELETING EVERYTHING
delete from Suppliers

--Check table data
select * from Suppliers;

-- Data for Products
INSERT INTO Products([Supplier ID], BrandName, Description, Price, StockQuantity)
VALUES('11','Butlers','Chocolate - White Chocolate','1.5','50'),
('11','Butlers','Chocolate - Dark Chocolate','1.25','44'),
('11','Butlers','Chocolate - Milk Chocolate','1.4','88'),
('12','Buongiorno','Pasta - Penne','3.5','120'),
('12','Buongiorno','Pasta - Spaghetti','3','111'),
('12','Buongiorno','Pasta - Lasagna','3.25','166'),
('13','Colgate','ToothPaste - Total White','3', '44'),
('14','Axe','Deodorant - 48hr Sports','2', '65'),
('15','Nescaf�','Coffee - Intense','6', '30'),
('15','Nescaf�','Coffee - Decaff','5.5', '15'),
('16', 'Oreo', 'Sweets - Cake','10', '20'),
('16', 'Oreo', 'Sweets - Cookie','3.3', '133'),
('17', 'FreshChicken', 'Chicken - Chicken Breast' ,'5.0', '23'),
('17', 'FreshChicken', 'Chicken - Chicken Heart' ,'4.0', '33'),
('17', 'FreshChicken', 'Chicken - Chicken Tight' ,'1.50', '54'),
('17', 'FreshChicken', 'Chicken -  Whole Chicken' ,'11.0', '7')


-- Check table data
SELECT * FROM Products

--Data for Company Rep
INSERT INTO [Company Rep]([Supplier ID], Name, [Company Name], Phone)
VALUES ('11','John Kelly','Butlers','085 1234567'),
('12','Mary Noolan','Buongiorno','087 1234567'),
('13','Jennifer','Colgate','087 1234567'),
('14','Mary Noolan','Axe','087 1234567'),
('15','Mary Noolan','Nescaf�','087 1234567'),
('16','Laura Whelan','SweetStuff','087 1234567'),
('17','Jordan McLean','FreshChicken','087 1234567')

-- Wrong supplier id, use update statement to fix them
update [Company Rep]
set [Supplier ID] = 13
where [Company Name] = 'Colgate';
-- 
update [Company Rep]
set [Supplier ID] = 14
where [Company Name] = 'Axe';
--
update [Company Rep]
set [Supplier ID] = 15
where [Company Name] = 'Nescaf�';

-- Check table data
SELECT * FROM [Company Rep]

INSERT INTO Inventory([Department ID], [Product ID], [current stock level], [stock threshold])
values ('2','5000','50','10'),
('2','5002','44','10'),
('2','5004','88','10'),
('1','5006','120','10'),
('1','5008','111','10'),
('1','5010','166','10'),
('3','5012','44','10'),
('3','5014','65','10'),
('2','5016','30','10'),
('2','5018','15','5'),
('2','5020','20','5'),
('2','5022','133','40'),
('2','5024','23','10'),
('2','5026','33','10'),
('2','5028','54','15'),
('2','5030','7','5')



-- check data
select * from Inventory

--Data for Sales
INSERT INTO Sales([Department ID], [Product ID], Quantity, [Sale date], [End bill])
VALUES ('2', '5008', '2', '2024/01/04', '6'),
('2', '5030', '2', '2024/02/07', '22'),
('2', '5022', '3', '2024/02/29', '9.9'),
('2', '5016', '2', '2024/01/04', '12'),
('2', '5012', '7', '2024/01/04', '21'),
('2', '5024', '4', '2024/01/04', '20'),
('2', '5026', '5', '2024/01/04', '20')

-- check data
select * from Sales

-- 
-- Create 4 Views that would be beneficial for the business. 
-- Views should consist of:
-- 1 using a JOIN.

-- Create StockAfterSales VIEW 1
go
create view StockAfterSales as
select
    Inventory.[Product ID], Products.[BrandName], Inventory.[Department ID], Inventory.[current stock level] as OldStock,
    Inventory.[current stock level] - ISNULL(SummedSales.TotalQuantitySold, 0) as StockAfterSales,
    Inventory.[stock threshold]
from
    Inventory
left join
    (SELECT 
        [Product ID], 
        SUM([Quantity]) AS TotalQuantitySold 
     from
        Sales 
     group by
        [Product ID]
    ) SummedSales on Inventory.[Product ID] = SummedSales.[Product ID]
JOIN 
    Products on Inventory.[Product ID] = Products.[Product ID];
go

--Check view data
select * from StockAfterSales
-------------------------------------------------------------------------------------
--At least 1 listing all items from any table in order of some attribute.
--To drop a view and create it again
DROP VIEW IF EXISTS EmployeeOrde1r;

-- Create EmployeeOrder VIEW 2
go
CREATE VIEW EmployeeOrder AS
SELECT TOP 100 Employee.[Employee ID], 
Employee.Name + ' ' + Employee.Surname AS Full_Name,
Departmants.[Department Name]
FROM Departmants
FULL OUTER JOIN Employee ON Departmants.[Department ID] = Employee.[Department ID]
ORDER BY Full_Name ASC;
go
--Check view data
select * from EmployeeOrder

-------------------------------------------------------------------------------------
--At least 1 using �DISTINCT� operator.
DROP VIEW IF EXISTS CleanData
-- Create CleanData VIEW 3
go
Create view CleanData as 
Select distinct Products.[Description], Inventory.[current stock level], Inventory.[stock threshold]
from Products
inner join Inventory
	on Products.[Product ID] = Inventory.[Product ID]
go

--Check view data
select * from CleanData

-------------------------------------------------------------------------------------


--At least 1 using �Aliased� column name
-- Create Checking_Gender VIEW 4

go
create view Checking_Gender as
select Employee.Name + ' ' + Employee.Surname as Full_Name, Departmants.[Department Name], Employee.Position, Employee.[Gender ID],
	case Employee.[Gender ID]
		when 'F' then 'Female'
		when 'M' then 'Male'
		when 'N' then 'Not Disclosed'
		when 'O' then 'Other'
	end as Gender_Description
from Departmants full outer join Employee
	on Departmants.[Department ID] = Employee.[Department ID]

go

-- Check View Data
select * from Checking_Gender

-------------------------------------------------------------------------------------



---------------------
--store procedures


--insert procedure
--CREATE PROCEDURE [dbo].[uspAddStudent]
--	@fn nvarchar(50),
--	@sn nvarchar(50),
--	@eirC nvarchar(20),
--	@cy nvarchar(50),
--	@age nvarchar(150),
--	@ge nvarchar(50),
--	@ph nvarchar(20),
--	@ema nvarchar(100),
--	@cour nvarchar(50),
--	@mod nvarchar(50)
--AS
--	INSERT INTO Student(FirstName, Surname, EirCode, County, Age, Gender, Phone, Email, Course, Module) VALUES(@fn, @sn, @eirC, @cy, @age, @ge, @ph, @ema, @cour, @mod)
--RETURN 0

--Insert Proc
create proc InsertDesigner
@FName varchar(30),
@SName varchar(30),
@Email varchar(100),
@Phone varchar(20)
As
	insert into Designer(DesignerFirstName,DesignerSurName,DesignerEmail,DesignerPhoneNo)
	--values('Jennie','Byrne','jennifer.byrne@dbs.ie','+353146454')
	values(@FName,@SName,@Email,@Phone)
	if @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN
			select ERROR_MESSAGE(),ERROR_PROCEDURE() -- functions to bring back system info
			print 'ERROR!!! No insert'
			return -1 -- tells calling program there is a problem, stops proc.
	END
return 0 -- all good
go
exec InsertDesigner 'Jennie','Byrne','jennifer.byrne@dbs.ie','+353146454'
go