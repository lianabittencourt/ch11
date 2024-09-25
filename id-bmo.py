#!/home/pnboia1/.venv/bin/python
# source .venv/bin/activate

""" script para rodar o ID-BMO semestralmente

Ex: query_banco_pnboia.py {semester} {year} --> os dias e os meses sempre serão fixos"""

## libraries
import os
import sys
import argparse
import numpy as np
import pandas as pd
import psycopg2 as pg
from dotenv import load_dotenv
import matplotlib.pyplot as plt
from datetime import datetime, timedelta
import warnings
warnings.filterwarnings("ignore")


# importar variaveis de ambiente (criar arquivo .env na pasta home), importante para boas praticas de seguranca
load_dotenv()


## functions
def get_date_range(semester, year):
    """Função para pegar as datas inicial e final para cada semestre"""

    if semester   == 1:
        start_date = datetime(year, 1, 1)
        end_date   = datetime(year, 6, 30)
    elif semester == 2:
        start_date = datetime(year, 7, 1)
        end_date   = datetime(year, 12, 31)

    return start_date, end_date

def get_previous_semesters(semester, year):
    """Função para pegar o semestre atual e os 5 semestres anteriores"""

    semesters = []
    for _ in range(6):
        semesters.append((semester, year))
        if semester == 1:
            semester = 2
            year -= 1     # Subtrai o ano ao trocar de 1 para 2
        else:
            semester = 1  # Apenas troca o semestre sem alterar o ano

    return semesters

def calculate_availability(data, start_date, end_date):
    """Função para calcular a disponibilidade das boias"""

    # dias totais do semestre
    # total_days = (end_date - start_date).days + 1

    buoy_availability = {}

    # dias e % que a boia funcionou no semestre (a partir do momento que foi lançada)
    for _, row in data.iterrows():
        total_days       = (end_date.date() - row['min_date_time']).days
        days_operational = (row['max_date_time'] - row['min_date_time']).days + 1
        buoy_availability[row['name']] = days_operational / total_days * 100

    return sum(buoy_availability.values()) / len(buoy_availability)

def fetch_data(start_date, end_date):
    """Função para acessar os dados no BD"""

    ## conectando ao banco
    conn = pg.connect(database = os.getenv('PNBOIA_DB'),
                      host     = os.getenv('PNBOIA_HOST'),
                      user     = os.getenv('PNBOIA_USER'),
                      password = os.getenv('PNBOIA_PSW'),
                      port     = os.getenv('PNBOIA_PORT'))

    ## query para selecionar os dados
    query = f"SELECT * FROM get_operating_buoys('{start_date}', '{end_date}');"
    data  = pd.read_sql(query, conn)
    conn.close()

    ## pegando período min e max de funcionamento de cada boia
    data['min_date_time'] = pd.to_datetime(data['min_date_time'])
    data['max_date_time'] = pd.to_datetime(data['max_date_time'])

    ## Remover a parte da hora, mantendo apenas a data
    data['min_date_time'] = data['min_date_time'].dt.date
    data['max_date_time'] = data['max_date_time'].dt.date

    return data


def main(semester, year):
    semesters = get_previous_semesters(semester, year)
    availabilities = []

    for sem, yr in semesters:
        start_date, end_date = get_date_range(sem, yr)
        data = fetch_data(start_date, end_date)
        availability = calculate_availability(data, start_date, end_date)
        availabilities.append((f"{sem}ºSEM{yr}", availability))

    # Inverter a lista de availabilities
    availabilities.reverse()
    labels, values = zip(*availabilities)
    meta  = [50] * len(labels)
    x     = np.arange(len(labels))
    width = 0.35

    fig, ax = plt.subplots()

    # Barras de 'ID-BMO' (agora desenhadas primeiro)
    bars = ax.bar(x - width/2, values, width, label='ID-BMO', color='#003366')

    # Barras de 'META FIXA' (agora desenhadas depois)
    ax.bar(x + width/2, meta, width, label='META FIXA', color='#cc0000')

    # Adicionar os valores no topo de cada barra azul
    for bar in bars:
        height = bar.get_height()
        ax.text(bar.get_x() + bar.get_width()/2.0, height, f'{height:.2f}',
                ha='center', va='bottom', fontsize=10, fontweight='bold')

    # Ajustes de títulos e legendas
    ax.set_ylabel('Disponibilidade (%)', fontweight='bold', fontsize=15)
    ax.set_title('ID-BMO', fontweight='bold', fontsize=16)
    ax.set_xticks(x)
    ax.set_xticklabels(labels, fontweight='bold')
    ax.legend()

    plt.show()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Calcular o índice de disponibilidade das boias.")
    parser.add_argument("semester", type=int, choices=[1, 2], help="Semester (1 or 2)")
    parser.add_argument("year",     type=int, help="Year YYYY")

    args = parser.parse_args()
    main(args.semester, args.year)
