-- Step 1: Create the Pharmacy database
CREATE DATABASE Pharmacy;
GO

-- Step 2: Use the Pharmacy database
USE Pharmacy;
GO

-- Create Users Table
-- This table stores user information like the username and password
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(100) NOT NULL
);

-- Insert sample data into Users Table (use IDENTITY_INSERT to keep explicit IDs for sample data)
SET IDENTITY_INSERT Users ON;
INSERT INTO Users (UserID, Username, Password) VALUES
(1, 'admin', 'admin123'),
(2, 'pharmacist', 'pharm123'),
(3, 'cashier', 'cash123');
SET IDENTITY_INSERT Users OFF;
GO

-- Create Suppliers Table
-- This table stores information about suppliers such as name, phone, and contact details
CREATE TABLE Suppliers (
    SupplierID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    ContactName VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Email VARCHAR(100) NOT NULL
);

SET IDENTITY_INSERT Suppliers ON;
INSERT INTO Suppliers (SupplierID, Name, PhoneNumber, ContactName, Address, Email) VALUES
(1, 'Pharma Inc.', '123-456-7890', 'John Doe', '123 Pharma Street', 'contact@pharmainc.com'),
(2, 'Med Supply Ltd.', '987-654-3210', 'Jane Smith', '456 Medical Ave', 'sales@medsupply.com');
SET IDENTITY_INSERT Suppliers OFF;
GO

-- Create Customer Table
-- This table stores customer details like their name, address, and contact information
-- Use plural table name to match application code (Customers)
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL
);

SET IDENTITY_INSERT Customers ON;
INSERT INTO Customers (CustomerID, Name, Address, PhoneNumber, Email) VALUES
(1, 'Alice Johnson', '123 Main St', '555-1111', 'alice@email.com'),
(2, 'Bob Brown', '456 Oak St', '555-2222', 'bob@email.com');
SET IDENTITY_INSERT Customers OFF;
GO

-- Create Products Table
-- This table holds product information, including the supplier and product details
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(150) NOT NULL,
    Category VARCHAR(100) NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    Description VARCHAR(500) NULL,
    SupplierID INT NOT NULL,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

SET IDENTITY_INSERT Products ON;
INSERT INTO Products (ProductID, ProductName, Category, UnitPrice, Description, SupplierID) VALUES
(1, 'Paracetamol', 'Pain Reliever', 10.00, 'Pain reliever', 1),
(2, 'Aspirin', 'Pain Reliever', 12.00, 'Anti-inflammatory', 1),
(3, 'Amoxicillin', 'Antibiotic', 20.00, 'Antibiotic for infections', 2);
SET IDENTITY_INSERT Products OFF;
GO

