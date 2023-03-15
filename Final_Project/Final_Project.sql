USE master;
GO

DROP DATABASE IF EXISTS Final_Project;
CREATE DATABASE Final_Project;
USE Final_Project;

-- Employer Table
DROP TABLE IF EXISTS Employer;
CREATE TABLE Employer 
(EmployerID   TINYINT NOT NULL IDENTITY(1,1),
CompanyName   VARCHAR(25) NOT NULL,
TaxID         VARCHAR(20) NOT NULL,
StreetAddress VARCHAR(35) NOT NULL,
City          VARCHAR(25) NOT NULL,
State         CHAR(2) NOT NULL,
ZipCode       VARCHAR(10) NOT NULL,
CONSTRAINT PK_Employer_EmployerID PRIMARY KEY (EmployerID)
);

INSERT INTO Employer (CompanyName, TaxID, StreetAddress, City, State, ZipCode)
VALUES ('Mega', '05-89390', '700 Osuna Rd NE', 'Albuquerque', 'NM', 84113),
		   ('Imerys', '28-09704', '100 Mansell Court E Suite 300', 'Roswell', 'GA', 30076),
		   ('BestDeal', '48-09203', '1232 Blanding Blvd Ste 5', 'Orange Park', 'FL', 32065),
		   ('Brooks', '24-95830', '3400 Stone Way N #500', 'Seattle', 'WA', 98103)
       
-- SELECT * FROM Employer;

-- EmployeeType Table
DROP TABLE IF EXISTS EmployeeType;
CREATE TABLE EmployeeType
(EmployeeTypeID         TINYINT NOT NULL IDENTITY(1,1),
EmployeeTypeDescription VARCHAR(25) NOT NULL,
CONSTRAINT PK_EmployeeType_EmployeeTypeID PRIMARY KEY (EmployeeTypeID)
);

INSERT INTO EmployeeType (EmployeeTypeDescription)
VALUES ('Fulltime'), ('Parttime'), ('Intern')

-- SELECT * FROM EmployeeType

-- Employees Table
DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees
(EmployeeID		  	INT NOT NULL IDENTITY(1,1),
EmployerID		  	TINYINT NOT NULL,
EmployeeTypeID  	TINYINT NOT NULL,
FirstName			    VARCHAR(25) NOT NULL,
MiddleName		  	VARCHAR(25) DEFAULT NULL,
LastName			    VARCHAR(25) NOT NULL,
StreetAddress	  	VARCHAR(35) NOT NULL,
City				      VARCHAR(25) NOT NULL,
State				      CHAR(2) NOT NULL,
ZipCode			    	VARCHAR(10) NOT NULL,
SSN					      CHAR(9) NOT NULL,
DOB					      DATE NOT NULL,
HireDate		    	DATE NOT NULL,
TerminationDate		DATE DEFAULT NULL,
TerminationReason	VARCHAR(100) DEFAULT NULL,
Salary				    DECIMAL(8,2) NOT NULL
CONSTRAINT PK_Employees_EmployeeID PRIMARY KEY (EmployeeID),
CONSTRAINT FK_Employees_EmployerID FOREIGN KEY (EmployerID) REFERENCES Employer (EmployerID),
CONSTRAINT FK_Employees_EmployeeTypeID FOREIGN KEY (EmployeeTypeID) REFERENCES EmployeeType (EmployeeTypeID)
);

