*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    OperatingSystem

Resource    ..//Resources/header_navigation.resource
Resource    ..//Resources/home_page.resource

*** Variables ***
${PRODUCT_NAME_LOCATOR}    xpath://div[@class='product-name']/h1
${FIRST_REVIEW_LINK_LOCATOR}    xpath://a[text()='Be the first to review this product']
${ADD_REVIEW_LINK_LOCATOR}    xpath://a[text()='Add your review']

*** Keywords ***  
Be The First To Review Link Should Appear
    Element Should Be Visible    ${FIRST_REVIEW_LINK_LOCATOR}

Add Your Review Link Should Appear
    Element Should Be Visible    ${ADD_REVIEW_LINK_LOCATOR}

Go To Review Page
    #Go to review page when the product has no review
    ${check_key}    Run Keyword And Return Status    Wait Until Element Is Visible    ${FIRST_REVIEW_LINK_LOCATOR}
    IF    ${check_key}
        Click Link    ${FIRST_REVIEW_LINK_LOCATOR}
    END
    
    #Go to review page when the product has already reviewed
    ${check_key}    Run Keyword And Return Status    Wait Until Element Is Visible    ${ADD_REVIEW_LINK_LOCATOR}
    IF    ${check_key}
        Click Link    ${ADD_REVIEW_LINK_LOCATOR}
    END