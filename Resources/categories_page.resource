*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    OperatingSystem

Resource    ..//Resources/header_navigation.resource
Resource    ..//Resources/home_page.resource
Resource    ..//Resources/product_details_page.resource

*** Variables ***
${CATEGORIES_LINK_LOCATOR}    xpath://*[contains(@class, 'block block-category-navigation')]/div/ul/li/a
${SUB_CATEGORIES_LINK_LOCATOR}    xpath://ul[(@class='sublist')]//li[(@class='inactive')]//a
${PRODUCT_LINK_LOCATOR}    xpath://h2[@class='product-title']/a
${PRODUCT_RATING_LOCATOR}    xpath://div[@class='rating']//div
    

${COMPUTERS_CATEGORY_LINK_LOCATOR}    //li[(@class='active last')]/a
${SOFTWARES_SUBCATEGORY_LINK_LOCATOR}    xpath://li[(@class='active last')]//li[(@class='inactive')]/a[text()='Software ']
${CELLPHONES_SUBCATEGORY_LINK_LOCATOR}
${OTHERS_SUBCATEGORY_LINK_LOCATOR}
${ACCESSORIES_SUBCATEGORY_LINK_LOCATOR}
${PRODUCT_NAME_GLOBAL}

*** Keywords ***  
Search And Go To Unreview Product - Draft
    Click Link    ${COMPUTER_MENU_LINK_LOCATOR}
    Wait Until Element Is Visible    ${COMPUTERS_CATEGORY_LINK_LOCATOR}
    @{categories}  Get WebElements  ${CATEGORIES_LINK_LOCATOR}
    @{link_list}    Create List

    FOR  ${category}  IN  @{categories}
        Wait Until Element Is Visible    ${category}
        ${url}=  get element attribute   ${category}  href
        Append To List        ${link_list}    ${url}
    END
    Log Many   @{link_list}

    
    @{sub_category_url}    Create List
    FOR    ${category_url}    IN    @{link_list}
        Go To    ${category_url}
        @{sub_categories}    Get WebElements    ${SUB_CATEGORIES_LINK_LOCATOR}
        FOR    ${sub_category}    IN    @{sub_categories}
            Wait Until Element Is Visible    ${sub_category}
            ${sub_category_link}=  get element attribute   ${sub_category}  href
            Append To List    ${sub_category_url}    ${sub_category_link}
        END            
    END
    
    

Open A Product Page And Get Product Name
    Wait Until Element Is Visible    ${DIGITAL_DOWNLOADS_MENU_LINK_LOCATOR}
    Click Link    ${DIGITAL_DOWNLOADS_MENU_LINK_LOCATOR}
    Wait Until Element Is Visible    ${PRODUCT_LINK_LOCATOR}
    Click Link    ${PRODUCT_LINK_LOCATOR}
    ${PRODUCT_NAME_GLOBAL}=    Get Text    ${PRODUCT_NAME_LOCATOR}
    Set Global Variable    ${PRODUCT_NAME_GLOBAL}


Open Unreview Product Page And Get Product Name
    Wait Until Element Is Visible    ${COMPUTER_MENU_LINK_LOCATOR}
    Click Link    ${COMPUTER_MENU_LINK_LOCATOR}
    Click Link    ${SOFTWARES_SUBCATEGORY_LINK_LOCATOR}
    Click Link    ${PRODUCT_LINK_LOCATOR}
    ${PRODUCT_NAME_GLOBAL}=    Get Text    ${PRODUCT_NAME_LOCATOR}
    Set Global Variable    ${PRODUCT_NAME_GLOBAL}
    Log     ${PRODUCT_NAME_GLOBAL}