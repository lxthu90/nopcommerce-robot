*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Resource    ..//Config/env.resource
Resource    ..//TestData/home_page_data.resource
Resource    ../Utilities/common_function.resource
Resource    ../Resources/header_navigation.resource


*** Variables ***
${SLIDER_LOCATOR}    xpath://div[@class='nivo-controlNav']
${WELCOME_HEADER_LOCATOR}    xpath://div[@class='topic-block-title']//h2
${WELCOME_CONTENT_LOCATOR}    xpath://div[@class='topic-block-body']
${DOCUMENT_LINK_LOCATOR}    xpath://div[@class='topic-block-body']//a[text()='Documentation']
${FORUM_LINK_LOCATOR}    xpath://div[@class='topic-block-body']//a[text()='Forums']
${NOPCOMMERCE_LINK_LOCATOR}    xpath://div[@class='topic-block-body']//a[text()='nopCommerce.com']

${ELECTRONICS_LINK_LOCATOR}    xpath://h2[@class='title']//a[text()=' Electronics ']
${APPAREL_LINK_LOCATOR}    xpath://h2[@class='title']//a[text()=' Apparel ']
${DIGITAL_DOWNLOADS_LINK_LOCATOR}    xpath://h2[@class='title']//a[text()=' Digital downloads ']
${ELECTRONICS_IMAGE_LOCATOR}    xpath://img[@alt='Picture for category Electronics']
${APPAREL_IMAGE_LOCATOR}    xpath://img[@alt='Picture for category Apparel']
${DIGITAL_IMAGE_LOCATOR}    xpath://img[@alt='Picture for category Digital downloads']

${FEATURE_PRODUCTS_LOCATOR}    xpath://div[@class='product-grid home-page-product-grid']//div[@class='item-box']
${PRODUCT_NAME_LINKS_LOCATOR}    //h2[@class='product-title']//a
${ADD_TO_CART_BUTTONS_LOCATOR}           //input[@class='button-2 product-box-add-to-cart-button']    #changed
${ADD_TO_COMPARE_LIST_BUTTONS_LOCATOR}   //input[@class='button-2 add-to-compare-list-button']    #changed
${ADD_TO_WISHLIST_BUTTONS_LOCATOR}       //input[@class='button-2 add-to-wishlist-button']    #changed

${NEWS_ITEMS_LOCATOR}    xpath://div[@class='news-items']//div[@class='news-item']
${NEWS_TITLE_LINK_LOCATORS}    //div[@class='news-head']
${DETAILS_BUTTONS_LOCATOR}    //a[@class='read-more']
${VIEW_NEWS_ARCHIVE_BUTTONS_LOCATOR}    //a[text()='View News Archive']

