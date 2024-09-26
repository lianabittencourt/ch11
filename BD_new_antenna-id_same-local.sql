-- inserir boias com antenna_id novos, mas locais nos quais já foram lançadas anteriormente

-- verificar o hull_id atual filtrando pelo local de lançamento nas duas tabelas
-- exemplo para ABROLHOS
SELECT * from moored.buoys
WHERE name LIKE '%ABROLHOS%'

SELECT * from moored.register_buoys
WHERE name LIKE '%ABROLHOS%'


-- checar qual hull_id está disponivel (ordem crescente)
SELECT * FROM inventory.hulls 
ORDER BY hull_id


-- adicionar o novo hull_id com as info necessarias 
-- o que está abaixo é apenas um exemplo
INSERT INTO inventory.hulls (hull_id, type, brand, model, hull_number, condition, observation, diameter, weight, project_id)
VALUES (46, 'ONDOGRAFO', 'SOFAR', 'SPOTTER-V3', 'SPOT-30402R', 'OK', NULL, 0.42, 7.45, 2)


-- atualizar novos hull_id e antenna_id na planilha
-- https://docs.google.com/spreadsheets/d/1KMiFo1pHgZQTaxTEQN58_R866zd4cml-9zf0ipipnDs/edit?pli=1&gid=2015468458#gid=2015468458