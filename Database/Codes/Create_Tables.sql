-- ============================================= Database Creation =============================================

CREATE DATABASE SampleOffersAPI;
GO
USE SampleOffersAPI;



-- ============================================= 1. Placeholders Table =============================================

CREATE TABLE Placeholders
(
    Placeholder_ID INT PRIMARY KEY IDENTITY,
    Placeholder_Guid UNIQUEIDENTIFIER NOT NULL UNIQUE DEFAULT NEWSEQUENTIALID(),
    Placeholder_Name VARCHAR(100) NOT NULL,
    Channel_Name VARCHAR(100),
    Channel_Type VARCHAR(100) CHECK (Channel_Type IN ('Web', 'Mobile', 'Other')),
    Placeholder_Offer_Limit INT CHECK (Placeholder_Offer_Limit >= 0),
    Placeholder_Creation_Date DATETIME DEFAULT GETDATE(),
    Placeholder_Meta NVARCHAR(MAX) NULL,
    Placeholder_Is_Active BIT NOT NULL DEFAULT 1
);

INSERT INTO Placeholders 
(Placeholder_Name, Channel_Name, Channel_Type, Placeholder_Offer_Limit, Placeholder_Meta, Placeholder_Is_Active)
VALUES
('Home Page Banner',   'NLI',      'Web',    15, N'{"service_type":"Retail","placeholder_description":""}', 1),
('Hero Banner',        'iMobile',  'Mobile',  3, N'{"service_type":"Retail","placeholder_description":""}', 1),
('What''s New',        'RIB',      'Web',     8, N'{"service_type":"Retail%","placeholder_description":""}', 1),
('Offer For You',      'NLI',      'Web',     2, N'{"service_type":"Retail","placeholder_description":""}', 0),
('Marchent Dashboard', 'InstaBIZ', 'Mobile',  4, N'{"service_type":"Corporate","placeholder_description":""}', 1),
('Notification',       'NLI',      'Web',     6, N'{"service_type":"Retail","placeholder_description":""}', 1),
('FT Success',         'InstaBIZ', 'Mobile', 10, N'{"service_type":"Corporate","placeholder_description":""}', 1),
('GST Success',        'CIB',      'Web',     7, N'{"service_type":"Corporate","placeholder_description":""}', 1),
('Loans',              'RIB',      'Web',    12, N'{"service_type":"Retail","placeholder_description":""}', 0),
('Rewards',            'iMobile',  'Mobile', 15, N'{"service_type":"Retail","placeholder_description":""}', 1);

SELECT * FROM Placeholders;

-- DROP TABLE Placeholders;



-- ============================================= 2. Offers Table =============================================

CREATE TABLE Offers
(
    Offer_ID INT PRIMARY KEY IDENTITY,
    Offer_GUID UNIQUEIDENTIFIER NOT NULL UNIQUE DEFAULT NEWSEQUENTIALID(),
    Offer_Name VARCHAR(100),
    Offer_Description VARCHAR(500) NULL,
    Offer_Type VARCHAR(100),
    Offer_Start_Date DATETIME NOT NULL,
    Offer_End_Date DATETIME NOT NULL,
    Offer_Priority INT,
    Offer_View_Threshold INT,
    Offer_Click_Threshold INT,
    Offer_Banner_Type VARCHAR(100),
    Offer_Content NVARCHAR(MAX) NULL,
    Offer_Extra_Content NVARCHAR(MAX) NULL,
    Offer_Meta NVARCHAR(MAX) NULL,
    Last_Modification_Date DATETIME NOT NULL DEFAULT GETDATE(),
    Offer_Visibility_Flag BIT NOT NULL DEFAULT 1,
    CONSTRAINT CK_Offers_Date CHECK (Offer_End_Date >= Offer_Start_Date)
);

INSERT INTO Offers
(Offer_Name, Offer_Description, Offer_Type, Offer_Start_Date, Offer_End_Date, Offer_Priority, 
 Offer_View_Threshold, Offer_Click_Threshold, Offer_Banner_Type, Offer_Content, 
 Offer_Extra_Content, Offer_Meta, Offer_Visibility_Flag)
