

 CREATE DATABASE SampleOffersAPI

 USE SampleOffersAPI

 -- Tables to be created 
 -- 1. Offers - (10 Records) 
 -- 2. Placeholders
 -- 3. Customers
 -- 4. CustomerOffers
 -- 5. PlaceholderOffers


 --------------------------------------------- Placeholders Table ---------------------------------------------

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
	Placeholder_Is_Active BIT NOT NULL DEFAULT 1,
 )


INSERT INTO Placeholders (Placeholder_Name, Channel_Name, Channel_Type, Placeholder_Offer_Limit, Placeholder_Meta, Placeholder_Is_Active)
VALUES
    ('Home Page Banner',   'NLI',      'Web',    15, N'{"service_type":"Retail","placeholder_description":""}', 1),
    ('Hero Banner',        'iMobile',  'Mobile',  3, N'{"service_type":"Retail","placeholder_description":""}', 1),
    ('What''s New',        'RIB',      'Web',     8, N'{"service_type":"Retail%","placeholder_description":""}', 1),
    ('Offer For You',      'NLI',      'Web',     2, N'{"service_type":"Retail","placeholder_description":""}', 0),
    ('Notification',       'NLI',      'Web',     6, N'{"service_type":"Retail","placeholder_description":""}', 1),
    ('Marchent Dashboard', 'InstaBIZ', 'Mobile',  4, N'{"service_type":"Corporate","placeholder_description":""}', 1),
    ('FT Success',         'InstaBIZ', 'Mobile', 10, N'{"service_type":"Corporate","placeholder_description":""}', 1),
    ('GST Success',        'CIB',      'Web',     7, N'{"service_type":"Corporate","placeholder_description":""}', 1),
    ('Loans',              'RIB',      'Web',    12, N'{"service_type":"Retail","placeholder_description":""}', 0),
    ('Rewards',            'iMobile',  'Mobile', 15, N'{"service_type":"Retail","placeholder_description":""}', 1);


SELECT * FROM Placeholders

--DROP TABLE Placeholders


 --------------------------------------------- Offers Table ---------------------------------------------

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
		CONSTRAINT CK_Offers_Date CHECK (Offer_End_Date >= Offer_Start_Date),
)


INSERT INTO Offers
(Offer_Name, Offer_Description, Offer_Type, Offer_Start_Date, Offer_End_Date, Offer_Priority, Offer_View_Threshold, Offer_Click_Threshold, Offer_Banner_Type, 
 Offer_Content, Offer_Extra_Content, Offer_Meta, Offer_Visibility_Flag)
VALUES
-- 1st Record
('Pre-Approved Home Loan Offer', 'Offer Description', 'NBA', '2025-09-01', '2026-12-31', 1, 10, 3, 'Static', 
    N'{
        "redirection_URL": "https://www.example.com/offers/123",
        "image_URL": {
            "mobile": "https://cdn.example.com/images/offer_mobile.jpg",
            "desktop": "https://cdn.example.com/images/offer_desktop.jpg",
            "tablet": "https://cdn.example.com/images/offer_tablet.jpg"
        },
        "offer_text": "Get 20% off on your first purchase!"
    }', 
'', N'{"product":"HL"}', 1),


-- 2nd Record
('Personal Loan Asset Offer', 'Offer Description', 'NBA', '2025-09-01', '2026-12-31', 2, 10, 3, 'Static', 
    N'{
        "redirection_URL": "https://www.example.com/offers/123",
        "image_URL": {
            "mobile": "https://cdn.example.com/images/offer_mobile.jpg",
            "desktop": "https://cdn.example.com/images/offer_desktop.jpg",
            "tablet": "https://cdn.example.com/images/offer_tablet.jpg"
        },
        "offer_text": "Get 20% off on your first purchase!"
    }', 
'', N'{"product":"PL"}', 1),


