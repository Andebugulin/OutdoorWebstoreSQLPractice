CREATE DATABASE OutdoorStore;

USE dbo.OutdoorStore;

CREATE TABLE Store (
    StoreId INT IDENTITY(1,1) PRIMARY KEY,
    StoreName VARCHAR(255),
    Address VARCHAR(255),
    City VARCHAR(255),
    PostalCode VARCHAR(10),
    Country VARCHAR(255)
);

CREATE TABLE Products (
    ProductId INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(255),
    Description TEXT,
    Price DECIMAL(10,2),
    Category VARCHAR(255)
);

CREATE TABLE Customers (
    CustomerId INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    Password VARCHAR(255),
    Address VARCHAR(255),
    City VARCHAR(255),
    PostalCode VARCHAR(10),
    Country VARCHAR(255)
);

CREATE TABLE Employee (
    EmployeeId INT IDENTITY(1,1) PRIMARY KEY,
    StoreId INT FOREIGN KEY REFERENCES Store(StoreId),
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    Position VARCHAR(255),
);

CREATE TABLE Orders (
    OrderId INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId INT FOREIGN KEY REFERENCES Customers(CustomerId),
    OrderDate DATETIME,
    EmployeeId INT FOREIGN KEY REFERENCES Employee(EmployeeId),
);

CREATE TABLE OrderDetails (
    OrderId INT FOREIGN KEY REFERENCES Orders(OrderId),
    ProductId INT FOREIGN KEY REFERENCES Products(ProductId),
    PRIMARY KEY (OrderId, ProductId)
);


CREATE TABLE PaymentDetails (
    PaymentId INT IDENTITY(1,1) PRIMARY KEY,
    OrderId INT FOREIGN KEY REFERENCES Orders(OrderId),
    PaymentType VARCHAR(255),
    PaymentCompleted BIT
);

CREATE TABLE StoreInventory (
    StoreId INT FOREIGN KEY REFERENCES Store(StoreId),
    ProductId INT FOREIGN KEY REFERENCES Products(ProductId),
    StockQuantity INT,
    PRIMARY KEY (StoreId, ProductId)
);
