# CovidDataAnalysis
This project is about the analysis of sample data of COVID-19 cases as recorded from January 2019 to December, 2020.
## Project Overview
CovidDataAnalysis is a project that focuses on analyzing COVID-19 data stored in a PostgreSQL database. The project includes SQL queries for data analysis, a Python script (`extract_covid_data.py`) to connect to the database, download COVID-19 data, and load it into the database.
## Prerequisites
Before running the project, ensure you have the following prerequisites installed:
- PostgreSQL database
- Python 3.x
- pgAdmin 4 (optional, for visualizing query results)

## Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/your-username/CovidDataAnalysis.git
    cd CovidDataAnalysis
    ```

2. Install the required Python packages:

    ```bash
    pip install -r requirements.txt
    ```

3. Create a `.env` file in the project root directory with your database connection details. Example:

    ```env
    DB_HOST=your_database_host
    DB_PORT=your_database_port
    DB_NAME=your_database_name
    DB_USER=your_database_user
    DB_PASSWORD=your_database_password
    ```

## Usage

1. Execute the Python script to download and load COVID-19 data into the database:

    ```bash
    python extract_covid_data.py
    ```

2. Run the SQL queries located in the `.sql` file to perform data analysis on the COVID-19 data.

3. View the query results in pgAdmin 4 or your preferred PostgreSQL client.

## Output

The `output` folder contains screenshots of the query results when executed using pgAdmin 4.

## Additional Information

- The SQL queries for data analysis are located in `.sql`.
- Feel free to customize the queries or Python script according to your specific needs.


