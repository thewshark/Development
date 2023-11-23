select CONCAT('INSERT INTO Artigo (Artigo, Descricao, UnidadeVenda, UnidadeBase, Iva, MovStock, TipoArtigo) VALUES (','''',Artigo,'''',',','''', Descricao,'''',',','''', UnidadeVenda,'''',',','''', UnidadeBase,'''',',','''', Iva,'''',',','''', MovStock,'''',',','''', TipoArtigo,'''',')') from artigo where artigo not like 'MAT%' and artigo not like 'SUB%' and artigo not like 'EQP%' and artigo not like 'MAO%' and artigo not like 'REV%' and artigo not like 'TRP%' and artigo not like 'ART%' and artigo not like 'AUTO%'

select CONCAT('INSERT INTO Familias (Familia,Descricao,PermiteDevolucao) VALUES ','(''',Familia,'''',',','''',Descricao,'''',',','''',PermiteDevolucao,''')') from familias


select CONCAT('INSERT INTO SubFamilias (Familia,SubFamilia,Descricao,PermiteDevolucao) VALUES (','''',Familia,'''',',','''', SubFamilia,'''',',','''', Descricao,'''',',','''', PermiteDevolucao,'''',')') from SubFamilias

select CONCAT('INSERT INTO ArtigoMoeda (Artigo,Moeda,Unidade) VALUES (','''',Artigo,'''',',','''',Moeda,'''',',','''',Unidade,'''',')') from ArtigoMoeda where artigo not like 'MAT%' and artigo not like 'SUB%' and artigo not like 'EQP%' and artigo not like 'MAO%' and artigo not like 'REV%' and artigo not like 'TRP%' and artigo not like 'ART%' and artigo not like 'AUTO%'
