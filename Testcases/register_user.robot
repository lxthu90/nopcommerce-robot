*** Settings ***
Library     SeleniumLibrary
Library    DataDriver    ../TestData/register_new_user_data.csv
Resource    ..//Resources/register_page.resource
Resource    ../Utilities/web_locator.resource

Test Template    Register New User With CSV
Test Setup    home_page.Open Home Page
Test Teardown    Close All Browsers

*** Variables ***

*** Test Cases ***
Register New User In Many Scenarios
    Register New User Scenarios    ${title}    ${gender}   ${firstname}    ${lastname} ${dob_day}  ${dob_month}    ${dob_year}    ${email}  ${company}  ${password}    ${confirmPassword}

*** Keywords ***
Register New User With CSV
    [Arguments]    ${title}    ${gender}    ${firstname}  ${lastname}  ${dob_day}    ${dob_month}    ${dob_year}    ${email}  ${company}    ${password}    ${confirmPassword}
    Log To Console    ${title}
    Log To Console    ${REGISTER_LINK_LOCATOR}
    web_locator.Click On Link    ${REGISTER_LINK_LOCATOR}
    web_locator.Select Radio Button With Value    ${GENDER_RADIO_LOCATOR}    ${gender}
    web_locator.Input Texts Into Field    ${FIRST_NAME_TEXTBOX_LOCATOR}    ${firstname}
    web_locator.Input Texts Into Field    ${LAST_NAME_TEXTBOX_LOCATOR}    ${lastname}
    Select From List By Value    ${DOB_DAY_DROPDOWN_LOCATOR}    ${dob_day}
    Select From List By Value    ${DOB_MONTH_DROPDOWN_LOCATOR}    ${dob_month}
    Select From List By Value    ${DOB_YEAR_DROPDOWN_LOCATOR}    ${dob_year}
    web_locator.Input Texts Into Field    ${EMAIL_TEXTBOX_LOCATOR}    ${email}
    web_locator.Input Texts Into Field    ${COMPANY_TEXTBOX_LOCATOR}      ${company}
    web_locator.Input Texts Into Field    ${PASSWORD_TEXTBOX_LOCATOR}    ${password}
    web_locator.Input Texts Into Field    ${CONFIRM_PASSWORD_TEXTBOX_LOCATOR}    ${password}
    web_locator.Click On Element  ${REGISTER_BUTTON_LOCATOR}
