*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    random

Resource    ..//Config/env.resource
Resource    ..//TestData/home_page_data.resource
Resource    ../Utilities/common_function.resource
Resource    ../Resources/header_navigation.resource
Resource    ../Resources/register_page.resource


*** Variables ***
${LOGIN_PAGE_TITLE_LOCATOR}    Your store. Login

${LOGIN_EMAIL_TEXTBOX_LOCATOR}    xpath://input[@id='Email']
${LOGIN_PASSWORD_TEXTBOX_LOCATOR}    id:Password
${LOGIN_BUTTON_LOCATOR}    xpath://button[@class='button-1 login-button']
${REGISTER_BUTTON_LOCATOR}    xpath://button[@class='button-1 register-button']

*** Keywords ***
Go To Login Page
    Maximize Browser Window
    Click Link    ${LOGIN_LINK_LOCATOR}

Login Page Should Appear
    ${title}=    Get Title 
    Should Be Equal As Strings    ${title}    ${LOGIN_PAGE_TITLE_LOCATOR}

Login To System Then Going To Home Page
    Maximize Browser Window
    Wait Until Element Is Visible    ${LOGO_LINK_LOCATOR}
    ${email}=    Register New Random User
    ${check_if_user_loged_in}    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGOUT_LINK_LOCATOR}
    IF  not ${check_if_user_loged_in}
        Click Link    ${LOGIN_LINK_LOCATOR}
        Input Text    ${LOGIN_EMAIL_TEXTBOX_LOCATOR}    ${email}
        Input Text    ${LOGIN_PASSWORD_TEXTBOX_LOCATOR}    ${PASSWORD_DEFAULT_DATA}
        Click Button    ${LOGIN_BUTTON_LOCATOR}
        Maximize Browser Window
    END
    Click Element    ${LOGO_LINK_LOCATOR}


