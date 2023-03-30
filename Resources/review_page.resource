*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    OperatingSystem

Resource    ..//Resources/header_navigation.resource
Resource    ..//Resources/home_page.resource
Resource    ..//Resources/categories_page.resource

*** Variables ***

${REVIEW_TITLE_LABEL_LOCATOR}    xpath://div[@class='inputs']/label[@for='AddProductReview_Title']
${REVIEW_TITLE_TEXTBOX_LOCATOR}    id:AddProductReview_Title
${REVIEW_TEXT_LABEL_LOCATOR}    xpath://div[@class='inputs']/label[@for='AddProductReview_ReviewText']
${REVIEW_TEXT_TEXTBOX_LOCATOR}    id:AddProductReview_ReviewText
${RATING_LABEL_LOCATOR}    xpath://div[@class='name-description']/label[@for='AddProductReview_Rating']
${SUBMIT_BUTTON_LOCATOR}    xpath://div[@class='buttons']/input[@name='add-review']    #changed
${RATING_RADIO_BUTTON_LOCATOR}    AddProductReview.Rating
${EXCELLENT_OPTION_LOCATOR}    xpath://input[@value=5]
${PAGE_TITLE_LOCATOR}    xpath://div[@class='page-title']

${PRODUCT_REVIEW_TITLE_TEXT_LOCATOR}    Existing reviews
${REVIEW_SUCCESSFULLY_MESSAGE_TEXT_LOCATOR}    Product review is successfully added.
${QUESTION_TEXT_LOCATOR}    Was this review helpful?
${YES_OTPION_LOCATOR}    xpath://div[@class='product-review-item'][1]//div[@class='product-review-helpfulness']//span[@class='vote-options']/span[1]
${NO_OPTION_LOCATOR}    xpath://div[@class='product-review-item'][1]//div[@class='product-review-helpfulness']//span[@class='vote-options']/span[2]

${REVIEW_TITLE_ERROR_LOCATOR}    xpath://label[@for='AddProductReview_Title']/following-sibling::span[@class='field-validation-error']
${REVIEW_TITLE_ERROR_TEXT_LOCATOR}    Review title is required.


${REVIEW_TEXT_ERROR_LOCATOR}    xpath://label[@for='AddProductReview_ReviewText']/following-sibling::span[@class='field-validation-error']
${REVIEW_TEXT_ERROR_TEXT_LOCATOR}    Review text is required.
${LOGIN_REQUIRE_ERROR_LOCATOR}    xpath://div[@class='message-error validation-summary-errors']//li


*** Keywords ***  
    
Verify The Form For Writing The Review
    Wait Until Element Is Visible    ${REVIEW_TITLE_LABEL_LOCATOR}
    Wait Until Element Is Visible    ${REVIEW_TITLE_TEXTBOX_LOCATOR}
    Wait Until Element Is Visible    ${REVIEW_TEXT_LABEL_LOCATOR}
    Wait Until Element Is Visible    ${REVIEW_TEXT_TEXTBOX_LOCATOR}
    Wait Until Element Is Visible    ${RATING_LABEL_LOCATOR}







Enter Valid Review And Verify Information
    [Arguments]    ${review_title}    ${review_text}    ${rating}
    Input Text    ${REVIEW_TITLE_TEXTBOX_LOCATOR}    ${review_title}
    Input Text    ${REVIEW_TEXT_TEXTBOX_LOCATOR}    ${review_text}
    Select Radio Button    ${RATING_RADIO_BUTTON_LOCATOR}    ${rating}
    
    #Submit review
    Click Button    ${SUBMIT_BUTTON_LOCATOR}
    Wait Until Element Is Visible    ${PAGE_TITLE_LOCATOR}
    
    #Verify review is saved successfully
    Page Should Contain    ${PRODUCT_REVIEW_TITLE_TEXT_LOCATOR}
    Page Should Contain    ${REVIEW_SUCCESSFULLY_MESSAGE_TEXT_LOCATOR}

    #${title_text}=    Get Text    xpath://div[@class='page-title']/h1
    Page Should Contain    Product reviews for ${PRODUCT_NAME_GLOBAL}
    
    Page Should Contain    ${review_title}
    Page Should Contain    ${review_text}
    Page Should Contain    ${QUESTION_TEXT_LOCATOR}
    Page Should Contain    ${QUESTION_TEXT_LOCATOR}
    Element Should Be Visible    ${YES_OTPION_LOCATOR}
    Element Should Be Visible    ${NO_OPTION_LOCATOR}


Leave Review Title And Review Text Blank And Click Submit
    Clear Element Text    ${REVIEW_TITLE_TEXTBOX_LOCATOR}
    Clear Element Text    ${REVIEW_TEXT_TEXTBOX_LOCATOR}
    Click Button    ${SUBMIT_BUTTON_LOCATOR}


Review Title Error Message Should Appear
    Wait Until Element Is Visible    ${REVIEW_TITLE_ERROR_LOCATOR}
    ${actual_error_text}=    Get Text    ${REVIEW_TITLE_ERROR_LOCATOR}
    Should Be Equal As Strings    ${actual_error_text}          ${REVIEW_TITLE_ERROR_TEXT_LOCATOR}

Review Text Error Message Should Appear
    Wait Until Element Is Visible    ${REVIEW_TEXT_ERROR_LOCATOR}
    ${actual_error_text}=    Get Text    ${REVIEW_TEXT_ERROR_LOCATOR}
    Should Be Equal As Strings      ${actual_error_text}    ${REVIEW_TEXT_ERROR_TEXT_LOCATOR}

Verify Default Rating Option
    ${is_check}=    Get Element Attribute    ${EXCELLENT_OPTION_LOCATOR}    checked
    Should Be Equal    ${is_check}    true

Verify That User Is Unable To Review When Not Logged In
    Element Should Be Disabled    ${REVIEW_TITLE_TEXTBOX_LOCATOR}
    Element Should Be Disabled    ${REVIEW_TEXT_TEXTBOX_LOCATOR}
    Element Should Be Visible    ${LOGIN_REQUIRE_ERROR_LOCATOR}


User Votes Review As Yes
    Click Element    ${YES_OTPION_LOCATOR}
    Sleep    1
    

User Votes Review As No
    Click Element    ${NO_OPTION_LOCATOR}
    Sleep    1


Rating Section Should Appear Under Product Short Description
    ${is_first_review}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${FIRST_REVIEW_LINK_LOCATOR}
    IF    not ${is_first_review}
        Element Should Be Visible    ${ADD_REVIEW_LINK_LOCATOR}
    END