INSERT INTO Employees (EmployerID, EmployeeTypeID, FirstName, MiddleName, LastName, StreetAddress, City, State, ZipCode, SSN, DOB, HireDate, TerminationDate, TerminationReason, Salary)
VALUES  (1, 1, 'Ann', 'A', 'Lopez', '20414 Laverton Dr', 'Katy', 'TX', 37449, '999237449', '1949-01-29', '2005-03-21', NULL, NULL, 136973.99),
		(1, 1, 'Clara',	'C', 'Bush', '1701 Shelby Drive', 'LA VISTA', 'NE',	37462, '999237462', '1963-03-29', '2007-11-26', NULL, NULL, 136762.73),
		(1, 1, 'Dave', 'D', 'Tven', '313 N CENTER', 'Wytheville', 'VA', 37470, '999237470', '1971-07-26', '2004-12-13', NULL, NULL,	143272.68),
		(1, 1, 'Peggy',	'P', 'Christakis', '3821 S. Lowe', 'Zumbrota', 'VA', 37497,	'999237497', '1954-10-27', '2006-11-21', '2015-01-01', 'overage_child',	194597.11),
		(1, 1, 'Jim', NULL,	'Ali', '6265 RIVERSHORE PARKWAY', 'Harvest', 'AL', 37481, '999237481', '1971-07-18', '2006-01-24', NULL, NULL, 91697.20),
		(1, 1, 'Roma', 'R',	'Whee',	'315 MAGNOLIA DR', 'Zurich', 'AL', 37518, '999237518', '1973-07-17', '2005-10-24', NULL, NULL, 34028.22),
		(2, 1, 'David', NULL, 'Wolfer',	'119 MAGNOLIA STREET APT 1', 'Zephyr', 'TX', 37533,	'999237533', '1971-04-12', '1993-01-04', '2014-10-15', 'employment_terminatic', 93925.01),
		(2, 1, 'Jerry',	'J', 'Cicic', '1049 Wood Duck Ave',	'Zephyr', 'TX',	37535, '999237535', '1945-04-25', '2005-05-16', NULL, NULL, 191497.36),
		(2, 1,	'Barbara', 'B',	'Kosling', '4811 N Lamb Dr', 'Zephyr', 'TX', 37555,	'999237555', '1943-11-01', '2010-01-14', NULL, NULL,	42749.34),
		(2, 1, 'Robin', 'R', 'McClemmy', '1126 Moccasin Dr.', 'Zephyr',	'TX', 37558, '999237558', '1968-01-06', '2004-07-19', NULL, NULL, 192292.59),
		(2, 2, 'Kayla', 'K', 'Sakauye', '7 Cinder Hill Road', 'Zephyr', 'TX', 37537, '999237537', '1988-09-05', '2006-09-18', NULL, NULL, 39322.82),
		(2, 1, 'David',	'D', 'Viccaro',	'7299 S. Sundown Circle', 'Zurich',	'AL', 37539, '999237539', '1986-08-12', '2007-08-24', NULL, NULL,	83915.08),
		(2, 2, 'Tammy',	'T', 'Felonk', '9565 Elk Mountain Cir',	'Zephyr', 'TX',	37540, '999237540',	'1963-02-07', '2001-08-24', NULL, NULL, 119937.19),
		(2, 3, 'Barbara', 'B', 'Tyreman', '10 FITZRANDOLPH RD',	'Zephyr', 'VA',	37541, '999237541',	'1971-04-10', '2003-08-25', NULL, NULL, 188499.18),
		(2, 1,	'Tonya', 'T', 'Thomas',	'233 Via Villena', 'Wytheville', 'VA', 37542, '999237542', '1981-02-10', '2002-09-04', NULL, NULL, 116574.73),
		(2, 2, 'Janie', 'J',	'McGowens',	'14807 BLUES CREEK ROAD', 'Zumbrota', 'VA',	37543, '999237543', '1959-02-02', '2005-09-01', NULL, NULL, 35400.26),
		(2, 1, 'Sara', 'Ellen',	'Stroemer',	'6135 Hegerman Street',	'Zephyr', 'TX',	37544, '999237544',	'1985-03-10', '2007-08-21', NULL, NULL, 140630.11),
		(2, 2, 'Mary', 'Jane', 'Sanjeevi', '4680 Old Pond Drive', 'Yorkville', 'VA', 37547, '999237547', '1950-10-09', '1998-08-10', NULL, NULL, 130631.40),
		(2, 2, 'Mary', 'Ann', 'Cavitch', '11101 Reiger Rd #826', 'Point of Rocks', 'MD', 37548,	'999237548', '1970-05-02', '2005-08-15', NULL, NULL, 112827.21),
		(2, 2, 'Erin', 'E',	'Sawczuk', '3128 S Fernwood Ave', 'Wytheville',	'VA', 37551, '999237551', '1987-09-04', '2009-07-27', NULL, NULL, 194708.65),
		(2, 1, 'Mary', 'M',	'Slusarchuk', '1343 East BrickYard', 'Wyckoff',	'OH', 37552, '999237552', '1951-03-25', '2001-07-31', NULL, NULL,	29420.12),
		(2, 1, 'Kimberly', 'K',	'Davee', '20251 Elk Creek Dr W', 'Zephyr', 'TX', 37553,	'999237553', '1977-04-04', '2000-03-08', NULL, NULL, 97012.14),
		(3, 1, 'Doris', 'Dottle', 'Kasotia', '9235 S Wabash', 'New York', 'NY',	80917, '999680917',	'1974-08-24', '2009-11-06', NULL, NULL, 54787.80),
		(3, 2, 'Ruby', 'R',	'Searcy', '52353 TRIPOLI WAY', 'New York', 'NY', 48719,	'999448719', '1951-09-16', '2009-06-24', '2015-01-01', 'overage_child', 143138.03),
		(3, 1, 'Linda',	'L', 'Schepens', '10207 Green Tree Road', 'Zurich',	'AL', 37592, '999237592', '1952-07-23', '2007-04-23', NULL, NULL, 57012.66),
		(3, 2, 'Faye',	'F', 'Antil', '3201 Ashland', 'Zephyr', 'TX', 37620, '999237620', '1953-03-07', '1977-05-03', NULL, NULL, 70900.62),
		(3, 1, 'Keith',	'K', 'Tharachai', '3948 Lorien Way NW',	'Wyckoff', 'CO', 37621,	'999237621', '1959-03-19', '1973-06-06', NULL, NULL, 143057.45),
		(3, 1, 'Richard', 'R', 'Hefestay', '1765 DYER DR.',	'Melvindale', 'MI', 37622, '999237622',	'1946-10-21', '1998-02-09', NULL, NULL, 117223.21),
		(3, 2, 'Patricia', 'P',	'Ritzheimer', '652 COLLEEN DR', 'Youngstown', 'NY',	37626, '999237626',	'1955-01-03', '1980-11-25', NULL, NULL, 37893.96),
		(3, 1, 'Nancy',	'N', 'Deldeo', '105 Silvercreek Drive',	'Youngstown', 'NY',	37629, '999237629', '1945-04-08', '1988-11-07', NULL, NULL, 113456.99),
		(3, 2, 'Roger',	'R', 'Oung', '8422 AMANDA PLACE', 'New York', 'NY',	37632, '999237632',	'1960-11-03', '1995-10-05', NULL, NULL, 102695.90),
		(3, 1, 'Melissa', 'M', 'Bracher', '2514 S BRISTOL',	'New York',	'NY', 39408, '999239408', '1976-10-17', '2000-10-25', NULL, NULL, 62230.44),
		(3, 1, 'Dora', 'D',	'Knibloe', '3015 N 1800 Ave', 'New York', 'NY', 39410, '999239410',	'1962-10-31', '2007-04-03', NULL, NULL, 136109.68),
		(3, 1, 'Gloria', 'G', 'Rauens',	'887 PLANK RD',	'Youngstown', 'NY',	50291, '999250291',	'1964-03-13', '1993-04-22', NULL, NULL, 121432.87),
		(3, 1, 'Lynn', 'L',	'Alouf', '6431 Pirtlewood Circle', 'Youngstown', 'NY', 50292, '999250292', '1954-08-31', '1979-08-27', NULL, NULL, 194176.61),
		(3, 2, 'Angela', NULL, 'Nagavel', '12219 Greenleaf Ave', 'Wyckoff',	'NJ', 50293, '999250293', '1969-10-20', '2003-08-26', NULL, NULL, 113964.23),
		(3, 1, 'Monique', 'M', 'Muuka',	'809 RT. 105', 'Youngstown', 'NY',	50295, '999250295',	'1968-08-11', '1998-01-24', NULL, NULL, 91625.11),
		(3, 1, 'Karlita', 'K', 'Sperstad', '3914 Brookdale Ave', 'New York', 'NY', 50298, '999250298', '1974-01-05', '2001-07-30', NULL, NULL,	123859.50),
		(3, 2, 'Rosalyn', 'R',	'Beauclair', '152 S MAIN ST', 'New York', 'NY',	74741, '999374741',	'1975-09-09', '2009-04-29', NULL, NULL, 165088.59),
		(3, 2, 'Maggie', NULL, 'Iwach',	'20535 Barlow', 'Youngstown', 'NY',	94036, '999394036',	'1950-07-02', '2009-04-29', NULL, NULL, 32176.30),
		(3, 1, 'Tina', 'T',	'Grisbee', '19585 Black Road', 'New York', 'NY', 48146,	'999448146', '1982-02-23', '2009-06-23', NULL, NULL, 107620.30),
		(4, 1, 'Connie', 'C', 'Alberg', '4955 W 7th St', 'New York', 'NY', 48908, '191489085', '1959-01-27', '2010-06-01', '2015-02-03', 'retirement',	180169.90),
		(4, 2, 'Chanthanard', 'C', 'Sjurset', '83 Glann Rd', 'New York', 'NY', 23914, '191239146', '1988-12-02', '2010-04-05', NULL, NULL, 128282.37),
		(4, 1, 'Ashley', 'A', 'Ticatch', '1905 Wayne Dr', 'New York', 'NY',	46461, '191464614', '1988-04-22', '2009-08-20', NULL, NULL, 56684.61),
		(3, 1, 'Doris',	'Dottie', 'Kasotia', '9235 S Wabash', 'New York', 'NY',	80917, '999680917', '1974-08-24', '2009-11-06', NULL, NULL, 54787.80),
		(3, 1, 'Ronald', NULL, 'Leoncavallo', '810 Eagle Hills Way', 'New York', 'NY', 72656, '999672656', '1963-02-04', '2009-11-16', NULL, NULL, 71487.66)

-- SELECT * FROM Employees;