VALUES
('Pre-Approved Home Loan Offer','Offer Description','NBA','2025-09-01','2026-12-31',1,10,3,'Static',
 N'{"redirection_URL":"https://www.example.com/offers/123","image_URL":{"mobile":"https://cdn.example.com/images/offer_mobile.jpg","desktop":"https://cdn.example.com/images/offer_desktop.jpg","tablet":"https://cdn.example.com/images/offer_tablet.jpg"},"offer_text":"Get 20% off on your first purchase!"}',
 '',N'{"product":"HL"}',1),
('Personal Loan Asset Offer','Offer Description','NBA','2025-09-01','2026-12-31',2,10,3,'Static',
 N'{"redirection_URL":"https://www.example.com/offers/123","image_URL":{"mobile":"https://cdn.example.com/images/offer_mobile.jpg","desktop":"https://cdn.example.com/images/offer_desktop.jpg","tablet":"https://cdn.example.com/images/offer_tablet.jpg"},"offer_text":"Get 20% off on your first purchase!"}',
 '',N'{"product":"PL"}',1),
('Forex Offer','Offer Description','NBA','2025-09-01','2026-12-31',3,10,3,'Static',
 N'{"redirection_URL":"https://www.example.com/offers/123","image_URL":{"mobile":"https://cdn.example.com/images/offer_mobile.jpg","desktop":"https://cdn.example.com/images/offer_desktop.jpg","tablet":"https://cdn.example.com/images/offer_tablet.jpg"},"offer_text":"Get 20% off on your first purchase!"}',
 '',N'{"product":"Forex"}',1),
('Credit Card Upgrade Offer','Offer Description','NBA','2025-09-01','2026-12-31',4,10,3,'Static',
 N'{"redirection_URL":"https://www.example.com/offers/123","image_URL":{"mobile":"https://cdn.example.com/images/offer_mobile.jpg","desktop":"https://cdn.example.com/images/offer_desktop.jpg","tablet":"https://cdn.example.com/images/offer_tablet.jpg"},"offer_text":"Get 20% off on your first purchase!"}',
 '',N'{"product":"CC"}',1),
('Gold Loan Offer','Offer Description','NBA','2025-09-01','2026-12-31',5,10,3,'Static',
 N'{"redirection_URL":"https://www.example.com/offers/123","image_URL":{"mobile":"https://cdn.example.com/images/offer_mobile.jpg","desktop":"https://cdn.example.com/images/offer_desktop.jpg","tablet":"https://cdn.example.com/images/offer_tablet.jpg"},"offer_text":"Get 20% off on your first purchase!"}',
 '',N'{"product":"GL"}',1),
('Scan & Pay Offer','Offer Description','NBA','2025-09-01','2026-12-31',6,10,3,'Static',
 N'{"redirection_URL":"https://www.example.com/offers/123","image_URL":{"mobile":"https://cdn.example.com/images/offer_mobile.jpg","desktop":"https://cdn.example.com/images/offer_desktop.jpg","tablet":"https://cdn.example.com/images/offer_tablet.jpg"},"offer_text":"Get 20% off on your first purchase!"}',
 '',N'{"product":"SP"}',1),
('Real Time MF Investment','Offer Description','NBA','2025-09-01','2026-12-31',7,10,3,'Static',
 N'{"redirection_URL":"https://www.example.com/offers/123","image_URL":{"mobile":"https://cdn.example.com/images/offer_mobile.jpg","desktop":"https://cdn.example.com/images/offer_desktop.jpg","tablet":"https://cdn.example.com/images/offer_tablet.jpg"},"offer_text":"Get 20% off on your first purchase!"}',
 '',N'{"product":"MF"}',1),
