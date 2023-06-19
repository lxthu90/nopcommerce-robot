*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    OperatingSystem

Resource    ..//configs/env.resource
Resource    ..//TestData/home_page_data.resource
Resource    ..//TestData/header_navigation_data.resource
Resource    ../Utilities/utills.resource
Resource    ../Utilities/web_locator.resource
Resource    ../Utilities/base_page.resource
Resource    ../Utilities/data_helper.resource



*** Variables ***
${CURRENCY_DROPDOWN_LOCATOR}    id:customerCurrency
${LOGO_LINK_LOCATOR}    xpath://img[@alt='Your store name']    #changed
${REGISTER_LINK_LOCATOR}    xpath://a[@class='ico-register']
${LOGIN_LINK_LOCATOR}    xpath://a[@class='ico-login']
${LOGOUT_LINK_LOCATOR}    xpath://a[@class='ico-logout']
${WISHLIST_LINK_LOCATOR}    xpath://a[@class='ico-wishlist']
${WISHLIST_NUMBER_LOCATOR}    xpath://span[@class='wishlist-qty']
${SHOPPING_CART_LINK_LOCATOR}    xpath://a[@class='ico-cart']
${MY_ACCOUNT_LINK_LOCATOR}    xpath://a[@class='ico-account']
${SHOPPING_CART_NUMBER_LOCATOR}    xpath://span[@class='cart-qty']
${SEARCH_BOX_LOCATOR}    id:small-searchterms
${SEARCH_BUTTON_LOCATOR}    xpath://input[@value='Search']    #changed

${CATEGORIES_MENU_LOCATOR}    xpath://ul[@class='top-menu notmobile']/li/a
${COMPUTER_MENU_LINK_LOCATOR}    xpath://a[text()='Computers ']
${ELECTRONICS_MENU_LINK_LOCATOR}    xpath://a[text()='Electronics ']
${APPAREL_MENU_LINK_LOCATOR}    xpath://a[text()='Apparel ']
${DIGITAL_DOWNLOADS_MENU_LINK_LOCATOR}    xpath://a[text()='Digital downloads ']
${BOOKS_MENU_LINK_LOCATOR}    xpath://a[text()='Books ']
${JEWELRY_MENU_LINK_LOCATOR}    xpath://a[text()='Jewelry ']
${GIFT_CARDS_MENU_LINK_LOCATOR}    xpath://a[text()='Gift Cards ']


*** Keywords ***
Log Out Button Should Be Visible
    Element Should Be Visible    ${LOGOUT_LINK_LOCATOR}

User Log Out
    web_locator.Click On Link    ${LOGOUT_LINK_LOCATOR}
    
Go To Register Page By Clicking On Register Link
    web_locator.Click On Link    ${REGISTER_LINK_LOCATOR}

Verify HomePage Link Header When Not Logging In
    Element Should Be Visible    ${REGISTER_LINK_LOCATOR}
    Element Should Be Visible    ${LOGIN_LINK_LOCATOR}
    Element Should Be Visible    ${WISHLIST_LINK_LOCATOR}

Verify HomePage Link Header When Logged In
    Element Should Be Visible    ${LOGOUT_LINK_LOCATOR}
    Element Should Be Visible    ${WISHLIST_LINK_LOCATOR}

Verify List Value Of Currency Dropdown
    ${dropdown_values}    Get List Items    ${CURRENCY_DROPDOWN_LOCATOR}
    ${expected_list}    Create List    @{CURRENCY_DROPDOWN_DATA}
    Lists Should Be Equal    ${dropdown_values}    ${expected_list}

Verify Currency Dropdown Value Should Be
    [Arguments]    ${currency_dropdown_selected_value}
    List Selection Should Be    ${CURRENCY_DROPDOWN_LOCATOR}    ${currency_dropdown_selected_value}

Verify Number Of Wistlist
    [Arguments]    ${number_of_wistlist}
    ${value}=    web_locator.Get Text From    ${WISHLIST_NUMBER_LOCATOR}
    Log    Number of wistlist is ${value}
    Should Be Equal    (${number_of_wistlist})    ${value}

