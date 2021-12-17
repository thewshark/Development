-- Check if an SP exists

-- Method 1
IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'GCP_VND_ActualizaDocumentoVenda')
BEGIN
    PRINT 'true'
END
ELSE
BEGIN
    PRINT 'false'
END

-- Method 2
IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GCP_VND_ActualizaDocumentoVenda'))
BEGIN
    PRINT 'true'
END
ELSE
BEGIN
    PRINT 'false'
END

-- Method 3
IF EXISTS(SELECT 1 FROM PRIDEMO.sys.procedures
 WHERE object_id=OBJECT_ID(N'PRIDEMO.dbo.GCP_VND_ActualizaDocumentoVenda'))
BEGIN
    PRINT 'true'
END
ELSE
BEGIN
    PRINT 'false'
END
