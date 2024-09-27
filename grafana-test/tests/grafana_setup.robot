*** Settings ***
Library    RequestsLibrary
Resource    keywords.robot

*** Variables ***
${GRAFANA_URL}  http://localhost:3000
${API_KEY}    Bearer glsa_ZyajE3mnPsPiUMWIu7qFK5Gp7GXYqU4j_6d1e76e4
${DB_HOST}    mariadb-service
${DB_USER}    root
${DB_PASS}    password
${DB_NAME}    testdb
${DATASOURCE_URL}    /api/datasources
${DASHBOARD_URL}    /api/dashboards/db

*** Test Cases ***
Configure Grafana Data Source And Dashboard
    [Documentation]    @Author: Nilmani
    ...    This Test case will verify the creation of grafana datasource
    ...    and creation of grafana dashboard
    [Timeout]    5mins
    [Tags]    
    Create Grafana Data Source
    Create Grafana Dashboard
    Log    Grafana Datasource and dashboard created
