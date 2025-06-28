"Built a Python-based ETL pipeline using pandas and SQLAlchemy to clean, transform, and load data from raw CSV files into a MySQL database, forming a dimensional star schema. Exported analytical outputs and visualized them using Power BI. Included basic logging and modular script structure."
-------------------------------------------------------------------------------------------------------------------------------
🛠 TECH STACK:
| Layer         | Tool/Technology           |
| ------------- | ------------------------- |
| Source Data   | CSV files (3)             |
| Data Cleaning | Python (pandas)           |
| DBMS          | MySQL                     |
| ORM           | SQLAlchemy                |
| Data Modeling | Star Schema               |
| Visualization | Power BI                  |
| IDEs          | Jupyter Notebook          |

------------------------------------------------------------------------------------------------------------------------------
DATA SOURCES:
=> DIM.DATE.Table.csv
=> soccer_src1.csv
=> sockey_src2.csv
You can view these files under the folder raw data.

------------------------------------------------------------------------------------------------------------------------------
STEP-BY-STEP PROCESS:
1. ETL PROCESS:
Extracted the raw data from csv files using python.
Performed cleaning operations on the data by using pandas.
Loaded the transformed data into MySQL database using SQLAlchemy connector.
Refer the 'python script' folder for basic ETL scripts and database connection code.

2. DATABASE MODELLING:
Since the raw data was from an OLTP database, 'dimensional modelling' was performed to obtain the required star schema.
Defined all the dimension tables(dim_league, dim_club, dim_country, dim_time, dim_matchtype, dim_player) and fact tables(fact_player_statistics, fact_team_statistics)
along with their attributes and relationships.
To get a better understanding of relationships refer the '.docx' file in 'Data modelling' folder.
With help of reverse engineering in MySQL workbench generated an EER diagram which is also attached in 'Data modelling' folder.

3. DATA INSERTION INTO MySQL:
The tables creation and insertion of data is done by python and sql scripts respectively.
SQLAlchemy is used for connecting Python => MySQL workbench

4. ANALYTICAL QUERYING:
Executed key business logical queries in SQL and python.
Exported the results as CSV using pandas.

5.VISUALIZATION:
Used PowerBI to visualize the analytical results.
Created a dashboard to deliver the business insights effectively.
Download the '.pbix' into your system to view the dashboard.

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ANALYTICAL QUESTIONS ANSWERED:
| # | Question                                                       |
| - | -------------------------------------------------------------- |
| 1 | Which player has maximum appearances in international matches? |
| 2 | Who were top 10 goal scorers in year 2010?                     |
| 3 | Top 5 players who got red card?                                |
| 4 | What are the top 5 successful clubs?                           |
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
REQUIREMENTS:
pandas
sqlalchemy
logging
jupyterlab
notebook
microsoft powerbi

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




