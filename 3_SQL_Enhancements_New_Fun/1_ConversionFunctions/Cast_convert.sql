--Use CAST,to explicitly convert an expression when you don't want or need to format the results: 
--CAST(expression AS datatype)
--CONVERT lets you convert and format in one step as follows, where style specifies the format:
--CONVERT (datatype, expression, style) -- it won't work with user-defined data types.
--Style - style values for datetime or smalldatetime conversion to character data.  
--Add 100 to a style value to get a four-place year that includes the century (yyyy).

DECLARE @A varchar(2)
DECLARE @B varchar(2)
DECLARE @C varchar(2)
set @A=25
set @B=15
set @C=33
Select CAST(@A as int) + CAST(@B as int) +CAST (@C as int) as Result

