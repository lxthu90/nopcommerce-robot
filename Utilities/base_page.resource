*** Settings ***
Library    SeleniumLibrary
Resource    ..//Config/env.resource
Resource    ..//TestData/home_page_data.resource
Resource    ..//TestData/header_navigation_data.resource
Resource    ../Utilities/utills.resource
Resource    ../Utilities/web_locator.resource

*** Variables ***
${PRICE_VALUE_LOCATOR}    xpath://span[@class='price actual-price']
@{ACTUAL_PRICE_VALUE_GLOBAL}
${CURRENCY_SYMBOL_GLOBAL}

*** Keywords ***

Get All Actual Prices Values In Current Page
    @{actual_price_list}    Create List
    ${prices}    Get WebElements    ${PRICE_VALUE_LOCATOR}
    FOR    ${price}    IN    @{prices}
        #Get full text of price
        ${price_value}    Set Variable    ${price.text}
        #Remove currecy symbol in price text
        ${price_value}    Set Variable    ${price.text}[1:]
        #Remove , character in price
        ${price_value}    Remove String    ${price_value}    ,
        #Convert to number
        ${price_value}    Convert To Number    ${price_value}
        #Add value to list
        Append To List    ${actual_price_list}    ${price_value}
        
    END
    Log Many    @{actual_price_list}
    Set Global Variable     @{ACTUAL_PRICE_VALUE_GLOBAL}    @{actual_price_list}
    Log Many    ${ACTUAL_PRICE_VALUE_GLOBAL}
    [Return]    @{ACTUAL_PRICE_VALUE_GLOBAL}

Get Current Currency Symbol
    Wait Until Element Is Visible    ${CURRENCY_DROPDOWN_LOCATOR}
    ${currency_symbol}=    Get Selected List Label    ${CURRENCY_DROPDOWN_LOCATOR}
    Set Global Variable    ${CURRENCY_SYMBOL_GLOBAL}        ${currency_symbol}

I Want To Verify That Price Is Exchanged Properly To
    [Arguments]    ${currency_symbol}
    home_page.Go To Home Page Without Logging In
    web_locator.Select Value Of Dropdown    ${CURRENCY_DROPDOWN_LOCATOR}    US Dollar
    base_page.Get All Actual Prices Values In Current Page
    web_locator.Select Value Of Dropdown    ${CURRENCY_DROPDOWN_LOCATOR}    ${currency_symbol}
    header_navigation.The Price Should Be Converted Corresponding To The Chosen Option