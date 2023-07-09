DECLARE @isExists INT
exec master.dbo.xp_fileexist 'C:\temp\20230507111306.full.bak', 
@isExists OUTPUT
SELECT case @isExists when 1 then 'true' else 'false' end as FileDoesExists