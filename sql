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
