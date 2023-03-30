*** Settings ***
Library    SeleniumLibrary
Library    XML

*** Variables ***
${browser}    chrome
${url}    https://demo.nopcommerce.com/
${email_txt}
${password_txt}

*** Test Cases ***
TestingInputBox
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Title Should Be    nopCommerce demo store
    Click Link    xpath://a[contains(text(),'Log in')]

    ${email_txt}=    Set Variable    id=Email
    ${password_txt}=    Set Variable    id=Password

    Element Should Be Visible    ${email_txt}
    Element Should Be Enabled    ${email_txt}

    Input Text    ${email_txt}    username90
    Sleep    3
    Input Password    ${password_txt}    123456
    Sleep    3
    Close Browser

*** Keywords ***
