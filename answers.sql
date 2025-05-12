-- Question 1: Achieving 1NF (First Normal Form)

SELECT OrderID, CustomerName, 'Laptop' AS Product
FROM ProductDetail WHERE FIND_IN_SET('Laptop', Products) > 0
UNION ALL
SELECT OrderID, CustomerName, 'Mouse' AS Product
FROM ProductDetail WHERE FIND_IN_SET('Mouse', Products) > 0
UNION ALL
SELECT OrderID, CustomerName, 'Tablet' AS Product
FROM ProductDetail WHERE FIND_IN_SET('Tablet', Products) > 0
UNION ALL
SELECT OrderID, CustomerName, 'Keyboard' AS Product
FROM ProductDetail WHERE FIND_IN_SET('Keyboard', Products) > 0
UNION ALL
SELECT OrderID, CustomerName, 'Phone' AS Product
FROM ProductDetail WHERE FIND_IN_SET('Phone', Products) > 0;

-- Question 2: Achieving 2NF (Second Normal Form)

-- Step 1: Create an 'Orders' table without the 'Product' and 'Quantity' columns, keeping only the 'OrderID' and 'CustomerName'.
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Insert data into the 'Orders' table.
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Step 2: Create a 'Products' table for the product and quantity information.
CREATE TABLE Products (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert product details into the 'Products' table.
INSERT INTO Products (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