('Pay to Contact Offer','Offer Description','NBA','2025-09-01','2026-12-31',8,10,3,'Static',
 N'{"redirection_URL":"https://www.example.com/offers/123","image_URL":{"mobile":"https://cdn.example.com/images/offer_mobile.jpg","desktop":"https://cdn.example.com/images/offer_desktop.jpg","tablet":"https://cdn.example.com/images/offer_tablet.jpg"},"offer_text":"Get 20% off on your first purchase!"}',
 '',N'{"product":"PC"}',1),
('Mutual Fund Offer','Offer Description','NBA','2025-09-01','2026-12-31',9,10,3,'Static',
 N'{"redirection_URL":"https://www.example.com/offers/123","image_URL":{"mobile":"https://cdn.example.com/images/offer_mobile.jpg","desktop":"https://cdn.example.com/images/offer_desktop.jpg","tablet":"https://cdn.example.com/images/offer_tablet.jpg"},"offer_text":"Get 20% off on your first purchase!"}',
 '',N'{"product":"MF"}',1),
('iWish Offer','Offer Description','NBA','2025-09-01','2026-12-31',10,10,3,'Static',
 N'{"redirection_URL":"https://www.example.com/offers/123","image_URL":{"mobile":"https://cdn.example.com/images/offer_mobile.jpg","desktop":"https://cdn.example.com/images/offer_desktop.jpg","tablet":"https://cdn.example.com/images/offer_tablet.jpg"},"offer_text":"Get 20% off on your first purchase!"}',
 '',N'{"product":"iWish"}',1),
('Two Wheeler Loan Offer','Offer Description','NBA','2025-09-01','2026-12-31',11,10,3,'Static',
 N'{"redirection_URL":"https://www.example.com/offers/123","image_URL":{"mobile":"https://cdn.example.com/images/offer_mobile.jpg","desktop":"https://cdn.example.com/images/offer_desktop.jpg","tablet":"https://cdn.example.com/images/offer_tablet.jpg"},"offer_text":"Get 20% off on your first purchase!"}',
 '',N'{"product":"TWL"}',1),
('Fastag Offer','Offer Description','NBA','2025-09-01','2026-12-31',12,10,3,'Static',
 N'{"redirection_URL":"https://www.example.com/offers/123","image_URL":{"mobile":"https://cdn.example.com/images/offer_mobile.jpg","desktop":"https://cdn.example.com/images/offer_desktop.jpg","tablet":"https://cdn.example.com/images/offer_tablet.jpg"},"offer_text":"Get 20% off on your first purchase!"}',
 '',N'{"product":"Fastag"}',1),
('Education Loan Offer','Offer Description','NBA','2025-09-01','2026-12-31',13,10,3,'Static',
 N'{"redirection_URL":"https://www.example.com/offers/123","image_URL":{"mobile":"https://cdn.example.com/images/offer_mobile.jpg","desktop":"https://cdn.example.com/images/offer_desktop.jpg","tablet":"https://cdn.example.com/images/offer_tablet.jpg"},"offer_text":"Get 20% off on your first purchase!"}',
 '',N'{"product":"EL"}',1),
('Electricity Billpay Offer','Offer Description','NBA','2025-09-01','2026-12-31',14,10,3,'Static',
 N'{"redirection_URL":"https://www.example.com/offers/123","image_URL":{"mobile":"https://cdn.example.com/images/offer_mobile.jpg","desktop":"https://cdn.example.com/images/offer_desktop.jpg","tablet":"https://cdn.example.com/images/offer_tablet.jpg"},"offer_text":"Get 20% off on your first purchase!"}',
 '',N'{"product":"BBPS"}',1),
('Credit Card Limit Increase Offer','Offer Description','NBA','2025-09-01','2026-12-31',15,10,3,'Static',
 N'{"redirection_URL":"https://www.example.com/offers/123","image_URL":{"mobile":"https://cdn.example.com/images/offer_mobile.jpg","desktop":"https://cdn.example.com/images/offer_desktop.jpg","tablet":"https://cdn.example.com/images/offer_tablet.jpg"},"offer_text":"Get 20% off on your first purchase!"}',
 '',N'{"product":"CLI"}',1),