-- 3rd Record
('Forex Offer', 'Offer Description', 'NBA', '2025-09-01', '2026-12-31', 3, 10, 3, 'Static', 
    N'{
        "redirection_URL": "https://www.example.com/offers/123",
        "image_URL": {
            "mobile": "https://cdn.example.com/images/offer_mobile.jpg",
            "desktop": "https://cdn.example.com/images/offer_desktop.jpg",
            "tablet": "https://cdn.example.com/images/offer_tablet.jpg"
        },
        "offer_text": "Get 20% off on your first purchase!"
    }', 
'', N'{"product":"Forex"}', 1),


-- 4th Record
('Credit Card Upgrade Offer', 'Offer Description', 'NBA', '2025-09-01', '2026-12-31', 4, 10, 3, 'Static', 
    N'{
        "redirection_URL": "https://www.example.com/offers/123",
        "image_URL": {
            "mobile": "https://cdn.example.com/images/offer_mobile.jpg",
            "desktop": "https://cdn.example.com/images/offer_desktop.jpg",
            "tablet": "https://cdn.example.com/images/offer_tablet.jpg"
        },
        "offer_text": "Get 20% off on your first purchase!"
    }', 
'', N'{"product":"CC"}', 1),


-- 5th Record
('Gold Loan Offer', 'Offer Description', 'NBA', '2025-09-01', '2026-12-31', 5, 10, 3, 'Static', 
    N'{
        "redirection_URL": "https://www.example.com/offers/123",
        "image_URL": {
            "mobile": "https://cdn.example.com/images/offer_mobile.jpg",
            "desktop": "https://cdn.example.com/images/offer_desktop.jpg",
            "tablet": "https://cdn.example.com/images/offer_tablet.jpg"
        },
        "offer_text": "Get 20% off on your first purchase!"
    }', 
'', N'{"product":"GL"}', 1),


-- 6th Record
('Scan & Pay Offer', 'Offer Description', 'NBA', '2025-09-01', '2026-12-31', 6, 10, 3, 'Static', 
    N'{
        "redirection_URL": "https://www.example.com/offers/123",
        "image_URL": {
            "mobile": "https://cdn.example.com/images/offer_mobile.jpg",
            "desktop": "https://cdn.example.com/images/offer_desktop.jpg",
            "tablet": "https://cdn.example.com/images/offer_tablet.jpg"
        },
        "offer_text": "Get 20% off on your first purchase!"
    }', 
'', N'{"product":"SP"}', 1),


-- 7th Record
('Real Time MF Investment', 'Offer Description', 'NBA', '2025-09-01', '2026-12-31', 7, 10, 3, 'Static', 
    N'{
        "redirection_URL": "https://www.example.com/offers/123",
        "image_URL": {
            "mobile": "https://cdn.example.com/images/offer_mobile.jpg",
            "desktop": "https://cdn.example.com/images/offer_desktop.jpg",
            "tablet": "https://cdn.example.com/images/offer_tablet.jpg"
        },
        "offer_text": "Get 20% off on your first purchase!"
    }', 
'', N'{"product":"MF"}', 1),


-- 8th Record
('Pay to Contact Offer', 'Offer Description', 'NBA', '2025-09-01', '2026-12-31', 8, 10, 3, 'Static', 
    N'{
        "redirection_URL": "https://www.example.com/offers/123",
        "image_URL": {
            "mobile": "https://cdn.example.com/images/offer_mobile.jpg",
            "desktop": "https://cdn.example.com/images/offer_desktop.jpg",
            "tablet": "https://cdn.example.com/images/offer_tablet.jpg"
        },
        "offer_text": "Get 20% off on your first purchase!"
    }', 
'', N'{"product":"PC"}', 1),


-- 9th Record
('Mutual Fund Offer', 'Offer Description', 'NBA', '2025-09-01', '2026-12-31', 9, 10, 3, 'Static', 
    N'{
        "redirection_URL": "https://www.example.com/offers/123",
        "image_URL": {
            "mobile": "https://cdn.example.com/images/offer_mobile.jpg",
            "desktop": "https://cdn.example.com/images/offer_desktop.jpg",
            "tablet": "https://cdn.example.com/images/offer_tablet.jpg"
        },
        "offer_text": "Get 20% off on your first purchase!"
    }', 
'', N'{"product":"MF"}', 1),


