*** Settings ***

Documentation       A test suite with tests for login.
Library             SeleniumLibrary
Library             String

*** Variables ***

${LOGIN URL}    http://www.saucedemo.com
${Password}     secret_sauce
${BROWSER}      Chrome

*** Keywords ***

Open Browser To Login Page
    Open Browser   ${LOGIN URL}     ${BROWSER} 
    Maximize Browser Window   
       
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

login page is open
    Open Browser   ${LOGIN URL}     ${BROWSER} 
    Maximize Browser Window   
       
valid username ${username} and password are inserted
    Input Username  ${username}
    Input Password

credentials are submitted
    Click Button    class:login-button    


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

BDD Example
    Given login page is open
    When valid username standard_user and password are inserted
    And credentials are submitted
    Then product page should be open
    [Teardown]   Close Browser
