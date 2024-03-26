
SELECT 
	(SELECT Descricao FROM COP_Obras WHERE Id = ISNULL(Custos.ObraID, Previsao.ObraID)) as ObraID, 
	ISNULL(Previsao.ValorAdjCusto,0) as VlrAdjCusto, 
	ISNULL(Previsao.ValorAdjExec,0) as VlrAdjExec, 
	IsNull(Custos.ValorCusto,0) as VlrCusto, ISNULL(Custos.ValorExec,0) as VlrExec
FROM 
	(SELECT ObraID, IsNull(SubEmpid,-1) as SubEmpid, 
	SUM(ValorCusto) AS ValorCusto, 
	SUM(ValorExec) as ValorExec FROM COP_CustosClasse GROUP BY ObraID, IsNull(SubEmpid,-1)) Custos
		FULL OUTER JOIN (SELECT OO.ObraID, OI.OrcID, IsNull(OI.SubEmpid,-1) as SubEmpid, SUM(OI.PrecoCustoFormula * OI.Quant) as ValorAdjCusto, SUM(OI.PrecoExecFormula * OI.QuantExec) as ValorAdjExec
		FROM Orcamentos_Item OI 
			INNER JOIN Orcamentos_Orcamento OO ON OO.OrcID = OI.OrcID 
		WHERE 
		OO.PropostaBase = 1 AND OI.IsGroup = 0
		GROUP By OO.ObraID, OI.OrcID, IsNull(OI.SubEmpid,-1) ) Previsao
		ON Custos.ObraID = Previsao.ObraID AND Custos.SubEmpid = Previsao.SubEmpid
		LEFT OUTER JOIN Geral_SubEmpreitada S ON ISNULL(Custos.SubEmpid, Previsao.SubEmpid) = S.SubEmpId
		LEFT OUTER JOIN COP_Obras O ON O.ID = ISNULL(Custos.ObraID, Previsao.ObraID)
WHERE O.Tipo = 'S'


