import pandas as pd
import requests
from io import StringIO
import psycopg2
from sqlalchemy import create_engine
from dotenv import  dotenv_values
dotenv_values()


def get_database_conn():
    # Get database credentials from environment variable
    config = (dotenv_values('.env'))
    db_user_name = config.get('DB_USER_NAME')
    db_password =config.get('DB_PASSWORD')
    host = config.get('HOST')
    port = config.get('PORT')
    db_name =config.get('DB_NAME')
    conn = create_engine(f'postgresql+psycopg2://{db_user_name}:{db_password}@{host}:{port}/{db_name}')
    return conn

conn = get_database_conn()

def extract_csv_data(): 
    file_id = "1SzmRIwlpL5PrFuaUe_1TAcMV0HYHMD_b"
    url = f"https://drive.google.com/uc?id={file_id}"
    response = requests.get(url)
    covid_data = response.text
    df = pd.read_csv(StringIO(covid_data))
    df.columns = df.columns.str.lower()
    df.to_csv('raw/covid_19_data.csv', index = False)
    print('covid_19_data written successfully to csv file')
    
   
def load_to_db():
    data = pd.read_csv('raw/covid_19_data.csv')
    data.to_sql('covid_data', con =get_database_conn(), if_exists = 'replace', index = False)
    print('Data loaded successfully to postgres')


def main():
    extract_csv_data()
    load_to_db()
    
main()   