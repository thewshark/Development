SELECT 

Main.Codigo, 

UPPER(Main.Descricao) AS Descricao, 

-- START VALOR AUTOS NORMAIS *********************************************************************************************************
CONVERT(DECIMAL(19,2), (SELECT  
	ISNULL(SUM(A.AMValor), 0)
FROM COP_Autos A WITH (NOLOCK)
    INNER JOIN COP_Obras      O WITH (NOLOCK) ON O.ID = A.ObraID
    LEFT  JOIN Geral_Entidade E WITH (NOLOCK) ON E.EntidadeId = O.EntidadeIDA
    LEFT  JOIN (
        SELECT TOP 1 OCA.AutoID, OC.Codigo + '/' + CAST(OC.Numero AS VARCHAR(20)) AS CertCod
        FROM COP_ObraCertificacoes OC WITH (NOLOCK)
            INNER JOIN COP_ObraCertificacoesAutos OCA WITH (NOLOCK) ON OCA.ObraCertificacaoID = OC.ID
        WHERE OCA.Facturado = 1
        GROUP BY OCA.AutoID, OC.Codigo, OC.Numero
    ) AS C ON C.AutoID = A.ID
    LEFT  JOIN (
        SELECT LC.AutoID
        FROM LinhasCompras LC WITH (NOLOCK)
            INNER JOIN COP_Obras          OB  WITH (NOLOCK) ON OB.ID = LC.ObraID
            INNER JOIN CabecCompras       CC  WITH (NOLOCK) ON CC.Id = LC.IdCabecCompras
            INNER JOIN CabecComprasStatus CCS WITH (NOLOCK) ON CCS.IdCabecCompras = CC.Id
            LEFT  JOIN LinhasCompras      LCE WITH (NOLOCK) ON LCE.IDLinhaEstorno = LC.Id
        WHERE (OB.ID = Main.ID OR OB.ObraPaiID = Main.ID) AND OB.Tipo = 'S' AND LC.AutoID IS NOT NULL
            AND CCS.Anulado = 0 AND LC.IDLinhaEstorno IS NULL AND LCE.Id IS NULL AND LC.Quantidade <> 0 AND LC.PrecUnit <> 0
        GROUP BY LC.AutoID
    ) AS F ON F.AutoID = A.ID
WHERE (O.ID = Main.ID OR O.ObraPaiID = Main.ID) AND O.Tipo = 'S')) AS ValorAutosNormais,

-- END VALOR AUTOS NORMAIS *********************************************************************************************************


-- START VALOR AUTOS MAIS *********************************************************************************************************

CONVERT(DECIMAL(19,2), (SELECT  
	ISNULL(SUM(A.TMValor), 0)
FROM COP_Autos A WITH (NOLOCK)
    INNER JOIN COP_Obras      O WITH (NOLOCK) ON O.ID = A.ObraID
    LEFT  JOIN Geral_Entidade E WITH (NOLOCK) ON E.EntidadeId = O.EntidadeIDA
    LEFT  JOIN (
        SELECT TOP 1 OCA.AutoID, OC.Codigo + '/' + CAST(OC.Numero AS VARCHAR(20)) AS CertCod
        FROM COP_ObraCertificacoes OC WITH (NOLOCK)
            INNER JOIN COP_ObraCertificacoesAutos OCA WITH (NOLOCK) ON OCA.ObraCertificacaoID = OC.ID
        WHERE OCA.Facturado = 1
        GROUP BY OCA.AutoID, OC.Codigo, OC.Numero
    ) AS C ON C.AutoID = A.ID
    LEFT  JOIN (
        SELECT LC.AutoID
        FROM LinhasCompras LC WITH (NOLOCK)
            INNER JOIN COP_Obras          OB  WITH (NOLOCK) ON OB.ID = LC.ObraID
            INNER JOIN CabecCompras       CC  WITH (NOLOCK) ON CC.Id = LC.IdCabecCompras
            INNER JOIN CabecComprasStatus CCS WITH (NOLOCK) ON CCS.IdCabecCompras = CC.Id
            LEFT  JOIN LinhasCompras      LCE WITH (NOLOCK) ON LCE.IDLinhaEstorno = LC.Id
        WHERE (OB.ID = Main.ID OR OB.ObraPaiID = Main.ID) AND OB.Tipo = 'S' AND LC.AutoID IS NOT NULL
            AND CCS.Anulado = 0 AND LC.IDLinhaEstorno IS NULL AND LCE.Id IS NULL AND LC.Quantidade <> 0 AND LC.PrecUnit <> 0
        GROUP BY LC.AutoID
    ) AS F ON F.AutoID = A.ID
WHERE (O.ID = Main.ID OR O.ObraPaiID = Main.ID) AND O.Tipo = 'S')) AS ValorAutosMais,

