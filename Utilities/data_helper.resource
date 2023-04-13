*** Settings ***
Library    SeleniumLibrary
Resource    ..//Config/env.resource
Resource    ..//TestData/home_page_data.resource
Resource    ../Utilities/utills.resource
Resource    ../Resources/header_navigation.resource
Resource    ../Utilities/web_locator.resource
Resource    ..//TestData/header_navigation_data.resource



*** Keywords ***
Exchange Currency
    [Arguments]    ${amount}    ${to_currency}
        #get currency rate
        ${currency_rate}=    Get From Dictionary        ${CURRENCY_RATE_DATA}    ${to_currency}
        ${currency_rate}=    Convert To Number    ${currency_rate}
        
        #exchange price
        ${exchanged_value}  Evaluate    ${amount}*${currency_rate}
        ${exchanged_value}  Evaluate    round(${exchanged_value},2)
        [Return]    ${exchanged_value}