-- PhoneType Table
DROP TABLE IF EXISTS PhoneType;
CREATE TABLE PhoneType
(PhoneTypeID         SMALLINT NOT NULL IDENTITY(1,1),
PhoneTypeDescription VARCHAR(10) NOT NULL,
CONSTRAINT PK_PhoneType_PhoneTypeID PRIMARY KEY (PhoneTypeID)
);

INSERT INTO PhoneType (PhoneTypeDescription)
VALUES ('Mobile'), ('Home'), ('Work')

-- SELECT * FROM PhoneType

-- PhoneNumber Table
DROP TABLE IF EXISTS PhoneNumber;
CREATE TABLE PhoneNumber
(Phonenumber		VARCHAR(20) NOT NULL,
EmployeeID			INT NOT NULL,
PhoneTypeID			SMALLINT NOT NULL,
CONSTRAINT PK_PhoneNumber_Phonenumber PRIMARY KEY (Phonenumber),
CONSTRAINT FK_PhoneNumber_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID),
CONSTRAINT FK_PhoneNumber_PhoneTypeID FOREIGN KEY (PhoneTypeID) REFERENCES PhoneType (PhoneTypeID)
);

INSERT INTO PhoneNumber (Phonenumber, EmployeeID, PhoneTypeID)
VALUES  ('777237449', 1, 3),
	 	('777237452', 2, 3),
		('777237456', 3, 3),
		('777237460', 4, 3),
		('777237462', 5, 3),
		('777237466', 6, 3),
		('777237469', 7, 3),
		('777237470', 8, 3),
		('777237473', 9, 3),
		('777237474', 10, 3),
		('777237476', 11, 3),
		('777237477', 12, 3),
		('777237479', 13, 3),
		('777237480', 14, 3),
		('777237481', 15, 3),
		('777237483', 16, 3),
		('777237484', 17, 3),
		('777237485', 18, 3),
		('777237486', 19, 3),
		('777237487', 20, 3),
		('777237489', 21, 3),
		('777237495', 22, 3),
		('777237496', 23, 3),
		('777237497', 24, 3),
		('777237498', 25, 3),
		('777237499', 26, 3),
		('777237500', 27, 3),
		('777237502', 28, 3),
		('777237506', 29, 3),
		('777237510', 30, 3),
		('777237511', 31, 3),
		('777237512', 32, 3),
		('777237516', 33, 3),
		('777237517', 34, 3),
		('777237518', 35, 3),
		('777237519', 36, 3),
		('777237528', 37, 3),
		('777237531', 38, 3),
		('777237532', 39, 3),
		('777237533', 40, 3),
		('777237534', 41, 3),
		('777237535', 42, 3),
		('777237537', 43, 3),
		('777237539', 44, 3),
		('5146839851', 1, 2),
		('5569088416', 3, 1),
		('7056418784', 5, 1),
		('7132534030', 7, 1),
		('7372701791', 9, 2),
		('5048438442', 10, 2),
		('7049122824', 12,	1),
		('5196221398',	14,	2),
		('6738406069',	16,	1),
		('2837106714',	18,	1),
		('5845515507',	20,	2),
		('6405877315',	21,	2),
		('9356334889',	23,	1),
		('4556264619',	25,	2),
		('8106725182',	27,	2),
		('8508004423',	29,	2),
		('3315914772',	30,	2),
		('2783975410',	32,	2),
		('2439613864',	34,	1),
		('5809084779',	36,	1),
		('4026553430',	38,	1),
		('4975623331',  40,	1),
		('6717549448',	41,	1),
		('4804093861',	43,	1)
    
-- SELECT * FROM PhoneNumber;

-- Security Table
DROP TABLE IF EXISTS Security;
CREATE TABLE Security
(EmployeeID			INT NOT NULL,
CompLogin			  VARCHAR(25) NOT NULL,
CompPassword		VARCHAR(20) NOT NULL,
SecurityType		VARCHAR(9) NOT NULL,
CONSTRAINT PK_Security_EmployeeID PRIMARY KEY (EmployeeID),
CONSTRAINT FK_Security_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);

INSERT INTO Security (EmployeeID, CompLogin, CompPassword, SecurityType)
VALUES  (1,	'5960759247',	'Tn4h2mMx',	'MFA'),
		(2,	'6678768192',	'fDUPFfc5',	'MFA'),
		(3,	'1757929719',	'mhJG8Bv7', 'MFA'),
		(4,	'640932743',	'3CjaxuCL',	'MFA'),
		(5,	'6973587584',	'nAkDMY7e',	'MFA'),
		(6,	'9164237739',	'LJa8XC85', 'MFA'),
		(7,	'6652284706',	'mzp4gPsA',	'MFA'),
		(8,	'4174685759',	'uXEu8XHM',	'MFA'),
		(9,	'1986942644',	'JPZQVW3a',	'MFA'),
		(10, '3863652442',	'7CPAkVTz',	'MFA'),
		(11,	'9042202172',	'x4xb3Y9e',	'MFA'),
		(12,	'1799618290',	'eqAusVRS',	'MFA'),
		(13,	'1271408603',	'XNXLCueX',	'MFA'),
		(14,	'6519761311',	'xQb79mTA',	'MFA'),
		(15,	'1678165452',	'bqRKL2nL',	'MFA'),
		(16,	'6418456145',	'nW7Myx63',	'MFA'),
		(17,	'1043243070',	'PLLa9TqJ',	'HardToken'),
		(18,	'6597670169',	'FvCWgLpf',	'HardToken'),
		(19,	'6629637154',	'bQCypPQE',	'HardToken'),
		(20,	'874776212',	'q2ppeYu4',	'HardToken'),
		(21,	'3896567824',	'9KsqDtka',	'HardToken'),
		(22,	'6661014792',	'RyV9UfC7',	'HardToken'),
		(23,	'8356256044',	'btPxC3fj',	'HardToken'),
		(24,	'3022557366',	'jRx5jgKp',	'HardToken'),
		(25,	'1234321977',	'3hses4s7',	'HardToken'),
		(26,	'1432551856',	'LmXC6mfU',	'HardToken'),
		(27,	'8418041179',	'umUzX9Tx',	'HardToken'),
		(28,	'8572719023',	'de5q7dyv',	'HardToken'),
		(29,	'5204439036',	'QG9SZbvq',	'HardToken'),
		(30,	'5837000747',	'aeLXsvDe',	'HardToken'),
		(31,	'8462489910',	'5VTnspGN',	'HardToken'),
		(32,	'4837585151',	'stveZ69V',	'SoftToken'),
		(33,	'1169159589',	'jLrTZfBm',	'SoftToken'),
		(34,	'8771663599',	'jbC2gaLC',	'SoftToken'),
		(35,	'8153255124',	'7Updm2bQ',	'SoftToken'),
		(36,	'7199567432',	'MTxgunT9',	'SoftToken'),
		(37,	'4326608800',	'fTrVwX34',	'SoftToken'),
		(38,	'9571614443',	'dHj5gAqB',	'SoftToken'),
		(39,	'1114279130',	'kbDPgtkY',	'SoftToken'),
		(40,	'4111940971',	'8VfGWVeT',	'SoftToken'),
		(41,	'3028158121',	'R9b9HxWb',	'SoftToken'),
		(42,	'543916124',	'yJjVpDRP',	'SoftToken'),
		(43,	'8091077756',	'akzD8jYc',	'SoftToken'),
		(44,	'1972719231',	'kaThQZ3n',	'SoftToken'),
		(45,	'3416999928',	'nZMCJqNb',	'SoftToken'),
		(46,	'9006488241',	'nE9ungYp',	'SoftToken')

