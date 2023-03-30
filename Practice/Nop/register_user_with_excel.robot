*** Settings ***
Library     SeleniumLibrary
Library    DataDriver    ../TestData/data.xlsx    sheet_name=Sheet1
Resource    ..//Resources/register_page.resource    
Test Template    Register New User With CSV

*** Variables ***


*** Test Cases ***
Register New User
    Register New User Scenarios    ${title}    ${gender}   ${firstname}    ${lastname} ${dob_day}  ${dob_month}    ${dob_year}    ${email}  ${company}  ${password}    ${confirmPassword}


*** Keywords ***
Register New User With CSV
    [Arguments]    ${title}    ${gender}    ${firstname}  ${lastname}  ${dob_day}    ${dob_month}    ${dob_year}    ${email}  ${company}    ${password}    ${confirmPassword}
    Log To Console    ${title}
    Go to RegisterPage
    Select Gender    ${gender}
    Enter Firsname    ${firstname}
    Enter Lastname    ${lastname}
    Select Day of birth    ${dob_day}
    Select Month of birth    ${dob_month}
    Select Year of birth    ${dob_year}
    Enter Email    ${email}
    Enter Company    ${company}
    Enter Password    ${password}
    Enter Confirm Password    ${confirmPassword}
    Click Register
    Close All Browsers


    