-- END VALOR AUTOS MAIS *********************************************************************************************************

-- START VALOR AUTOS MENOS *********************************************************************************************************

CONVERT(DECIMAL(19,2), (SELECT  
	ISNULL(SUM(A.TMenosValor), 0)
FROM COP_Autos A WITH (NOLOCK)
    INNER JOIN COP_Obras      O WITH (NOLOCK) ON O.ID = A.ObraID
    LEFT  JOIN Geral_Entidade E WITH (NOLOCK) ON E.EntidadeId = O.EntidadeIDA
    LEFT  JOIN (
        SELECT TOP 1 OCA.AutoID, OC.Codigo + '/' + CAST(OC.Numero AS VARCHAR(20)) AS CertCod
        FROM COP_ObraCertificacoes OC WITH (NOLOCK)
            INNER JOIN COP_ObraCertificacoesAutos OCA WITH (NOLOCK) ON OCA.ObraCertificacaoID = OC.ID
        WHERE OCA.Facturado = 1
        GROUP BY OCA.AutoID, OC.Codigo, OC.Numero
    ) AS C ON C.AutoID = A.ID
    LEFT  JOIN (
        SELECT LC.AutoID
        FROM LinhasCompras LC WITH (NOLOCK)
            INNER JOIN COP_Obras          OB  WITH (NOLOCK) ON OB.ID = LC.ObraID
            INNER JOIN CabecCompras       CC  WITH (NOLOCK) ON CC.Id = LC.IdCabecCompras
            INNER JOIN CabecComprasStatus CCS WITH (NOLOCK) ON CCS.IdCabecCompras = CC.Id
            LEFT  JOIN LinhasCompras      LCE WITH (NOLOCK) ON LCE.IDLinhaEstorno = LC.Id
        WHERE (OB.ID = Main.ID OR OB.ObraPaiID = Main.ID) AND OB.Tipo = 'S' AND LC.AutoID IS NOT NULL
            AND CCS.Anulado = 0 AND LC.IDLinhaEstorno IS NULL AND LCE.Id IS NULL AND LC.Quantidade <> 0 AND LC.PrecUnit <> 0
        GROUP BY LC.AutoID
    ) AS F ON F.AutoID = A.ID
WHERE (O.ID = Main.ID OR O.ObraPaiID = Main.ID) AND O.Tipo = 'S')) AS ValorAutosMenos,

-- END VALOR AUTOS MENOS *********************************************************************************************************

-- START TOTAL SUBEMPREITADAS ********************************************************************************************

CONVERT(DECIMAL(19,2), (SELECT ISNULL(SUM(CS.Valor),0) AS Valor
FROM FN_COP_DaObrasMaisContratosAdicionais('CANC, CONC, PERD') OCA
    CROSS APPLY FN_COP_DaCustosSubempreitadas(OCA.ID, 1, NULL, GETDATE()) CS
WHERE OCA.Tipo IN ('O', 'C') AND OCA.ObraPrincipalID = Main.ID)) AS TotalSubEmpreitadas,

-- END TOTAL SUBEMPREITADAS ********************************************************************************************

-- START TOTAL MATERIAIS E SERVIÇOS ********************************************************************************************

CONVERT(DECIMAL(19,2), (SELECT ISNULL(SUM(ISNULL(C1.Quantidade, 0) * ISNULL(C1.PrecoUnit, 0)),0) AS Valor
FROM COP_MovimentosCusto C1
    INNER JOIN COP_Obras O ON C1.ObraID = O.ID
WHERE (O.ID = Main.ID OR O.ObraPaiID = Main.ID) AND C1.Data <= GETDATE()
    -- Compras, Vendas, Contas Correntes, Internos, Stocks, Bancos, Variações
    AND C1.Origem IN ('C', 'V', 'M', 'D', 'S', 'B', 'F') AND O.Tipo <> 'S')) AS MateriaisServicos,

-- END TOTAL MATERIAIS E SERVIÇOS ********************************************************************************************

