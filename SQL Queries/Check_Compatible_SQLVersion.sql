SELECT
  CASE 
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '8%' THEN 'false'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '9%' THEN 'false'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '10.0%' THEN 'false'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '10.5%' THEN 'false'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '11%' THEN 'true'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '12%' THEN 'true'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '13%' THEN 'true'     
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '14%' THEN 'true' 
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '15%' THEN 'true' 
	 WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '16%' THEN 'true' 
	 WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '17%' THEN 'true' 
	 WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '18%' THEN 'true' 
	 WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '19%' THEN 'true' 
	 WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '20%' THEN 'true' 
     ELSE 'false'
  END AS Compatible,
  CASE 
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '8%' THEN 'SQL2000'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '9%' THEN 'SQL2005'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '10.0%' THEN 'SQL2008'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '10.5%' THEN 'SQL2008 R2'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '11%' THEN 'SQL2012'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '12%' THEN 'SQL2014'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '13%' THEN 'SQL2016'     
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '14%' THEN 'SQL2017' 
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '15%' THEN 'SQL2019' 
	 WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '16%' THEN 'SQL2020' 
	 WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '17%' THEN 'SQL2021' 
	 WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '18%' THEN 'SQL2022' 
	 WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '19%' THEN 'SQL2023' 
	 WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '20%' THEN 'SQL2024' 
     ELSE 'unknown'
  END AS MajorVersion,
  SERVERPROPERTY('ProductLevel') AS ProductLevel,
  SERVERPROPERTY('Edition') AS Edition,
  SERVERPROPERTY('ProductVersion') AS ProductVersion