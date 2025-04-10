import os
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sqlalchemy import create_engine
from datetime import datetime, timedelta
from dotenv import load_dotenv
from loguru import logger
import argparse
import warnings
warnings.filterwarnings("ignore")

# Load environment variables
load_dotenv()

# Configure logger
logger.add("id-bmo_henrique.log", rotation="10 MB", level="INFO")

def get_date_range(semester, year):
    """Get date range for a specific semester"""
    if semester == 1:
        start_date = datetime(year, 1, 1)
        end_date = datetime(year, 6, 30)
    elif semester == 2:
        start_date = datetime(year, 7, 1)
        end_date = datetime(year, 12, 31)
    return start_date, end_date

def get_previous_semesters(semester, year):
    """Get the current semester and the 5 previous semesters"""
    semesters = []
    for _ in range(6):
        semesters.append((semester, year))
        if semester == 1:
            semester = 2
            year -= 1
        else:
            semester = 1
    return semesters

def calculate_availability(data, start_date, end_date):
    """Calculate buoy availability percentage"""
    logger.info(f"Raw data from database:\n{data}")

    buoy_availability = {}

    # Create database connection once
    engine = create_engine(f"postgresql://{os.getenv('PNBOIA_USER')}:{os.getenv('PNBOIA_PSW').replace('@', '%40')}@{os.getenv('PNBOIA_HOST')}:{os.getenv('PNBOIA_PORT')}/{os.getenv('PNBOIA_DB')}")

    for _, row in data.iterrows():
        # Calculate total possible days from min_date_time to end_date
        total_days = (end_date.date() - row['min_date_time'].date()).days

        # Calculate operational days by counting distinct days with data
        # Use BETWEEN operator to include both start and end dates
        query = f"""
            SELECT COUNT(DISTINCT(DATE(date_time))) as distinct_days
            FROM (
                SELECT buoy_id, date_time FROM moored.spotter_general
                UNION ALL
                SELECT buoy_id, date_time FROM moored.bmobr_general
                UNION ALL
                SELECT buoy_id, date_time FROM moored.criosfera_general
                UNION ALL
                SELECT buoy_id, date_time FROM moored.triaxys_general
            ) AS combined
            WHERE buoy_id = {row['buoy_id']}
                AND date_time BETWEEN '{row['min_date_time']}' AND '{end_date}'
        """

        with engine.connect() as conn:
            result = pd.read_sql(query, conn)
            days_operational = result.iloc[0]['distinct_days']

        logger.info(f"Buoy: {row['name']}")
        logger.info(f"  Total days in period: {total_days}")
        logger.info(f"  Operational days: {days_operational}")
        logger.info(f"  Availability: {(days_operational / total_days * 100):.2f}%")

        buoy_availability[row['name']] = days_operational / total_days * 100

    logger.info(f"Individual buoy availabilities: {buoy_availability}")
    overall_availability = sum(buoy_availability.values()) / len(buoy_availability)
    logger.info(f"Overall average availability: {overall_availability:.2f}%")

    return overall_availability

def fetch_buoy_data(start_date, end_date):
    """Fetch buoy data from the database"""
    logger.info(f"Fetching buoy data for period: {start_date} to {end_date}")

    # Create database connection string
    db_url = f"postgresql://{os.getenv('PNBOIA_USER')}:{os.getenv('PNBOIA_PSW').replace('@', '%40')}@{os.getenv('PNBOIA_HOST')}:{os.getenv('PNBOIA_PORT')}/{os.getenv('PNBOIA_DB')}"

    # Create SQLAlchemy engine
    engine = create_engine(db_url)
    logger.info("Connected to the database")

    # Step 1: Get distinct buoy IDs
    query_buoy_ids = f"""
        SELECT DISTINCT(buoy_id)
        FROM (
            SELECT buoy_id, date_time FROM moored.spotter_general
            UNION ALL
            SELECT buoy_id, date_time FROM moored.bmobr_general
            UNION ALL
            SELECT buoy_id, date_time FROM moored.criosfera_general
            UNION ALL
            SELECT buoy_id, date_time FROM moored.triaxys_general
        ) AS combined
        WHERE date_time BETWEEN '{start_date}' AND '{end_date}'
        AND buoy_id NOT IN (31, 32);
    """

    with engine.connect() as conn:
        buoy_ids_df = pd.read_sql(query_buoy_ids, conn)
        buoy_ids = ','.join(map(str, buoy_ids_df['buoy_id'].tolist()))
        logger.info(f"Found buoy IDs: {buoy_ids}")

        # Step 2: Get buoy names and min_date_time
        query_buoy_names = f"""
            SELECT
                combined.buoy_id,
                mb.name,
                MIN(combined.date_time) as min_date_time
            FROM (
                SELECT buoy_id, date_time FROM moored.spotter_general
                UNION ALL
                SELECT buoy_id, date_time FROM moored.bmobr_general
                UNION ALL
                SELECT buoy_id, date_time FROM moored.criosfera_general
                UNION ALL
                SELECT buoy_id, date_time FROM moored.triaxys_general
            ) AS combined
            JOIN
                moored.buoys AS mb
            ON
                combined.buoy_id = mb.buoy_id
            WHERE
                combined.date_time BETWEEN '{start_date}' AND '{end_date}'
                AND combined.buoy_id IN ({buoy_ids})
            GROUP BY
                combined.buoy_id, mb.name;
        """
        data = pd.read_sql(query_buoy_names, conn)

    logger.info("Fetched and processed buoy data successfully")
    return data

def main(semester, year):
    semesters = get_previous_semesters(semester, year)
    availabilities = []

    for sem, yr in semesters:
        start_date, end_date = get_date_range(sem, yr)
        logger.info(f"\nProcessing semester {sem} of year {yr}")
        logger.info(f"Date range: {start_date} to {end_date}")

        data = fetch_buoy_data(start_date, end_date)
        availability = calculate_availability(data, start_date, end_date)
        availabilities.append((f"{sem}ºSEM{yr}", availability))

        logger.info(f"Current semester availability: {availability:.2f}%")
        logger.info(f"Current availabilities list: {availabilities}")

    # Reverse the availabilities list
    availabilities.reverse()
    logger.info(f"Final availabilities list (reversed): {availabilities}")
    labels, values = zip(*availabilities)
    meta = [50] * len(labels)
    x = np.arange(len(labels))
    width = 0.35

    fig, ax = plt.subplots()

    # ID-BMO bars (drawn first)
    bars = ax.bar(x - width/2, values, width, label='ID-BMO', color='#003366')

    # Fixed META bars (drawn after)
    #ax.bar(x + width/2, meta, width, label='META FIXA', color='#cc0000')
    ax.axhline(50, color='red', linestyle='dashed', linewidth=1.5)

    # Add values on top of each blue bar
    for bar in bars:
        height = bar.get_height()
        ax.text(bar.get_x() + bar.get_width()/2.0, height, f'{height:.2f}',
                ha='center', va='bottom', fontsize=10, fontweight='bold')

    # Adjust titles and legends
    ax.set_ylabel('Disponibilidade (%)', fontweight='bold', fontsize=15)
    ax.set_title('ID-BMO', fontweight='bold', fontsize=16)
    ax.set_xticks(x)
    ax.set_xticklabels(labels, fontweight='bold')
    ax.legend()

    plt.show()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Calcular o índice de disponibilidade das boias.")
    parser.add_argument("semester", type=int, choices=[1, 2], help="Semester (1 or 2)")
    parser.add_argument("year", type=int, help="Year YYYY")

    args = parser.parse_args()
    main(args.semester, args.year)