Verify Number Of Shopping Cart
    [Arguments]    ${number_of_shopping_cart}
    ${value}=    web_locator.Get Text From    ${SHOPPING_CART_NUMBER_LOCATOR}
    Log    Number of shopping cart is ${value}
    Should Be Equal    (${number_of_shopping_cart})    ${value}

Hasing A Search Bar With Search Box And Search button
    Element Should Be Visible   ${SEARCH_BOX_LOCATOR}
    Element Should Be Visible   ${SEARCH_BUTTON_LOCATOR}
    Element Should Be Visible   ${SEARCH_BOX_LOCATOR}

Verify Placeholder Value Of Search box
    ${placeholder_text}=    Get Placeholder Value Of Textbox     ${SEARCH_BOX_LOCATOR}
    Should Be Equal    ${placeholder_text}    ${PLACEHOLDER_SEARCHBOX_TEXT_DATA}

Verify Search Button Should Be Enabled
    Element Should Be Enabled    ${SEARCH_BUTTON_LOCATOR}

Verify Categories Menu Contains Corresponding Sub Category
    ${CATEGORIES_NAME}    Create List    @{MENU_CATEGORIES_DATA}
    ${SUB_CATEGORIES_NAME}    Create List    @{MENU_SUB_CATEGORIES_DATA}
    @{ACTUAL_SUB_CATEGORIES}    Create List

    @{menu_categories}  Get WebElements  ${CATEGORIES_MENU_LOCATOR}
    ${count}=    Get Length   ${menu_categories}
    FOR    ${index}    IN RANGE    0    ${count}
        #Mouse Over    ${menu_categories}[${index}]
        ${category_name}=    Set Variable    ${CATEGORIES_NAME}[${index}]
        Log To Console    ${category_name}        
        @{SUB_CATEGORIES_ELEMENTS}    Get WebElements    //ul[@class='top-menu notmobile']//a[text()='${category_name} ']/following-sibling::ul/li/a
        FOR    ${sub_categories_element}    IN    @{SUB_CATEGORIES_ELEMENTS}
            Mouse Over    ${menu_categories}[${index}]
            Wait Until Element Is Visible    ${sub_categories_element}
            ${sub_name}=    web_locator.Get Text From    ${sub_categories_element}
            Append To List    ${ACTUAL_SUB_CATEGORIES}    ${sub_name}
        END
    END
    Log Many    @{ACTUAL_SUB_CATEGORIES}
    Log Many    @{CATEGORIES_NAME}
    Lists Should Be Equal  ${ACTUAL_SUB_CATEGORIES}  ${SUB_CATEGORIES_NAME}  ignore_order=True

    


The Price Should Be Converted Corresponding To The Chosen Option
    #Get actual prices list in us dollar
    ${PRICES_LIST_DEFAULT}    Create List    @{ACTUAL_PRICE_VALUE_GLOBAL}
    
    #Get current currency symbol
    base_page.Get Current Currency Symbol
    ${current_currency_symbol}=    Set Variable    ${CURRENCY_SYMBOL_GLOBAL}
    #get prices value on page after seleting currency
    base_page.Get All Actual Prices Values In Current Page
    ${PRICES_LIST_AFTER}    Create List    @{ACTUAL_PRICE_VALUE_GLOBAL}
    Log Many    ${PRICES_LIST_AFTER}

    #exchange prices in us dollar to current currency symbol
    @{EXCHANGED_PRICES}    Create List
    FOR    ${price}    IN    @{PRICES_LIST_DEFAULT}
        ${exchanged_price}=    data_helper.Exchange Currency    ${price}    ${current_currency_symbol}
        Append To List    ${EXCHANGED_PRICES}    ${exchanged_price}
    END
    
    #verify
    Lists Should Be Equal    ${EXCHANGED_PRICES}    ${PRICES_LIST_AFTER}