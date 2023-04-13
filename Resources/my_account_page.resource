*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

Resource    ..//Resources/header_navigation.resource
Resource    ../Utilities/web_locator.resource
Resource    ../Constants/message_constant.resource
*** Variables ***

*** Keywords ***  
Go To My Account Page
    web_locator.Click On Link    ${MY_ACCOUNT_LINK_LOCATOR}
My Account Page Should Appear
     ${title}=    Get Title 
     Should Be Equal As Strings    ${title}    ${MY_ACCOUNT_PAGE_TITLE}