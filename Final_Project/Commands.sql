-- Select Database
USE Final_Project;

-- Indexes
-- Create Nonunique Indexes

CREATE INDEX IX_Employer_State ON Employer (State);
CREATE INDEX IX_Employees_State ON Employees (State);
CREATE INDEX IX_Carrier_State ON Carrier (State):
CREATE INDEX IX_Security_SecurityType ON Security (SecurityType);
CREATE INDEX IX_Benefits_BenefitDescription ON Benefits (BenefitDescription);
CREATE INDEX IX_PhoneType_PhoneTypeDescription ON PhoneType (PhoneTypeDescription);

-- Create Unique Indexes

CREATE UNIQUE INDEX UIX_Employees_SSN ON Employees (SSN);
CREATE UNIQUE INDEX UIX_Employer_CompanyName_TaxID ON Employer (CompanyName, TaxID);
CREATE UNIQUE INDEX UIX_Employer_TaxID ON Employer (TaxID);
CREATE UNIQUE INDEX UIX_Dependents_SSN ON Dependents (SSN);
CREATE UNIQUE INDEX UIX_Employees_FirstName_MiddleName_LastName ON Employees (FirstName, MiddleName, LastName);
CREATE UNIQUE INDEX UIX_Carrier_TaxID ON Carrier (TaxID);
CREATE UNIQUE INDEX UIX_Carrier_CarrierName ON Carrier (CarrierName);
CREATE UNIQUE INDEX UIX_Carrier_CarrierName_TaxID ON Carrier (CarrierName, TaxID);

-- Views
-- Veiw all current employees that live in Texas as a directory

CREATE OR ALTER VIEW TexasEmployeeDirectory AS
SELECT CONCAT (E.FirstName, ' ', COALESCE(E.MiddleName, ' '), ' ', E.LastName) AS EmployeeName,
       CONCAT (E.StreetAddress, ' ', E.City, ' ', E.State, ' ', E.Zipcode) AS Address,
       PN.Phonenumber AS PhoneNumber,
       PT.PhoneTypeDescription
FROM Employees as E
INNER JOIN PhoneNumber AS PN ON E.EmployeeID = PN.EmployeeID
INNER JOIN PhoneType AS PT ON PN.PhoneTypeID = PT.PhoneTypeID
WHERE E.TerminationDate IS NULL AND E.State = 'TX'
GROUP BY CONCAT (E.FirstName, ' ', COALESCE(E.MiddleName, ' '), ' ', E.LastName),
         CONCAT (E.StreetAddress, ' ', E.City, ' ', E.State, ' ', E.ZipCode),
         PN.PhoneNumber,
         PT.PhoneTypeDescription
         
SELECT * FROM TexasEmployeeDirectory
ORDER BY EmployeeName

-- Display Employee Security Type

CREATE OR ALTER VIEW EmployeeSecurityType AS
SELECT CONCAT (E.FirstName, ' ', COALESCE(E.MiddleName, ' '), ' ', E.LastName) AS EmployeeName, S.SecurityType AS SecurityType
FROM Employees AS E
INNER JOIN Security AS S ON E.EmployeeID = S.EmployeeID
WHERE E.TerminationDate IS NULL

SELECT * FROM EmployeeSecurityType
ORDER BY EmployeeName

-- Stored Procedures
-- Changing the current plan or add a plan or display a duplicate

CREATE OR ALTER PROCEDURE ChangeEmployeeSelection
(
    @EmployeeID INT,
    @NewPlanID SMALLINT,
    @NewLevelID TINYINT,
    @CurrentBenefit VARCHAR(100)
)
AS
BEGIN
    DECLARE



















