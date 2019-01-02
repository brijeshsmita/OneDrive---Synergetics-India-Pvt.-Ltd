

--Choose() Function

--This function returns a value out of a list based on its index number. 
--You can think of it as an array kind of thing. The Index number here starts from 1.

SELECT Choose(3, 'Mon','Tue','Wed','Thurs','Fri','Sat','Sun') As ChooseResult 

DECLARE @X INT;
SET @X=50;
DECLARE @Y INT;
SET @Y=60;
SELECT IIF(@X>@Y, 50, 60) As IIFResult

-- SELECT iif(@X>@Y, 50, 60) As IIFResult returns false value that is 60.


DECLARE @ShowIndex INT;
SET @ShowIndex =5;
SELECT CHOOSE(@ShowIndex, 'M','N','H','P','T','L','S','H') As ChooseResult 


--When passed a set of types to the function it returns the data type with the highest precedence; 

DECLARE @ShowIndex2 INT;
SET @ShowIndex2 =5;
SELECT CHOOSE(@ShowIndex2 ,35,42,12,14,15,18)  As CooseResult

DECLARE @ShowIndex1 INT;
SET @ShowIndex1 =5;
SELECT Choose(@ShowIndex1 ,35,42,12.6,14,15,18.7)  As CooseResult

-- use index=5. It will start at 1. Choose() returns 15.0 as output since 15 is present at @ShowIndex location 5 because in the item list,
-- fractional numbers have higher precedence than integers.


--If an index value exceeds the bound of the array it returns NULL
DECLARE @ShowIndex3 INT;
SET @ShowIndex3 =9;
SELECT Choose(@ShowIndex3 , 'M','N','H','P','T','L','S','H')  As CooseResult

--try with SET @ShowIndex =-1; --returns null

-- If the provided index value has a float data type other than int, 
--then the value is implicitly converted to an integer; see:

DECLARE @ShowIndex4  INT;
SET @ShowIndex4 =4.5;
SELECT Choose(@ShowIndex4 ,35,42,12.6,13,15,20) As CooseResult


SELECT CHOOSE ( 3, 'Chelsea', 'Man Utd', 'Liverpool', 'Arsenal' ) AS 'The Best team';

--use of these functions 
USE AdventureWorks2014
GO

SELECT CHOOSE(1,Title,FirstName,MiddleName,LastName)  FROM Person.Person;
SELECT CHOOSE(2,Title,FirstName,MiddleName,LastName) FROM Person.Person;
 
SELECT CHOOSE(1,Title,FirstName,MiddleName,LastName) + ' ' + CHOOSE(2,Title,FirstName,MiddleName,LastName) + ' ' + CHOOSE(3,Title,FirstName,MiddleName,LastName) + ' .' + CHOOSE(4,Title,FirstName,MiddleName,LastName) FROM Person.Person;

SELECT NationalIDNumber,
       JobTitle,Hiredate,
       MONTH(HireDate) as HireMonth,
       CHOOSE(MONTH(HireDate),
              'Winter', 'Winter', 'Winter',
              'Spring', 'Spring', 'Spring',
              'Summer', 'Summer', 'Summer',
              'Fall', 'Fall', 'Fall') as [Hiring Season]
FROM  HumanResources.Employee

--IIF() Function
--The IIF function is used to check a condition.
-- Suppose X>Y. In this condition a is the first expression and b is the second expression. 
--If the first expression evaluates to TRUE then the first value is displayed, if not the second value is displayed.

SELECT [ProductID],[Name],IIF((LEFT(Name,7)= 'Touring'), 'Out Of stock','In stock') as StockAvailability
FROM [Production].[Product]


SELECT NationalIDNumber,
       IIF(Gender='F','Female','Male')
FROM   HumanResources.Employee


SELECT NationalIDNumber,
       Gender,
       MaritalStatus,
       IIF(Gender='F',IIF(MaritalStatus='S','Single Female', 'Married Female'),
                      IIF(MaritalStatus='S','Single Male', 'Married Male'))
FROM   HumanResources.Employee

--IIF --shortcut for CASE construct 
SELECT NationalIDNumber,
       Gender,
       MaritalStatus,
       CASE
           WHEN MaritalStatus = 'S' Then 'Single'
           ELSE 'Married'
       END +
       ' ' +
       CASE
           WHEN Gender = 'F' Then 'Female'
           ELSE 'Male'
       END
FROM   HumanResources.Employee



--SELECT IIF(DATEPART(WEEKDAY,GETDATE())=3 ,'Today is Tuesday','It is not Tuesday') as 'Day of the Week' ;

--to produce a small report where every product that starts with ‘Touring’ should return back ‘Out Of Stock‘.




/*

SELECT [StudentNumber], IIF( [GradePoint] BETWEEN 92 AND 100, 'A',
                        IIF( [GradePoint] BETWEEN 83 AND 91,  'B',
                        IIF( [GradePoint] BETWEEN 74 AND 82,  'C',
                        IIF( [GradePoint] BETWEEN 65 AND 73,  'D',
                        IIF( [GradePoint] < 65, 'F', 'I' ))))) AS [LetterGrade]
FROM [dbo].[Student]
Here’s how the same query will look like using the CASE statement instead of the IIF function:

SELECT [StudentNumber], CASE WHEN [GradePoint] BETWEEN 92 AND 100 THEN 'A'
                             WHEN [GradePoint] BETWEEN 83 AND 91  THEN 'B'
                             WHEN [GradePoint] BETWEEN 74 AND 82  THEN 'C'
                             WHEN [GradePoint] BETWEEN 65 AND 73  THEN 'D'
                             WHEN [GradePoint] < 65 THEN 'F'
                             ELSE 'I' END AS [LetterGrade]
FROM [dbo].[Student]
*/