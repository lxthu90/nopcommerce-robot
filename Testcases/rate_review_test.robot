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
Resource    ../Resources/categories_page.resource
Resource    ../Resources/review_page.resource



Test Setup    home_page.Go To Home Page
Test Teardown    Close All Browsers

*** Variables ***



*** Test Cases ***
 Verify the first rate for the Product
    login_page.Login To System Then Going To Home Page
    categories_page.Open Unreview Product Page And Get Product Name
    product_details_page.Be The First To Review Link Should Appear
    product_details_page.Go To Review Page
    review_page.Verify The Form For Writing The Review
    review_page.Enter Valid Review And Verify Information     this is title    hello    1

Verify the "Write your own review" Form For The Product
    login_page.Login To System Then Going To Home Page
    categories_page.Open A Product Page And Get Product Name
    product_details_page.Go To Review Page
    review_page.Verify The Form For Writing The Review
    review_page.Leave Review Title And Review Text Blank And Click Submit
    review_page.Review Title Error Message Should Appear
    review_page.Review Text Error Message Should Appear    
    review_page.Verify Default Rating Option
    review_page.Enter Valid Review And Verify Information    review title    review text    2

Verify That The User Is Not Able To Rate When The User Is Not Logged In
    home_page.Go To Home Page Without Logging In
    categories_page.Open A Product Page And Get Product Name
    product_details_page.Go To Review Page
    review_page.Verify The Form For Writing The Review
    review_page.Verify That User Is Unable To Review When Not Logged In

Verify That The Owner Is Not Able To Vote Their Review
    login_page.Login To System Then Going To Home Page
    categories_page.Open A Product Page And Get Product Name
    product_details_page.Go To Review Page    
    review_page.Enter Valid Review And Verify Information     this is title    hello    1
    review_page.User Votes Review As Yes
    review_page.User Votes Review As No
    Page Should Contain    You cannot vote for your own review
        
Verify That The User Not Owner Is Able To Vote Their Review
    login_page.Login To System Then Going To Home Page
    categories_page.Open A Product Page And Get Product Name
    product_details_page.Go To Review Page    
    review_page.Enter Valid Review And Verify Information     this is title    hello    1
    header_navigation.User Log Out
    #Login with another user
    login_page.Login To System Then Going To Home Page
    categories_page.Open A Product Page And Get Product Name
    product_details_page.Go To Review Page
    review_page.User Votes Review As Yes
    Page Should Contain    Successfully voted
    review_page.User Votes Review As No
    Page Should Contain    Successfully voted

View the Rating on Product details page
    categories_page.Open A Product Page And Get Product Name
    review_page.Rating Section Should Appear Under Product Short Description

*** Keywords ***
