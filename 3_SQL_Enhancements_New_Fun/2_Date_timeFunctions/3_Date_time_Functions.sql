---examples 
--Date Functions 
--Returns the current system date and time. Example:
SELECT GETDATE() -- 2017-08-09 17:39:44.927


-- Current Date and Time
--SYSDATETIME and SYSUTCDATE have more fractional seconds precision than GETDATE and GETUTCDATE. 
--SYSUTCDATETIME() : Returns data as UTC time ( Coordinated Universal Time ) and its precision is in nanoseconds..

SELECT
  GETDATE()           AS [GETDATE],----GETDATE() : Its precision is in milliseconds.
  CURRENT_TIMESTAMP   AS [CURRENT_TIMESTAMP],
   GETUTCDATE()        AS [GETUTCDATE],
  SYSDATETIME()       AS [SYSDATETIME],----SYSDATETIME() : Its precision is in nanseconds.
  SYSUTCDATETIME()    AS [SYSUTCDATETIME],----SYSUTCDATETIME() : Returns data as UTC time ( Coordinated Universal Time ) and its precision is in nanoseconds..
  SYSDATETIMEOFFSET() AS [SYSDATETIMEOFFSET];



--Returns the specified part item of a date date as an integer. Examples:
SELECT DATEPART(month, '01.01.2005') -- 1 (1 = January)
SELECT DATEPART(weekday, '01.01.2005') -- 7 (7 = Sunday)
--Returns the specified part item of the date date as a character string. Example:
SELECT DATENAME(weekday, '01.01.2005') -- Saturday


--Adds the number n of units specified by the value i to the given date d. Example:
SELECT DATEADD(DAY,3,HireDate)  FROM emp; -- adds three days to the starting date of employment of every employee (see the sample database).
SELECT DATEADD(year, 1, '20090212');
SELECT DATEADD(year,31,HireDate)  FROM emp;

-- DATEDIFF

--Calculates the difference between the two date parts dat1 and dat2 and returns the result as an integer in units specified by the value item. Example:
SELECT DATEDIFF(year, BirthDate, GETDATE()) AS age FROM employee; -> returns the age of each employee.
SELECT DATEDIFF(day, '20080212', '20090212');
SELECT DATEDIFF(day, '20170529', '20170629');----31
SELECT DATEDIFF(day, '20170629', '20170529');----(-31)


SELECT
DATEADD(day,
DATEDIFF(day, '20010101', CURRENT_TIMESTAMP), '20010101');

-- DAY, MONTH, YEAR
SELECT
  DAY('20170529') AS theday,
  MONTH('20170529') AS themonth,
  YEAR('20170529') AS theyear;
  
  
SELECT EOMONTH(SYSDATETIME());

--SELECT orderid, orderdate, custid, empid
--FROM Sales.Orders
--WHERE orderdate -- EOMONTH(orderdate);

 
-- DATEPART
SELECT DATEPART(month, '20170529');


-- DATENAME
SELECT DATENAME(month, '20170529');
SELECT DATENAME(month, '20090212');
SELECT DATENAME(year, '20090212');


--The ISDATE function accepts a character string as input 
--and returns 1 if it is convertible to a date and
--time data type and 0 if it isn’t.

SELECT ISDATE('20090212');
SELECT ISDATE('20090230');

--The FROMPARTS  SQL Server 2012. 
--They accept integer inputs representing parts of a date and time value 
--and construct a value of the requested type from those parts.
----It is a Sql Server native function not dependent on the .NET CLR.



-- fromparts
SELECT
DATEFROMPARTS(2012, 02, 12),
DATETIME2FROMPARTS(2012, 02, 12, 13, 30, 5, 1, 7),--DATETIMEFROMPARTS ( year, month, day, hour, minute, seconds, milliseconds )

DATETIMEFROMPARTS(2012, 02, 12, 13, 30, 5, 997),
DATETIMEFROMPARTS(1753,1,1,0,0,0,0) AS 'MIN DATETIME',

SMALLDATETIMEFROMPARTS(2012, 02, 12, 13, 30),
TIMEFROMPARTS(13, 30, 5, 1, 7);


--/* Using DATEFROMPARTS Function */
--/*DECLARE 
--  @YEAR  INT = 2012
--, @MONTH INT = 01 
--, @DAY   INT = 09 
--SELECT DATEFROMPARTS (@YEAR, @MONTH, @DAY) AS [Retrieved Data Using DATEFROMPARTS Function]
--*/


--The
--DATEFORMAT setting is expressed as a combination of the characters d, m, and y. For example, the
--us_english language setting sets the DATEFORMAT to mdy, whereas the British language setting
--sets the DATEFORMAT to dmy. You can override the DATEFORMAT setting in your session by using
--the SET DATEFORMAT command, but as mentioned earlier, changing language-related settings is
--generally not recommended.


SELECT
  CAST(SYSDATETIME() AS DATE) AS [current_date],
  CAST(SYSDATETIME() AS TIME) AS [current_time];

 --SELECT orderid, custid, empid, orderdate
--FROM Sales.Orders
--WHERE YEAR(orderdate) -- 2007;


--SELECT orderid, custid, empid, orderdate
--FROM Sales.Orders
--WHERE YEAR(orderdate) -- 2007 AND MONTH(orderdate) -- 2;

---------------------------------------------------------------------
-- Offset Related Functions
---------------------------------------------------------------------
--**-- format : SWITCHOFFSET ( DATETIMEOFFSET, time_zone )  
-- SWITCHOFFSET
SELECT SWITCHOFFSET(SYSDATETIMEOFFSET(), '-01:00');
SELECT SWITCHOFFSET(SYSDATETIMEOFFSET(), '-08:00');

SELECT 
  SWITCHOFFSET('20130212 14:00:00.0000000 -08:00', '-05:00') AS [SWITCHOFFSET],
  TODATETIMEOFFSET('20130212 14:00:00.0000000', '-08:00') AS [TODATETIMEOFFSET];

  --EOFMONTH

  -- last day of the month you specify
  DECLARE @Date1 datetime
SET @Date1 = GETDATE()
SELECT EOMONTH (@Date1)

--To get the last day of the current month using EOMONTH function:

SELECT EOMONTH (GETDATE())

--To get the last day of the previous month specify offset -1:

SELECT EOMONTH (GETDATE(), -1)

--To get the last day of the next month specify offset 1:

SELECT EOMONTH (GETDATE(), 1)

--EOMONTH function can also be used to calculate the first day of the month. Here is an example:

DECLARE @Date1 datetime
SET @Date1 = '04/27/2014'
SELECT DATEADD(DAY, 1, EOMONTH(@Date1, -1))

  --Previously developers used to do 

 select  dateadd(month,1+datediff(month,0,getdate()),-1) 
