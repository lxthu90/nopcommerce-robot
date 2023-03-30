*** Settings ***
Library     SeleniumLibrary
Resource    ..//Resources/register_page.resource

#Suite Setup    Open Browser    chrome
#Suite Teardown    Close All Browsers

*** Test Cases ***
Register new user
    Go to RegisterPage
    Select Gender    M
    register_page.Enter Firsname    First
    register_page.Enter Lastname    Last
    register_page.Select Day of birth    10
    register_page.Select Month of birth    12
    register_page.Select Year of birth    1990
    register_page.Enter Email    abc12@gmail.com
    register_page.Enter Company    Nash
    register_page.Enter Password    123456
    register_page.Enter Confirm Password    123456
    register_page.Click Register
    register_page.Verify that Register Successfully
    Sleep    20

*** Keywords ***