-- 10th Record
('iWish Offer', 'Offer Description', 'NBA', '2025-09-01', '2026-12-31', 10, 10, 3, 'Static', 
    N'{
        "redirection_URL": "https://www.example.com/offers/123",
        "image_URL": {
            "mobile": "https://cdn.example.com/images/offer_mobile.jpg",
            "desktop": "https://cdn.example.com/images/offer_desktop.jpg",
            "tablet": "https://cdn.example.com/images/offer_tablet.jpg"
        },
        "offer_text": "Get 20% off on your first purchase!"
    }', 
'', N'{"product":"iWish"}', 1),


-- 11th Record
('Two Wheeler Loan Offer', 'Offer Description', 'NBA', '2025-09-01', '2026-12-31', 11, 10, 3, 'Static', 
    N'{
        "redirection_URL": "https://www.example.com/offers/123",
        "image_URL": {
            "mobile": "https://cdn.example.com/images/offer_mobile.jpg",
            "desktop": "https://cdn.example.com/images/offer_desktop.jpg",
            "tablet": "https://cdn.example.com/images/offer_tablet.jpg"
        },
        "offer_text": "Get 20% off on your first purchase!"
    }', 
'', N'{"product":"TWL"}', 1),


-- 12th Record
('Fastag Offer', 'Offer Description', 'NBA', '2025-09-01', '2026-12-31', 12, 10, 3, 'Static', 
    N'{
        "redirection_URL": "https://www.example.com/offers/123",
        "image_URL": {
            "mobile": "https://cdn.example.com/images/offer_mobile.jpg",
            "desktop": "https://cdn.example.com/images/offer_desktop.jpg",
            "tablet": "https://cdn.example.com/images/offer_tablet.jpg"
        },
        "offer_text": "Get 20% off on your first purchase!"
    }', 
'', N'{"product":"Fastag"}', 1),


-- 13th Record
('Education Loan Offer', 'Offer Description', 'NBA', '2025-09-01', '2026-12-31', 13, 10, 3, 'Static', 
    N'{
        "redirection_URL": "https://www.example.com/offers/123",
        "image_URL": {
            "mobile": "https://cdn.example.com/images/offer_mobile.jpg",
            "desktop": "https://cdn.example.com/images/offer_desktop.jpg",
            "tablet": "https://cdn.example.com/images/offer_tablet.jpg"
        },
        "offer_text": "Get 20% off on your first purchase!"
    }', 
'', N'{"product":"EL"}', 1),


-- 14th Record
('Electricity Billpay Offer', 'Offer Description', 'NBA', '2025-09-01', '2026-12-31', 14, 10, 3, 'Static', 
    N'{
        "redirection_URL": "https://www.example.com/offers/123",
        "image_URL": {
            "mobile": "https://cdn.example.com/images/offer_mobile.jpg",
            "desktop": "https://cdn.example.com/images/offer_desktop.jpg",
            "tablet": "https://cdn.example.com/images/offer_tablet.jpg"
        },
        "offer_text": "Get 20% off on your first purchase!"
    }', 
'', N'{"product":"BBPS"}', 1),


-- 15th Record
('Credit Card Limit Increase Offer', 'Offer Description', 'NBA', '2025-09-01', '2026-12-31', 15, 10, 3, 'Static', 
    N'{
        "redirection_URL": "https://www.example.com/offers/123",
        "image_URL": {
            "mobile": "https://cdn.example.com/images/offer_mobile.jpg",
            "desktop": "https://cdn.example.com/images/offer_desktop.jpg",
            "tablet": "https://cdn.example.com/images/offer_tablet.jpg"
        },
        "offer_text": "Get 20% off on your first purchase!"
    }', 
'', N'{"product":"CLI"}', 1),


-- 16th Record
('Consumer EMI Offer', 'Offer Description', 'NBA', '2025-09-01', '2026-12-31', 16, 10, 3, 'Static', 
    N'{
        "redirection_URL": "https://www.example.com/offers/123",
        "image_URL": {
            "mobile": "https://cdn.example.com/images/offer_mobile.jpg",
            "desktop": "https://cdn.example.com/images/offer_desktop.jpg",
            "tablet": "https://cdn.example.com/images/offer_tablet.jpg"
        },
        "offer_text": "Get 20% off on your first purchase!"
    }', 