-- START TOTAL ESTIMADO OBRA *********************************************************************************************************

CONVERT(DECIMAL(19,2), (SELECT ISNULL(T2.Valor, T1.Valor) Valor
FROM (SELECT 9 AS Ordem, 'C1' AS Tipo, 0 AS Valor) AS T1
    LEFT JOIN (
        SELECT 9 AS Ordem, 'C1' AS Tipo, (CASE WHEN ISNULL(TotExec, 0) = 0 THEN ISNULL(TotCusto, 0) ELSE ISNULL(TotExec, 0) END) AS Valor
        FROM Orcamentos_Orcamento
        WHERE ObraID = Main.ID AND OrcPrincipal = 1
    ) AS T2 ON T2.Ordem = T1.Ordem) + (SELECT ISNULL(SUM(TotExec),0) AS Valor
FROM Orcamentos_Orcamento orc1
    INNER JOIN COP_Obras of1 ON orc1.ObraId = of1.ID 
WHERE of1.Tipo = 'C' AND of1.ObraPaiID = Main.ID AND of1.Estado NOT IN ('CANC','CONC','PERD')
    AND of1.DataAdjudicacao <= GETDATE() AND orc1.OrcPrincipal = 1)) AS TotalEstimadoObra,

-- END TOTAL ESTIMADO OBRA *********************************************************************************************************

-- START REAL OBRA *************************************************************************************
CONVERT(DECIMAL(19,2), (SELECT ISNULL(SUM(CS.Valor),0) AS Valor
FROM FN_COP_DaObrasMaisContratosAdicionais('CANC, CONC, PERD') OCA
    CROSS APPLY FN_COP_DaCustosSubempreitadas(OCA.ID, 1, NULL, GETDATE()) CS
WHERE OCA.Tipo IN ('O', 'C') AND OCA.ObraPrincipalID = Main.ID) +

(SELECT ISNULL(SUM(ISNULL(C1.Quantidade, 0) * ISNULL(C1.PrecoUnit, 0)),0) AS Valor
FROM COP_MovimentosCusto C1
    INNER JOIN COP_Obras O ON C1.ObraID = O.ID
WHERE (O.ID = Main.ID OR O.ObraPaiID = Main.ID) AND C1.Data <= GETDATE()
    -- Compras, Vendas, Contas Correntes, Internos, Stocks, Bancos, Variações
    AND C1.Origem IN ('C', 'V', 'M', 'D', 'S', 'B', 'F') AND O.Tipo <> 'S') +

(SELECT ISNULL(SUM(ISNULL(C1.Quantidade, 0) * ISNULL(C1.PrecoUnit, 0)),0) AS Valor
FROM COP_MovimentosCusto C1
    INNER JOIN COP_Obras O ON O.ID = C1.ObraID
WHERE (C1.ObraID = Main.ID OR (O.ObraPaiID = Main.ID AND O.Tipo = 'C'))
    AND C1.Data <= GETDATE() AND C1.Origem = 'P' AND O.Tipo <> 'S') +

(SELECT ISNULL(SUM(ISNULL(C1.Quantidade, 0) * ISNULL(C1.PrecoUnit, 0)), 0) AS Valor
FROM COP_MovimentosCusto C1
    INNER JOIN COP_Obras O ON O.ID = C1.ObraID
WHERE (C1.ObraID = Main.ID OR (O.ObraPaiID = Main.ID AND O.Tipo = 'C'))
    AND C1.Data <= GETDATE() AND C1.Origem = 'E' AND O.Tipo <> 'S') +

(SELECT ISNULL(SUM(ISNULL(C.Quantidade, 0) * ISNULL(C.PrecoUnit, 0)),0) AS Valor
FROM COP_Custos C
    INNER JOIN COP_Obras O ON C.ObraID = O.ID
    LEFT OUTER JOIN Geral_Classe ON C.ClasseID = Geral_Classe.ClasseId
    LEFT OUTER JOIN Orcamentos_Item OI ON C.ItemId = OI.ItemId
WHERE (O.ID = Main.ID OR O.ObraPaiID = Main.ID) AND C.Data <= GETDATE() AND O.Tipo <> 'S') +

(SELECT ISNULL(SUM(af1.TMenosValorExec), 0) AS Valor

FROM COP_Autos af1
    INNER JOIN COP_Obras of1 ON af1.ObraID = of1.ID
WHERE (ObraID = Main.ID OR (of1.ObraPaiID = Main.ID AND of1.Tipo = 'C')) AND af1.Data <= GETDATE())) AS RealObra,

