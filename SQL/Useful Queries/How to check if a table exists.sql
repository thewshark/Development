-- How to test if a table exists in a database

-- Method 1
IF EXISTS (SELECT 1 
           FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_TYPE='BASE TABLE' 
           AND TABLE_NAME='CabecDoc') 
   SELECT 'true' AS res ELSE SELECT 'false' AS Result;


-- Method 2
IF OBJECT_ID (N'CabecDoc', N'U') IS NOT NULL 
   SELECT 'true' AS res ELSE SELECT 'false' AS Result;


-- Method 3
IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'CabecDoc'))
BEGIN
    SELECT 'true' AS Result
END
ELSE
BEGIN
	SELECT 'false' AS Result
END