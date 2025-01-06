-- Query com perguntas e respostas 



-- Quais são os clientes e os veículos que eles possuem?

SELECT c.Nome AS Cliente, v.Placa AS Veículo, v.Modelo, v.Marca, v.Ano
FROM Cliente c
JOIN Veiculo v ON c.idCliente = v.Id_Cliente;

-- Quais ordens de serviço estão pendentes?

SELECT Numero_OS, Data_Emissao, Status
FROM OrdemServico
WHERE Status != 'Concluída';

-- Qual é o valor total de cada pedido de serviço (incluindo peças e serviços)?

SELECT o.Numero_OS, 
       SUM(IFNULL(p.Valor_Total_Item, 0)) + 
       SUM(IFNULL(s.Valor_Mao_de_Obra, 0)) AS Valor_Total
FROM OrdemServico o
LEFT JOIN Peca_OS p ON o.Numero_OS = p.Ordem_Servico_Numero_OS
LEFT JOIN Item_OS i ON o.Numero_OS = i.Ordem_Servico_Numero_OS
LEFT JOIN Servico s ON i.Servico_idServico = s.idServico
GROUP BY o.Numero_OS;

-- Quais mecânicos pertencem a uma determinada equipe?

SELECT m.Nome AS Mecanico, e.Nome AS Equipe
FROM Mecanico m
JOIN Equipe e ON m.Equipe_idEquipe = e.idEquipe
WHERE e.Nome = 'Equipe b'; 

-- Quantas ordens de serviço cada mecânico atendeu?

SELECT m.Nome AS Mecanico, COUNT(os.Numero_OS) AS Quantidade_Atendimentos
FROM Mecanico m
LEFT JOIN OrdemServico os ON m.idMecanico = os.Numero_OS 
GROUP BY m.idMecanico;

-- Quais peças foram usadas nas ordens de serviço realizadas em 2022?

SELECT p.Nome AS Peca, ps.Quantidade, ps.Valor_Total_Item, os.Data_Emissao
FROM Peca_OS ps
JOIN Peca p ON ps.Peca_idPeca = p.idPeca
JOIN OrdemServico os ON ps.Ordem_Servico_Numero_OS = os.Numero_OS
WHERE YEAR(os.Data_Emissao) = 2025;




