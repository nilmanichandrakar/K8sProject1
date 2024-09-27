*** Settings ***
Library    SeleniumLibrary
Suite Setup    Run Keywords    startSeleniumServer
...        AND   Get Web Driver Instance

*** Variables ***
${GRAFANA_URL}    http://localhost:3000

*** Test Cases ***
Validate Grafana Dashboard
    Open Browser    ${GRAFANA_URL}/d/DASHBOARD_ID    firefox
    Maximize Browser Window
    Capture Page Screenshot    dashboard_screenshot.png
    [Teardown]    Close Browser
