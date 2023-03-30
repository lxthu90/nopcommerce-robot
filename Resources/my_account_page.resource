*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

Resource    ..//Resources/header_navigation.resource

*** Variables ***
${MY_ACCOUNT_PAGE_TITLE}    Your store. Account

*** Keywords ***  
Go To My Account Page
    Maximize Browser Window
    Click Link    ${MY_ACCOUNT_LINK_LOCATOR}
My Account Page Should Appear
     ${title}=    Get Title 
     Should Be Equal As Strings    ${title}    ${MY_ACCOUNT_PAGE_TITLE}