-- SELECT * FROM Security;

-- MFA Table
DROP TABLE IF EXISTS MFA;
CREATE TABLE MFA
(EmployeeID			INT NOT NULL,
PhoneNumber			VARCHAR(20) NOT NULL,
Email				    VARCHAR(100) NOT NULL,
CONSTRAINT PK_MFA_EmployeeID PRIMARY KEY (EmployeeID),
CONSTRAINT FK_MFA_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Security (EmployeeID)
);

INSERT INTO MFA (EmployeeID, PhoneNumber, Email)
VALUES  (1,	'777237449',	'alopez@mega.com'),
		(2,	'777237452',	'cbush@mega.com'),
		(3,	'777237456',	'dtven@mega.com'),
		(4,	'777237460',	'pchristakis@mega.com'),
		(5,	'777237462',	'jali@mega.com'),
		(6,	'777237466',	'rwhee@mega.com'),
		(7,	'777237469',	'dwolfer@imerys.com'),
		(8,	'777237470',	'jcicic@imerys.com'),
		(9,	'777237473',	'bkosling@imerys.com'),
		(10,	'777237474',	'rmcclemmy@imerys.com'),
		(11,	'777237476',	'ksakauye@imerys.com'),
		(12,	'777237477',	'dviccaro@imerys.com'),
		(13,	'777237479',	'tfelonk@imerys.com'),
		(14,	'777237480',	'btyreman@imerys.com'),
		(15,	'777237481',	'tthomas@imerys.com'),
		(16,	'777237483',	'jmcgowens@imerys.com')

-- SELECT * FROM MFA;

-- HardToken Table
DROP TABLE IF EXISTS HardToken;
CREATE TABLE HardToken
(EmployeeID			INT NOT NULL,
Manufacturer		VARCHAR(25) NOT NULL,
TokenID			  	VARCHAR(10) NOT NULL,
CONSTRAINT PK_HardToken_EmployeeID PRIMARY KEY (EmployeeID),
CONSTRAINT FK_HardToken_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Security (EmployeeID)
);

INSERT INTO HardToken (EmployeeID, Manufacturer, TokenID)
VALUES  (17,	'Cisco',	'7315929100'),
		(18,	'Cisco',	'4907893098'),
		(19,	'Cisco',	'5316144157'),
		(20,	'Cisco',	'3671433653'),
		(21,	'Cisco',	'6011108777'),
		(22,	'Nokia',	'5810822042'),
		(23,	'Nokia',	'6137824248'),
		(24,	'Nokia',	'217811148'),
		(25,	'Nokia',	'7154574298'),
		(26,	'Nokia',	'6332848201'),
		(27,	'Asus',	'760059500'),
		(28,	'Asus',	'4094054027'),
		(29,	'Asus',	'9264364637'),
		(30,	'Asus',	'5526610931'),
		(31,	'Asus',	'4669609255')

-- SELECT * FROM HardToken;

-- SoftToken Table
DROP TABLE IF EXISTS SoftToken;
CREATE TABLE SoftToken
(EmployeeID			INT NOT NULL,
Provider			  VARCHAR(25) NOT NULL,
WebServiceURL		VARCHAR(150) NOT NULL,
CONSTRAINT PK_SoftToken_EmployeeID PRIMARY KEY (EmployeeID),
CONSTRAINT FK_SoftToken_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Security (EmployeeID)
);

INSERT INTO SoftToken (EmployeeID, Provider, WebServiceURL)
VALUES  (32,	'Microsoft',	'www.microsoft.com/getID'),
		(33,	'Microsoft',	'www.microsoft.com/getID'),
		(34,	'Microsoft',	'www.microsoft.com/getID'),
		(35,	'Microsoft',	'www.microsoft.com/getID'),
		(36,	'Microsoft',	'www.microsoft.com/getID'),
		(37,	'Microsoft',	'www.microsoft.com/getID'),
		(38,	'Microsoft',	'www.microsoft.com/getID'),
		(39,	'Microsoft',	'www.microsoft.com/getID'),
		(40,	'AmazonCloud',	'www.amazoncloud.com/getID'),
		(41,	'AmazonCloud',	'www.amazoncloud.com/getID'),
		(42,	'AmazonCloud',	'www.amazoncloud.com/getID'),
		(43,	'AmazonCloud',	'www.amazoncloud.com/getID'),
		(44,	'AmazonCloud',	'www.amazoncloud.com/getID'),
		(45,	'AmazonCloud',	'www.amazoncloud.com/getID'),
		(46,	'AmazonCloud',	'www.amazoncloud.com/getID')

-- SELECT * FROM SoftToken;


-- Carrier Table
DROP TABLE IF EXISTS Carrier;
CREATE TABLE Carrier
(CarrierID			TINYINT NOT NULL IDENTITY(1,1),
CarrierName			VARCHAR(25) NOT NULL,
TaxID				    VARCHAR(20) NOT NULL,
PolicyID			  VARCHAR(20) NOT NULL,
StreetAddress		VARCHAR(35) NOT NULL,
City			    	VARCHAR(25) NOT NULL,
State				    CHAR(2) NOT NULL,
ZipCode			  	VARCHAR(10) NOT NULL,
CONSTRAINT PK_Carrier_CarrierID PRIMARY KEY (CarrierID)
);