-- END REAL OBRA ************************************************************************************************************


-- START POR FATURAR *******************************************************************************************************

CONVERT(DECIMAL(19,2), (SELECT ISNULL(T2.Valor, T1.Valor) Valor
FROM (SELECT 9 AS Ordem, 'C1' AS Tipo, 0 AS Valor) AS T1
    LEFT JOIN (
        SELECT 9 AS Ordem, 'C1' AS Tipo, (CASE WHEN ISNULL(TotExec, 0) = 0 THEN ISNULL(TotCusto, 0) ELSE ISNULL(TotExec, 0) END) AS Valor
        FROM Orcamentos_Orcamento
        WHERE ObraID = Main.ID AND OrcPrincipal = 1
    ) AS T2 ON T2.Ordem = T1.Ordem) + (SELECT ISNULL(SUM(TotExec),0) AS Valor
FROM Orcamentos_Orcamento orc1
    INNER JOIN COP_Obras of1 ON orc1.ObraId = of1.ID 
WHERE of1.Tipo = 'C' AND of1.ObraPaiID = Main.ID AND of1.Estado NOT IN ('CANC','CONC','PERD')
    AND of1.DataAdjudicacao <= GETDATE() AND orc1.OrcPrincipal = 1))
-
CONVERT(DECIMAL(19,2), (SELECT ISNULL(SUM(CS.Valor),0) AS Valor
FROM FN_COP_DaObrasMaisContratosAdicionais('CANC, CONC, PERD') OCA
    CROSS APPLY FN_COP_DaCustosSubempreitadas(OCA.ID, 1, NULL, GETDATE()) CS
WHERE OCA.Tipo IN ('O', 'C') AND OCA.ObraPrincipalID = Main.ID) +

(SELECT ISNULL(SUM(ISNULL(C1.Quantidade, 0) * ISNULL(C1.PrecoUnit, 0)),0) AS Valor
FROM COP_MovimentosCusto C1
    INNER JOIN COP_Obras O ON C1.ObraID = O.ID
WHERE (O.ID = Main.ID OR O.ObraPaiID = Main.ID) AND C1.Data <= GETDATE()
    -- Compras, Vendas, Contas Correntes, Internos, Stocks, Bancos, Variações
    AND C1.Origem IN ('C', 'V', 'M', 'D', 'S', 'B', 'F') AND O.Tipo <> 'S') +

(SELECT ISNULL(SUM(ISNULL(C1.Quantidade, 0) * ISNULL(C1.PrecoUnit, 0)),0) AS Valor
FROM COP_MovimentosCusto C1
    INNER JOIN COP_Obras O ON O.ID = C1.ObraID
WHERE (C1.ObraID = Main.ID OR (O.ObraPaiID = Main.ID AND O.Tipo = 'C'))
    AND C1.Data <= GETDATE() AND C1.Origem = 'P' AND O.Tipo <> 'S') +

(SELECT ISNULL(SUM(ISNULL(C1.Quantidade, 0) * ISNULL(C1.PrecoUnit, 0)), 0) AS Valor
FROM COP_MovimentosCusto C1
    INNER JOIN COP_Obras O ON O.ID = C1.ObraID
WHERE (C1.ObraID = Main.ID OR (O.ObraPaiID = Main.ID AND O.Tipo = 'C'))
    AND C1.Data <= GETDATE() AND C1.Origem = 'E' AND O.Tipo <> 'S') +

(SELECT ISNULL(SUM(ISNULL(C.Quantidade, 0) * ISNULL(C.PrecoUnit, 0)),0) AS Valor
FROM COP_Custos C
    INNER JOIN COP_Obras O ON C.ObraID = O.ID
    LEFT OUTER JOIN Geral_Classe ON C.ClasseID = Geral_Classe.ClasseId
    LEFT OUTER JOIN Orcamentos_Item OI ON C.ItemId = OI.ItemId
WHERE (O.ID = Main.ID OR O.ObraPaiID = Main.ID) AND C.Data <= GETDATE() AND O.Tipo <> 'S') +

(SELECT ISNULL(SUM(af1.TMenosValorExec), 0) AS Valor

FROM COP_Autos af1
    INNER JOIN COP_Obras of1 ON af1.ObraID = of1.ID
WHERE (ObraID = Main.ID OR (of1.ObraPaiID = Main.ID AND of1.Tipo = 'C')) AND af1.Data <= GETDATE())) 
-
CONVERT(DECIMAL(19,2), (SELECT  
	ISNULL(SUM(A.TMenosValor), 0)
FROM COP_Autos A WITH (NOLOCK)
    INNER JOIN COP_Obras      O WITH (NOLOCK) ON O.ID = A.ObraID
    LEFT  JOIN Geral_Entidade E WITH (NOLOCK) ON E.EntidadeId = O.EntidadeIDA
    LEFT  JOIN (
        SELECT TOP 1 OCA.AutoID, OC.Codigo + '/' + CAST(OC.Numero AS VARCHAR(20)) AS CertCod
        FROM COP_ObraCertificacoes OC WITH (NOLOCK)
            INNER JOIN COP_ObraCertificacoesAutos OCA WITH (NOLOCK) ON OCA.ObraCertificacaoID = OC.ID
        WHERE OCA.Facturado = 1
        GROUP BY OCA.AutoID, OC.Codigo, OC.Numero
    ) AS C ON C.AutoID = A.ID
    LEFT  JOIN (
        SELECT LC.AutoID
        FROM LinhasCompras LC WITH (NOLOCK)
            INNER JOIN COP_Obras          OB  WITH (NOLOCK) ON OB.ID = LC.ObraID
            INNER JOIN CabecCompras       CC  WITH (NOLOCK) ON CC.Id = LC.IdCabecCompras
            INNER JOIN CabecComprasStatus CCS WITH (NOLOCK) ON CCS.IdCabecCompras = CC.Id
            LEFT  JOIN LinhasCompras      LCE WITH (NOLOCK) ON LCE.IDLinhaEstorno = LC.Id
        WHERE (OB.ID = Main.ID OR OB.ObraPaiID = Main.ID) AND OB.Tipo = 'S' AND LC.AutoID IS NOT NULL
            AND CCS.Anulado = 0 AND LC.IDLinhaEstorno IS NULL AND LCE.Id IS NULL AND LC.Quantidade <> 0 AND LC.PrecUnit <> 0
        GROUP BY LC.AutoID
    ) AS F ON F.AutoID = A.ID
WHERE (O.ID = Main.ID OR O.ObraPaiID = Main.ID) AND O.Tipo = 'S'))

