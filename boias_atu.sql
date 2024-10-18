--------------------------
-- boias para atualizar --
--------------------------

-- IMBITUBA:   29
-- ALCATRAZES: 27
-- ABROLHOS:   20 
-- NATAL:      39
-- PECEM:      41 -- sst none; nao está com as temperaturas em prof

SELECT * FROM moored.buoys
WHERE name LIKE '%PECEM%'


SELECT * FROM moored.register_buoys
WHERE name LIKE '%ABROLHOS%'
ORDER BY start_date DESC


SELECT * FROM moored.spotter_general where buoy_id=20
order by date_time DESC


SELECT * FROM quality_control.spotter --WHERE buoy_id =
order by buoy_id


SELECT * FROM inventory.hulls


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
-- VALUES (5, 20, {"miss_value": {"parameters": ["wtmp1", "wtmp2"], "limits": [[-9999, null], [-9999, null]]}, "gross_range": {"parameters": ["wtmp1", "wtmp2"], "limits": [[-5, 50], [-5, 50]]}, "fine_range": {"parameters": [ "wtmp1", "wtmp2"], "limits": [[0, 30], [0, 30]]}, "stuck_sensor": {"parameters": ["wtmp1", "wtmp2"], "limits": 7}, "t_continuity": {"parameters": ["wtmp1", "wtmp2"], "sigma": [8.6, 8.6], "limits": 3}});


SELECT * FROM quality_control.spotter
order by id desc
where buoy_id=41
-- INSERT INTO quality_control.spotter (id, buoy_id, qc_config)
-- VALUES (17, 20, NULL);


SELECT * FROM moored.spotter_smart_mooring_config
order by id
-- INSERT INTO moored.spotter_smart_mooring_config (id, buoy_id, sensor, depth)
-- VALUES (8, 41, 'wtmp1', 1);
-- INSERT INTO moored.spotter_smart_mooring_config (id, buoy_id, sensor, depth)
-- VALUES (9, 41, 'wtmp2', 10);
-- INSERT INTO moored.spotter_smart_mooring_config (id, buoy_id, sensor, depth)
-- VALUES (10, 41, 'wtmp3', 20);


select * from moored.spotter_general
WHERE date_time = '2022-12-15 16:37:02';


select * from qualified_data.spotter_smart_mooring_qualified
where buoy_id=41
LIMIT 10


select * from qualified_data.spotter_qualified where buoy_id=41
-- order by buoy_id DESC
order by date_time
limit 10


------------------------------------------------------------
-- DESCONTINUADA
-- select * from qualified_data.qualified_data --where buoy_id=41
-- order by buoy_id DESC
-- limit 10


select * from inventory.hulls order by hull_id



-- alerts config
select * from moored.alerts_config
order by buoy_id desc
-- INSERT INTO moored.alerts_config (id, buoy_id, position, transmission, transmission_gap, sensor_fail, high_values, low_values)
-- VALUES (38, 41, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE);


-- alerts
select * from moored.alerts
order by id desc
-- INSERT INTO moored.alerts (id, buoy_id, position, transmission, transmission_gap, sensor_fail, high_values, low_values)
-- VALUES (14, 41, 400, 6, 4, NULL, NULL, NULL);


SELECT * FROM moored.buoys
WHERE name LIKE '%ABROLHOS%'


SELECT * FROM moored.register_buoys
WHERE name LIKE '%ABROLHOS%'
ORDER BY start_date DESC


SELECT * FROM inventory.hulls
ORDER BY hull_id DESC


SELECT * FROM moored.spotter_general -- está dando erro quanto tenta colocar os dados aqui
where buoy_id=20
order by date_time desc


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


SELECT * FROM moored.parameters
order by id desc


SELECT * FROM qualified_data.qualified_data
where buoy_id=20


SELECT * FROM qualified_data.spotter_qualified
where buoy_id=20


SELECT * FROM moored.spotter_smart_mooring 
-- where buoy_id=20

SELECT * FROM qualified_data.spotter_smart_mooring_qualified
-- where buoy_id=20


select * from adm.users


----------------------------------------------------------------------------
-- abrolhos:20
-- pecem: 41
-- alcatrazes: 27
-- imbituba: 29
-- natal: 39

SELECT * FROM quality_control.spotter
order by buoy_id desc


SELECT * FROM moored.spotter_general
where buoy_id=39
order by date_time 


select * from qualified_data.spotter_qualified
where buoy_id=39
order by date_time 


select * from inventory.sensors
order by sensor_type