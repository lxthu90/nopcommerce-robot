*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${url}    https://demo.nopcommerce.com/


*** Keywords ***
InputLoginInformation
    Input Text    id:Email    username90
    Input Text    id:Password    123456


*** Test Cases ***
LoginTest
    Open Browser    ${url}   chrome
    Click Element    xpath://a[contains(text(),'Log in')]
    InputLoginInformation
    Click Button    xpath://a[contains(@href,'deprecated-list.html')]
    Close Browser