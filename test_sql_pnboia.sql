-- IMBITUBA (vital, 35, 30AGO; -28.3218 -48.6444; SPOT-30406R), ALCATRAZES (antares, 43, 06AGO; -24.1278 -45.6775) --> buoys e register_buoys
-- buoys --> status atual da boia (true ou false)


-- ABROLHOS
SELECT * FROM moored.buoys
WHERE name LIKE '%ABROLHOS%'  

SELECT * FROM moored.register_buoys
WHERE name LIKE '%ABROLHOS%'  
-- ORDER BY start_date DESC
ORDER BY id DESC


-- PECEM
SELECT * from moored.buoys
WHERE name LIKE '%PECEM%'

SELECT * FROM moored.register_buoys
WHERE name LIKE '%PECEM%'  
ORDER BY start_date DESC


-- ANTARTICA
SELECT * from moored.buoys
WHERE name LIKE '%KELLER%'

SELECT * FROM moored.register_buoys 
WHERE name LIKE '%KELLER%'
ORDER BY start_date DESC




SELECT * FROM adm.users
ORDER BY user_type

-- DELETE FROM adm.users
-- WHERE id = 9;


DELETE FROM moored.register_buoys
where id=288

