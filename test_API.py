# Trecho de Código 1 - Requisição Simples
import requests
from datetime import datetime

endpoint      = 'qualified_data/pnboia'
buoy_id       = 10
token         = 'JXlFe-ybjfGGJgJRpKfa' # pass your user token here as a string
start_date    = datetime(2012,1,1,0,0,0).strftime("%Y-%m-%dT%H:%M:%S") # use the datetime format YYYY-mm-ddTHH:MM:SS
end_date      = datetime(2012,1,30,0,0,0).strftime("%Y-%m-%dT%H:%M:%S")
response_type = 'json'

url = f"http://dados.pnboia.org/v1/{endpoint}?buoy_id={buoy_id}&token={token}&start_date={start_date}&end_date={end_date}&response_type={response_type}"
data = requests.get(url).json()
print(data[-1]) # show the most recent retrieved data
