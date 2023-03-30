*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

Resource    ..//Resources/header_navigation.resource

*** Variables ***
${SHOPPING_CART_PAGE_TITLE}    Your store. Shopping Cart

*** Keywords ***  
Go To Shopping Cart Page
    Maximize Browser Window
    Click Link    ${SHOPPING_CART_LINK_LOCATOR}
Shopping Cart Page Should Appear
     ${title}=    Get Title 
     Should Be Equal As Strings    ${title}    ${SHOPPING_CART_PAGE_TITLE}
