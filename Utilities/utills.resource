*** Settings ***
Library    SeleniumLibrary
Library    XML
Library    DatabaseLibrary


Resource    ..//Resources/home_page.resource
Resource    ..//Config/env.resource

*** Variables ***

*** Keywords ***
Remove Character From List
    [Arguments]    ${list_texts}    ${character_tobe_removed}
    ${ouput_texts}    Create List
    FOR    ${text_in_list}    IN    @{list_texts}
        ${text_in_list}=    Remove String    ${text_in_list}    ${character_tobe_removed}
        ${ouput_texts}  Set Variable    ${ouput_texts}${text_in_list}        
    END
    [Return]    ${ouput_texts}

Prepare Unreviewed Product
    Connect To Database  pyodbc     ${DBName}  ${DBUser}  ${DBPassword}  ${DBHost}  ${DBPort}
    Execute Sql String    Update [nop].[dbo].[Product] Set [ApprovedTotalReviews]=0
    Execute Sql String    Delete From [nop].[dbo].[ProductReview]  Where Title <> 'Some sample review'
    
Prepare Reviewed Product
    Connect To Database  pyodbc     ${DBName}  ${DBUser}  ${DBPassword}  ${DBHost}  ${DBPort}
    Execute Sql String    Update [nop].[dbo].[Product] Set [ApprovedTotalReviews]=5
