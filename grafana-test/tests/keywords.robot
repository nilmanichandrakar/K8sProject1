*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem

*** Variables ***
${GRAFANA_URL}  http://localhost:3000
${API_KEY}    Bearer glsa_ZyahdjdkflfjhfjflfjE3mnPsPiUMWIu7qjfkfFK5Gp7GXYqjdddhdU4j_6djfhfjf1e76e4
${DB_HOST}    mariadb-service
${DB_USER}    root
${DB_PASS}    password
${DB_NAME}    testdb
${DATASOURCE_URL}    /api/datasources
${DASHBOARD_URL}    /api/dashboards/db
${DASHBOARD_JSON}   dashboard.json

*** Keywords ***
Create Grafana Data Source
    [Documentation]    @Author: Nilmani
    ...    This keyword is used to create grafana Data source
    ...    It will send the POST request to create the data source in Grafana
    
    ${headers}=    Create Dictionary    Authorization=${API_KEY}    Content-Type=application/json
    Create Session    grafana    ${GRAFANA_URL}    headers=${headers}
    ${payload}=    Create Dictionary
    ...    name=MariaDB
    ...    type=mysql
    ...    url=${DB_HOST}:3306
    ...    access=proxy
    ...    database=${DB_NAME}
    ...    user=${DB_USER}
    ...    secureJsonData={"password": "${DB_PASS}"}

    POST On Session    grafana    ${DATASOURCE_URL}    json=${payload}    headers=${headers}

Create Grafana Dashboard
    [Documentation]    @Author: Nilmani
    ...    This keyword is used to create grafana Dashboard
    ${headers}=    Create Dictionary    Authorization=${API_KEY}    Content-Type=application/json
    ${dashboard_payload}=    Load JSON From File    ${DASHBOARD_JSON}

    POST On Session    grafana    ${DASHBOARD_URL}    json=${dashboard_payload}    headers=${headers}

Get Web Driver Instance
    [Arguments]    ${BROWSER}=firefox
    [Timeout]    10 minutes
    ${Selenium_Local}    getConfigurationValue    selenium_local
    log   '${Selenium_Local}'
    Run Keyword if     '${Selenium_Local}'=='${False}'    Check Selenium Hub is running and start
    ${webDriverStatus}    Run Keyword And Return Status    checkWebDriverAlive
    Return From Keyword If    ${webDriverStatus}
    FOR    ${retry}    IN RANGE    3
        ${getStatus}    ${WEB_DRIVER}    Run Keyword And Ignore Error    getDriverInstance    ${True}    WebBrowser
        ${webDriverStatus}    Run Keyword And Return Status    checkWebDriverAlive
        Exit For Loop If    ${webDriverStatus} and '${getStatus}' == 'PASS'
        Run Keyword If    not ${webDriverStatus}    startSeleniumServer
    END
    Should Be True    ${webDriverStatus} and '${getStatus}' == 'PASS'    Exceeded 3 times retry but could not get web driver instance!
    Set Global Variable    ${WEB_DRIVER}
