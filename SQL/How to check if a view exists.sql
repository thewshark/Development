-- Test if a view exists on a database

-- Method 1
IF EXISTS(
   SELECT 1
   FROM   sys.objects
   WHERE  OBJECT_ID = OBJECT_ID('dbo.V_Clientes')
          AND Type_Desc = 'VIEW'
)
BEGIN
    PRINT 'true'
END
ELSE
BEGIN
	PRINT 'false'
END


-- Method 2
IF NOT EXISTS (
   SELECT 1
   FROM   sysobjects
   WHERE  NAME = 'dbo.V_Clientes'
          AND xtype = 'V'
)
BEGIN
    PRINT 'true'
END
ELSE
BEGIN
	PRINT 'false'
END



-- Method 3
IF EXISTS (
   SELECT 1
   FROM sys.views
   WHERE OBJECT_ID = OBJECT_ID(N'dbo.V_Clientes')
)
BEGIN
    PRINT 'true'
END
ELSE
BEGIN
	PRINT 'false'
END



-- Method 4
IF EXISTS (
   SELECT 1
   FROM   INFORMATION_SCHEMA.VIEWS
   WHERE  table_name = 'V_Clientes'
          AND table_schema = 'dbo'
)
BEGIN
    PRINT 'true'
END
ELSE
BEGIN
	PRINT 'false'
END



-- Method 5
IF EXISTS(
   SELECT OBJECT_ID('V_Clientes', 'V')
)
BEGIN
    PRINT 'true'
END
ELSE
BEGIN
	PRINT 'false'
END



-- Method 6
IF EXISTS (
   SELECT 1
   FROM   sys.sql_modules
   WHERE  OBJECT_ID = OBJECT_ID('dbo.V_Clientes')
)
BEGIN
    PRINT 'true'
END
ELSE
BEGIN
	PRINT 'false'
END
