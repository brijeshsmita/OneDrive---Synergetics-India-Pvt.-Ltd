--2008 
select Convert(varchar(30),'7/7/2011',102)
select Convert(varchar(30),'',102)

select Cast('7/7/2011' as datetime)
select Cast('' as datetime)

DECLARE @d DATETIME = '2008-10-13 18:45:19';

-- returns Oct-13/2008 18:45:19:
SELECT FORMAT(@d, N'MMM-dd/yyyy HH:mm:ss');

-- returns NULL if the conversion fails:
SELECT TRY_PARSE(FORMAT(@d, N'MMM-dd/yyyy HH:mm:ss') AS DATETIME);

-- returns an error if the conversion fails:
SELECT PARSE(FORMAT(@d, N'MMM-dd/yyyy HH:mm:ss') AS DATETIME);

DECLARE @MyDate  varchar(10);
DECLARE @realDate VARCHAR(10);  
BEGIN
SET @MyDate = 'iamnotadate' ;
SET @realDate = '13/09/2015'  ;
SELECT TRY_PARSE(@MyDate AS DATE) --NULL  
SELECT TRY_PARSE(@realDate AS DATE) -- 2015-09-13  
SELECT TRY_PARSE(@realDate AS DATE USING 'Fr-FR') -- 2015-09-13  
END;