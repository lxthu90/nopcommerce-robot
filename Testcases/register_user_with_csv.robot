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
    Click Link    ${REGISTER_LINK_LOCATOR}
    Select Radio Button    ${GENDER_RADIO_LOCATOR}    ${gender}
    Input Text    ${FIRST_NAME_TEXTBOX_LOCATOR}    ${firstname}
    Input Text    ${LAST_NAME_TEXTBOX_LOCATOR}    ${lastname}
    Select From List By Value    ${DOB_DAY_DROPDOWN_LOCATOR}    ${dob_day}
    Select From List By Value    ${DOB_MONTH_DROPDOWN_LOCATOR}    ${dob_month}
    Select From List By Value    ${DOB_YEAR_DROPDOWN_LOCATOR}    ${dob_year}
    Input Text    ${EMAIL_TEXTBOX_LOCATOR}    ${email}
    Input Text    ${COMPANY_TEXTBOX_LOCATOR}      ${company}
    Input Text    ${PASSWORD_TEXTBOX_LOCATOR}    ${password}
    Input Text    ${CONFIRM_PASSWORD_TEXTBOX_LOCATOR}    ${password}
    Click Button    ${REGISTER_BUTTON_LOCATOR}
    Close All Browsers