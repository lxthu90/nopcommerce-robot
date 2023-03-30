*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

Resource    ..//Resources/header_navigation.resource

*** Variables ***
${WISHLIST_PAGE_TITLE}    Your store. Wishlist

*** Keywords ***  
Go To Wishlist Page
    Maximize Browser Window
    Click Link    ${WISHLIST_LINK_LOCATOR}
Register Page Should Appear
     ${title}=    Get Title 
     Should Be Equal As Strings    ${title}    ${WISHLIST_PAGE_TITLE}
