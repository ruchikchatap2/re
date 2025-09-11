
CREATE DATABASE BankingSystem;
USE BankingSystem;

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Address VARCHAR(200)
);

-- Accounts Table
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    AccountType VARCHAR(20) CHECK (AccountType IN ('Savings' , 'Current')),
    Balance DECIMAL(12 , 2 ) DEFAULT 0.00,
    FOREIGN KEY (CustomerID)
        REFERENCES Customers (CustomerID)
);

-- Transactions Table
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    AccountID INT,
    TransactionType VARCHAR(20) CHECK (TransactionType IN ('Deposit' , 'Withdraw', 'Transfer')),
    Amount DECIMAL(12 , 2 ),
    TransactionDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (AccountID)
        REFERENCES Accounts (AccountID)
);

-- Loans Table
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    LoanType VARCHAR(50),
    LoanAmount DECIMAL(12 , 2 ),
    InterestRate DECIMAL(5 , 2 ),
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID)
        REFERENCES Customers (CustomerID)
);


-- Customers
INSERT INTO Customers (Name, Email, Phone, Address) VALUES
('Riya Sharma', 'riya@gmail.com', '9876543210', 'Delhi'),
('Arjun Mehta', 'arjun@gmail.com', '9123456780', 'Mumbai');

-- Accounts
INSERT INTO Accounts (CustomerID, AccountType, Balance) VALUES
(1, 'Savings', 50000.00),
(1, 'Current', 20000.00),
(2, 'Savings', 75000.00);

-- Transactions
INSERT INTO Transactions (AccountID, TransactionType, Amount) VALUES
(1, 'Deposit', 10000.00),
(1, 'Withdraw', 5000.00),
(2, 'Deposit', 15000.00);
-- Loans
INSERT INTO Loans (CustomerID, LoanType, LoanAmount, InterestRate, StartDate, EndDate) VALUES
(1, 'Home Loan', 1000000.00, 7.5, '2024-01-01', '2034-01-01'),
(2, 'Car Loan', 500000.00, 8.0, '2023-06-15', '2028-06-15');


-- Show all customers
SELECT 
    *
FROM
    Customers;

-- Get account balance of a customer
SELECT 
    Name, AccountType, Balance
FROM
    Customers
        JOIN
    Accounts ON Customers.CustomerID = Accounts.CustomerID
WHERE
    Name = 'Riya Sharma';

-- Total transactions of an account
SELECT 
    AccountID, SUM(Amount) AS Total_Amount
FROM
    Transactions
GROUP BY AccountID;

-- Customers with active loans
SELECT 
    Name, LoanType, LoanAmount
FROM
    Customers
        JOIN
    Loans ON Customers.CustomerID = Loans.CustomerID;

-- Top 3 customers with highest balance
SELECT 
    Customers.Name, SUM(Accounts.Balance) AS Total_Balance
FROM
    Customers
        JOIN
    Accounts ON Customers.CustomerID = Accounts.CustomerID
GROUP BY Customers.Name
ORDER BY Total_Balance DESC
LIMIT 3;



START TRANSACTION;

-- Withdraw 2000 from Account 1
UPDATE Accounts 
SET 
    Balance = Balance - 2000
WHERE
    AccountID = 1;

-- Deposit 2000 to Account 2
UPDATE Accounts 
SET 
    Balance = Balance + 2000
WHERE
    AccountID = 2;
COMMIT;
ROLLBACK;





