SELECT * from pg_catalog.pg_tables where schemaname != 'information_schema' and schemaname != 'pg_catalog';

CREATE DATABASE Umuzi;

CREATE TABLE Customers(
CustomerID SERIAL PRIMARY KEY,
FirstName VARCHAR(50),
LastName varchar(50),
Gender varchar(10),
Address varchar(50),
Phone bigint,
Email varchar(100),
City varchar(20),
Country varchar(50));

INSERT INTO Customers (FirstName, LastName, Gender, Address, Phone, Email, City, Country) VALUES
('John', 'Hibert', 'Male', '284 chaucer str', 084789657, 'john@gmail.com', 'Johannesburg', 'South Africa'),
('Thando', 'Sithole', 'Female', '240 Sect 1', 0794445584, 'thando@gmail.com', 'CapeTown', 'South Africa'),
('Leon', 'Glen', 'Male', '81 Everton Rd Gillits', 0820832830, 'leon@gmail.com', 'Durban', 'South Africa'),
('Charl', 'Muller', 'Male', '290A Dorset Ecke', 44856873, 'charl.muller@yahoo.com', 'Berlin', 'Germany'),
('Julis', 'Stein', 'Female', '2 Wernerring', 448672448, 'js234@yahoo.com', 'Frankfurt', 'Germany');

CREATE TABLE Employees(
EmployerID SERIAL PRIMARY KEY,
FirstName VARCHAR(50),
LastName varchar(50),
Email varchar(100),
JobTitle varchar(20));

INSERT INTO Employees (FirstName, LastName, Email,JobTitle) VALUES
('Kani', 'Matthew', 'mat@gmail.com', 'Manager'),
('Lesly', 'Cronje', 'LesC@gmail.com', 'Clerk'),
('Gideon', 'Maduku', 'm@gmail.com', 'Accountant');

CREATE TABLE Orders(
OrderID SERIAL PRIMARY KEY,
ProductID int,
PaymentID int,
FulfilledByEmployeeID int,
DateRequired DATE,
DateShipped DATE,
Status varchar(20));

INSERT INTO Orders (ProductID, PaymentID, FulfilledByEmployeeID, DateRequired, DateShipped, Status) VALUES
(1, 1, 2, 5 September 2018, 00-00-0000, 'Not shipped'),
(1, 2, 2, 04 september 2018, 03-09-2018, 'Shipped'),
(3, 3, 3, 06 September 2018, 00-00-0000, 'Not shipped');


CREATE TABLE Payments(
CustomerID SERIAL PRIMARY KEY,
PaymentID int,
PaymentDate DATE,
Amount varchar(1000));

INSERT INTO PAyments (CustomerID, PaymentID, PaymentDate, Amount) VALUES
(1, 1, '01-09-2018', 'R150.75'),
(5, 2, '03-09-2018', 'R150.75'),
(4, 3, '03-09-2018', 'R700.60');

CREATE TABLE Products(
ProductID SERIAL PRIMARY KEY,
ProductName varchar(100),
Description varchar(300),
BuyPrice varchar(1000));

INSERT INTO Products (ProductID, ProductName, Description, BuyPrice) VALUES
(1, 'Harley Davidson Chopper', 'This replica features working kickstand, front suspension, gear-shift lever', 'R150,75'),
(2, 'Classic Car', 'Turnable front wheels, steering function', 'R550.75'),
(3, 'Sports Car', 'Turnable front wheels, steereing function', R700.60);

-- PART2: QUERYING DATABASE
SELECT * FROM Customers;

-- Select only column with FirstName and LastName as name on Customers table
SELECT FirstName || ' ' || LastName AS name FROM Customers;

-- Show the name of the customer whose CustomerID is 1
SELECT FirstName || ' ' || LastName AS name FROM Customers WHERE CustomerID=2;

-- DELETE the record from Customers table for customer 2 (CustomerID=2) my list starts from the number two so i deleted my third CustomerID as i am taking it as my second CustomerID.
DELETE FROM Customers WHERE CustomerID=2;

-- UPDATE the record for CustomerID = 1 on the customer table so that the name is "Lerato Mabitso"
UPDATE Customers set FirstName = 'Lerato', LastName = 'Mabitso' WHERE CustomerID=1;

-- Select all unique statuses from the orders table and get a count of the number of orders for each unique status
SELECT DISTINCT status, COUNT(DISTINCT status) FROM orders GROUP BY status;

-- Return the MAXIMUM payment made on the payments table.
SELECT MAX(Amount) FROM Payments;

-- Select all Customers from the Customers table, sorted by country column in ascending order
SELECT * FROM Customers ORDER BY Country ASC;
-- Select all Customers from the Customers table, sorted by country column in descending order
SELECT * FROM Customers ORDER BY Country DESC;

 --Select all products with a price BETWEEN R100 and R600.
SELECT * FROM Products WHERE BuyPrice BETWEEN 100 AND 600;

--Select all fields from “Customers” where country is “Germany” AND city is “Berlin”.
SELECT * FROM Customers WHERE country = 'Germany' AND city = 'Berlin';

--Select all fields from “Customers” where city is “Cape Town” OR “Durban”.
SELECT * FROM Customers  WHERE city = 'Cape Town' OR city = 'Durban';

--Select all records from Products where the Price is GREATER than R500.
SELECT * FROM Products WHERE BuyPrice >500;

--Return the sum of the Amounts on the Payments table.
SELECT SUM(Amount) FROM Payments;

--Count the number of shipped orders in the Orders table.
SELECT COUNT(status) FROM Orders WHERE status='Shipped';

--Return the average price of all Products, in Rands and in Dollars (assume the exchange rate is R12 to the Dollar).
SELECT AVG(BuyPrice) AS Rand, AVG(BuyPrice/12) AS DOLLARS FROM products;

--Using INNER JOIN create a query that selects all Payments with Customer information.
SELECT
    Customers.CustomerID,
    Customers.FirstName,
    Customers.LastName,
    Customers.Gender,
    Customers.Address,
    Customers.Phone,
    Customers.Email,
    Customers.City,
    Customers.Country,
    payments.PaymentDate,
    payments.Amount
FROM
    Customers
INNER JOIN Payments ON Customers.CustomerID = Payments.CustomerID;

-- Select all products that have turnable front wheels.
SELECT * FROM Products WHERE description LIKE 'Turnable front wheels%';