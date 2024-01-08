SELECT 
	COP_Obras.Codigo,
	COP_Obras.Descricao,
	CabecCompras.Documento, 
	CabecCompras.Serie, 
	CabecCompras.TipoDoc, 
	CabecCompras.NumDoc, 
	CabecCompras.DataDoc, 
	CabecCompras.Entidade, 
	CabecCompras.Nome, 
	CabecCompras.TotalMerc 
FROM 
	CabecCompras (NOLOCK),
	COP_Obras (NOLOCK)
WHERE 
	CabecCompras.ObraID = COP_Obras.Id
AND
	TipoDoc = 'AUTS' 
AND 
	CabecCompras.Id NOT IN (
		SELECT DISTINCT  
			L.IDCabecCompras AS IDOrigem

		FROM       LinhasCompras      L  (NOLOCK)
			INNER JOIN LinhasComprasTrans LT (NOLOCK) ON LT.IdLinhasComprasOrigem = L.Id
			INNER JOIN LinhasCompras      LD (NOLOCK) ON LD.Id = LT.IdLinhasCompras
			INNER JOIN CabecCompras       CD (NOLOCK) ON CD.Id = LD.IdCabecCompras
			INNER JOIN DocumentosCompra   D  (NOLOCK) ON CD.TipoDoc = D.Documento 
			INNER JOIN CabecComprasStatus CS (NOLOCK) ON CS.IdCabecCompras = CD.Id
	)