${POLL_OPTIONS_LOCATOR}    xpath://ul[@class='poll-options']//li
${EXCELLENT_RADIO_BUTTON_LOCATOR}    (//li[@class='answer']//input)[1]
${GOOD_RADIO_BUTTON_LOCATOR}    (//li[@class='answer']//input)[2]    
${POOR_RADIO_BUTTON_LOCATOR}    (//li[@class='answer']//input)[3]    
${VERY_BAD_RADIO_BUTTON_LOCATOR}    (//li[@class='answer']//input)[4]    
${EXCELLENT_RADIO_TEXT_LOCATOR}    (//li[@class='answer']//label)[1]
${GOOD_RADIO_TEXT_LOCATOR}    (//li[@class='answer']//label)[2]    
${POOR_RADIO_TEXT_LOCATOR}    (//li[@class='answer']//label)[3]    
${VERY_BAD_RADIO_TEXT_LOCATOR}    (//li[@class='answer']//label)[4]    
${VOTE_BUTTON_LOCATOR}    id:vote-poll-1

${ALL_LINKS_IN_HOMEPAGE_LOCATOR}    //a
${ALL_TEXTS_IN_HOMEPAGE_LOCATOR}    xpath://a

*** Keywords ***
Go To Home Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Go To Home Page Without Logging In
    ${logged_in}=    Run Keyword And Return Status    Element Should Be Visible    ${LOGOUT_LINK_LOCATOR}
    Run Keyword If    ${logged_in}    Click Link    header_navigation.${LOGOUT_LINK_LOCATOR}
    
Verify Hasing New Products Slider
    Element Should Be Visible    ${SLIDER_LOCATOR}

Verify Welcome Content
    ${welcome_texts}=    Get Texts From List    ${WELCOME_CONTENT_LOCATOR}
    Log    Welcome texts 1 is: ${welcome_texts}
    ${welcome_texts}=    Remove Character From List    ${welcome_texts}    \n
    Log    Welcome texts 2 is: ${welcome_texts}
    Should Be Equal    ${welcome_texts}    ${WELCOME_TEXT_DATA}

Verify The Documentation, Forums and nopCommerce.com Should Be Link-text
    Element Should Be Visible    ${DOCUMENT_LINK_LOCATOR}
    Element Should Be Visible    ${FORUM_LINK_LOCATOR}
    Element Should Be Visible    ${NOPCOMMERCE_LINK_LOCATOR}
    
Has category block contains: "Electronics", "Apparel", "Digital downloads" options with image for each
    Element Should Be Visible    ${ELECTRONICS_LINK_LOCATOR}
    Element Should Be Visible    ${APPAREL_LINK_LOCATOR}
    Element Should Be Visible    ${DIGITAL_DOWNLOADS_LINK_LOCATOR}
    Element Should Be Visible    ${ELECTRONICS_IMAGE_LOCATOR}
    Element Should Be Visible    ${APPAREL_IMAGE_LOCATOR}
    Element Should Be Visible    ${DIGITAL_IMAGE_LOCATOR}

Verify Each Product In The Featured Products Grid
    ${count}=   get element count    ${FEATURE_PRODUCTS_LOCATOR}
    Should Be Equal As Integers    ${count}    4
    FOR    ${index}    IN RANGE    1    ${count}+1
        Element Should Be Visible    (${PRODUCT_NAME_LINKS_LOCATOR})[${index}]
        Element Should Be Enabled    (${ADD_TO_CART_BUTTONS_LOCATOR})[${index}]
        Element Should Be Enabled    (${ADD_TO_COMPARE_LIST_BUTTONS_LOCATOR})[${index}]
        Element Should Be Enabled    (${ADD_TO_WISHLIST_BUTTONS_LOCATOR})[${index}]
    END

Verify Each News Block Contains 3 The Lastesr News Cards
    ${count}=   Get Element Count    ${NEWS_ITEMS_LOCATOR}
    Should Be Equal As Integers    ${count}    3
    FOR    ${index}    IN RANGE    1    ${count}+1
        Element Should Be Visible    (${NEWS_TITLE_LINK_LOCATORS})[${index}]
        Element Should Be Enabled    (${DETAILS_BUTTONS_LOCATOR})[${index}]
        
    END
    Element Should Be Enabled    ${VIEW_NEWS_ARCHIVE_BUTTONS_LOCATOR}

Verify Community Poll Block Should Contain 4 Radio Buttons
    ${count}=   Get Element Count    ${POLL_OPTIONS_LOCATOR}
    Should Be Equal As Integers    ${count}    4

    ${excelent_radio_text}    Get Text    ${EXCELLENT_RADIO_TEXT_LOCATOR}
    ${good_radio_button}    Get Text    ${GOOD_RADIO_TEXT_LOCATOR}    
    ${poor_radio_text}    Get Text    ${POOR_RADIO_TEXT_LOCATOR}   
    ${very_bad_text}    Get Text    ${VERY_BAD_RADIO_TEXT_LOCATOR}

    Should Be Equal As Strings    ${excelent_radio_text}    ${EXCELLENT_RADIO_TEXT_DATA}
    Should Be Equal As Strings    ${good_radio_button}    ${GOOD_RADIO_TEXT_DATA}
    Should Be Equal As Strings    ${poor_radio_text}   ${POOR_RADIO_TEXT_DATA}
    Should Be Equal As Strings    ${very_bad_text}    ${VERY_BAD_RADIO_TEXT_DATA}
    Element Should Be Enabled     ${VOTE_BUTTON_LOCATOR}
