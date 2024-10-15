--------------------------
-- boias para atualizar --
--------------------------


-- PECEM
SELECT * FROM moored.buoys
WHERE name LIKE '%PECEM%'
-- formato do deploy_date:    2024-09-27
-- formato do last_date_time: 2024-09-27 09:34:39

SELECT * FROM moored.register_buoys
WHERE name LIKE '%PECEM%'
ORDER BY start_date DESC


-- ABROLHOS
SELECT * FROM moored.buoys
WHERE name LIKE '%ABROLHOS%'
-- formato do last_date_time: 2024-09-27 09:34:39

SELECT * FROM moored.register_buoys
WHERE name LIKE '%ABROLHOS%' -- buoy_id=20; hull_id=46
ORDER BY start_date DESC


-- delete from moored.register_buoys where id=302
SELECT * FROM moored.spotter_general where buoy_id=41 -- pecem: hull_id=30
order by date_time DESC

SELECT * FROM quality_control.spotter --WHERE buoy_id =
order by buoy_id



-- ALCATRAZES
SELECT * FROM inventory.hulls
where hull_id=46
WHERE model LIKE '%V3%'

-- where buoy_id=41
WHERE name LIKE '%PECEM%'

-- pecem: 16; smart mooring
-- abrolhos: 20


SELECT * FROM moored.register_buoys
WHERE name LIKE '%PECEM%'
ORDER BY start_date DESC


SELECT * FROM quality_control.spotter
order by buoy_id
-- INSERT INTO quality_control.spotter (id, buoy_id, qc_config)
-- VALUES (16, 41, NULL);

SELECT * FROM quality_control.spotter_smart_mooring -- buoy_id=20; hull_id=46
order by buoy_id
-- INSERT INTO quality_control.spotter_smart_mooring (id, buoy_id, qc_config)
-- VALUES (5, 20, NULL);

SELECT * FROM quality_control.spotter
order by id desc
where buoy_id=41
-- INSERT INTO quality_control.spotter (id, buoy_id, qc_config)
-- VALUES (17, 20, NULL);


SELECT * FROM moored.spotter_smart_mooring_config
order by id desc
-- INSERT INTO moored.spotter_smart_mooring_config (id, buoy_id, sensor, depth)
-- VALUES (11, 20, 'wtmp1', 16);
-- INSERT INTO moored.spotter_smart_mooring_config (id, buoy_id, sensor, depth)
-- VALUES (12, 20, 'wtmp2', 16);
-- INSERT INTO moored.spotter_smart_mooring_config (id, buoy_id, sensor, depth)
-- VALUES (13, 20, 'wtmp3', 16);


select * from moored.spotter_general
where buoy_id=20

select * from qualified_data.spotter_smart_mooring_qualified
where buoy_id=20


select * from qualified_data.spotter_qualified --where buoy_id=41
order by buoy_id DESC
limit 10

select * from qualified_data.qualified_data --where buoy_id=41
order by buoy_id DESC
limit 10




select * from inventory.hulls order by hull_id



-- alerts config
select * from moored.alerts_config
order by id desc

INSERT INTO moored.alerts_config (id, buoy_id, position, transmission, transmission_gap, sensor_fail, high_values, low_values)
VALUES (38, 41, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE);


-- alerts
select * from moored.alerts
order by id desc

-- INSERT INTO moored.alerts (id, buoy_id, position, transmission, transmission_gap, sensor_fail, high_values, low_values)
-- VALUES (14, 41, 400, 6, 4, NULL, NULL, NULL);


-- buoy_id=20; hull_id=46
SELECT * FROM moored.buoys
WHERE name LIKE '%ABROLHOS%'


SELECT * FROM moored.register_buoys
WHERE name LIKE '%ABROLHOS%'
ORDER BY start_date DESC
-- delete from moored.register_buoys where id=309

SELECT * FROM inventory.hulls
ORDER BY hull_id DESC

SELECT * FROM moored.spotter_general -- está dando erro quanto tenta colocar os dados aqui
where buoy_id=20


SELECT * FROM moored.spotter_smart_mooring_config
where buoy_id=20


SELECT * FROM quality_control.spotter
where buoy_id=20


SELECT * FROM moored.alerts_config
where buoy_id=20

SELECT * FROM moored.alerts
order by id desc
-- INSERT INTO moored.alerts (id, buoy_id, position, transmission, transmission_gap, sensor_fail, high_values, low_values)
-- VALUES (15, 20, 400, 6, 4, NULL, NULL, NULL);



SELECT * FROM qualified_data.qualified_data
where buoy_id=20

SELECT * FROM qualified_data.spotter_qualified
where buoy_id=20


SELECT * FROM moored.spotter_smart_mooring 
-- where buoy_id=20

SELECT * FROM qualified_data.spotter_smart_mooring_qualified
-- where buoy_id=20