INSERT INTO Carrier (CarrierName, TaxID, PolicyID, StreetAddress, City, State, ZipCode)
VALUES  ('Aetna', '57-73564', '9GGLE8YZ4W', '151 Farmington Avenue', 'Hartford', 'CT', 06156),
		('Anthem', '10-85525', 'JDBA1TZES9', '220 Virginia Avenue', 'Indianapolis', 'IN', 46204),
		('BCBS of TX', '34-32083', 'XWEGFTNBP6', '5225 S Loop 289 #207', 'San Antonio', 'TX', 79424),
		('Blue Cross Blue Shield', '79-78646', '2ZBY9NVT9U', '225 North Michigan Ave', 'Chicago', 'IL', 60601),
		('BlueAdvantage', '30-40825', '1LGHUXOAHQ', '5525 Reitz Ave', 'Baton Rouge', 'LA', 70809),
		('CIGNA', '38-42984', 'V4WZTBCNXA', '900 Cottage Grove Road', 'Bloomfield', 'CT', 06002),
		('Joy Standard', '09-78838', 'HB7K7M21GU', '568 Water Drive', 'Winona', 'MN', 55987),
		('Kaiser', '69-07356', 'LVR7K8D4QE', '1950 Franklin St', 'Oakland', 'CA', 94612),
		('Medicare', '33-80728', 'DV6LQKEOHV', 'PO Box 1270', 'Lawrence', 'KS', 66044),
		('Unum', '41-90850', 'INS1L01Q9X', '1 Fountain Square', 'Chattanooga', 'TN', 37402),
		('United Health Care', '73-79925', 'Z52SFTCG10', '9900 Bren Rd E', 'Minnetonka', 'MN', 55343),
		('UPMC', '48-83699', '9B0YAJHUG7', '200 Lothrop St', 'Pittsburgh', 'PA', 15213),
		('Delta Dental', '89-50659', 'JN1X9FAKEU', '500 S Washington Ave Suite 2060', 'Minneapolis', 'MN', 55415),
		('Humana', '26-14905', '5GA8WEC1VP', '5200 Southpoint Dr', 'Louisville', 'KY', 40229),
		('MetLife', '24-49806', 'HGLK9U6SX1', '200 Park Avenue', 'New York', 'NY', 10166),
		('EyeCare of Wisconsin', '59-37756', '7UVEY6DS5X', '35 Henry Ave', 'Detroit', 'MI', 48205),
		('Eyemed', '47-43134', '0ZRHMSPC85', '4000 Luxottica Place', 'Mason', 'OH', 45040),
		('Guardian', '66-97536', 'JIK4LGPVKS', '7 Hanover Sq', 'New York', 'NY', 10004),
		('Davis', '68-25271', 'KXCP7V7YCC', '711 Troy-Schenectady Rd', 'Latham', 'NY', 12110),
		('VSP', '06-71562', '0EDI0FTOJI', '3333 Quality Drive', 'Rancho Cordova', 'CA', 95670)

-- SELECT * FROM Carrier;

-- Benefits Table
DROP TABLE IF EXISTS Benefits;
CREATE TABLE Benefits
(BenefitsID			    SMALLINT NOT NULL IDENTITY(1,1),
BenefitDescription	VARCHAR(100),
CONSTRAINT PK_Benefits_BenefitsID PRIMARY KEY (BenefitsID)
);

INSERT INTO Benefits (BenefitDescription)
VALUES ('Medical'), ('Dental'), ('Vision'), ('LTD')

-- Plans Table
DROP TABLE IF EXISTS Plans;
CREATE TABLE Plans
(PlanID			     	SMALLINT NOT NULL IDENTITY(1,1),
CarrierID			    TINYINT DEFAULT NULL,
BenefitsID			  SMALLINT NOT NULL,
PlanDescription		VARCHAR(100),
CONSTRAINT PK_Plans_PlanID PRIMARY KEY (PlanID),
CONSTRAINT FK_Plans_CarrierID FOREIGN KEY (CarrierID) REFERENCES Carrier (CarrierID),
CONSTRAINT FK_Plans_BenefitsID FOREIGN KEY (BenefitsID) REFERENCES Benefits (BenefitsID)
);

