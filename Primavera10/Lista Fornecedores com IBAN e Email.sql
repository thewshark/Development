SELECT 
	Fornecedores.Fornecedor, 
	Fornecedores.Nome,
	(SELECT TOP 1 ContasBancariasTerc.IBAN FROM ContasBancariasTerc (NOLOCK) WHERE ContasBancariasTerc.Entidade = Fornecedores.Fornecedor AND ContasBancariasTerc.TipoEntidade = 'F') AS IBAN,
	(SELECT TOP 1 Contactos.Email FROM Contactos WHERE Contactos.Contacto = CONCAT('F', Fornecedores.Fornecedor)) AS Email

FROM 
	Fornecedores (NOLOCK)