#!/usr/bin/env python
# coding: utf-8

# In[ ]:


get_ipython().system('pip install sqlalchemy')
get_ipython().system('pip install pymysql')


# ##### Downloading required packages

# In[ ]:


from sqlalchemy import create_engine,text
import pandas as pd
import logging

logging.basicConfig(level=logging.INFO)


# ##### Database connection establishment

# In[ ]:


username ='root'
password ='rootserver'
host='localhost'
port='3306'
database='socceranalysispy'

engine=create_engine(f'mysql+pymysql://{username}:{password}@{host}:{port}/{database}',echo=False)


# ##### Extract (ETL)

# In[ ]:


df1 = pd.read_csv('soccer_src1.csv', encoding='ISO-8859-1')
df2 = pd.read_csv('sockey_src2.csv', encoding='ISO-8859-1')
df3 = pd.read_csv('dim_date_table.csv', encoding='ISO-8859-1')
logging.info("Extracted data from all CSV files.")


# ##### Transform (ETL)

# In[ ]:


df1=df1.fillna('NA')
df2=df2.fillna('NA')

def clean_salary(value):
    try:
        value = str(value).replace('$', '').replace(',', '')
        return float(value)
    except:
        return None  

df1['salary'] = df1['salary'].apply(clean_salary)
df2['Net Worth'] = df2['Net Worth'].apply(clean_salary)

logging.info(" Cleaned and transformed data.")


# ##### Load (ETL)

# In[ ]:


df1.to_sql('soccer_src1', con=engine, if_exists='replace', index=False)
df2.to_sql('sockey_src2', con=engine, if_exists='replace', index=False)
df3.to_sql('dim_date_table', con=engine, if_exists='replace', index=False)

logging.info(" Loaded data into MySQL tables.")


# ##### Creation of dimention and fact tables

# In[ ]:


with open('trial.sql', 'r') as file:
    sql_script = file.read()

with engine.connect() as conn:
    for statement in sql_script.strip().split(';'):
        if statement.strip():
            conn.execute(text(statement.strip()))
    conn.commit()


# ##### Populating data into dimension and fact tables

# In[ ]:


with open('populating data.sql', 'r') as file:
    sql_script = file.read()

with engine.connect() as conn:
    for statement in sql_script.strip().split(';'):
        if statement.strip():
            conn.execute(text(statement.strip()))
    conn.commit()


# In[ ]:


query0 = """
SELECT *
FROM dim_player ;
"""
 
df_player = pd.read_sql_query(text(query0), con=engine)
df = pd.DataFrame(df_player)
df


# ##### Analytical reports

# In[ ]:


# 1. Player with maximum appearances in International matches
query0 = """
SELECT 
    fps.player_id,
    p.player_name,
    SUM(fps.appearances) AS Total_Appearances
FROM Fact_Player_Statistics fps
JOIN dim_player p ON fps.player_id = p.player_id
JOIN dim_matchtype m ON fps.matchtype_id = m.matchtype_id
WHERE m.match_name = 'International'
GROUP BY fps.player_id, p.player_name
ORDER BY Total_Appearances DESC;

"""
 
df_player = pd.read_sql_query(text(query0), con=engine)
df = pd.DataFrame(df_player)
df


# In[ ]:


# 2. Top 10 goal scorers of 2010
query1 = """
SELECT 
    fps.player_id,
    p.player_name,
    SUM(fps.goals_scored) AS Total_Goals
FROM fact_player_statistics fps
JOIN dim_player p ON fps.player_id = p.player_id
JOIN dim_time t ON fps.time_id = t.time_id
WHERE t.`Year` = 2010
GROUP BY fps.player_id, p.player_name
ORDER BY Total_Goals DESC
LIMIT 10;
"""

df_top = pd.read_sql_query(text(query1), con=engine)
df1 = pd.DataFrame(df_top)
df1


# In[ ]:


# 3. Top 5 players who got red card
query2 = """
SELECT 
    fps.player_id,
    p.player_name,
    SUM(fps.red_card) AS Total_Red_Cards
FROM fact_player_statistics fps
JOIN dim_player p ON fps.player_id = p.player_id
GROUP BY fps.player_id, p.player_name
ORDER BY Total_Red_Cards DESC
LIMIT 5;"""

df_top5 = pd.read_sql_query(text(query2), con = engine)
df2 = pd.DataFrame(df_top5)
df2


# In[ ]:


# 4. Top 5 successful clubs
query3 = """
SELECT 
    c.club_name,
    SUM(fts.wins) AS Total_Wins
FROM fact_team_statistics fts
JOIN dim_club c ON fts.club_id = c.club_id
GROUP BY c.club_name
ORDER BY Total_Wins DESC
LIMIT 5
OFFSET 1;"""

df_club = pd.read_sql_query(text(query3), con = engine)
df3 = pd.DataFrame(df_club)
df3


# ##### Exporting outputs to csv files

# In[ ]:


df.to_csv(r'E:\cts intern\soccer analysis\output reports\output5.csv', index = False)


# In[ ]:


df1.to_csv(r'E:\cts intern\soccer analysis\output2.csv', index = False)


# In[ ]:


df2.to_csv(r'E:\cts intern\soccer analysis\output3.csv', index = False)


# In[ ]:


df3.to_csv(r'E:\cts intern\soccer analysis\output4.csv', index = False)

