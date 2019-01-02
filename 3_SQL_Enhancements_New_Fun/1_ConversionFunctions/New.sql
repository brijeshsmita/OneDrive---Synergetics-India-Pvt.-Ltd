
--Using CAST:
--CAST ( expression AS data_type )

---Using CONVERT:
--CONVERT ( data_type [ ( length ) ] , expression [ , style ] )

--Using PARSE
--PARSE ( string_value AS data_type [ USING culture ] )  
/*
1) CAST is supported by ANSI SQL Standard, 
so it's a best practice to prefer CAST over CONVERT and PARSE if its enough to do the job.

2) PARSE function relies on the presence of the .NET framework common language runtime (CLR), 
which may be an extra dependency and may not be present
 in every Windows server where you have installed Microsoft SQL Server.

3) The PARSE function supports an optional USING clause indicating the culture, 
which is any valid culture supported by the .NET framework. 
If culture is not specified then it will use the current session's effective language.
*/
SELECT CONVERT(DATETIME2, '06/08/2012') AS [CONVERT Function Result] --Using Convert Function
Go
SELECT CONVERT(DATETIME, '02/31/2013')  AS 'CONVRT Function Result'
Go



--with invalid date eg   31st Feburary, 2013. 
--TRY_CONVERT function will return NULL value instead of throwing exception. 
SELECT TRY_CONVERT(DATETIME, '02/31/2013')  AS 'TRY_CONVERT Function Result'
Go


SELECT CONVERT(DATETIME, '02/12/2007', 101);
--The literal is interpreted as February 12, 2007 regardless of the language setting that is in effect.
--If you want to use the format dd/mm/yyyy, use style number 103.
SELECT CONVERT(DATETIME, '02/12/2007', 103);
--Difference Between CONVERT and TRY_CONVERT

--Both CONVERT and TRY_CONVERT function converts the expression to the requested type. 
--But if the CONVERT function fails to convert the value to the requested type then raises an exception, 
-- the other hand if TRY_CONVERT function returns a NULL value if it fails to convert the value to the requested type. 


SELECT CONVERT(DATETIME2, 'Monday, 06 august 2012') AS [CONVERT Function Result] --Using Convert Function
Go
SELECT TRY_CONVERT(DATETIME2,' Monday, 06 august 2012')  AS 'TRY_CONVERT Function Result'
Go


SELECT PARSE('06/08/2012' AS Datetime2 USING 'en-US') AS [PARSE Function Result] 
-- Using Parse Function
GO

SELECT PARSE('Monday, 06 august 2012' AS Datetime2  USING 'en-US') AS [PARSE Function Result] 
-- Using Parse Function
GO

SELECT Try_Parse ('Monday, 06 august 2012' AS Datetime2  USING 'en-US') AS [Try_PARSE Function Result] -- Using Try_Parse Function
GO



--Difference between PARSE and CONVERT function.

--PARSE function will successfully converts the string ‘Monday, 06 august 2012’ to date time,
-- but the CONVERT function fails to convert the same value.
-- That is PARSE function tries it’s best to convert the input string value to the requested type,
-- but CONVERT function requires the input string to be exact format no variations allowed.

--PARSE Function Succeeds
SELECT PARSE('Saturday, 08 June 2013' AS DATETIME)  AS 'PARSE Function Result' 
SELECT PARSE('Sat, 08 June 2013' AS DATETIME)  AS 'PARSE Function Result' 
SELECT PARSE('Saturday 08 June 2013' AS DATETIME)  AS 'PARSE Function Result' 
 
--CONVERT Function Fails
SELECT CONVERT(DATETIME, 'Saturday, 08 June 2013') AS 'CONVERT Function Result' 
SELECT CONVERT(DATETIME, 'Sat, 08 June 2013') AS 'CONVERT Function Result' 
SELECT CONVERT(DATETIME, 'Saturday 08 June 2013')  AS 'CONVERT Function Result' 



-- PARSE String to INT
SELECT PARSE('1000' AS INT) AS 'String to INT'
-- PARSE String to Numeric
SELECT PARSE('1000.06' AS NUMERIC(8,2)) AS 'String to Numeric'

-- PARSE string value is in the US currency format to Money 
SELECT PARSE('$2500' as MONEY using 'en-US')  AS 'String in US Currency Format to MONEY'