INSERT INTO Plans (CarrierID, BenefitsID, PlanDescription)
VALUES  (1, 1, 'Aetna Choice POS II'),
		(1, 1, 'Aetna Choice POS II HDHP'),
		(1, 1, 'Aetna Global Benefits'),
		(1, 1, 'Aetna HMO'),
		(1, 1, 'Aetna HSA Plan (Low)'),
		(1, 1, 'Aetna Medicare HMO (NPA1)'),
		(1, 1, 'Aetna OOA HSA Plan (Low)'),
		(1, 1, 'Aetna OOA PPO Plan (High)'),
		(1, 1, 'Aetna Open Access Plan (High)'),
		(1, 1, 'Aetna QPOS Plan (Middle)'),
		(2, 1, 'Anthem Blue Cross High PPO'),
		(2, 1, 'Anthem Blue Cross Low PPO'),
		(3, 1, 'BCBS of TX $0 PPO - (R055)'),
		(3, 1, 'BCBS of TX $1000 Out of Area (R017)'),
		(3, 1, 'BCBS of TX $1000 PPO - (R020)'),
		(3, 1, 'BCBS of TX $2000 Out of Area - (R067)'),
		(3, 1, 'BCBS of TX $2000 PPO - (R068)'),
		(3, 1, 'BCBS of TX $300 Out of Area - (R072)'),
		(3, 1, 'BCBS of TX $300 PPO - (R057)'),
		(3, 1, 'BCBS of TX $300 Retiree Med Only - (073)'),
		(3, 1, 'BCBS of TX $300 Retiree Med/RX - (056)'),
		(3, 1, 'BCBS of TX $325 Out of Area'),
		(3, 1, 'BCBS of TX $325 PPO'),
		(3, 1, 'BCBS of TX $340 Out of Area'),
		(3, 1, 'BCBS of TX $340 PPO'),
		(3, 1, 'BCBS of TX EPPO - (R058)'),
		(3, 1, 'BCBS of TX Union - (R025)'),
		(3, 1, 'BCBS of TX Union - Medicare (R025)'),
		(4, 1, 'Blue Cross Blue Shield - HRA 80'),
		(4, 1, 'Blue Cross Blue Shield - HRA 90'),
		(4, 1, 'Blue Cross Blue Shield HCA (2 tier)'),
		(4, 1, 'Blue Cross Blue Shield HCA (4 tier)'),
		(4, 1, 'Blue Cross Blue Shield PPO 1'),
		(4, 1, 'Blue Cross Blue Shield PPO 2'),
		(5, 1, 'BlueAdvantage PPO'),
		(5, 1, 'BlueAdvantage PPO 2'),
		(5, 1, 'BlueAdvantage PPO 3'),
		(6, 1, 'CIGNA Choice Fund with HSA'),
		(6, 1, 'CIGNA CORE Option'),
		(6, 1, 'CIGNA International Plan'),
		(6, 1, 'CIGNA Open Access Plus (OAP) - CORE (Retiree Split Dependent)'),
		(6, 1, 'CIGNA Open Access Plus (OAP) - CORE (Retiree)'),
		(6, 1, 'CIGNA-CMB'),
		(6, 1, 'CIGNA-MCN'),
		(7, 1, 'Joy Standard Retiree Comp 0064'),
		(7, 1, 'Joy Standard Retiree Comp 0064 (UMR)'),
		(8, 1, 'Kaiser (Non-TALB) - Retiree, Spouse Both Under Age 65 (Non-Medicare)'),
		(8, 1, 'Kaiser (Non-TALB) - Under/Over (One Medicare Eligible)'),
		(8, 1, 'Kaiser (TALB) - Retiree, Spouse Both Age 65+ (Medicare)'),
		(8, 1, 'Kaiser (TALB) - Retiree, Spouse Both Under Age 65 (Non-Medicare)'),
		(8, 1, 'Kaiser (TALB) - Under/Over (One Medicare Eligible)'),
		(8, 1, 'Kaiser Medicare Supplement (Removed 2011)'),
		(8, 1, 'Kaiser Permanente'),
		(8, 1, 'Kaiser Permanente (Non-TALB)'),
		(8, 1, 'Kaiser Permanente (NRA)'),
		(8, 1, 'Kaiser Permanente (TALB)'),
		(9, 1, 'Medicare Supp Plan 0065'),
		(9, 1, 'Medicare Supp Plan 0065 (UMR)'),
		(9, 1, 'Medicare Supp Plan 0068'),
		(9, 1, 'Medicare Supp Plan 0068 (UMR)'),
		(9, 1, 'Medicare Supp Plan 0069'),
		(9, 1, 'Medicare Supp Plan 0069 (UMR)'),
		(9, 1, 'Medicare Supp Plan 0070'),
		(9, 1, 'Medicare Supp Plan 0070 (UMR)'),
		(9, 1, 'Medicare Supp Plan 0071'),
		(9, 1, 'Medicare Supp Plan 0071 (UMR)'),
		(9, 1, 'Medicare Supp Plan 0072'),
		(9, 1, 'Medicare Supp Plan 0072 (UMR)'),
		(9, 1, 'Medicare Supplement'),
		(9, 1, 'Medicare Supplement Plan (S)'),
		(9, 1, 'Medicare Supplement Plan (S) (UMR)'),
		(10, 1, 'Unum - Platinum'),
		(10, 1, 'Unum - PPO'),
		(10, 1, 'Unum PPO $1000 Deductible'),
		(10, 1, 'Unum PPO $1500 Deductible'),
		(10, 1, 'Unum PPO $500 Deductible'),
		(11, 1, 'United Healt Care - CT Partnership - Under 65 (with Rx CoPays)'),
		(11, 1, 'United Health Care - HDHP'),
		(11, 1, 'United Health Care - HRA'),
		(11, 1, 'United Health Care - HRA 80'),
		(11, 1, 'United Health Care - HRA 90'),
		(12, 1, 'UPMC POS'),
		(12, 1, 'UPMC PPO'),
		(NULL, 1, 'Waive'),
		(NULL, 1, 'Waive Coverage'),
		(NULL, 1, 'Waive Medical'),
		(1, 2, 'Aetna Dental PPO'),
		(4, 2, 'Blue Cross Blue Shield Basic Plan'),
		(4, 2, 'Blue Cross Blue Shield Dental (R053)'),
		(4, 2, 'Blue Cross Blue Shield Dental Indemnity (R076)'),
		(4, 2, 'Blue Cross Blue Shield Care+Plus'),
		(6, 2, 'CIGNA Dental & Vision'),
		(6, 2, 'CIGNA Dental PPO'),
		(6, 2, 'CIGNA PPO'),
		(13, 2, 'Delta Dental'),
		(13, 2, 'Delta Dental - Fee for Service'),
		(13, 2, 'Delta Dental - PPO'),
		(13, 2, 'Delta Dental PPO (Point of Service) (H)'),
		(13, 2, 'Delta Dental PPO (Point of Service) (S)'),
		(13, 2, 'Delta Dental Premier Plus PPO Plan'),
		(13, 2, 'Delta Dental Care/PMI'),
		(14, 2, 'Humana Dental HMO - California'),
		(14, 2, 'Humana Dental HMO - Florida'),
		(14, 2, 'Humana Dental HMO - Georgia'),
		(14, 2, 'Humana Dental HMO - Illinois'),
		(14, 2, 'Humana Dental HMO - Wisconsin'),
		(14, 2, 'Humana Dental Network Advantage Plan'),
		(10, 2, 'Unum - Dental PPO'),
		(10, 2, 'Unum - High Plan'),
		(10, 2, 'Unum - Low Plan'),
		(10, 2, 'Unum - Principal Dental Plan'),
		(15, 2, 'MetLife Dental'),
		(15, 2, 'MetLife Dental - Inactive 2014'),
		(15, 2, 'MetLife Dental - Dropped 12/31/2018'),
		(NULL, 2, 'No Coverage'),
		(NULL, 2, 'Waive'),
		(NULL, 2, 'Waive Coverage'),
		(2, 3, 'Anthem Vision Exam'),
		(2, 3, 'Anthem Vision Plus'),
		(2, 3, 'Anthem Vision (Base)'),
		(16, 3, 'EyeCare of Wisconsin Buy Up Plan (Waive Med) - Post Tax'),
		(16, 3, 'EyeCare of Wisconsin Buy Up Plan (Waive Med) - Pre Tax'),
		(6, 3, 'CIGNA Vision'),
		(6, 3, 'CIGNA Vision Location 700'),
		(6, 3, 'CIGNA Vision Plan'),
		(17, 3, 'Eyemed Vision'),
		(17, 3, 'Eyemed Vision (InActive 12/31/13)'),
		(17, 3, 'Eyemed Vision (S)'),
		(17, 3, 'Eyemed Vision Care'),
		(17, 3, 'Eyemed Vision Plan'),
		(18, 3, 'Guardian Full Feature Plan'),
		(18, 3, 'Guardian International Vision'),
		(15, 3, 'MetLife - Voluntary Vision'),
		(15, 3, 'MetLife Vision'),
		(19, 3, 'Davis Vision Plan B - $10 CoPay'),
		(19, 3, 'Davis Vision Plan C - $20 CoPay'),
		(19, 3, 'Davis Vision Superior Vision Services'),
		(19, 3, 'Davis Vision The Vision Service Plan'),
		(19, 3, 'Davis Vision The Vision Service Plan (COBRA)'),
		(19, 3, 'Davis Vision The Vision Service Plan (MA)'),
		(19, 3, 'Davis Vision Center Basic Coverage'),
		(11, 3, 'United Healthcare Vision With Safety Glasses'),
		(11, 3, 'United Healthcare Vision Without Safety Glasses'),
		(11, 3, 'United Healthcare Vision'),
		(10, 3, 'UNUM Vision/Always Care'),
		(10, 3, 'UNUM Vision 1 - 3 Tier'),
		(10, 3, 'UNUM Vision 1 - 4 Tier'),
		(10, 3, 'UNUM Vision 2 - 3 Tier'),
		(10, 3, 'UNUM Vision 2 - 4 Tier'),
		(10, 3, 'UNUM Vision Base Plan'),
		(10, 3, 'UNUM Vision Buy-up'),
		(10, 3, 'UNUM Vision Care Plan'),
		(10, 3, 'UNUM Vision Care, Inc'),
		(10, 3, 'UNUM Vision FT'),
		(10, 3, 'UNUM Vision Location 700'),
		(10, 3, 'UNUM Vision Plan'),
		(10, 3, 'UNUM Vision Preferred'),
		(10, 3, 'UNUM Vision Premier Plan'),
		(10, 3, 'UNUM Vision PTA'),
		(10, 3, 'UNUM Vision PTB'),
		(10, 3, 'UNUM Vision Reimbursement Plan'),
		(10, 3, 'UNUM Vision Service Plan'),
		(10, 3, 'UNUM Vision Service Plan (VSP)'),
		(10, 3, 'UNUM Vision Service Plan - D'),
		(10, 3, 'UNUM Vision (removed 2015 carrier change'),
		(20, 3, 'VSP (PT)'),
		(20, 3, 'VSP (Self Pay)'),
		(20, 3, 'VSP (Union)'),
		(20, 3, 'VSP - Vision (004)'),
		(20, 3, 'VSP Safety Glasses ONLY'),
		(20, 3, 'VSP Signature Plan'),
		(20, 3, 'VSP Signature Plan AND Safety Glasses'),
		(20, 3, 'VSP Vision'),
		(20, 3, 'VSP Vision Care'),
		(20, 3, 'VSPPT'),
		(NULL, 3, 'Waive'),
		(NULL, 3, 'Waive Vision Coverage'),
		(NULL, 3, 'Waive Vision Offering'),
		(NULL, 3, 'Waived'),
		(NULL, 3, 'Decline Coverage'),
		(NULL, 3, 'No Coverage'),
		(NULL, 3, 'Not-Enrolled'),
		(NULL, 3, 'Opt-Out'),
		(NULL, 3, 'Opt-Out Credit')
    
