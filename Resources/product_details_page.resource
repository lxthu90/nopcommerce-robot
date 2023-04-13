*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    OperatingSystem

Resource    ..//Resources/header_navigation.resource
Resource    ..//Resources/home_page.resource
Resource    ../Utilities/web_locator.resource

*** Variables ***
${PRODUCT_NAME_LOCATOR}    xpath://div[@class='product-name']/h1
${FIRST_REVIEW_LINK_LOCATOR}    xpath://a[text()='Be the first to review this product']
${ADD_REVIEW_LINK_LOCATOR}    xpath://a[text()='Add your review']

*** Keywords ***  
Click On The First To Review Link
    Element Should Be Visible    ${FIRST_REVIEW_LINK_LOCATOR}
    Click On Link    ${FIRST_REVIEW_LINK_LOCATOR}

Click On Add Your Review Link
    Element Should Be Visible    ${ADD_REVIEW_LINK_LOCATOR}
    Click On Link    ${ADD_REVIEW_LINK_LOCATOR}
