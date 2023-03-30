*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Resource    ..//Config/env.resource
Resource    ..//TestData/home_page_data.resource
Resource    ../Utilities/common_function.resource
Resource    ..//Resources/home_page.resource

*** Variables ***

*** Keywords ***
Draft Verify Number Of Featured Products Grid Should Be
    [Arguments]    ${number_of_product}
    ${product_items}    Get WebElements    ${FEATURE_PRODUCTS}
    ${products}    Get Length    ${product_items}
    Log    Number of product is ${products}
    Should Be Equal As Integers    ${products}    ${number_of_product}
    FOR    ${product_item}    IN    @{product_items}
        ${product_image}    Get WebElement    xpath=.//img
        Should Be True    ${product_image.is_displayed()} 
    END


Draft testcase 
    ${i}    Set Variable    1
    ${feature_products}    Get WebElements    ${FEATURE_PRODUCTS}
    FOR    ${feature_product}    IN    @{feature_products}
         # Verify that the name of product is displayed as link-text
        ${product_name_links}  Get WebElements  ${PRODUCT_NAME_LINKS}
        ${product_name_link}    Set Variable    (${product_name_links})[3]
        ${product_name_link_text}=    Get Text    ${product_name_link}
        Log to Console    ${product_name_link_text}
        Should Be True    ${product_name_link.is_displayed}
        
        # Verify that "Add to cart" button is enabled
        #${add_to_cart_button}  Get WebElements  ${ADD_TO_CART_BUTTONS}
        #Should Be True    ${add_to_cart_button.is_enabled}
        
        # Verify that "Add to compare list" button is enabled
        #${add_to_compare_list_button}  Get WebElements  ${ADD_TO_COMPARE_LIST_BUTTONS}
        #Should Be True    ${add_to_compare_list_button.is_enabled} 
        
        #Verify that "Add to wishlist" button is enabled
        #${add_to_wishlist_button}  Get WebElements  ${ADD_TO_WISHLIST_BUTTONS}
        #Should Be True    ${add_to_wishlist_button.is_enabled}
        
        #${i}=    ${i}+1
        Log to console    ${i}
    END
    
Draft Verify Each product in the Featured products grid constains Name and Add To Cart Button

    # Verify that the name of product is displayed as link-text
    ${product_name_links}  Get WebElements  ${PRODUCT_NAME_LINKS}
    FOR  ${product_name_link}  IN     @{product_name_links}
        ${product_name_link_text}=    Get Text    ${product_name_link}
        Log to Console    ${product_name_link_text}
        Should Be True    ${product_name_link.is_displayed}      
    END
    
    # Verify that "Add to cart" button is enabled
    ${add_to_cart_buttons}  Get WebElements  ${ADD_TO_CART_BUTTONS}
    FOR  ${add_to_cart_button}  IN     @{add_to_cart_buttons}
        Should Be True    ${add_to_cart_button.is_enabled}    
    END
    
    # Verify that "Add to compare list" button is enabled
    ${add_to_compare_list_buttons}  Get WebElements  ${ADD_TO_COMPARE_LIST_BUTTONS}
    FOR  ${add_to_compare_list_button}  IN     @{add_to_compare_list_buttons}
        Should Be True    ${add_to_compare_list_button.is_enabled}    
    END
    
    # Verify that "Add to wishlist" button is enabled
    ${add_to_wishlist_buttons}  Get WebElements  ${ADD_TO_WISHLIST_BUTTONS}
    FOR  ${add_to_wishlist_button}  IN     @{add_to_wishlist_buttons}
        Should Be True    ${add_to_wishlist_button.is_enabled}
    END
    
Verify Cursor Atribute When Hovering Mouse
    # ${count}=    Get Element Count    //a
    # FOR    ${index}    IN   ${count}+1    
    #     # ${cursor}=    Execute JavaScript    return window.getComputedStyle(document.querySelectorAll('a')[agruments[0]]).cursor;    ${index}
    #     ${a}=    Convert To String    ${index}
    #     ${cursor}=    Execute JavaScript    return console.log(agruments[0]);    ${a}
    #     # Should Be Equal As Strings    ${cursor}    pointer      
    # END
    
    ${count}=    Get Element Count    xpath://a
    FOR    ${index}    IN RANGE    1    ${count}+1
        ${string_txt}    Convert To String    (//a)[${index}]
        #${string_txt}    Set Variable    abc
        Log To Console    ${string_txt}
        #${cursor}=    Execute JavaScript    return window.getComputedStyle(arguments[0]).getPropertyValue('color');      '(//a)[${index}]'
        ${cursor}=    Get Element Attribute    ${string_txt}    color
        Log To Console    =========================${cursor}
    END
            

Verify abc
     ${cursor}=    Execute JavaScript    return window.getComputedStyle(document.querySelector('a')).cursor;
    Should Be Equal As Strings    ${cursor}    pointer