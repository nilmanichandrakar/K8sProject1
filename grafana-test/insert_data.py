
import pymysql
import random
from datetime import datetime, timedelta

def insert_random_data(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME):
    connection = pymysql.connect(
        host=DB_HOST,
        user=DB_USER,
        password=DB_PASSWORD,
        database=DB_NAME,
        cursorclass=pymysql.cursors.DictCursor
    )

    cursor = connection.cursor()
    
    start_time = datetime.now()
    
    for i in range(180):
        temperature = random.uniform(-10, 40)  
        pressure = random.uniform(950, 1050)  
        
        sql = """
        INSERT INTO measurements (timestamp_utc, temperature, pressure)
        VALUES (%s, %s, %s)
        """
        timestamp = start_time + timedelta(seconds=i)
        
        cursor.execute(sql, (timestamp, temperature, pressure))
        connection.commit()
    
    cursor.close()

