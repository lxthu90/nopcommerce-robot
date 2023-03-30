*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

Resource    ..//Config/env.resource
Resource    ..//TestData/home_page_data.resource
Resource    ..//TestData/header_navigation_data.resource
Resource    ../Utilities/common_function.resource

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
${SEARCH_BUTTON_LOCATOR}    xpath://input[@class='button-1 search-box-button']    #changed

${CATEGORIES_MENU_LOCATOR}    xpath://ul[@class='top-menu notmobile']/li/a
${COMPUTER_MENU_LINK_LOCATOR}    xpath://a[text()='Computers ']
${ELECTRONICS_MENU_LINK_LOCATOR}    xpath://a[text()='Electronics ']
${APPAREL_MENU_LINK_LOCATOR}    xpath://a[text()='Apparel ']
${DIGITAL_DOWNLOADS_MENU_LINK_LOCATOR}    xpath://a[text()='Digital downloads ']
${BOOKS_MENU_LINK_LOCATOR}    xpath://a[text()='Books ']
${JEWELRY_MENU_LINK_LOCATOR}    xpath://a[text()='Jewelry ']
${GIFT_CARDS_MENU_LINK_LOCATOR}    xpath://a[text()='Gift Cards ']

${DESKTOPS_SUBMENU_LINK_LOCATOR}    xpath://ul[@class='top-menu notmobile']//ul[@class='sublist first-level']//a[text()='Desktops ']
${NOTEBOOKS_SUBMENU_LINK_LOCATOR}    xpath://ul[@class='top-menu notmobile']//ul[@class='sublist first-level']//a[text()='Notebooks ']
${SOFTWARES_SUBMENU_LINK_LOCATOR}    xpath://ul[@class='top-menu notmobile']//ul[@class='sublist first-level']//a[text()='Software ']

${CAMERA_PHOTO_SUBMENU_LINK_LOCATOR}    xpath://ul[@class='top-menu notmobile']//ul[@class='sublist first-level']//a[text()='Camera & photo ']
${CELLPHONES_SUBMENU_LINK_LOCATOR}    xpath://ul[@class='top-menu notmobile']//ul[@class='sublist first-level']//a[text()='Cell phones ']
${OTHERS_SUBMENU_LINK_LOCATOR}    xpath://ul[@class='top-menu notmobile']//ul[@class='sublist first-level']//a[text()='Others ']

${SHOES_SUBMENU_LINK_LOCATOR}    xpath://ul[@class='top-menu notmobile']//ul[@class='sublist first-level']//a[text()='Shoes ']
${CLOTHING_SUBMENU_LINK_LOCATOR}    xpath://ul[@class='top-menu notmobile']//ul[@class='sublist first-level']//a[text()='Clothing ']
${ACCESSORIES_SUBMENU_LINK_LOCATOR}    xpath://ul[@class='top-menu notmobile']//ul[@class='sublist first-level']//a[text()='Accessories ']


*** Keywords ***
User Log Out
    Click Link    ${LOGOUT_LINK_LOCATOR}
Go To Register Page By Clicking On Register Link
    Click Link    ${REGISTER_LINK_LOCATOR}
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
    ${value}=    Get Text    ${WISHLIST_NUMBER_LOCATOR}
    Log    Number of wistlist is ${value}
    Should Be Equal    (${number_of_wistlist})    ${value}

Verify Number Of Shopping Cart
    [Arguments]    ${number_of_shopping_cart}
    ${value}=    Get Text    ${SHOPPING_CART_NUMBER_LOCATOR}
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

Verify Sub menu
    @{menu_categories}  Get WebElements  ${CATEGORIES_MENU_LOCATOR}
    FOR  ${category}  IN  @{menu_categories}
        ${category_name}  Set Variable  ${category.text}
        Log To Console    ${category_name}
        Mouse Over    ${category}
        IF    '${category_name}'=='Computers'
            Wait Until Element Is Visible   ${DESKTOPS_SUBMENU_LINK_LOCATOR}
            Wait Until Element Is Visible   ${NOTEBOOKS_SUBMENU_LINK_LOCATOR}
            Wait Until Element Is Visible   ${SOFTWARES_SUBMENU_LINK_LOCATOR}
        END
        IF    '${category_name}'=='Electronics'
            Wait Until Element Is Visible    ${CAMERA_PHOTO_SUBMENU_LINK_LOCATOR}
            Wait Until Element Is Visible    ${CELLPHONES_SUBMENU_LINK_LOCATOR}
            Wait Until Element Is Visible    ${OTHERS_SUBMENU_LINK_LOCATOR}
        END
        IF    '${category_name}'=='Apparel'
            Wait Until Element Is Visible   ${SHOES_SUBMENU_LINK_LOCATOR}
            Wait Until Element Is Visible   ${CLOTHING_SUBMENU_LINK_LOCATOR}
            Wait Until Element Is Visible   ${ACCESSORIES_SUBMENU_LINK_LOCATOR}
        END
    END

Change Value Of Currency Dropdown
    ${selected_value}=    Get Selected List Label    ${CURRENCY_DROPDOWN_LOCATOR}
    IF    '${selected_value}'=='US Dollar'
        Select From List By Label    ${CURRENCY_DROPDOWN_LOCATOR}    Euro
    END
    IF    '${selected_value}'=='Euro'
        Select From List By Label    ${CURRENCY_DROPDOWN_LOCATOR}    US Dollar
    END
    [Return]    ${selected_value}
    
Exchange Currency
    [Arguments]    ${amount}    ${convert_from}
    IF  '${convert_from}'=='US Dollar'
        ${currency_rate}=    Convert To Number    ${CURRENCY_RATE_DATA}
        ${exchanged_value}  Evaluate    ${amount}*${currency_rate}
        ${exchanged_value}  Evaluate    round(${exchanged_value},2)
    ELSE IF     '${convert_from}'=='Euro'
        ${currency_rate}=    Convert To Number    ${CURRENCY_RATE_DATA}
        ${exchanged_value}  Evaluate    ${amount}/${currency_rate}
        ${exchanged_value}  Evaluate    round(${exchanged_value},2)
    ELSE
        Log     The type to convert must be US Dollar OR Euro but receive ${convert_from}
    END
    [RETURN]    ${exchanged_value}

The Price Should Be Converted Corresponding To The Chosen Option
    #Get current currency symbol
    ${currency_symbol}=    Get Selected List Label    ${CURRENCY_DROPDOWN_LOCATOR}

    #Get all actual value in page before changing currency symbol
    @{price_list_before}=    common_function.Get All Actual Prices Values
    Log Many    Before @{price_list_before}

    #Exchange value from current currency
    @{price_list_exchanged}    Create List
    FOR    ${price}    IN    @{price_list_before}
        ${price_exchange}=    Exchange Currency    ${price}    ${currency_symbol}
        Append To List    ${price_list_exchanged}     ${price_exchange}
    END
    Log Many    Exchange @{price_list_exchanged}        
    #Change currency symbol
    Change Value Of Currency Dropdown
    #Get all actual value in page again
    @{price_list_after}=    common_function.Get All Actual Prices Values
    Log Many    After @{price_list_after}
    Lists Should Be Equal   ${price_list_exchanged}    ${price_list_after}
    