-- PARSE String to DateTime
SELECT PARSE('05-18-2013' as DATETIME) AS 'String to DATETIME'
-- PARSE String to DateTime
SELECT PARSE('2013/05/18' as DATETIME) AS 'String to DATETIME'
-- PARSE string value in the India date format to DateTime 
SELECT PARSE('18-05-2013' as DATETIME using 'en-in')  AS 'String in Indian DateTime Format to DATETIME'

SELECT PARSE('08-JUNE-2013' AS DATETIME)
SELECT PARSE('08-JUN-2013' AS DATETIME)
SELECT PARSE('2013JUNE08' AS DATETIME)
SELECT PARSE('08/JUN/2013' AS DATETIME)


--PARSE invalid String to DATETIME
SELECT PARSE('2012/02/31' as DATETIME)



--Try Parse 
go
	DECLARE @someDate AS varchar(10);  
	DECLARE @realDate AS VARCHAR(10);  
	SET @someDate = 'iamnotadate';  
	SET @realDate = '2015/12/09';  
	
	SELECT TRY_PARSE(@someDate AS DATE); --NULL  
	SELECT TRY_PARSE(@realDate AS DATE); -- 2015-09-13  


--TRY_CONVERT – Throws Exception
--TRY_CONVERT function raises an exception.
	--Examples:
DECLARE @sampletext AS VARCHAR(10);  
SET @sampletext = '123456';  
DECLARE @realDate1 AS VARCHAR(10);  
SET @realDate1 = '2015/12/05';  
SELECT TRY_CONVERT(INT, @sampletext); -- 123456  
SELECT TRY_CONVERT(DATETIME, @sampletext); -- NULL  
SELECT TRY_CONVERT(DATETIME, @realDate1, 111); -- Sep, 13 2015  


SELECT TRY_CONVERT(INT, '100')
SELECT TRY_CONVERT(NUMERIC(8,2), '1000.06')
SELECT TRY_CONVERT(INT, 100)
SELECT TRY_CONVERT(NUMERIC(8,2), 1000.06)
SELECT TRY_CONVERT(DATETIME, '05/18/2013')
SELECT TRY_CONVERT(DATETIME, '05/18/2013',111)


SELECT TRY_CONVERT(XML, 10)
--Explicit conversion from data type int to xml is not allowed.


--string value to an XML type is supported. 
SELECT TRY_CONVERT(XML, '10') AS 'XML Output'


--use  of TRY_CONVERT function in IF condition:


IF TRY_CONVERT(DATETIME,'Basavaraj') IS NULL 
        PRINT 'TRY_CONVERT: Conversion Successful'
ELSE
        PRINT 'TRY_CONVERT: Conversion Unsuccessful'



--see the StateProvinceCode column of Person.StateProvince table stores character data,
-- but we have both a character value "CA" and an numeric value "86" stored in this column.
SELECT 
   CountryRegionCode,StateProvinceID,StateProvinceCode 
FROM Person.StateProvince 
WHERE  CountryRegionCode IN ('US','FR') AND   Name IN ('california','Vienne')

SELECT 
  StateProvinceID
 ,StateProvinceCode
 ,PARSE(StateProvinceCode AS INT) AS [Using PARSE Function] 
FROM Person.StateProvince 
 WHERE 
  CountryRegionCode IN ('US','FR') 
   AND 
  Name IN ('california','Vienne')
GO



--Use CAST,to explicitly convert an expression when you don't want or need to format the results: 
--CAST(expression AS datatype)
--CONVERT lets you convert and format in one step as follows, where style specifies the format:
--CONVERT (datatype, expression, style) -- it won't work with user-defined data types.
--Style - style values for datetime or smalldatetime conversion to character data.  
--Add 100 to a style value to get a four-place year that includes the century (yyyy).

--Calculating the logarithm for a number.
--The following example calculates the LOG for the specified float expression.
 
DECLARE @var float;
SET @var = 10;
SELECT 'The LOG of the variable is: ' + CONVERT(varchar, LOG(@var));
GO

-- Calculating the logarithm of the exponent of a number.
-- example calculates the LOG for the exponent of a number.
 
SELECT LOG (EXP (10));



-- approximate types
DECLARE @f AS FLOAT = '29545428.029495';
SELECT CAST(@f AS NUMERIC(28, 2)) AS value;

-- attempt to convert fails
SELECT CAST('abc' AS INT);

-- attempt to convert returns a NULL
SELECT TRY_CAST('abc' AS INT);
