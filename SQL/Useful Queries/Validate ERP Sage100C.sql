IF 
EXISTS(SELECT 1 FROM sys.procedures WHERE Name = 'CDOC_GetItems')
AND
EXISTS(SELECT 1 FROM sys.procedures WHERE Name = 'CDOC_GetVersion')
AND
EXISTS(SELECT 1 FROM sys.procedures WHERE Name = 'CDOC_UpdateItem')
AND 
EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND TABLE_NAME='Clientes')
AND 
EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND TABLE_NAME='DOCGCLIN')
AND 
EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND TABLE_NAME='Pendente')
AND 
EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND TABLE_NAME='Grupos')
AND 
EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND TABLE_NAME='MOTIVOSANULACAO')
AND
EXISTS(SELECT 1 FROM   sys.objects WHERE  OBJECT_ID = OBJECT_ID('dbo.SSARTIGOS') AND Type_Desc = 'VIEW')
BEGIN
    SELECT 'true' AS result
END
ELSE
BEGIN
    SELECT 'false' AS result
END