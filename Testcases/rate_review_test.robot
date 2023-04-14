*** Settings ***
Library     SeleniumLibrary
Library    String
Library    Process


Resource    ..//Resources/home_page.resource
Resource    ..//Utilities/utills.resource
Resource    ..//Resources/header_navigation.resource
Resource    ../Resources/register_page.resource
Resource    ../Resources/login_page.resource
Resource    ../Resources/wishlist_page.resource
Resource    ../Resources/shopping_cart_page.resource
Resource    ../Resources/my_account_page.resource
Resource    ../Resources/categories_page.resource
Resource    ../Resources/review_page.resource


Test Setup    home_page.Open Home Page
Test Teardown    Close All Browsers

*** Variables ***



*** Test Cases ***
 Verify The First Rate For The Product
    utills.Prepare Unreviewed Product
    login_page.Login To System Then Going To Home Page
    categories_page.Open A Product Page    ${DIGITAL_DOWNLOADS_MENU_LINK_LOCATOR}    ${PRODUCT_LINK_LOCATOR}
    product_details_page.Click On The First To Review Link
    review_page.Enter Valid Review    this is title    hello    1
    review_page.Submit Review
    review_page.Verify Review Information

Verify the "Write your own review" Form For The Product
    utills.Prepare Reviewed Product
    login_page.Login To System Then Going To Home Page
    categories_page.Open A Product Page    ${DIGITAL_DOWNLOADS_MENU_LINK_LOCATOR}    ${PRODUCT_LINK_LOCATOR}
    product_details_page.Click On Add Your Review Link
    review_page.Submit Review
    review_page.Review Title Error Message Should Appear
    review_page.Review Text Error Message Should Appear    
    review_page.Verify Default Rating Option
    review_page.Enter Valid Review    this is title    hello    1
    review_page.Submit Review
    review_page.Verify Review Information


Verify That The User Is Not Able To Rate When The User Is Not Logged In
    utills.Prepare Reviewed Product
    home_page.Go To Home Page Without Logging In
    categories_page.Open A Product Page    ${DIGITAL_DOWNLOADS_MENU_LINK_LOCATOR}    ${PRODUCT_LINK_LOCATOR}
    product_details_page.Click On Add Your Review Link
    review_page.Verify That User Is Unable To Review When Not Logged In

Verify That The Owner Is Not Able To Vote Their Review
    utills.Prepare Reviewed Product
    login_page.Login To System Then Going To Home Page
    categories_page.Open A Product Page    ${DIGITAL_DOWNLOADS_MENU_LINK_LOCATOR}    ${PRODUCT_LINK_LOCATOR}
    product_details_page.Click On Add Your Review Link   
    review_page.Enter Valid Review     this is title    hello    1
    review_page.Submit Review
    review_page.User Votes Review As Yes
    review_page.Verify That User Is Unable Vote Their Review
    review_page.User Votes Review As No
    review_page.Verify That User Is Unable Vote Their Review

Verify That The User Not Owner Is Able To Vote Their Review
    utills.Prepare Reviewed Product
    login_page.Login To System Then Going To Home Page
    categories_page.Open A Product Page    ${DIGITAL_DOWNLOADS_MENU_LINK_LOCATOR}    ${PRODUCT_LINK_LOCATOR}
    product_details_page.Click On Add Your Review Link
    review_page.User Votes Review As Yes
    review_page.Verify That User Is Able Vote Others Review
    review_page.User Votes Review As No
    review_page.Verify That User Is Able Vote Others Review

View the Rating on Product details page
    utills.Prepare Reviewed Product
    categories_page.Open A Product Page    ${DIGITAL_DOWNLOADS_MENU_LINK_LOCATOR}    ${PRODUCT_LINK_LOCATOR}
    review_page.Rating Section Should Appear Under Product Short Description
    
*** Keywords ***
