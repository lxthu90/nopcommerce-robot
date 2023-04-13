*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    OperatingSystem

Resource    ..//Resources/header_navigation.resource
Resource    ..//Resources/home_page.resource
Resource    ..//Resources/categories_page.resource
Resource    ..//Constants/message_constant.resource
Resource    ../Utilities/web_locator.resource

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


${YES_OTPION_LOCATOR}    xpath://div[@class='product-review-item'][1]//div[@class='product-review-helpfulness']//span[@class='vote-options']/span[1]
${NO_OPTION_LOCATOR}    xpath://div[@class='product-review-item'][1]//div[@class='product-review-helpfulness']//span[@class='vote-options']/span[2]

${REVIEW_TITLE_ERROR_LOCATOR}    xpath://label[@for='AddProductReview_Title']/following-sibling::span[@class='field-validation-error']
${REVIEW_TEXT_ERROR_LOCATOR}    xpath://label[@for='AddProductReview_ReviewText']/following-sibling::span[@class='field-validation-error']
${LOGIN_REQUIRE_ERROR_LOCATOR}    xpath://div[@class='message-error validation-summary-errors']//li


${PRODUCT_REVIEW_TITLE_TEXT_LOCATOR}    //div[@class='product-review-list']//div[@class='title']//strong
${REVIEW_SUCCESSFULLY_LOCATOR}    //div[@class='page-body']//div[@class='result']
${REVIEW_PAGE_TITLE_LOCATOR}    xpath://div[@class='page-title']/h1
${FIRST_REVIEW_TITLE_LOCATOR}    //div[@class='review-item-head']//div[@class='review-title'][1]
${FIRST_REVIEW_TEXT_LOCATOR}    //div[@class='product-review-item'][1]//div[@class='review-text']
${QUESTION_LOCATOR}    //span[@class='question'][1]
${FIRST_VOTE_RESULT_LOCATOR}    xpath://div[@class='product-review-item'][1]//span[@class='result']

*** Keywords ***  
    
Verify The Form For Writing The Review
    Wait Until Element Is Visible    ${REVIEW_TITLE_LABEL_LOCATOR}
    Wait Until Element Is Visible    ${REVIEW_TITLE_TEXTBOX_LOCATOR}
    Wait Until Element Is Visible    ${REVIEW_TEXT_LABEL_LOCATOR}
    Wait Until Element Is Visible    ${REVIEW_TEXT_TEXTBOX_LOCATOR}
    Wait Until Element Is Visible    ${RATING_LABEL_LOCATOR}

Enter Valid Review 
    [Arguments]    ${review_title}    ${review_text}    ${rating}
    web_locator.Input Texts Into Field    ${REVIEW_TITLE_TEXTBOX_LOCATOR}    ${review_title}
    web_locator.Input Texts Into Field    ${REVIEW_TEXT_TEXTBOX_LOCATOR}    ${review_text}
    web_locator.Select Radio Button With Value    ${RATING_RADIO_BUTTON_LOCATOR}    ${rating}
    Set Global Variable    ${REVIEW_TITLE_GLOBAL}    ${review_title}
    Set Global Variable    ${REVIEW_TEXT_GLOBAL}    ${review_text}
    

Verify Review Information
    #Verify review is saved successfully
    ${expected_text}=    Get Text From    ${PRODUCT_REVIEW_TITLE_TEXT_LOCATOR}
    Should Be Equal As Strings    ${expected_text}    ${PRODUCT_REVIEW_TITLE_TEXT_MESSAGE}
    ${expected_text}=    Get Text From    ${REVIEW_SUCCESSFULLY_LOCATOR}
    Should Be Equal As Strings    ${expected_text}    ${REVIEW_SUCCESSFULLY_MESSAGE}


    ${title_text}=    Get Text From    ${REVIEW_PAGE_TITLE_LOCATOR}
    ${expected_text}=    Set Variable    Product reviews for ${PRODUCT_NAME_GLOBAL}
    Should Be Equal As Strings    ${expected_text}    ${title_text}

    ${expected_text}=    Get Text From    ${FIRST_REVIEW_TITLE_LOCATOR}
    Should Be Equal As Strings    ${expected_text}    ${REVIEW_TITLE_GLOBAL}
    
    ${expected_text}=    Get Text From    ${FIRST_REVIEW_TEXT_LOCATOR}
    Should Be Equal As Strings    ${expected_text}    ${REVIEW_TEXT_GLOBAL}
    
    ${expected_text}=    Get Text From    ${QUESTION_LOCATOR}
    Should Be Equal As Strings    ${expected_text}    ${QUESTION_TEXT_MESSAGE}
    Element Should Be Visible    ${YES_OTPION_LOCATOR}
    Element Should Be Visible    ${NO_OPTION_LOCATOR}

Submit Review
    web_locator.Click On Element    ${SUBMIT_BUTTON_LOCATOR}

Review Title Error Message Should Appear
    ${actual_error_text}=    Get Text From    ${REVIEW_TITLE_ERROR_LOCATOR}
    Should Be Equal As Strings    ${actual_error_text}          ${REVIEW_TITLE_ERROR_TEXT_MESSAGE}

Review Text Error Message Should Appear
    Wait Until Element Is Visible    ${REVIEW_TEXT_ERROR_LOCATOR}
    ${actual_error_text}=    Get Text    ${REVIEW_TEXT_ERROR_LOCATOR}
    Should Be Equal As Strings      ${actual_error_text}    ${REVIEW_TEXT_ERROR_TEXT_MESSAGE}

Verify Default Rating Option
    ${is_check}=    Get Element Attribute    ${EXCELLENT_OPTION_LOCATOR}    checked
    Should Be Equal    ${is_check}    true

Verify That User Is Unable To Review When Not Logged In
    Element Should Be Disabled    ${REVIEW_TITLE_TEXTBOX_LOCATOR}
    Element Should Be Disabled    ${REVIEW_TEXT_TEXTBOX_LOCATOR}
    Element Should Be Visible    ${LOGIN_REQUIRE_ERROR_LOCATOR}
    
User Votes Review As Yes
    Scroll Element Into View    ${YES_OTPION_LOCATOR}
    web_locator.Click On Element    ${YES_OTPION_LOCATOR}
    
User Votes Review As No
    web_locator.Click On Element    ${NO_OPTION_LOCATOR}

Verify That User Is Unable Vote Their Review
    ${expected_text}=    Get Text From    ${FIRST_VOTE_RESULT_LOCATOR}
    Should Be Equal As Strings     ${expected_text}       ${ERROR_VOTE_RESULT_MESSAGE}

Verify That User Is Able Vote Others Review
        Wait Until Element Is Visible    ${FIRST_VOTE_RESULT_LOCATOR}        
        ${expected_text}=    Get Text From    ${FIRST_VOTE_RESULT_LOCATOR}
        Should Be Equal As Strings     ${expected_text}       ${SUCCESS_VOTE_RESULT_MESSAGE}

Rating Section Should Appear Under Product Short Description
    ${is_first_review}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${FIRST_REVIEW_LINK_LOCATOR}
    IF    not ${is_first_review}
        Element Should Be Visible    ${ADD_REVIEW_LINK_LOCATOR}
    END