-- SELECT * FROM Plans WHERE BenefitsID = 3;

-- EmployerPlan Table
DROP TABLE IF EXISTS EmployerPlan;
CREATE TABLE EmployerPlan
(EmployerPlanID		SMALLINT NOT NULL IDENTITY(1,1),
PlanID			    	SMALLINT NOT NULL,
EmployerID		  	TINYINT NOT NULL,
CONSTRAINT PK_EmployerPlan_EmployerPlanID PRIMARY KEY (EmployerPlanID),
CONSTRAINT FK_EmployerPlan_PlanID FOREIGN KEY (PlanID) REFERENCES Plans (PlanID),
CONSTRAINT FK_EmployerPlan_EmployerID FOREIGN KEY (EmployerID) REFERENCES Employer (EmployerID)
);

INSERT INTO EmployerPlan (PlanID, EmployerID)
VALUES  (134, 1),
		(173, 1),
		(71, 1),
		(157, 2),
		(9, 2),
		(170, 2),
		(150, 2),
		(94, 3),
		(41, 3),
		(118, 4),
		(170, 4),
		(124, 4),
		(156, 4)
    
-- SELECT * FROM EmployerPlan;

-- Level Table
DROP TABLE IF EXISTS Levels;
CREATE TABLE Levels
(LevelID			    TINYINT NOT NULL IDENTITY(1,1),
LevelDescription	VARCHAR(100),
CONSTRAINT PK_Level_LevelID PRIMARY KEY (LevelID)
);

INSERT INTO Levels (LevelDescription)
VALUES  ('Elected'),
		('Employee + 1 (Spouse or Child)'),
		('Employee + 1 Child'),
		('Employee + 1 Non-tax Dep'),
		('Employee + 1 or more Tax Dep + 1 or more non-tax Dep'),
		('Employee + 1 Tax Dep and 2 or more Non-tax Dep'),
		('Emlployee + 1-2 Children (no spouse)'),
		('Employee + 2 Children'),
		('Employee + 2 or more Non-tax Dep'),
		('Employee + 2 or more Tax Dep and 1 non-tax Dep'),
		('Employee + 2-3 Dep (4 max)'),
		('Employee + 3 Children'),
		('Employee + 4 or more Dep'),
		('Employee + Children + Domestic Partner'),
		('Employee + Children + DP'),
		('Employee + Domestic Partner'),
		('Employee + Domestic Partner + 1 Emp Child'),
		('Employee + Domestic Partner + 1 or more taxdep + 1 or more nontax dep'),
		('Employee + Domestic Partner + 2 or more Employee Children'),
		('Employee + Domestic Partner + Child(ren)'),
		('Employee + Domestic Partner + Domestic Partner Child(ren)'),
		('Employee + Domestic Partner + Employee Child(ren)'),
		('Employee + Emp Children & 1 DP Child'),
		('Employee + Family'),
		('Employee + Family (either SP/C or DP child of DP'),
		('Employee + Spouse (no children)'),
		('Employee + Spouse + 1 Child'),
		('Employee + Spouse + 1 or more non-tax Dep'),
		('Employee + Spouse + 1 or more taxdep + 1 or more nontax Dep'),
		('Employee + Spouse + Child(ren)'),
		('Employee + Two or more Dep'),
		('Employee Only'),
		('Not Enrolled'),
		('Opt-Out')

-- SELECT * FROM Levels;

-- Dependents Table
DROP TABLE IF EXISTS Dependents
CREATE TABLE Dependents
(DependentID		INT NOT NULL IDENTITY(1,1),
EmployeeID			INT NOT NULL,
FirstName		  	VARCHAR(25) NOT NULL,
MiddleName			VARCHAR(25) DEFAULT NULL,
LastName		  	VARCHAR(25) NOT NULL,
DOB					    DATE NOT NULL,
SSN				    	CHAR(9) NOT NULL,
CONSTRAINT PK_Dependents_DependentID PRIMARY KEY (DependentID),
CONSTRAINT FK_Dependents_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);

INSERT INTO Dependents (EmployeeID, FirstName, MiddleName, LastName, DOB, SSN)
VALUES  (2,	'George', 'G', 'Bush', '1961-10-20', '99941265'),
		(3,	'Andrea', 'A', 'Tven', '1972-12-26',	'99937224'),
		(3,	'Aubrey', 'A', 'Tven', '2003-06-12', '99937225'),
		(3,	'Amelia', 'A', 'Tven', '2005-08-30', '99937242'),
		(3,	'Charles', NULL, 'Tven', '2009-07-27', '99948575'),
		(5,	'Joseph', 'J', 'Ali', '1961-04-18', '99937223'),
		(5,	'Kelley', 'K', 'Ali', '1973-07-27', '99955485'),
		(5,	'Lily',	'L', 'Ali', '2006-06-24', '99955491'),
		(4,	'Archie', 'A', 'Christakis', '1950-07-01', '99937212'),
		(6,	'Neeley', 'N', 'Whee', '1998-04-16', '99937219'),
		(6,	'Patricia',	'P', 'Whee', '1969-10-03', '99937220'),
		(6,	'Robert', 'R', 'Whee', '2002-07-18','99937221'),
		(6,	'Sara',	'S', 'Whee', '1997-01-27', '99937222'),
		(7,	'Abigail', 'A', 'Wolfer', '1997-02-11', '99937184'),
		(7,	'Benjamin',	',B', 'Wolfer', '2002-08-13', '99937185'),
		(7,	'William', NULL, 'Wolfer', '1999-03-31','99937187'),
		(7,	'Kelly', NULL, 'Wolfer', '1970-05-10', '99954296'),
		(8,	'Nellie', 'N', 'Cicic', '1944-11-21', '99937209'),
		(9,	'James', 'J', 'Kosling', '9/8/1938', '99937198'),
		(10, 'Brandon', 'B', 'McClemmy', '1992-09-10', '99937205'),
		(10, 'Charles',	'C', 'McClemmy', '2000-08-02', '99937206'),
		(10, 'Larry', 'L', 'McClemmy', '1968-03-24','99937207'),
		(10, 'Robert', 'R', 'McClemmy', '1994-10-26', '99937208'),
		(15, 'Roy', 'R', 'Thomas', '1980-05-19',	'99937226'),
		(17, 'Randolph', 'R', 'Stroemer', '1985-08-15', '99955981'),
		(25, 'Donald', 'D', 'Schepens', '1952-09-06','99941521'),
		(27, 'Cynthia',	'C', 'Tharachai	', '1961-05-14', '99937194'),
		(33, 'Terri', 'T', 'Knibloe', '2009-02-06', '19214845'),
		(34, 'Ayesha', 'A', 'Rauens	', '1996-03-09','99954297'),
		(37, 'Porsha', 'P', 'Muuka', '1991-07-03', '99945303'),
		(39, 'John', 'J', 'Beauclair', '1965-05-18','19216939'),
		(41, 'Joshua', 'J',	'Grisbee', '1978-04-11', '99956363'),
		(41, 'Alexis', 'A', 'Grisbee', '2003-05-01', '99956365'),
		(41, 'Carson', 'C', 'Grisbee', '2006-02-18', '99956366'),
		(45, 'Riley', 'R', 'Kasotia	',	'2000-06-10', '19110273'),
		(45, 'Ethan', 'E', 'Kasotia', '2005-04-19', '19110275'),
		(45, 'Anna', 'A', 'Kasotia', '2005-04-19', '19110276'),
		(45, 'Stanley', 'S', 'Kasotia', '1977-11-18', '19110277'),
		(46, 'Diane', 'D', 'Leoncavallo', '1959-12-23',	'19108896'),
		(46, 'Seth', 'S', 'Leoncavallo', '1995-05-18', '19108897'),
		(46, 'Logan', 'L', 'Leoncavallo', '1997-10-18',	'19108898')

