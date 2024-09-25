-- IMBITUBA (vital, 35, 30AGO; -28.3218 -48.6444), ALCATRAZES (antares, 43, 06AGO; -24.1278 -45.6775) --> buoys e register_buoys
-- buoys --> status atual da boia (true ou false)
-- colocar manutencao -> lancamento -> fundeada

SELECT * FROM moored.buoys -- status atual da boia
WHERE name LIKE '%IMBITUBA%' -- ID=29
-- WHERE name LIKE '%ALCATRAZES%'  -- ID=27

SELECT * FROM moored.register_buoys 
WHERE name LIKE '%IMBITUBA%' -- ID=29 
-- WHERE name LIKE '%ALCATRAZES%'  -- ID=27
ORDER BY start_date DESC

SELECT * FROM moored.register_buoys 
ORDER BY start_date DESC LIMIT 10

SELECT * FROM inventory.hulls ORDER BY hull_id

INSERT INTO inventory.hulls (hull_id, type, brand, model, hull_number, condition, observation, diameter, weight, project_id)
VALUES (44, 'ONDOGRAFO', 'SOFAR', 'SPOTTER-V3', 'SPOT-30406R', 'OK', NULL, 0.42, 7.45, 2)


SELECT * FROM institution.project ORDER BY id