CREATE TABLE Store (
    StoreId INT AUTO_INCREMENT PRIMARY KEY,
    StoreName VARCHAR(255),
    Address VARCHAR(255),
    City VARCHAR(255),
    PostalCode VARCHAR(10),
    Country VARCHAR(255)
);

CREATE TABLE Products (
    ProductId INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(255),
    Description TEXT,
    Price DECIMAL(10,2),
    Category VARCHAR(255)
);

CREATE TABLE Customers (
    CustomerId INT AUTO_INCREMENT PRIMARY KEY,
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
    EmployeeId INT AUTO_INCREMENT PRIMARY KEY,
    StoreId INT,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    Position VARCHAR(255),
    FOREIGN KEY (StoreId) REFERENCES Store(StoreId)
);

CREATE TABLE Orders (
    OrderId INT AUTO_INCREMENT PRIMARY KEY,
    CustomerId INT,
    OrderDate DATETIME,
    EmployeeId INT,
    FOREIGN KEY (CustomerId) REFERENCES Customers(CustomerId),
    FOREIGN KEY (EmployeeId) REFERENCES Employee(EmployeeId)
);

CREATE TABLE OrderDetails (
    OrderId INT,
    ProductId INT,
    PRIMARY KEY (OrderId, ProductId),
    FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
    FOREIGN KEY (ProductId) REFERENCES Products(ProductId)
);

CREATE TABLE PaymentDetails (
    PaymentId INT AUTO_INCREMENT PRIMARY KEY,
    OrderId INT,
    PaymentType VARCHAR(255),
    PaymentCompleted BIT,
    FOREIGN KEY (OrderId) REFERENCES Orders(OrderId)
);

CREATE TABLE StoreInventory (
    StoreId INT,
    ProductId INT,
    StockQuantity INT,
    PRIMARY KEY (StoreId, ProductId),
    FOREIGN KEY (StoreId) REFERENCES Store(StoreId),
    FOREIGN KEY (ProductId) REFERENCES Products(ProductId)
);
