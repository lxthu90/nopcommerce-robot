*** Settings ***
Library    SeleniumLibrary
Library    XML

*** Variables ***
${browser}    firefox
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
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Title Should Be    nopCommerce demo store
    Click Link    xpath://a[contains(text(),'Register')]
    Title Should Be    nopCommerce demo store. Register
    
    
    #fill in data to register
    
    #Select a random gender
    ${gender}=  Evaluate  random.choice(['M', 'F'])
    Select Radio Button    Gender    ${gender}

    Input Text    id:FirstName    Firsname 01
    Input Text    id:LastName    Lastname 01
    
    # Select a random date of birth
    ${day}=  Evaluate  random.randint(1, 28)
    ${month}=  Evaluate  random.randint(1, 12)
    ${year}=  Evaluate  random.randint(1980, 2000)
    Select From List By Value    DateOfBirthDay    ${day}
    Sleep    2
    Select From List By Value    DateOfBirthMonth    ${month}
    Sleep    2
    Select From List By Value    DateOfBirthYear    ${year}
    Sleep    2
    
    Input Text    id:Email    username90@gmail.com
    Input Password    id:Password    123456
    Input Password    id:ConfirmPassword    123456
    
    Click Button    xpath://button[@id='register-button']
    Sleep    2
    Close Browser

*** Keywords ***
