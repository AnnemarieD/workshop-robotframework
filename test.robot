*** Settings ***

Documentation       A test suite with tests for login.
Library             SeleniumLibrary
Library             String

*** Variables ***

${LOGIN URL}    http://www.saucedemo.com
${Username}     standard_user
${Password}     secret_sauce
${BROWSER}      Chrome

*** Keywords ***

Open Browser To Login Page
    Open Browser   ${LOGIN URL}     ${BROWSER}    
       
Input Username
    [Arguments]  ${username}
    ${element}  Set Variable   id:user-name
    Wait Until Element Is Visible   ${element}
    Input Text  ${element}  ${username} 

Input Password
    ${element}  Set Variable   id:password
    Wait Until Element Is Visible   ${element}
    Input Text  ${element}  ${Password}

Submit Credentials
    Click Button    class:login-button    

Product Page Should Be Open
    ${element}  Set Variable    class:product_label
    Wait Until Element Is Visible   ${element}
    Variable Should Exist   ${element}

Locked Out Error Should Be Displayed
    ${errorButton}  Set Variable    class:error-button
    Wait until element is Visible   ${errorButton}
    Element should be visible   ${errorButton}
 
*** Test Cases ***

Valid Login
    Open Browser To Login Page
    Input Username  standard_user
    Input Password
    Submit Credentials
    Product Page Should Be Open
    [Teardown]    Close Browser

Invalid Login
    Open Browser To Login Page
    Input Username  locked_out_user   
    Input Password
    Submit Credentials 
    Locked Out Error Should Be Displayed
    [Teardown]  Close Browser