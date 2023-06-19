*** Settings ***
Library     SeleniumLibrary
Library    String
Library    Process


Resource    ..//resources/home_page.resource
Resource    ..//utilities/utills.resource
Resource    ..//resources/header_navigation.resource
Resource    ../resources/register_page.resource
Resource    ../resources/login_page.resource
Resource    ../resources/wishlist_page.resource
Resource    ../resources/shopping_cart_page.resource
Resource    ../resources/my_account_page.resource
Resource    ../utilities/web_locator.resource
Resource    ../utilities/base_page.resource
Resource    ../utilities/data_helper.resource

Test Setup    Initialize Environment
Test Teardown    Clean Up Environment

*** Variables ***



*** Test Cases ***     
Verify That The Default Values Of UI of "Home" Page As The Designed Mockup - The User Is Not Logged In
    home_page.Go To Home Page
    header_navigation.Verify Currency Dropdown Value Should Be    ${DEFAULT_CURRENCY_SYMBOL}
    header_navigation.Verify HomePage Link Header When Not Logging In
    header_navigation.Verify Number Of Wistlist    ${DEFAULT_WISHLIST_NUMBER}
    header_navigation.Verify Number Of Shopping Cart    ${DEFAULT_SHOPPING_CART_NUMBER}
    header_navigation.Hasing A Search Bar With Search Box And Search button
    header_navigation.Verify Categories Menu Contains Corresponding Sub Category
    header_navigation.Verify Search Button Should Be Enabled
    home_page.Verify Hasing New Products Slider
    home_page.Verify Welcome Content
    home_page.Verify The Documentation, Forums and nopCommerce.com Should Be Link-text
    home_page.Verify Each Product In The Featured Products Grid
    home_page.Verify Each News Block Contains 3 The Lastesr News Cards
    home_page.Verify Community Poll Block Options


Verify That The Default Values Of UI of "Home" Page As The Designed Mockup - The User Is Logged In
    home_page.Go To Home Page
    login_page.Login To System
    header_navigation.Verify HomePage Link Header When Logged In

Verify That The Data In Sublists Of Each Option In Categories Menu Is As Required
    home_page.Go To Home Page
    header_navigation.Verify Categories Menu Contains Corresponding Sub Category

Verify That The Data In The "Currency" Drop-down List Is As Required
    home_page.Go To Home Page
    header_navigation.Verify List Value Of Currency Dropdown

Verify That The Price Of Products In The "Featured Products" Grid Is Converted Corresponding To The Chosen Option At The "Currency" Drop-down List
    [Template]    I Want To Verify That Price Is Exchanged Properly To
        Euro
        US Dollar

Verify That The System Redirects To "Register" Page When Clicking On The "Register" Option On The Header Menu Bar
    home_page.Go To Home Page
    header_navigation.Go To Register Page By Clicking On Register Link
    register_page.Register Page Should Appear
    
Verify That The System Redirects To "Home Page" Page When Clicking On The "Home Page" Option On The Header Menu Bar
    home_page.Go To Home Page
    login_page.Go To Login Page
    login_page.Login Page Should Appear

Verify That The System Redirects To "Wishlist" Page When Clicking On The "Wishlist" Option On The Header Menu Bar
    home_page.Go To Home Page
    wishlist_page.Go To Wishlist Page
    wishlist_page.Register Page Should Appear

Verify That The System Redirects To "Shopping_Cart" Page When Clicking On The "Shopping_Cart" Option On The Header Menu Bar
    home_page.Go To Home Page
    shopping_cart_page.Go To Shopping Cart Page
    shopping_cart_page.Shopping Cart Page Should Appear

Verify That The System Redirects To "My Account" Page When Clicking On The "My Account" Option On The Header Menu Bar
    home_page.Go To Home Page
    login_page.Login To System
    my_account_page.Go To My Account Page
    my_account_page.My Account Page Should Appear

*** Keywords ***