('Consumer EMI Offer','Offer Description','NBA','2025-09-01','2026-12-31',16,10,3,'Static',
 N'{"redirection_URL":"https://www.example.com/offers/123","image_URL":{"mobile":"https://cdn.example.com/images/offer_mobile.jpg","desktop":"https://cdn.example.com/images/offer_desktop.jpg","tablet":"https://cdn.example.com/images/offer_tablet.jpg"},"offer_text":"Get 20% off on your first purchase!"}',
 '',N'{"product":"EMI"}',1),
('BBPS Electricity Offer','Offer Description','NBA','2025-09-01','2026-12-31',17,10,3,'Static',
 N'{"redirection_URL":"https://www.example.com/offers/123","image_URL":{"mobile":"https://cdn.example.com/images/offer_mobile.jpg","desktop":"https://cdn.example.com/images/offer_desktop.jpg","tablet":"https://cdn.example.com/images/offer_tablet.jpg"},"offer_text":"Get 20% off on your first purchase!"}',
 '',N'{"product":"BBPS"}',1),
('Debit Card Upgrade Offer','Offer Description','NBA','2025-09-01','2026-12-31',18,10,3,'Static',
 N'{"redirection_URL":"https://www.example.com/offers/123","image_URL":{"mobile":"https://cdn.example.com/images/offer_mobile.jpg","desktop":"https://cdn.example.com/images/offer_desktop.jpg","tablet":"https://cdn.example.com/images/offer_tablet.jpg"},"offer_text":"Get 20% off on your first purchase!"}',
 '',N'{"product":"DCU"}',1),
('Auto Loan Default Offer','Offer Description','Default','2025-09-01','2026-12-31',19,10,3,'Static',
 N'{"redirection_URL":"https://www.example.com/offers/123","image_URL":{"mobile":"https://cdn.example.com/images/offer_mobile.jpg","desktop":"https://cdn.example.com/images/offer_desktop.jpg","tablet":"https://cdn.example.com/images/offer_tablet.jpg"},"offer_text":"Get 20% off on your first purchase!"}',
 '',N'{"product":"AL"}',1),
('Demat Default Offer','Offer Description','Default','2025-09-01','2026-12-31',20,10,3,'Static',
 N'{"redirection_URL":"https://www.example.com/offers/123","image_URL":{"mobile":"https://cdn.example.com/images/offer_mobile.jpg","desktop":"https://cdn.example.com/images/offer_desktop.jpg","tablet":"https://cdn.example.com/images/offer_tablet.jpg"},"offer_text":"Get 20% off on your first purchase!"}',
 '',N'{"product":"Demat"}',1);

SELECT * FROM Offers;

-- Update default offers threshold
UPDATE Offers
SET Offer_Visibility_Flag = 0
WHERE Offer_ID = 19

-- Validate JSON field
SELECT ISJSON(Offer_Content)
FROM Offers
WHERE Offer_ID = 19;

-- Update specific Offer Content
UPDATE Offers 
SET Offer_Content = N'{
    "redirection_URL": "https://www.chittaranjansaha.com", 
    "image_URL": { 
        "mobile": "https://raw.githubusercontent.com/git-chittaranjan/offers-implementation-api/main/Frontend/Contents/Desktop/Demat_Default_Offer.gif", 
        "desktop": "https://raw.githubusercontent.com/git-chittaranjan/offers-implementation-api/main/Frontend/Contents/Desktop/Demat_Default_Offer.gif", 
        "tablet": "https://raw.githubusercontent.com/git-chittaranjan/offers-implementation-api/main/Frontend/Contents/Desktop/Demat_Default_Offer.gif" 
    }, 
    "offer_text": "Demat_Default_Offer.gif" 
}'
WHERE Offer_ID = 20;

-- DROP TABLE Offers;



-- ============================================= 3. Customers Table =============================================

