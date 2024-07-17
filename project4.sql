CREATE DATABASE InventoryManagement4;
USE InventoryManagement4;

CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    City VARCHAR(255),
    Country VARCHAR(255),
    Phone VARCHAR(20),
    Email VARCHAR(255)
);
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    CategoryID INT,
    SupplierID INT,
    UnitPrice DECIMAL(10, 2),
    QuantityInStock INT
);


CREATE TABLE Transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    TransactionType ENUM('Purchase', 'Sale'),
    Quantity INT,
    TransactionDate DATE,
    Notes TEXT
);


INSERT INTO Categories (CategoryID, CategoryName) VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Books'),
(4, 'Home Appliances'),
(5, 'Toys'),
(6, 'Furniture'),
(7, 'Sports');


INSERT INTO Suppliers (SupplierID, SupplierName, Address, City, Country, Phone, Email) VALUES
(1, 'Sonny Electronics', '123 Main Street', 'Mumbai', 'India', '123-456-7890', 'info@electronicsupplier.com'),
(2, 'Zaraa fashions', '456 Broadway', 'Delhi', 'India', '987-654-3210', 'info@fashionhouse.com'),
(3, 'Book world', '789 Elm Street', 'Bangalore', 'India', '111-222-3333', 'info@bookemporium.com'),
(4, 'Home Appliances Co.', '321 Oak Avenue', 'Chennai', 'India', '444-555-6666', 'info@homeappliancesco.com'),
(5, 'Kids World', '555 Maple Drive', 'Kolkata', 'India', '777-888-9999', 'info@toyworld.com'),
(6, 'Ikea Furniture', '777 Pine Street', 'Hyderabad', 'India', '999-888-7777', 'info@furnituredepot.com'),
(7, 'ABC Sports', '888 Cedar Avenue', 'Pune', 'India', '222-333-4444', 'info@sportssupply.com'),
(8, 'Gadget World', '234 Tech Lane', 'Mumbai', 'India', '333-444-5555', 'info@gadgetworld.com'),
(9, 'Fashion Hub', '789 Chic Avenue', 'Delhi', 'India', '666-777-8888', 'info@fashionhub.com');

-- Insert sample data into Products
INSERT INTO Products (ProductID, ProductName, CategoryID, SupplierID, UnitPrice, QuantityInStock) VALUES
(1, 'Smartphone', 1, 1, 599.99, 50),
(2, 'Laptop', 1, 1, 999.99, 30),
(3, 'T-shirt', 2, 2, 19.99, 100),
(4, 'Jeans', 2, 2, 39.99, 80),
(5, 'Python Programming Book', 3, 3, 29.99, 20),
(6, 'Blender', 4, 4, 49.99, 50),
(7, 'LEGO Set', 5, 5, 59.99, 40),
(8, 'Dining Table', 6, 6, 299.99, 10);


INSERT INTO Transactions (TransactionID, ProductID, TransactionType, Quantity, TransactionDate, Notes) VALUES
(1, 1, 'Purchase', 10, '2024-05-01', 'Bulk order for smartphones'),
(2, 2, 'Purchase', 5, '2024-05-02', 'Order for laptops'),
(3, 3, 'Sale', 25, '2024-05-03', 'Sale of T-shirts'),
(4, 4, 'Sale', 30, '2024-05-04', 'Sale of Jeans'),
(5, 5, 'Purchase', 10, '2024-05-05', 'Order for Python books'),
(6, 6, 'Sale', 35, '2024-05-06', 'Sale of blenders'),
(7, 7, 'Purchase', 25, '2024-05-07', 'Order for LEGO sets'),
(8, 8, 'Sale', 5, '2024-05-08', 'Sale of dining tables'),
(9, 1, 'Sale', 15, '2024-06-01', 'Sale of smartphones'),
(10, 3, 'Purchase', 50, '2024-06-02', 'Restocking T-shirts'),
(11, 2, 'Sale', 10, '2024-06-03', 'Sale of laptops'),
(12, 4, 'Purchase', 20, '2024-06-04', 'Restocking Jeans'),
(13, 5, 'Sale', 5, '2024-06-05', 'Sale of Python books'),
(14, 6, 'Sale', 10, '2024-06-06', 'Sale of blenders'),
(15, 7, 'Purchase', 30, '2024-06-07', 'Order for more LEGO sets'),
(16, 8, 'Purchase', 5, '2024-06-08', 'Order for dining tables'),
(17, 2, 'Purchase', 10, '2024-06-09', 'Order for more laptops'),
(18, 1, 'Sale', 8, '2024-06-10', 'Sale of smartphones'),
(19, 3, 'Sale', 20, '2024-06-11', 'Sale of T-shirts'),
(20, 4, 'Sale', 15, '2024-06-12', 'Sale of Jeans');


ALTER TABLE Products
ADD CONSTRAINT FK_CategoryID
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);

ALTER TABLE Products
ADD CONSTRAINT FK_SupplierID
FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID);

ALTER TABLE Transactions
ADD CONSTRAINT FK_ProductID
FOREIGN KEY (ProductID) REFERENCES Products(ProductID);

-- Queries

SELECT p.ProductName, c.CategoryName, s.SupplierName
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID;


SELECT c.CategoryName, SUM(p.QuantityInStock) AS TotalQuantity
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName;


SELECT TransactionType, SUM(Quantity * UnitPrice) AS TotalSalesAmount
FROM Transactions t
JOIN Products p ON t.ProductID = p.ProductID
GROUP BY TransactionType;
