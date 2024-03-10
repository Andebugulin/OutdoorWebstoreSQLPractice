### 1) For each product, get the price doubled

```sql
SELECT ProductName, Price * 2 AS PriceDoubled FROM Products;
```

### 2) Get the length of ProductNames from Products table

```sql
SELECT ProductName, LENGTH(ProductName) AS NameLength FROM Products;
```

### 3) Get the length of ProductNames from Products table where the name lenght is less than 20

```sql
SELECT ProductName, LENGTH(ProductName) AS NameLength FROM Products WHERE LENGTH(ProductName) < 20;
```

### 4) Get all the products in Products table ordered primarily by length and secondarily by alphabetial order

```sql
SELECT ProductName FROM Products ORDER BY LENGTH(ProductName), ProductName;
```

### 5) Get the full name of each customer in Customers table as one column

```sql
SELECT CONCAT(FirstName, ' ', LastName) AS FullName FROM Customers;
```

### 6) Get the combined length of each full names in Customers table

```sql
SELECT SUM(LENGTH(CONCAT(FirstName, ' ', LastName))) AS TotalLength FROM Customers;
```

### 7) Get the total price for each order (hint. use JOIN)

```sql
SELECT 
    o.OrderId, 
    SUM(p.Price) AS TotalPrice
FROM 
    Orders o
INNER JOIN OrderDetails od ON o.OrderId = od.OrderId
INNER JOIN Products p ON od.ProductId = p.ProductId
GROUP BY 
    o.OrderId;

```

### 8) Get the sum of the total price of all the orders

Building on the previous query:

```sql
SELECT SUM(p.Price) AS SumTotalPrice
FROM Orders o
JOIN OrderDetails od ON o.OrderId = od.OrderId
JOIN Products p ON od.ProductId = p.ProductId;
```

### 9) Get all orders that have been made between 03.10.2023 - 31.01.2024 time range

```sql
SELECT *
FROM Orders
WHERE OrderDate BETWEEN '2023-10-03' AND '2024-01-31';

```

### 10) Get all products with the cheapest price

```sql
SELECT ProductName FROM Products
WHERE Price = (SELECT MIN(Price) FROM Products);
```

### 11) Get all products whose price is at most double of the cheapest ones (hint. use subquery)

```sql
SELECT ProductName
FROM Products
WHERE Price <= 2 * (SELECT MIN(Price) FROM Products);

```

### 12) Get all orders which total price is more than 100 and less than 200

```sql
SELECT o.OrderId, SUM(p.Price) AS TotalPrice
FROM Orders o
JOIN OrderDetails od ON o.OrderId = od.OrderId
JOIN Products p ON od.ProductId = p.ProductId
GROUP BY o.OrderId
HAVING SUM(p.Price) > 100 AND SUM(p.Price) < 200;
```

### 13) Create new EmployeeOrderTotals VIEW which is used to fetch total orders handled by each employee

```sql
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

```

### 14) Create new StoreSalesTotals VIEW which is used to get the total sales made in each store

```sql
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
```

### Get the full name of each employee working in the store with the highest total sales using the VIEW's created before

```sql
SELECT CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeFullName
FROM Employee e
WHERE e.StoreId = (
  SELECT s.StoreId
  FROM StoreSalesTotals s
  ORDER BY s.TotalSales DESC
  LIMIT 1
);
```
