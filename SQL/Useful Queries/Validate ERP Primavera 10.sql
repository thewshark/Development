IF 
EXISTS(SELECT 1 FROM sys.procedures WHERE Name = 'GCP_VND_ActualizaDocumentoVenda')
AND
EXISTS(SELECT 1 FROM sys.procedures WHERE Name = 'GCP_INT_ActualizaDocumentoInterno_LinhasInternosStatus')
AND
EXISTS(SELECT 1 FROM sys.procedures WHERE Name = 'GCP_EliminaTabelasAuxiliares')
AND 
EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND TABLE_NAME='CabecDoc')
AND 
EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND TABLE_NAME='LinhasDoc')
AND 
EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND TABLE_NAME='CabecInternos')
AND 
EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND TABLE_NAME='LinhasInternos')
AND 
EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND TABLE_NAME='ResumoIva')
AND
EXISTS(SELECT 1 FROM   sys.objects WHERE  OBJECT_ID = OBJECT_ID('dbo.V_Clientes') AND Type_Desc = 'VIEW')
AND
EXISTS(SELECT 1 FROM   sys.objects WHERE  OBJECT_ID = OBJECT_ID('dbo.V_INV_ArtigoArmazem') AND Type_Desc = 'VIEW')
BEGIN
    SELECT 'true' AS result
END
ELSE
BEGIN
    SELECT 'false' AS result
END