CREATE TABLE Customers
(
    Cust_ID INT IDENTITY,
    Cust_Fed_ID VARCHAR(100) PRIMARY KEY,
    Cust_Name VARCHAR(100),
    Cust_Data NVARCHAR(MAX),
    Cust_Entry_Date DATETIME NOT NULL DEFAULT GETDATE(),
    Cust_Is_Active BIT NOT NULL DEFAULT 1
);

INSERT INTO Customers (Cust_Fed_ID, Cust_Name, Cust_Data)
VALUES 
('4839201746', 'Rahul Sharma', N'{"age": 32, "city": "Mumbai", "gender": "Male"}'),
('9283746150', 'Ananya Gupta', N'{"age": 28, "city": "Delhi", "gender": "Female"}'),
('7152903846', 'Vikram Singh', N'{"age": 40, "city": "Bengaluru", "gender": "Male"}'),
('6049382751', 'Priya Nair', N'{"age": 35, "city": "Chennai", "gender": "Female"}'),
('8391046275', 'Arjun Mehta', N'{"age": 30, "city": "Kolkata", "gender": "Male"}');

SELECT * FROM Customers ORDER BY Cust_ID;

-- DROP TABLE Customers;

UPDATE Customers 
	SET Cust_Is_Active = 0
WHERE Cust_Fed_ID = '8391046275'


-- ============================================= 4. CustomerOffers Table =============================================

CREATE TABLE CustomerOffers
(
    Cust_Fed_ID VARCHAR(100) NOT NULL,
    Offer_ID INT NOT NULL,
    Offer_Guid UNIQUEIDENTIFIER NOT NULL,
    Assigned_Date DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (Cust_Fed_ID, Offer_ID),
    FOREIGN KEY (Cust_Fed_ID) REFERENCES Customers(Cust_Fed_ID),
    FOREIGN KEY (Offer_ID) REFERENCES Offers(Offer_ID)
);

INSERT INTO CustomerOffers (Cust_Fed_ID, Offer_ID, Assigned_Date) VALUES
('4839201746',  1, '2025-08-01'), ('4839201746',  3, '2025-08-05'), ('4839201746',  5, '2025-08-06'),
('4839201746',  7, '2025-08-12'), ('4839201746',  9, '2025-08-19'), ('4839201746', 11, '2025-08-20'),
('4839201746', 13, '2025-08-20'), ('4839201746', 15, '2025-08-20'), ('4839201746', 17, '2025-08-20'),
('9283746150',  2, '2025-08-03'), ('9283746150',  4, '2025-08-14'), ('9283746150',  6, '2025-08-14'),
('9283746150',  8, '2025-08-14'), ('9283746150', 10, '2025-08-14'), ('9283746150', 12, '2025-08-14'),
('9283746150', 14, '2025-08-14'), ('9283746150', 16, '2025-08-14'), ('9283746150', 18, '2025-08-14'),
('7152903846',  3, '2025-08-07'), ('7152903846',  6, '2025-08-08'), ('7152903846',  9, '2025-08-11'),
('7152903846', 12, '2025-08-11'), ('7152903846', 15, '2025-08-11'), ('7152903846', 18, '2025-08-11'),
('6049382751',  1, '2025-08-04'), ('6049382751',  3, '2025-08-10'), ('6049382751',  5, '2025-08-16'),
('6049382751',  7, '2025-08-18'), ('6049382751',  9, '2025-08-18'), ('6049382751', 10, '2025-08-18'),
('6049382751', 12, '2025-08-18'), ('6049382751', 14, '2025-08-18'), ('6049382751', 16, '2025-08-18'),
('6049382751', 18, '2025-08-18'),
('8391046275',  1, '2025-08-13'), ('8391046275',  2, '2025-08-15'), ('8391046275',  3, '2025-08-17'),
('8391046275',  4, '2025-08-17'), ('8391046275',  5, '2025-08-17'), ('8391046275',  6, '2025-08-17'),
('8391046275',  7, '2025-08-17'), ('8391046275',  8, '2025-08-17'), ('8391046275',  9, '2025-08-17'),
('8391046275', 10, '2025-08-17'), ('8391046275', 11, '2025-08-17'), ('8391046275', 12, '2025-08-17'),
('8391046275', 13, '2025-08-17'), ('8391046275', 14, '2025-08-17'), ('8391046275', 15, '2025-08-17'),
('8391046275', 16, '2025-08-17'), ('8391046275', 17, '2025-08-17'), ('8391046275', 18, '2025-08-17');

