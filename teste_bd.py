#!/usr/bin/python3
# -*- coding: utf-8 -*-

#!/usr/bin/env python
# -*- coding: utf-8 -*-


import psycopg2

try:
    connection = psycopg2.connect(
        user="remobs",
        password="Remobs@2020",
        host="18.230.154.85",
        port="5432",
        database="pnboia"
    )

    cursor = connection.cursor()
    cursor.execute("SELECT * FROM moored.register_buoys WHERE name LIKE '%ALCATRAZES%' ORDER BY start_date DESC;")
    records = cursor.fetchall()

    print("Dados retornados:", records)

except Exception as error:
    print("Erro ao conectar ao banco de dados:", error)

finally:
    if connection:
        cursor.close()
        connection.close()