'', N'{"product":"EMI"}', 1),


-- 17th Record
('BBPS Electricity Offer', 'Offer Description', 'NBA', '2025-09-01', '2026-12-31', 17, 10, 3, 'Static', 
    N'{
        "redirection_URL": "https://www.example.com/offers/123",
        "image_URL": {
            "mobile": "https://cdn.example.com/images/offer_mobile.jpg",
            "desktop": "https://cdn.example.com/images/offer_desktop.jpg",
            "tablet": "https://cdn.example.com/images/offer_tablet.jpg"
        },
        "offer_text": "Get 20% off on your first purchase!"
    }', 
'', N'{"product":"BBPS"}', 1),


-- 18th Record
('Debit Card Upgrade Offer', 'Offer Description', 'NBA', '2025-09-01', '2026-12-31', 18, 10, 3, 'Static', 
    N'{
        "redirection_URL": "https://www.example.com/offers/123",
        "image_URL": {
            "mobile": "https://cdn.example.com/images/offer_mobile.jpg",
            "desktop": "https://cdn.example.com/images/offer_desktop.jpg",
            "tablet": "https://cdn.example.com/images/offer_tablet.jpg"
        },
        "offer_text": "Get 20% off on your first purchase!"
    }', 
'', N'{"product":"DCU"}', 1),


-- 19th Record
('Auto Loan Default Offer', 'Offer Description', 'Default', '2025-09-01', '2026-12-31', 19, 10, 3, 'Static', 
    N'{
        "redirection_URL": "https://www.example.com/offers/123",
        "image_URL": {
            "mobile": "https://cdn.example.com/images/offer_mobile.jpg",
            "desktop": "https://cdn.example.com/images/offer_desktop.jpg",
            "tablet": "https://cdn.example.com/images/offer_tablet.jpg"
        },
        "offer_text": "Get 20% off on your first purchase!"
    }', 
'', N'{"product":"AL"}', 1),


-- 20th Record
('Demat Default Offer', 'Offer Description', 'Default', '2025-09-01', '2026-12-31', 20, 10, 3, 'Static', 
    N'{
        "redirection_URL": "https://www.example.com/offers/123",
        "image_URL": {
            "mobile": "https://cdn.example.com/images/offer_mobile.jpg",
            "desktop": "https://cdn.example.com/images/offer_desktop.jpg",
            "tablet": "https://cdn.example.com/images/offer_tablet.jpg"
        },
        "offer_text": "Get 20% off on your first purchase!"
    }', 
'', N'{"product":"Demat"}', 1)


 SELECT * FROM Offers

-- DROP TABLE Offers

UPDATE Offers
SET Offer_View_Threshold = NULL,
    Offer_Click_Threshold = NULL
WHERE Offer_Type = 'Default';


SELECT ISJSON(Offer_Content) 
FROM Offers 
WHERE Offer_ID = 2;


UPDATE Offers SET Offer_Content = N'{ "redirection_URL": "https://www.chittaranjansaha.com", "image_URL": { "mobile": "https://raw.githubusercontent.com/git-chittaranjan/offers-implementation-api/main/Frontend/Contents/Desktop/Personal_Loan_Asset_Offer.gif", "desktop": "https://raw.githubusercontent.com/git-chittaranjan/offers-implementation-api/main/Frontend/Contents/Desktop/Personal_Loan_Asset_Offer.gif", "tablet": "https://raw.githubusercontent.com/git-chittaranjan/offers-implementation-api/main/Frontend/Contents/Desktop/Personal_Loan_Asset_Offer.gif" }, "offer_text": "Personal Loan Asset Offer" }' WHERE Offer_ID = 2;

 --------------------------------------------- Customers Table ---------------------------------------------

 CREATE TABLE Customers
 (
	Cust_ID INT IDENTITY,
	Cust_Fed_ID VARCHAR(100) PRIMARY KEY,
	Cust_Name VARCHAR(100),
	Cust_Data NVARCHAR(MAX),
	Cust_Entry_Date DATETIME NOT NULL DEFAULT GETDATE(),
	Cust_Is_Active BIT NOT NULL DEFAULT 1,
 )


