Use TSQL2012
/*
You may have seen Transact-SQL code that passes strings around using an N prefix.
 This denotes that the subsequent string is in Unicode 
 (the N actually stands for National language character set). 
Which means that you are passing an NCHAR, NVARCHAR or NTEXT value, 
as opposed to CHAR, VARCHAR or TEXT.
Without the N prefix, the string is converted to the default code page of the database. 
This default code page may not recognize certain characters.*/

-- Character Functions
---------------------------------------------------------------------
-- Concatenation
SELECT empid, country, region, city,
  country + N',' + region + N',' + city AS location
FROM HR.Employees;

-- convert NULL to empty string
SELECT empid, country, region, city,
  country + COALESCE( N',' + region, N'') + N',' + city AS location
FROM HR.Employees;

-- using CONCAT
SELECT empid, country, region, city,
  CONCAT(country, N',' + region, N',' + city) AS location
FROM HR.Employees;

---------------------------------------------------------------------
-- Substring Extraction and Position
---------------------------------------------------------------------

SELECT SUBSTRING('abcde', 1, 3); -- 'abc'

SELECT LEFT('abcde', 3); -- 'abc'

SELECT RIGHT('abcde', 3); -- 'cde'

SELECT CHARINDEX(' ','Itzik Ben-Gan'); -- 6

SELECT PATINDEX('%[0-9]%', 'abcd123efgh'); -- 5

---------------------------------------------------------------------
-- String Length
---------------------------------------------------------------------

SELECT LEN(N'xyz'); -- 3

SELECT DATALENGTH(N'xyz'); -- 6

---------------------------------------------------------------------
-- String Alteration
---------------------------------------------------------------------

SELECT REPLACE('.1.2.3.', '.', '/'); -- '/1/2/3/'

SELECT REPLICATE('0', 10); -- '0000000000'

SELECT STUFF(',x,y,z', 1, 1, ''); -- 'x,y,z'

---------------------------------------------------------------------
-- String Formating
---------------------------------------------------------------------

SELECT UPPER('aBcD'); -- 'ABCD'

SELECT LOWER('aBcD'); -- 'abcd'

SELECT RTRIM(LTRIM('   xyz   ')); -- 'xyz'

SELECT FORMAT(1759, '000000000'); -- '0000001759'

---------------------------------------------------------------------
-- CASE Expression and Related Functions
---------------------------------------------------------------------

-- simple CASE expression
SELECT productid, productname, unitprice, discontinued,
  CASE discontinued
    WHEN 0 THEN 'No'
    WHEN 1 THEN 'Yes'
    ELSE 'Unknown'
  END AS discontinued_desc
FROM Production.Products;

-- searched CASE expression
SELECT productid, productname, unitprice,
  CASE
    WHEN unitprice < 20.00 THEN 'Low'
    WHEN unitprice < 40.00 THEN 'Medium'
    WHEN unitprice >= 40.00 THEN 'High'
    ELSE 'Unknown'
  END AS pricerange
FROM Production.Products;


-- The ISNULL() function looks at the first value and 
--the second parameter value is automatically limited to that length 
--but COALESCE() does not have this restriction.
-- COALESCE vs. ISNULL

DECLARE
  @x AS VARCHAR(3) = NULL,
  @y AS VARCHAR(10) = '1234567890';

SELECT COALESCE(@x, @y) AS [COALESCE]
SELECT  ISNULL(@x, @y) AS [ISNULL];
/*
 The only formatting capabilities that SQL Server has had until now was the CAST and CONVERT function.
  Some programmers write user defined functions for date conversion.
The long wait for this format function is over. 
The new SQL Server 2012 RC0 is leveraging the .NET format capabilities
 by introducing the FORMAT() function.

 The function FORMAT() accepts 3 parameters.
1> VALUE - date value or numeric value.
2>the.NET Framework format string. The format parameter is case sensitive.
  "D" doesn’t mean the same as "d".  
3>The third parameter is the culture. This can be any culture supported by the .NET Framework.
*/

-- display weekday date name, month name and the day with year

DECLARE @date DATETIME = '12/21/2011';
SELECT FORMAT ( @date, 'D', 'en-US' ) AS FormattedDate;

--display only the month name and day, you could use the following example.

DECLARE @date1 DATETIME = '12/21/2011';
SELECT FORMAT ( @date1, 'm', 'en-US' ) AS FormattedDate;

DECLARE @money money = '125000';
SELECT FORMAT ( @money, 'C') AS MyMoney;
 -- C for current locale ,  because my current locale language setting is en-us.


 -- display the currency ‘$’ explicitly by using the culture parameter \

DECLARE @money1 money = '125000';
SELECT FORMAT ( @money1, 'C', 'en-US'  ) AS MyMoney;

DECLARE @money2 money = '125000';
SELECT FORMAT ( @money2,'C', 'ta-IN') AS MyMoney; --India Tamil


--u can  change my language setting first and display the currency as shown below.

--set language british
--DECLARE @money3 money = '125000';
--SELECT FORMAT ( @money3, 'C') AS MyMoney;


--displays the number in percentage.

DECLARE @num bigint = 5
SELECT FORMAT ( @num, '00.000%') AS MyMoney;

SELECT Format(1222.4, '##,##0.00')   -- Returns "1,222.40".
SELECT Format(345.9, '###0.00')   -- Returns "345.90".
SELECT Format(15, '0.00%')   -- Returns "1500.00%".
