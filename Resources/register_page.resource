*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

Resource    ..//Resources/header_navigation.resource

*** Variables ***
${FIRST_NAME_TEXTBOX_LOCATOR}   id:FirstName
${LAST_NAME_TEXTBOX_LOCATOR}    id:LastName
${EMAIL_TEXTBOX_LOCATOR}        id:Email
${COMPANY_TEXTBOX_LOCATOR}      id:Company
${PASSWORD_TEXTBOX_LOCATOR}     id:Password
${CONFIRM_PASSWORD_TEXTBOX_LOCATOR}     id:ConfirmPassword
${DOB_DAY_DROPDOWN_LOCATOR}     name:DateOfBirthDay
${DOB_MONTH_DROPDOWN_LOCATOR}   name:DateOfBirthMonth
${DOB_YEAR_DROPDOWN_LOCATOR}    name:DateOfBirthYear
${MALE_GENDER_RADIO_LOCATOR}    id:gender-male
${FEMALE_GENDER_RADIO_LOCATOR}  id:gender-Female
${GENDER_RADIO_LOCATOR}         Gender
${REGISTER_BUTTON_LOCATOR}      id:register-button

${PASSWORD_DEFAULT_DATA}    123456
${REGISTER_PAGE_TITLE}    Your store. Register

*** Keywords ***  
Register Page Should Appear
     ${title}=    Get Title 
     Should Be Equal As Strings    ${title}    ${REGISTER_PAGE_TITLE}

Register New Random User 
    ${random_string}=    Generate Random String    5    [LOWER]

    ${gender}=    Generate Random String    1    MF
    ${firstname}=    Set Variable    ${random_string}_first
    ${lastname}=    Set Variable    ${random_string}_last
    ${dob_day}=    Evaluate    random.randint(1, 31)    random
    ${dob_month}=    Evaluate    random.randint(1, 12)    random
    ${dob_year}=    Evaluate    random.randint(1913, 2023)    random
    ${email}=    Set Variable    ${random_string}@gmail.com
    ${company}=    Set Variable    ${random_string}_company
    

    Click Link  ${REGISTER_LINK_LOCATOR}
    Select Radio Button    ${GENDER_RADIO_LOCATOR}    ${gender}
    Input Text    ${FIRST_NAME_TEXTBOX_LOCATOR}    ${firstname}
    Input Text    ${LAST_NAME_TEXTBOX_LOCATOR}    ${lastname}
    Select From List By Value    ${DOB_DAY_DROPDOWN_LOCATOR}    ${dob_day}
    Select From List By Value    ${DOB_MONTH_DROPDOWN_LOCATOR}    ${dob_month}
    Select From List By Value    ${DOB_YEAR_DROPDOWN_LOCATOR}    ${dob_year}
    Input Text    ${EMAIL_TEXTBOX_LOCATOR}    ${email}
    Input Text    ${COMPANY_TEXTBOX_LOCATOR}      ${company}
    Input Text    ${PASSWORD_TEXTBOX_LOCATOR}    ${PASSWORD_DEFAULT_DATA}
    Input Text    ${CONFIRM_PASSWORD_TEXTBOX_LOCATOR}    ${PASSWORD_DEFAULT_DATA}
    Click Button    ${REGISTER_BUTTON_LOCATOR}
    [Return]    ${random_string}@gmail.com