-- Create Sales Table
-- This table records sale transactions, with references to customers and total amount
CREATE TABLE Sales (
    SaleID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    SaleDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

SET IDENTITY_INSERT Sales ON;
INSERT INTO Sales (SaleID, CustomerID, SaleDate, TotalAmount) VALUES
(1, 1, '2025-01-15', 50.00),
(2, 2, '2025-01-16', 70.00);
SET IDENTITY_INSERT Sales OFF;
GO

-- Create SalesDetails Table
-- This table stores detailed information about each item in a sale
CREATE TABLE SalesDetails (
    SaleDetailID INT IDENTITY(1,1) PRIMARY KEY,
    SaleID INT NOT NULL,
    ProductID INT NOT NULL,
    BatchNumber VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL,
    TotalAmount DECIMAL(10, 2) NULL,
    FOREIGN KEY (SaleID) REFERENCES Sales(SaleID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

SET IDENTITY_INSERT SalesDetails ON;
INSERT INTO SalesDetails (SaleDetailID, SaleID, ProductID, BatchNumber, Quantity, TotalAmount) VALUES
(1, 1, 1, 'A100', 2, 20.00),
(2, 1, 2, 'B200', 1, 30.00),
(3, 2, 3, 'C300', 3, 60.00);
SET IDENTITY_INSERT SalesDetails OFF;
GO

-- Create Purchases Table
-- This table stores purchase transactions from suppliers, with the total purchase amount
CREATE TABLE Purchases (
    PurchaseID INT IDENTITY(1,1) PRIMARY KEY,
    SupplierID INT NOT NULL,
    PurchaseDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

SET IDENTITY_INSERT Purchases ON;
INSERT INTO Purchases (PurchaseID, SupplierID, PurchaseDate, TotalAmount) VALUES
(1, 1, '2025-01-10', 100.00),
(2, 2, '2025-01-12', 150.00);
SET IDENTITY_INSERT Purchases OFF;
GO

-- Create PurchaseDetails Table
-- This table records detailed information about each item in a purchase
CREATE TABLE PurchaseDetails (
    PurchaseDetailID INT IDENTITY(1,1) PRIMARY KEY,
    PurchaseID INT NOT NULL,
    ProductID INT NOT NULL,
    BatchNumber VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    ExpiryDate DATE NOT NULL,
    FOREIGN KEY (PurchaseID) REFERENCES Purchases(PurchaseID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

SET IDENTITY_INSERT PurchaseDetails ON;
INSERT INTO PurchaseDetails (PurchaseDetailID, PurchaseID, ProductID, BatchNumber, Quantity, Price, ExpiryDate) VALUES
(1, 1, 1, 'A100', 100, 8.00, '2026-01-01'),
(2, 1, 2, 'B200', 200, 9.00, '2026-01-01'),
(3, 2, 3, 'C300', 150, 15.00, '2026-01-01');
SET IDENTITY_INSERT PurchaseDetails OFF;
GO

-- Create Inventory Table
-- This table keeps track of inventory levels and product details
CREATE TABLE Inventory (
    InventoryID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    BatchNumber VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL,
    ExpiryDate DATE NOT NULL,
    SetPrice DECIMAL(10, 2) NOT NULL,
    SupplierID INT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

SET IDENTITY_INSERT Inventory ON;
INSERT INTO Inventory (InventoryID, ProductID, BatchNumber, Quantity, ExpiryDate, SetPrice, SupplierID) VALUES
(1, 1, 'A100', 50, '2026-01-01', 10.00, 1),
(2, 2, 'B200', 100, '2026-01-01', 12.00, 1),
(3, 3, 'C300', 75, '2026-01-01', 18.00, 2);
SET IDENTITY_INSERT Inventory OFF;
GO


-- Insert additional sample data into Suppliers Table
SET IDENTITY_INSERT Suppliers ON;
INSERT INTO Suppliers (SupplierID, Name, PhoneNumber, ContactName, Address, Email) VALUES
(3, 'HealthCare Supplies', '555-3333', 'Tom Green', '789 Wellness Blvd', 'contact@healthcare.com'),
(4, 'MediProducts Co.', '555-4444', 'Lucy Black', '101 Medi St', 'info@mediproducts.com');
SET IDENTITY_INSERT Suppliers OFF;
GO

-- Insert additional sample data into Customer Table
SET IDENTITY_INSERT Customers ON;
INSERT INTO Customers (CustomerID, Name, Address, PhoneNumber, Email) VALUES
(3, 'Charlie Davis', '789 Pine St', '555-3333', 'charlie@email.com'),
(4, 'Diana Evans', '101 Maple St', '555-4444', 'diana@email.com'),
(5, 'Edward Wright', '202 Birch St', '555-5555', 'edward@email.com');
SET IDENTITY_INSERT Customers OFF;
GO

-- Insert additional sample data into Products Table
SET IDENTITY_INSERT Products ON;
INSERT INTO Products (ProductID, ProductName, Category, UnitPrice, Description, SupplierID) VALUES
(4, 'Vitamin C', 'Supplements', 5.00, 'Vitamin C tablets for immune support', 2),
(5, 'Ibuprofen', 'Pain Reliever', 8.00, 'Pain relief and anti-inflammatory', 2),
(6, 'Insulin', 'Diabetes Care', 50.00, 'Insulin for diabetes management', 3),
(7, 'Cough Syrup', 'Cough and Cold', 15.00, 'Cough syrup for relief from cold', 4);
SET IDENTITY_INSERT Products OFF;
GO

-- Insert additional sample data into Sales Table
SET IDENTITY_INSERT Sales ON;
INSERT INTO Sales (SaleID, CustomerID, SaleDate, TotalAmount) VALUES
(3, 3, '2025-01-18', 45.00),
(4, 4, '2025-01-19', 80.00),
(5, 5, '2025-01-20', 120.00);
SET IDENTITY_INSERT Sales OFF;
GO

-- Insert additional sample data into SalesDetails Table
SET IDENTITY_INSERT SalesDetails ON;
INSERT INTO SalesDetails (SaleDetailID, SaleID, ProductID, BatchNumber, Quantity, TotalAmount) VALUES
(4, 3, 1, 'A100', 3, 30.00),
(5, 3, 2, 'B200', 2, 40.00),
(6, 4, 3, 'C300', 1, 20.00),
(7, 4, 5, 'D400', 4, 32.00),
(8, 5, 4, 'E500', 6, 30.00),
(9, 5, 7, 'F600', 2, 40.00);
SET IDENTITY_INSERT SalesDetails OFF;
GO

-- Insert additional sample data into Purchases Table
SET IDENTITY_INSERT Purchases ON;
INSERT INTO Purchases (PurchaseID, SupplierID, PurchaseDate, TotalAmount) VALUES
(3, 3, '2025-01-14', 120.00),
(4, 4, '2025-01-16', 200.00);
SET IDENTITY_INSERT Purchases OFF;
GO

-- Insert additional sample data into PurchaseDetails Table
SET IDENTITY_INSERT PurchaseDetails ON;
INSERT INTO PurchaseDetails (PurchaseDetailID, PurchaseID, ProductID, BatchNumber, Quantity, Price, ExpiryDate) VALUES
(4, 3, 4, 'G700', 300, 4.00, '2026-03-01'),
(5, 3, 6, 'H800', 100, 48.00, '2026-04-01'),
(6, 4, 7, 'I900', 150, 14.00, '2026-05-01');
SET IDENTITY_INSERT PurchaseDetails OFF;
GO

-- Insert additional sample data into Inventory Table
SET IDENTITY_INSERT Inventory ON;
INSERT INTO Inventory (InventoryID, ProductID, BatchNumber, Quantity, ExpiryDate, SetPrice, SupplierID) VALUES
(4, 4, 'G700', 50, '2026-03-01', 5.00, 3),
(5, 5, 'D400', 75, '2026-02-01', 8.00, 2),
(6, 6, 'H800', 60, '2026-04-01', 45.00, 3),
(7, 7, 'I900', 90, '2026-05-01', 12.00, 4);
SET IDENTITY_INSERT Inventory OFF;
GO