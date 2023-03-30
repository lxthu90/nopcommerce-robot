*** Settings ***
Library    SeleniumLibrary
Library    XML

*** Variables ***
${browser}    chrome
${url}    https://demo.nopcommerce.com/
${gender_radio}
${firstname_txt}
${lastname_txt}
${year_opt}
${month_opt}
${day_opt}
${email_txt}
${company_txt}
${newsletter_check}
${password_txt}
${confirmpassword_txt}

*** Test Cases ***
Testing
    #initialize variables value
    #set random gender
    ${gender}=  Evaluate  random.choice(['M', 'F'])

    # Set a random date of birth
    ${day}=  Evaluate  random.randint(1, 28)
    ${month}=  Evaluate  random.randint(1, 12)
    ${year}=  Evaluate  random.randint(1980, 2000)
    
    #Set delay time for every steps is 2s
    Set Selenium Speed    1

    #Execute test
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Title Should Be    nopCommerce demo store
    Click Link    xpath://a[contains(text(),'Register')]
    
    Set Selenium Timeout    10    #set timeout is 10 seconds
    Wait Until Page Contains    Register    #if don't set selenium timeout, the default timeout is 5s
    

    Title Should Be    nopCommerce demo store. Register
    
    #fill in data to register
    Select Radio Button    Gender    ${gender}
    Input Text    id:FirstName    Firsname 01
    Input Text    id:LastName    Lastname 01
    Select From List By Value    DateOfBirthDay    ${day}
    Select From List By Value    DateOfBirthMonth    ${month}
    Select From List By Value    DateOfBirthYear    ${year}
    Input Text    id:Email    username90@gmail.com
    Input Password    id:Password    123456
    Input Password    id:ConfirmPassword    123456
    Click Button    xpath://button[@id='register-button']
    Close Browser

*** Keywords ***
