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
    DECLARE @EmployeeSelectionID INT,
            @BenefitID SMALLINT;
    SET @BenefitID = (
           SELECT B.BenefitsID
           FROM EmployeeSelection AS ES
           WHERE ES.BenefitsID = @BenefitID AND @EmployeeID = ES.EmployeeID AND ES.StopDate IS NULL
    )
    IF EXISTS -- check for duplicate entry and print out the existing entry
    (
           SELECT ES.EmployeeSelectionID
           FROM EmployeeSelection AS ES
           WHERE ES.EmployeeSelectionID = @EmployeeSelectionID AND ES.EmployeeID = @EmployeeID AND ES.BenefitsID = @BenefitsID AND ES.PlanID = @NewPlanID AND ES.LevelID = @NewLevelID
    )
           BEGIN
              SELECT * FROM EmployeeSelection AS ES
              WHERE ES.EmployeeSelectionID = @EmployeeSelectionID AND ES.EmployeeID = @EmployeeID AND ES.BEnefitsID = @BenefitsID AND ES.PlanID = @NewPlanID AND ES.LevelID = @NewLevelID
           END
    ELSE
           IF EXISTS -- Update an existing entry
           (
                  SELECT ES.EmployeeSelectionID
                  FROM EmployeeSelection AS ES
                  WHERE ES.EmployeeSelectionID = @EmployeeSelectionID AND ES.EmployeeID = @EmployeeID AND ES.StopDate IS NULL AND (ES.BenefitsID != @BeneiftID OR ES.PlanID != @NewPlanID OR ES.LevelID != @NewLevelID)
           )
                  BEGIN
                       BEGIN TRANSACTION
                       UPDATE EmployeeSelection
                       SET StopDate = GETDATE()
                       WHERE EmployeeSelectionID = @EmployeeSelectionID;
                       
                       INSERT INTO EmployeeSelection (EmployeeID, BenefitsID, PlanID, LevelID, StartDate)
                       VALUES (@EmployeeID, @BenefitID, @NewPlanID, @NewLevelID, GETDATE());
                       COMMIT;
                  END
           ELSE
                  BEGIN -- add a new entry
                       BEGIN TRANSACTION
                       INSERT INTO EmployeeSelection (EmployeeID, BenefitsID, PlanID, LevelID, StartDate)
                       VALUES (@EmployeeID, @BenefitID, @NewPlanID, @NewLevelID, GETDATE());
                       COMMIT;
                  END
END

EXECUTE ChangeEmployeeSelection
       @EmployeeID = 6,
       @NewPlanID = 23,
       @NewLevel = 19,
       @CurrentBenefit = 'Medical'
       
SELECT * FROM EmployeeSelection
WHERE EmployeeID = 6 
ORDER BY EmployeeID, BenefitsID

-- Terminating an employee

CREATE OR ALTER PROCEDURE TerminateEmployee
(
       @EmployeeID TINYINT,
       @Reason VARCHAR(100)
)
AS
BEGIN
       BEGIN TRANSACTION
       UPDATE Employees
       SET TerminateDate = GETDATE()
       WHERE EmployeeID = @EmployeeId
       UPDATE Employees
       SET TerminationReason = @Reason
       WHERE EmployeeID = @EmployeeID
       UPDATE EmployeeSelection
       SET StopDate = GETDATE()
       WHERE EmployeeID = @EmployeeID AND StopDate IS NULL
       COMMIT;
END

EXECUTE TerminateEmployee
       @EmployeeID = 6,
       @Reason = 'Unfortunate Test User'
       
SELECT * FROM Employees
WHERE EmployeeID = 6

-- count of employees on the provided benefit type

CREATE OR ALTER PROCEDURE GetBenefitCount
(
       @BenefitName VARCHAR(100)
)
AS
BEGIN
       DECLARE @BenefitID = SMALLINT
       SET @BenefitID = 
              (
                     SELECT B.BenefitsID
                     FROM Benefits as B
                     WHERE B.BenefitDescription = @BenefitName
              )
       SELECT @BenefitName AS BenefitName, COUNT(ES.BenefitsID) AS BenefitCount
       FROM EmployeeSelection AS ES
       WHERE ES.BenefitsID = @BenefitID AND ES.StopDate IS NULL
END

EXECUTE GetBenefitCount
       @Benefitname = 'Medical'

-- General Query Statement

-- Display the current employee selection with names instead of IDs

SELECT CONCAT(E.FirstName, ' ', COALESCE(E.MiddleName, ' '), ' ', E.LastName) AS EmployeeName,
       B.BenefitDescription AS BenefitName,
       P.PlanDescription AS PlanName,
       L.LevelDescription AS LevelName,
       ES.StartDate AS StartDate
FROM Employees AS E
INNER JOIN EmployeeSelection AS ES ON E.EmployeeID = ES.EmployeeID
INNER JOIN Benefits AS B ON ES.BenefitsID = B.BenefitsID
INNER JOIN Plans AS P ON ES.PlanID = P.PlanID
INNER JOIN Levels AS L ON ES.LevelID = L.LevelID
WHERE E.TerminationDate IS NULL AND ES.StopDate IS NULL
ORDER BY E.EmployeeID, ES.BenefitsID

-- count of employees on every benefit type

SELECT 'Medical' AS BenefitName, COUNT(ES.BenefitsID) AS BenefitCount
FROM EmployeeSelection AS ES
WHERE ES.BenefitsID = 1 AND ES.StopDate IS NULL
UNION
SELECT 'Dental' AS BenefitName, COUNT(ES.BenefitsID) AS BenefitCount
FROM EmployeeSelection AS ES
WHERE ES.BenefitsID = 2 AND ES.StopDate IS NULL
UNION
SELECT 'Vision' AS BenefitName, COUNT(ES.BenefitsID) AS BenefitCount
FROM EmployeeSelection AS ES
WHERE ES.BenefitsID = 3 AND ES.StopDate IS NULL
UNION
SELECT 'LTD' AS BenefitName, COUNT(ES.BenefitsID) AS BenefitCount
FROM EmployeeSelection AS ES
WHERE ES.BenefitsID = 4 AND ES.StopDate IS NULL

-- count of employees by employer

SELECT EMPL.CompanyName AS CompanyName, COUNT(E.EmployeeID) AS NumerOfEmployees
FROM Employer AS EMPL
INNER JOIN Employees AS E ON EMPL.EmployerID = E.EmployerID
WHERE E.TerminationDate IS NULL
GROUP BY CompanyName

-- Lists the plans with their carrier

SELECT B.BenefitDescription AS BenefitName, P.PlanDescription As PlanName, C.CarrierName
FROM Plans AS P
INNER JOIN Benefits AS B ON P.BenefitsID = P.BenefitsID
INNER JOIN Carrier AS C ON C.CarrierID = P.CarrierID

-- count of plans in use

SELECT B.BenefitDescription AS BenefitType, P.PlanDescription AS PlanName, C.CarrierName AS CarrierName, COUNT(ES.PlanID) AS NumberEnrolled
FROM Plans AS P
INNER JOIN EmployeeSelection AS ES ON ES.PlanID = P.PlanID
INNER JOIN Benefits AS B ON B.BenefitsID = ES.BenefitsID
INNER JON Carrier AS C ON C.CarrierID = P.CarrierID
WHERE ES.StopDate IS NULL
GROUP BY B.BenefitDescription, P.PlanDescription, C.CarrierName
ORDER BY BenefitType ASC


















