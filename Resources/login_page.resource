*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    random

Resource    ..//configs/env.resource
Resource    ..//TestData/home_page_data.resource
Resource    ../Utilities/utills.resource
Resource    ../Resources/header_navigation.resource
Resource    ../Resources/register_page.resource
Resource    ../Utilities/web_locator.resource
Resource    ..//Constants/message_constant.resource


*** Variables ***
${LOGIN_EMAIL_TEXTBOX_LOCATOR}    xpath://input[@id='Email']
${LOGIN_PASSWORD_TEXTBOX_LOCATOR}    id:Password
${LOGIN_BUTTON_LOCATOR}    xpath://input[@value='Log in']    #changed
${REGISTER_BUTTON_LOCATOR}    xpath://input[@value='Register']    #changed

*** Keywords ***
Go To Login Page
    web_locator.Click On Link    ${LOGIN_LINK_LOCATOR}

Login Page Should Appear
    ${title}=    Get Title 
    Should Be Equal As Strings    ${title}    ${LOGIN_PAGE_TITLE_LOCATOR}

Login To System
    Wait Until Element Is Visible    ${LOGO_LINK_LOCATOR}
    ${email}=    Register New Random User
    ${check_if_user_loged_in}    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGOUT_LINK_LOCATOR}
    IF  not ${check_if_user_loged_in}
        web_locator.Click On Link    ${LOGIN_LINK_LOCATOR}
        web_locator.Input Texts Into Field    ${LOGIN_EMAIL_TEXTBOX_LOCATOR}    ${email}
        web_locator.Input Texts Into Field    ${LOGIN_PASSWORD_TEXTBOX_LOCATOR}    ${PASSWORD_DEFAULT_DATA}
        web_locator.Click On Element    ${LOGIN_BUTTON_LOCATOR}
    END
    web_locator.Click On Link    ${LOGO_LINK_LOCATOR}
    
    
