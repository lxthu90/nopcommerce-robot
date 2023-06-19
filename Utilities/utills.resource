*** Settings ***
Library    SeleniumLibrary
Library    XML
Library    DatabaseLibrary


Resource    ..//resources/home_page.resource
Resource    ..//configs/env.resource
Resource    ..//database_connection/database_helper.resource

*** Variables ***

*** Keywords ***
Initialize Environment
    Open Browser    about:blank    ${BROWSER}
    Maximize Browser Window
    database_helper.Initialize DB Connection


Clean Up Environment
    Close All Browsers
    database_helper.Close DB Connection

Remove Character From List
    [Arguments]    ${list_texts}    ${character_tobe_removed}
    ${ouput_texts}    Create List
    FOR    ${text_in_list}    IN    @{list_texts}
        ${text_in_list}=    Remove String    ${text_in_list}    ${character_tobe_removed}
        ${ouput_texts}  Set Variable    ${ouput_texts}${text_in_list}        
    END
    [Return]    ${ouput_texts}