SELECT * FROM CustomerOffers;

SELECT 
    c.Cust_ID, 
    c.Cust_Fed_ID, 
    c.Cust_Name, 
    o.Offer_ID,
    o.Offer_GUID,
    o.Offer_Name
FROM CustomerOffers co
INNER JOIN Offers o ON co.Offer_ID = o.Offer_ID
INNER JOIN Customers c ON co.Cust_Fed_ID = c.Cust_Fed_ID
WHERE c.Cust_Fed_ID = '9283746150';

-- DROP TABLE CustomerOffers;



-- ============================================= 5. PlaceholderOffers Table =============================================

CREATE TABLE PlaceholderOffers
(
    Offer_ID INT NOT NULL,
    Placeholder_ID INT NOT NULL,
    PRIMARY KEY (Offer_ID, Placeholder_ID),
    FOREIGN KEY (Offer_ID) REFERENCES Offers(Offer_ID),
    FOREIGN KEY (Placeholder_ID) REFERENCES Placeholders(Placeholder_ID)
);

INSERT INTO PlaceholderOffers (Placeholder_ID, Offer_ID) VALUES
(1,  1), (1,  2), (1,  3), (1,  4), (1,  5), (1,  6), (1,  7), (1,  8), (1,  9), (1, 10),
(1, 11), (1, 12), (1, 13), (1, 14), (1, 15), (1, 16), (1, 17), (1, 18), (1, 19), (1, 20),
(2,  3), (2,  6), (2,  9), (2, 12), (2, 15), (2, 18), (2, 19), (2, 20),
(3,  1), (3,  2), (3,  3), (3,  4), (3,  5), (3,  6), (3,  7), (3,  8), (3,  9), (3, 10),
(3, 15), (3, 16), (3, 17), (3, 18),
(4,  2), (4,  4), (4,  6), (4,  8), (4, 10), (4, 12), (4, 14), (4, 16), (4, 18), (4, 20),
(5,  1), (5,  3), (5,  5), (5,  7), (5,  9), (5, 11), (5, 13), (5, 15), (5, 17), (5, 19);

SELECT * FROM PlaceholderOffers;

SELECT 
    p.Placeholder_ID,
    p.Placeholder_Guid,
    p.Placeholder_Name, 
    p.Channel_Name, 
    o.Offer_ID, 
    o.Offer_Name
FROM PlaceholderOffers po
INNER JOIN Placeholders p ON po.Placeholder_ID = p.Placeholder_ID
INNER JOIN Offers o ON po.Offer_ID = o.Offer_ID
WHERE p.Placeholder_ID = 5;

-- DROP TABLE PlaceholderOffers;



-- ============================================= 6. BITs Table =============================================

CREATE TABLE Bits
(
    Bit_ID INT PRIMARY KEY IDENTITY,
    Bit_Guid UNIQUEIDENTIFIER NOT NULL UNIQUE DEFAULT NEWSEQUENTIALID(),
    Cust_Fed_ID VARCHAR(100),
    Offer_Guid UNIQUEIDENTIFIER,
    Offer_Name VARCHAR(100),
    Bit_Type VARCHAR(100) NOT NULL CHECK (Bit_Type IN ('VIEW','CLICK')),
    Channel_Name VARCHAR(100),
    Placeholder_Guid UNIQUEIDENTIFIER,
    Placeholder_Name VARCHAR(100),
    Action_Timestamp DATETIME2 DEFAULT SYSDATETIME()
);


