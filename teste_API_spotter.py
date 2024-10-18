# Trecho de Código 1 - Requisição Simples
import requests
import sys
from datetime import datetime

endpoint      = 'qualified_data/spotter'
buoy_id       = sys.argv[1]
# buoy_id       = 41
token         = 'JXlFe-ybjfGGJgJRpKfa' # pass your user token here as a string
# start_date    = datetime(int(sys.argv[2]),int(sys.argv[3]),int(sys.argv[4]),0,0,0).strftime("%Y-%m-%dT%H:%M:%S") # use the datetime format YYYY-mm-ddTHH:MM:SS
start_date    = datetime(2024,10,16,0,0,0).strftime("%Y-%m-%dT%H:%M:%S") # use the datetime format YYYY-mm-ddTHH:MM:SS
end_date      = datetime(2024,10,18,0,0,0).strftime("%Y-%m-%dT%H:%M:%S")
response_type = 'json'

url  = f"http://dados.pnboia.org/v1/{endpoint}?buoy_id={buoy_id}&token={token}&start_date={start_date}&end_date={end_date}&response_type={response_type}"

data = requests.get(url).json()
print(data[-1]) # show the most recent retrieved data
# print(data) # show the most recent retrieved data
