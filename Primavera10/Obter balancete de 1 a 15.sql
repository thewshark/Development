SELECT 
 [AcumuladosContas].[Conta]
, Descricao
, TipoConta
, SUM(Mes01Cr+Mes02Cr+Mes03Cr+Mes04Cr+Mes05Cr+Mes06Cr+Mes07Cr+Mes08Cr+Mes09Cr+Mes10Cr+Mes11Cr+Mes12Cr+Mes13Cr+Mes14Cr+Mes15Cr) AS MesCr
, SUM(Mes01Db+Mes02Db+Mes03Db+Mes04Db+Mes05Db+Mes06Db+Mes07Db+Mes08Db+Mes09Db+Mes10Db+Mes11Db+Mes12Db+Mes13Db+Mes14Db+Mes15Db) AS MesDb
, ABS(SUM(Mes01Cr+Mes02Cr+Mes03Cr+Mes04Cr+Mes05Cr+Mes06Cr+Mes07Cr+Mes08Cr+Mes09Cr+Mes10Cr+Mes11Cr+Mes12Cr+Mes13Cr+Mes14Cr+Mes15Cr) - SUM(Mes01Db+Mes02Db+Mes03Db+Mes04Db+Mes05Db+Mes06Db+Mes07Db+Mes08Db+Mes09Db+Mes10Db+Mes11Db+Mes12Db+Mes13Db+Mes14Db+Mes15Db)) AS MesSaldo
FROM AcumuladosContas WITH (NOLOCK) 
INNER JOIN PlanoContas WITH (NOLOCK) ON AcumuladosContas.Ano=PlanoContas.Ano And AcumuladosContas.Conta = PlanoContas.Conta 
WHERE 
 (((AcumuladosContas.Conta >= '0' AND AcumuladosContas.Conta <= '999999999') 
 AND NOT ((AcumuladosContas.Conta >= '00' AND AcumuladosContas.Conta <= '0999999999') OR (AcumuladosContas.Conta >= '90' AND AcumuladosContas.Conta <= '9999999999'))) OR (AcumuladosContas.Conta >= '00' AND AcumuladosContas.Conta <= '0999999999') OR (AcumuladosContas.Conta >= '90' AND AcumuladosContas.Conta <= '9999999999'))
 AND AcumuladosContas.Ano = 2024 
 AND AcumuladosContas.Moeda = 'EUR'
 GROUP BY AcumuladosContas.Conta, Descricao, TipoConta
 ORDER BY AcumuladosContas.Conta