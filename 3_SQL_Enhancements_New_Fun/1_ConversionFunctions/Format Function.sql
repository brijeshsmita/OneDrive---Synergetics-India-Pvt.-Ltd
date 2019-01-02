/*FORMAT is one of the new built-in String Function introduced as a Part of Sql Server 2012.
 It returns the value formatted in the specified format using the optional culture parameter value.
  It is not an Sql Server native function instead it is .NET CLR dependent function.
  
SYNTAX: FORMAT ( value, format [, culture ] )

Parameter	Description
value:	Value to be formatted
format:	This parameter specifies the format in which the vlaue will be formatted.
culture:	This parameter is optional, it specifies the culture in which the value is formatted. If it is not specified then the language of the current session is used.
RETURNS: Return value type is nvarchar.

-- Culture info for english in u.s. - en-US
-- Culture info for english in belize - en-BZ
-- Culture info for danish in denmark. - da-DK
-- Culture info for french in frnace - fr-FR */

Declare @t table(Culture varchar(10))
Insert into @t values('en-US'),('fr-FR'),('en-BZ'), ('da-DK')

Declare @currency int = 200

Select 
Culture
,FormattedCurrency = FORMAT(@currency,'c',Culture) 
From @t 


--OUTPUT  was a difficult choice with Cast and Convert.


Declare @t table(Culture varchar(10))
Insert into @t values('en-US'),('ru'),('no')

Declare @currency money = 10.25

Select 
Culture
,Res1 = FORMAT(@currency,'C1',Culture) 
,Res2 = FORMAT(@currency,'C2',Culture) 
,Res3 = FORMAT(@currency,'C3',Culture) 
,Res4 = FORMAT(@currency,'C4',Culture) 
From @t 
