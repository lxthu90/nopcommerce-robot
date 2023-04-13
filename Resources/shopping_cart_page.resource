*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

Resource    ..//Resources/header_navigation.resource
Resource    ../Utilities/web_locator.resource
Resource    ..//Constants/message_constant.resource

*** Variables ***

*** Keywords ***  
Go To Shopping Cart Page
    web_locator.Click On Link    ${SHOPPING_CART_LINK_LOCATOR}
Shopping Cart Page Should Appear
     ${title}=    Get Title 
     Should Be Equal As Strings    ${title}    ${SHOPPING_CART_PAGE_TITLE}
