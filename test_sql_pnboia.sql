-- IMBITUBA (vital, 35, 30AGO; -28.3218 -48.6444; SPOT-30406R), ALCATRAZES (antares, 43, 06AGO; -24.1278 -45.6775) --> buoys e register_buoys
-- buoys --> status atual da boia (true ou false)


SELECT * FROM moored.buoys         -- status atual da boia
-- WHERE name LIKE '%IMBITUBA%'    -- ID=29
-- WHERE name LIKE '%ALCATRAZES%'  -- ID=27 
WHERE antenna_id LIKE '%30362%'  

SELECT * from moored.buoys
WHERE name LIKE '%PECEM%'

SELECT * FROM moored.register_buoys 
-- WHERE name LIKE '%IMBITUBA%' -- ID=29 
WHERE name LIKE '%KELLER%'      -- ID=27
ORDER BY start_date DESC


SELECT * FROM inventory.hulls ORDER BY hull_id

-- INSERT INTO inventory.hulls (hull_id, type, brand, model, hull_number, condition, observation, diameter, weight, project_id)
-- VALUES (46, 'ONDOGRAFO', 'SOFAR', 'SPOTTER-V3', 'SPOT-30405R', 'OK', NULL, 0.42, 7.45, 2)



SELECT * FROM adm.users
ORDER BY user_type

-- DELETE FROM adm.users
-- WHERE id = 9;



SELECT * FROM moored.register_buoys
-- WHERE EXTRACT(YEAR FROM start_date) IN (2023, 2024)
WHERE EXTRACT(YEAR FROM end_date) IN (2023, 2024)
AND mode LIKE '%FUNDEADA%';


SELECT * FROM moored.buoys
WHERE name LIKE '%CABO%'
ORDER BY start_date