-- SELECT * FROM Dependents;

-- EmployeeSelection Table
DROP TABLE IF EXISTS EmployeeSelection;
CREATE TABLE EmployeeSelection
(EmployeeSelectionID	INT NOT NULL IDENTITY(1,1),
EmployeeID				INT NOT NULL,
BenefitsID				SMALLINT NOT NULL,
PlanID				  	SMALLINT NOT NULL,
LevelID				  	TINYINT NOT NULL,
StartDate			  	DATE NOT NULL,
StopDate			  	DATE DEFAULT NULL,
CONSTRAINT PK_EmployeeSelection_EmployeeSelectionID PRIMARY KEY (EmployeeSelectionID),
CONSTRAINT FK_EmployeeSelection_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID),
CONSTRAINT FK_EmployeeSelection_BenefitsID FOREIGN KEY (BenefitsID) REFERENCES Benefits (BenefitsID),
CONSTRAINT FK_EmployeeSelection_PlanID FOREIGN KEY (PlanID) REFERENCES Plans (PlanID),
CONSTRAINT FK_EmployeeSelection_LevelID FOREIGN KEY (LevelID) REFERENCES Levels (LevelID)
);

INSERT INTO EmployeeSelection (EmployeeID, BenefitsID, PlanID, LevelID, StartDate, StopDate)
VALUES  (1,	1,	23,	19,	'2010-03-08',	NULL),
		(2,	1,	76,	21,	'2010-12-26',	'2014-06-03'),
		(3,	1,	3,	12,	'2012-11-7',	NULL),
		(6,	1,	47,	22,	'2012-08-11',	NULL),
		(6,	2,	93,	29,	'2010-10-24',	NULL),
		(6,	3,	124,	25,	'2013-11-17',	NULL),
		(7,	1,	66,	4,	'2013-05-01',	'2015-01-01'),
		(8,	1,	80,	4,	'2012-05-23',	NULL),
		(9,	1,	48,	13,	'2013-06-27',	NULL),
		(10,	1,	43,	3,	'2013-01-16',	NULL),
		(11,	1,	52,	1,	'2011-07-25',	NULL),
		(12,	1,	5,	4,	'2011-11-07',	NULL),
		(13,	1,	64,	15,	'2012-08-10',	NULL),
		(41,	1,	58,	29,	'2011-10-08',	NULL),
		(41,	2,	106,	14,	'2010-09-28',	NULL),
		(41,	3,	173,	2,	'2013-03-11',	NULL),
		(14,	1,	18,	3,	'2011-09-14',	NULL),
		(15,	1,	3,	21,	'2010-08-18',	NULL),
		(16,	1,	35,	29,	'2010-05-15',	NULL),
		(17,	1,	8,	3,	'2013-03-27',	NULL),
		(18,	1,	52,	9,	'2013-04-28',	NULL),
		(19,	1,	35,	18,	'2012-10-17',	NULL),
		(20,	1,	42,	21,	'2013-09-05',	NULL),
		(21,	1,	11,	9,	'2012-09-20',	NULL),
		(22,	1,	32,	7,	'2011-06-17',	NULL),
		(23,	1,	22,	22,	'2011-11-23',	NULL),
		(24,	1,	5,	13,	'2010-12-26',	NULL),
		(25,	1,	27,	16,	'2013-07-28',	NULL),
		(26,	1,	1,	14,	'2010-05-10',	NULL),
		(27,	1,	63,	4,	'2011-10-13',	NULL),
		(28,	1,	19,	22,	'2012-08-06',	NULL),
		(29,	1,	48,	18,	'2011-01-01',	NULL),
		(30,	1,	52,	22,	'2010-01-02',	NULL),
		(31,	1,	66,	27,	'2013-08-05',	NULL),
		(32,	1,	42,	17,	'2012-05-25',	NULL),
		(33,	1,	13,	6,	'2010-08-10',	NULL),
		(34,	1,	16,	19,	'2011-09-03',	NULL),
		(35,	1,	78,	17,	'2011-07-02',	NULL),
		(36,	1,	42,	2,	'2011-04-14',	NULL),
		(37,	1,	73,	13,	'2011-09-03',	NULL)

-- SELECT * FROM EmployeeSelection;

-- DependentSelection Table
DROP TABLE IF EXISTS DependentSelection;
CREATE TABLE DependentSelection
(DependentSelectionID	  INT NOT NULL IDENTITY(1,1),
DependentID				      INT NOT NULL,
EmployeeSelectionID		  INT NOT NULL,
CONSTRAINT PK_DependentSelection_DependentSelectionID PRIMARY KEY (DependentSelectionID),
CONSTRAINT FK_DependentSelection_DependentID FOREIGN KEY (DependentID) REFERENCES Dependents (DependentID),
CONSTRAINT FK_DependentSelection_EmployeeSelectionID FOREIGN KEY (EmployeeSelectionID) REFERENCES EmployeeSelection (EmployeeSelectionID)
);

INSERT INTO DependentSelection (DependentID, EmployeeSelectionID)
VALUES  (10,	4),
		(11,	5),
		(12,	6),
		(32,	14),
		(33,	15),
		(34,	16),
		(1,	2),
		(18,	8),
		(19,	9),
		(24,	18),
		(25,	20),
		(26,	28),
		(27,	30),
		(29,	37),
		(30,	40)

-- SELECT * FROM DependentSelection;













