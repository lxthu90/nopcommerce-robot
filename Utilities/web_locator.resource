*** Settings ***

Library    SeleniumLibrary
Resource    ..//Resources/header_navigation.resource
Resource    ../Resources/register_page.resource



*** Variables ***

*** Keywords ***
Select Value Of Dropdown
    [Arguments]    ${dropbox_locator}    ${selected_value}
    Wait Until Element Is Visible    ${dropbox_locator}
    Select From List By Label    ${dropbox_locator}    ${selected_value}

Click On Element
    [Arguments]     ${element_locator}
    Wait Until Element Is Visible    ${element_locator}
    Click Element    ${element_locator}

Click On Link
    [Arguments]     ${link_locator}
    Wait Until Element Is Visible    ${link_locator}
    Click Element    ${link_locator}

Get Text From
    [Arguments]    ${locator}
    Wait Until Element Is Enabled    ${locator}
    ${text}=    Get Text    ${locator}
    [Return]    ${text}
    
Input Texts Into Field
    [Arguments]    ${field_locator}    ${texts}
    Wait Until Element Is Enabled    ${field_locator}
    Input Text    ${field_locator}    ${texts}

Get Placeholder Value Of Textbox
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    ${text}=    Get Element Attribute    ${locator}    placeholder
    [Return]    ${text}

Select Radio Button With Value
    [Arguments]    ${radio_button_locator}    ${selected_option}
    Wait Until Element Is Enabled    ${radio_button_locator}
    Select Radio Button    ${radio_button_locator}    ${selected_option}

Get Texts From List Of Locator
    [Arguments]    ${list_locator}
    Wait Until Element Is Visible    ${list_locator}
    ${texts}    Create List
    ${elements}    Get Web Elements    ${list_locator}
    FOR    ${element}    IN    @{elements}
        Log    ${element.text}
        Append To List    ${texts}    ${element.text}
    END
    [Return]    ${texts}