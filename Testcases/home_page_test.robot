*** Settings ***
Library     SeleniumLibrary
Library    String
Library    Process


Resource    ..//Resources/home_page.resource
Resource    ..//Utilities/common_function.resource
Resource    ..//Resources/header_navigation.resource
Resource    ../Resources/register_page.resource
Resource    ../Resources/login_page.resource
Resource    ../Resources/wishlist_page.resource
Resource    ../Resources/shopping_cart_page.resource
Resource    ../Resources/my_account_page.resource



Test Setup    home_page.Go To Home Page
Test Teardown    Close All Browsers

*** Variables ***



*** Test Cases ***
Verify That The Default Values Of UI of "Home" Page As The Designed Mockup - The User Is Not Logged In
    home_page.Go To Home Page Without Logging In
    header_navigation.Verify Currency Dropdown Value Should Be    US Dollar
    header_navigation.Verify HomePage Link Header When Not Logging In
    header_navigation.Verify Number Of Wistlist    0
    header_navigation.Verify Number Of Shopping Cart    0
    header_navigation.Hasing A Search Bar With Search Box And Search button
    header_navigation.Verify Sub menu
    header_navigation.Verify Search Button Should Be Enabled
    home_page.Verify Hasing New Products Slider
    home_page.Verify Welcome Content
    home_page.Verify The Documentation, Forums and nopCommerce.com Should Be Link-text
    home_page.Verify Each Product In The Featured Products Grid
    home_page.Verify Each News Block Contains 3 The Lastesr News Cards
    home_page.Verify Community Poll Block Should Contain 4 Radio Buttons


Verify That The Default Values Of UI of "Home" Page As The Designed Mockup - The User Is Logged In
    login_page.Login To System Then Going To Home Page
    header_navigation.Verify Currency Dropdown Value Should Be    US Dollar
    header_navigation.Verify HomePage Link Header When Logged In
    header_navigation.Verify Number Of Wistlist    0
    header_navigation.Verify Number Of Shopping Cart    0
    header_navigation.Hasing A Search Bar With Search Box And Search button
    header_navigation.Verify Sub menu
    header_navigation.Verify Search Button Should Be Enabled
    home_page.Verify Hasing New Products Slider
    home_page.Verify Welcome Content
    home_page.Verify The Documentation, Forums and nopCommerce.com Should Be Link-text
    home_page.Verify Each Product In The Featured Products Grid
    home_page.Verify Each News Block Contains 3 The Lastesr News Cards
    home_page.Verify Community Poll Block Should Contain 4 Radio Buttons

Verify That The Data In Sublists Of Each Option In Categories Menu Is As Required
    home_page.Go To Home Page Without Logging In
    header_navigation.Verify Sub menu

Verify That The Data In The "Currency" Drop-down List Is As Required
    home_page.Go To Home Page Without Logging In
    header_navigation.Verify List Value Of Currency Dropdown

Verify That The Price Of Products In The "Featured Products" Grid Is Converted Corresponding To The Chosen Option At The "Currency" Drop-down List
    home_page.Go To Home Page Without Logging In
    header_navigation.Change Value Of Currency Dropdown
    header_navigation.The Price Should Be Converted Corresponding To The Chosen Option    #the prices should be converted properly
    header_navigation.Change Value Of Currency Dropdown    #change currency symbol again
    header_navigation.The Price Should Be Converted Corresponding To The Chosen Option    #the prices should be converted properly

Verify That The System Redirects To "Register" Page When Clicking On The "Register" Option On The Header Menu Bar
    home_page.Go To Home Page Without Logging In
    header_navigation.Go To Register Page By Clicking On Register Link
    register_page.Register Page Should Appear
    
Verify That The System Redirects To "Home Page" Page When Clicking On The "Home Page" Option On The Header Menu Bar
    home_page.Go To Home Page Without Logging In
    login_page.Go To Login Page
    login_page.Login Page Should Appear

Verify That The System Redirects To "Wishlist" Page When Clicking On The "Wishlist" Option On The Header Menu Bar
    home_page.Go To Home Page Without Logging In
    wishlist_page.Go To Wishlist Page
    wishlist_page.Register Page Should Appear

Verify That The System Redirects To "Shopping_Cart" Page When Clicking On The "Shopping_Cart" Option On The Header Menu Bar
    home_page.Go To Home Page Without Logging In
    shopping_cart_page.Go To Shopping Cart Page
    shopping_cart_page.Shopping Cart Page Should Appear

Verify That The System Redirects To "My Account" Page When Clicking On The "My Account" Option On The Header Menu Bar
    login_page.Login To System Then Going To Home Page
    my_account_page.Go To My Account Page
    my_account_page.My Account Page Should Appear


*** Keywords ***