INSERT INTO Customers (Cust_Fed_ID, Cust_Name, Cust_Data)
VALUES 
('4839201746', 'Rahul Sharma', N'{"age": 32, "city": "Mumbai", "gender": "Male"}'),
('9283746150', 'Ananya Gupta', N'{"age": 28, "city": "Delhi", "gender": "Female"}'),
('7152903846', 'Vikram Singh', N'{"age": 40, "city": "Bengaluru", "gender": "Male"}'),
('6049382751', 'Priya Nair', N'{"age": 35, "city": "Chennai", "gender": "Female"}'),
('8391046275', 'Arjun Mehta', N'{"age": 30, "city": "Kolkata", "gender": "Male"}');


SELECT * FROM Customers

-- DROP TABLE Customers


 --------------------------------------------- CustomerOffers Table ---------------------------------------------

CREATE TABLE CustomerOffers (
    Cust_Fed_ID VARCHAR(100) NOT NULL,
    Offer_ID INT NOT NULL,
    Assigned_Date DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (Cust_Fed_ID, Offer_ID),
    FOREIGN KEY (Cust_Fed_ID) REFERENCES Customers(Cust_Fed_ID),
    FOREIGN KEY (Offer_ID) REFERENCES Offers(Offer_ID)
);


INSERT INTO CustomerOffers (Cust_Fed_ID, Offer_ID, Assigned_Date) 
VALUES 
('4839201746', 1, '2025-08-01'),
('9283746150', 2, '2025-08-03'),
('6049382751', 4, '2025-08-04'),
('4839201746', 5, '2025-08-05'),
('4839201746', 4, '2025-08-06'),
('7152903846', 2, '2025-08-07'),
('7152903846', 5, '2025-08-08'),
('6049382751', 2, '2025-08-10'),
('7152903846', 1, '2025-08-11'),
('4839201746', 3, '2025-08-12'),
('8391046275', 2, '2025-08-13'),
('9283746150', 4, '2025-08-14'),
('8391046275', 5, '2025-08-15'),
('6049382751', 1, '2025-08-16'),
('8391046275', 4, '2025-08-17'),
('6049382751', 3, '2025-08-18'),
('7152903846', 3, '2025-08-19'),
('7152903846', 4, '2025-08-20');


SELECT * FROM CustomerOffers

SELECT c.Cust_Fed_ID, c.Offer_ID, o.Offer_Name 
FROM CustomerOffers c
INNER JOIN Offers o
ON c.Offer_ID = o.Offer_ID
WHERE Cust_Fed_ID = '4839201746'

-- DROP TABLE CustomerOffers


--------------------------------------------- PlaceholderOffers Table ---------------------------------------------

CREATE TABLE PlaceholderOffers (
    Offer_ID INT NOT NULL,
    Placeholder_ID INT NOT NULL,
    PRIMARY KEY (Offer_ID, Placeholder_ID),
    FOREIGN KEY (Offer_ID) REFERENCES Offers(Offer_ID),
    FOREIGN KEY (Placeholder_ID) REFERENCES Placeholders(Placeholder_ID)
);


INSERT INTO PlaceholderOffers (Offer_ID, Placeholder_ID) 
VALUES 
(1, 1),
(1, 2),
(2, 2),
(2, 3),
(3, 4),
(3, 5),
(4, 2),
(4, 1),
(5, 3),
(5, 2);

SELECT * FROM PlaceholderOffers

SELECT po.Placeholder_ID, p.Placeholder_Name, po.Offer_ID, o.Offer_Name
FROM PlaceholderOffers po
INNER JOIN Placeholders p
ON po.Placeholder_ID = p.Placeholder_ID
INNER JOIN Offers o
ON po.Offer_ID = o.Offer_ID
WHERE po.Placeholder_ID = 1


-- DROP TABLE PlaceholderOffers




