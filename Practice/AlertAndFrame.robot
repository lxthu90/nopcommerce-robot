*** Settings ***
Library    SeleniumLibrary
Library    XML

*** Variables ***
${browser}    chrome
${url}

*** Test Cases ***
TestingAlert
    #initialize variables value
    ${url}    Set Variable    https://testautomationpractice.blogspot.com/
    
    #ok
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Click Button    xpath://button[contains(text(),'Click Me')]
    Sleep    2
    #Handle Alert    Accept
    Alert Should Be Present    Press a button!    Accept
    Sleep    2

    #dismiss
    Click Button    xpath://button[contains(text(),'Click Me')]
    Sleep    2
    #Alert Should Be Present    Press a button!    Dismiss
    Handle Alert    Dismiss
    Sleep    2

    #leave
    Click Button    xpath://button[contains(text(),'Click Me')]
    Sleep    2
    #Alert Should Be Present    Press a button!    Leave
    Handle Alert    Leave
    Sleep    2

    Close Browser

TestingFrame
    #initialize variables value
    ${url}    Set Variable    https://www.selenium.dev/selenium/docs/api/java/index.html?overview-summary.html
    
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Select Frame    packageListFrame    #can use id, name or xpath
    Click Link    org.openqa.selenium.devtools
    Unselect Frame

    Select Frame    packageFrame
    Click Link    Command
    Unselect Frame

    Select Frame    classFrame
    Click Link  Index
    Unselect Frame

*** Keywords ***
