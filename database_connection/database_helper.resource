*** Settings ***
Library    SeleniumLibrary
Library    DatabaseLibrary
Library    Telnet

Resource    ..//configs/env.resource


*** Variables ***


*** Keywords ***
Initialize DB Connection
    Connect To Database  pyodbc     ${DBName}  ${DBUser}  ${DBPassword}  ${DBHost}  ${DBPort}

Close DB Connection
    Close All Connections