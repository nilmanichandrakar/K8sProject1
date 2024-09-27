*** Settings ***
Library    DatabaseLibrary
Library    ../insert_data.py

*** Variables ***
${DB_NAME}    testdb
${DB_USER}    root
${DB_PASS}    password
# ${DB_HOST}    mariadb-service
${DB_HOST}    10.103.223.100
${DB_PORT}    3306

*** Test Cases ***
Insert Data Into MariaDB Table
    [Documentation]    @Author: Nilmani
    ...    This Test case will verify the database connection, data insertion into DB
    ...    and at last it will disconnect the Database
    [Timeout]    5 mins 
    [Tags]    TEST
    Connect To Database    pymysql   ${DB_NAME}    ${DB_USER}    ${DB_PASS}    ${DB_HOST}    ${DB_PORT}
    Insert Random Data   ${DB_HOST}    ${DB_USER}    ${DB_PASS}    ${DB_NAME}
    Disconnect From Database
    Log    Data Inserted into Database Successfully

