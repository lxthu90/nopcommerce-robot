*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

Resource    ..//Resources/header_navigation.resource
Resource    ../Utilities/web_locator.resource
Resource    ..//Constants/message_constant.resource

*** Variables ***

*** Keywords ***  
Go To Wishlist Page
    web_locator.Click On Link    ${WISHLIST_LINK_LOCATOR}
Register Page Should Appear
     ${title}=    Get Title 
     Should Be Equal As Strings    ${title}    ${WISHLIST_PAGE_TITLE}