AS PorFaturar

-- END POR FATURAR *******************************************************************************************************

FROM COP_Obras Main
LEFT OUTER JOIN Geral_Zona ON Main.ZonaID = Geral_Zona.ZonaId 
LEFT OUTER JOIN COP_FormaContratos ON Main.TipoCont = COP_FormaContratos.Tipo 
LEFT OUTER JOIN COP_TipoEmpreitadas ON Main.TipoEmp = COP_TipoEmpreitadas.Tipo 
LEFT OUTER JOIN COP_TipoPropostas ON Main.TipoProp = COP_TipoPropostas.Tipo 
LEFT OUTER JOIN COP_SituacoesObra ON Main.SituacaoID = COP_SituacoesObra.ID 
LEFT OUTER JOIN Geral_Entidade ON Main.EntidadeIDA = Geral_Entidade.EntidadeId 
LEFT JOIN V_Entidades ON Main.ERPTipoEntidadeA=V_Entidades.TipoEntidade AND Main.ERPEntidadeA=V_Entidades.Entidade 
LEFT OUTER JOIN COP_Obras O2 ON Main.ObraPaiID = O2.ID 
LEFT OUTER JOIN COP_TiposContratoAdicional T2 ON Main.TipoContratoAdicionalID = T2.ID 
LEFT OUTER JOIN COP_TipoObras ON Main.TipoObra = COP_TipoObras.Tipo 
LEFT OUTER JOIN COP_Empreitadas ON COP_Empreitadas.ID = Main.EmpreitadaID 
LEFT OUTER JOIN Geral_Entidade Geral_Entidade_1 ON Main.EntidadeIDB = Geral_Entidade_1.EntidadeId 
LEFT JOIN V_Entidades V_Entidades_B ON Main.ERPTipoEntidadeB=V_Entidades_B.TipoEntidade AND Main.ERPEntidadeB=V_Entidades_B.Entidade 
WHERE Main.Projecto=0  AND (Main.Tipo ='O')  AND (Main.Estado IN ('ADJU', 'CONS'))
ORDER BY Descricao ASC