INSERT INTO Bits (Cust_Fed_ID, Offer_Guid, Offer_Name, Bit_Type, Channel_Name, Placeholder_Guid, Placeholder_Name)
VALUES
--('4839201746', 'CBDA7CC0-5387-F011-9F57-64D69AE7FAE4', 'Pre-Approved Home Loan Offer', 'CLICK', 'NLI', '52C5AA3B-AB8B-F011-9F57-64D69AE7FAE4', 'Home Page Banner'),
('4839201746', 'CBDA7CC0-5387-F011-9F57-64D69AE7FAE4', 'Pre-Approved Home Loan Offer', 'CLICK', 'RIB', '54C5AA3B-AB8B-F011-9F57-64D69AE7FAE4', 'What''s New'),
('4839201746', 'CBDA7CC0-5387-F011-9F57-64D69AE7FAE4', 'Pre-Approved Home Loan Offer', 'VIEW', 'iMobile', '53C5AA3B-AB8B-F011-9F57-64D69AE7FAE4', 'Hero Banner'),
('4839201746', 'CBDA7CC0-5387-F011-9F57-64D69AE7FAE4', 'Pre-Approved Home Loan Offer', 'CLICK', 'RIB', '54C5AA3B-AB8B-F011-9F57-64D69AE7FAE4', 'What''s New'),
('4839201746', 'CBDA7CC0-5387-F011-9F57-64D69AE7FAE4', 'Pre-Approved Home Loan Offer', 'VIEW', 'NLI', '52C5AA3B-AB8B-F011-9F57-64D69AE7FAE4', 'Home Page Banner'),
('6049382751', 'F8E26247-5587-F011-9F57-64D69AE7FAE4', 'Gold Loan Offer', 'CLICK', 'NLI', '52C5AA3B-AB8B-F011-9F57-64D69AE7FAE4', 'Home Page Banner'),
('6049382751', 'F8E26247-5587-F011-9F57-64D69AE7FAE4', 'Gold Loan Offer', 'VIEW', 'NLI', '52C5AA3B-AB8B-F011-9F57-64D69AE7FAE4', 'Home Page Banner'),
('6049382751', 'F8E26247-5587-F011-9F57-64D69AE7FAE4', 'Gold Loan Offer', 'VIEW', 'NLI', '52C5AA3B-AB8B-F011-9F57-64D69AE7FAE4', 'Home Page Banner'),
('6049382751', 'F8E26247-5587-F011-9F57-64D69AE7FAE4', 'Gold Loan Offer', 'CLICK', 'NLI', '52C5AA3B-AB8B-F011-9F57-64D69AE7FAE4', 'Home Page Banner'),
('6049382751', 'F8E26247-5587-F011-9F57-64D69AE7FAE4', 'Gold Loan Offer', 'VIEW', 'NLI', '52C5AA3B-AB8B-F011-9F57-64D69AE7FAE4', 'Home Page Banner');

INSERT INTO Bits (Cust_Fed_ID, Offer_Guid, Offer_Name, Bit_Type, Channel_Name, Placeholder_Guid, Placeholder_Name)
VALUES
('6049382751', 'F6E26247-5587-F011-9F57-64D69AE7FAE4', 'Forex Offer', 'VIEW', 'InstaBIZ', '56C5AA3B-AB8B-F011-9F57-64D69AE7FAE4', 'Marchent Dashboard')

SELECT * FROM Bits

-- DROP TABLE Bits



-- ============================================= 7. Customer Offer Daily Status Table =============================================

CREATE TABLE CustomerOfferStatsDaily (
    Stat_Date DATE NOT NULL,
    Cust_Fed_ID VARCHAR(100) NOT NULL,
    Offer_Guid UNIQUEIDENTIFIER NOT NULL,
    View_Count INT DEFAULT 0,
    Click_Count INT DEFAULT 0,
    CONSTRAINT PK_CustomerOfferStatsDaily 
        PRIMARY KEY (Stat_Date, Cust_Fed_ID, Offer_Guid)
);

--DROP TABLE CustomerOfferStatsDaily

SELECT * FROM CustomerOfferStatsDaily




