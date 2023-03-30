*** Settings ***
Library    SeleniumLibrary
Library    XML
Library    DatabaseLibrary


Resource    ..//Resources/home_page.resource

*** Variables ***
${PRICE_VALUE}    xpath://span[@class='price actual-price']

${DBName}  nop
${DBUser}  thu
${DBPassword}  Nashtech1@
${DBHost}  VNLAP5CD1355B6X
${DBPort}  1443


*** Keywords ***

Verify Element Type
    [Arguments]    ${locator}    ${type}
    Get Element Attribute    ${locator}    ${type}

Get Placeholder Value Of Textbox
    [Arguments]    ${locator}
    ${text}=    Get Element Attribute    ${locator}    placeholder
    [Return]    ${text}

Get Texts From List
    [Arguments]    ${list_locator}
    ${texts}    Create List
    ${elements}    Get Web Elements    ${list_locator}
    FOR    ${element}    IN    @{elements}
        Log    ${element.text}
        Append To List    ${texts}    ${element.text}
    END
    [Return]    ${texts}

Remove Character From List
    [Arguments]    ${list_texts}    ${character_tobe_removed}
    ${ouput_texts}    Create List
    FOR    ${text_in_list}    IN    @{list_texts}
        ${text_in_list}=    Remove String    ${text_in_list}    ${character_tobe_removed}
        ${ouput_texts}    Set Variable    ${ouput_texts}${text_in_list}        
    END
    [Return]    ${ouput_texts}

Get All Actual Prices Values
    @{price_list}    Create List
    ${prices}    Get WebElements    ${PRICE_VALUE}
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
        Append To List    ${price_list}    ${price_value}
        
    END
    Log Many    @{price_list}
    [Return]    @{price_list}


Delete Rating Review In DB
    Connect To Database    dbConfigFile=./Resources/db.cfg

