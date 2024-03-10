-- Drop existing views if they exist
DROP VIEW IF EXISTS EmployeeOrderTotals;
DROP VIEW IF EXISTS StoreSalesTotals;

-- Double the price of each product
SELECT ProductName, Price * 2 AS PriceDoubled FROM Products;

-- Get the length of each product name
SELECT ProductName, LENGTH(ProductName) AS NameLength FROM Products;

-- Get the length of product names where length is less than 20
SELECT ProductName, LENGTH(ProductName) AS NameLength FROM Products WHERE LENGTH(ProductName) < 20;

-- List all products ordered by name length and then alphabetically
SELECT ProductName FROM Products ORDER BY LENGTH(ProductName), ProductName;

-- Concatenate first name and last name of customers to display full name
SELECT CONCAT(FirstName, ' ', LastName) AS FullName FROM Customers;

-- Get the total combined length of all customer full names
SELECT SUM(LENGTH(CONCAT(FirstName, ' ', LastName))) AS TotalLength FROM Customers;

-- Calculate the total price for each order
SELECT 
    o.OrderId, 
    SUM(p.Price) AS TotalPrice
FROM 
    Orders o
INNER JOIN OrderDetails od ON o.OrderId = od.OrderId
INNER JOIN Products p ON od.ProductId = p.ProductId
GROUP BY 
    o.OrderId;

-- Calculate the sum of all orders' total prices
SELECT SUM(p.Price) AS SumTotalPrice
FROM Orders o
JOIN OrderDetails od ON o.OrderId = od.OrderId
JOIN Products p ON od.ProductId = p.ProductId;

-- Select all orders made within the specified date range
SELECT *
FROM Orders
WHERE OrderDate BETWEEN '2023-10-03' AND '2024-01-31';

-- Find products with the cheapest price
SELECT ProductName FROM Products
WHERE Price = (SELECT MIN(Price) FROM Products);

-- Find products whose price is at most double the cheapest product's price
SELECT ProductName
FROM Products
WHERE Price <= 2 * (SELECT MIN(Price) FROM Products);

-- Find orders where the total price is more than 100 and less than 200
SELECT o.OrderId, SUM(p.Price) AS TotalPrice
FROM Orders o
JOIN OrderDetails od ON o.OrderId = od.OrderId
JOIN Products p ON od.ProductId = p.ProductId
GROUP BY o.OrderId
HAVING SUM(p.Price) > 100 AND SUM(p.Price) < 200;

-- Create a view for the total number of orders handled by each employee, including their store ID
CREATE VIEW EmployeeOrderTotals AS
SELECT
    e.StoreId,
    e.EmployeeId, 
    e.FirstName, 
    e.LastName,
    COUNT(o.OrderId) AS TotalOrders
FROM 
    Employee e
JOIN 
    Orders o ON e.EmployeeId = o.EmployeeId
GROUP BY 
    e.EmployeeId, e.FirstName, e.LastName, e.StoreId;

-- Create a view for the total sales made in each store, including the store name
CREATE VIEW StoreSalesTotals AS
SELECT 
    s.StoreId, 
    s.StoreName,
    SUM(p.Price) AS TotalSales
FROM 
    Store s
JOIN 
    Employee e ON s.StoreId = e.StoreId
JOIN 
    Orders o ON e.EmployeeId = o.EmployeeId
JOIN 
    OrderDetails od ON o.OrderId = od.OrderId
JOIN 
    Products p ON od.ProductId = p.ProductId
GROUP BY 
    s.StoreId, s.StoreName;

-- Get the full name of each employee working in the store with the highest total sales
SELECT CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeFullName
FROM Employee e
WHERE e.StoreId = (
  SELECT s.StoreId
  FROM StoreSalesTotals s
  ORDER BY s.TotalSales DESC
  LIMIT 1
);
