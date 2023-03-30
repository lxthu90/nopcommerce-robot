*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser  https://demo.nopcommerce.com/register?returnUrl=%2F  Chrome
Suite Teardown    Close Browser

*** Test Cases ***
Register New User With All Fields
    [Documentation]  Test registration of a new user with all fields filled
    Input Text       id:FirstName   John
    Input Text       id:LastName    Doe
    Input Text       id:Email       john.doe@example.com
    Input Text       id:Company     Test Company
    Input Text       id:Password    password123
    Input Text       id:ConfirmPassword  password123

    # Select a random date of birth
    ${day}=  Evaluate  random.randint(1, 28)
    ${month}=  Evaluate  random.randint(1, 12)
    ${year}=  Evaluate  random.randint(1980, 2000)
    Select From List by Index  id:DateOfBirthDay   ${day}
    Select From List by Index  id:DateOfBirthMonth ${month}
    Select From List by Index  id:DateOfBirthYear  ${year}

    # Select a random gender
    ${gender}=  Evaluate  random.choice(['Male', 'Female'])
    Click Element   xpath://label[text()='${gender}']/preceding-sibling::input

    Input Text       id:Password    password123
    Input Text       id:ConfirmPassword  password123
    Click Button     css:#register-button

    Wait Until Page Contains  Your registration completed
    Page Should Contain Element  css:.result
    Page Should Contain        Your registration completed

    [Teardown]  Click Button  css:.ico-logout
