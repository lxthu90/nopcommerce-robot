*** Settings ***
Library     SeleniumLibrary
Library    DataDriver    ../TestData/data.csv
Resource    ..//Resources/register_page.resource
Test Template    Register New User With CSV
Test Setup    home_page.Go To Home Page
Test Teardown    Close All Browsers

*** Variables ***

*** Test Cases ***
Register New User In Many Scenarios
    Register New User Scenarios    ${title}    ${gender}   ${firstname}    ${lastname} ${dob_day}  ${dob_month}    ${dob_year}    ${email}  ${company}  ${password}    ${confirmPassword}

*** Keywords ***
Register New User With CSV
    [Arguments]    ${title}    ${gender}    ${firstname}  ${lastname}  ${dob_day}    ${dob_month}    ${dob_year}    ${email}  ${company}    ${password}    ${confirmPassword}
    Log To Console    ${title}
    Maximize Browser Window
    Click Link    ${REGISTER_LINK}
    Select Radio Button    ${GENDER_RADIO}    ${gender}
    Input Text    ${FIRST_NAME_TEXTBOX}    ${firstname}
    Input Text    ${LAST_NAME_TEXTBOX}    ${lastname}
    Select From List By Value    ${DOB_DAY_DROPDOWN}    ${dob_day}
    Select From List By Value    ${DOB_MONTH_DROPDOWN}    ${dob_month}
    Select From List By Value    ${DOB_YEAR_DROPDOWN}    ${dob_year}
    Input Text    ${EMAIL_TEXTBOX}    ${email}
    Input Text    ${COMPANY_TEXTBOX}      ${company}
    Input Text    ${PASSWORD_TEXTBOX}    ${password}
    Input Text    ${CONFIRM_PASSWORD_TEXTBOX}    ${password}
    Click Button    ${REGISTER_BUTTON}
    Close All Browsers