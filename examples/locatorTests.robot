*** Settings ***
Library  SeleniumLibrary
Test Setup      Open Oelan homepage
Test Teardown   Close Browser

*** Variables ***
${URL}          http://www.oelan.nl
${BROWSER}      Chrome
${title website}    Oelan - Maak het verschil
${telefoonnummer footer}    020 330 29 62
${aantal trainingen}    ${6}

*Keywords*
Open Oelan homepage
    Open Browser    ${URL}  ${BROWSER}

Check titel van homepage
    ${actualTitle}=     Get Title   
    Should be equal   ${actualTitle}   ${title website}   

Check telefoonnummer in de footer
    ${actualTelefoonnummer}=    Get Text   xpath://*[@id="text-3"]/div/p[1]  
    Should contain     ${actualTelefoonnummer}     ${telefoonnummer footer}

Check aantal trainingen
    # Click Element   menu-item-3514
    ${actualAantal}=    Get Element Count      css: #menu-item-3569 > ul > li
    Should be equal     ${actualAantal}   ${aantal trainingen}
    
*** Test Cases ***
De titel van de site van Oelan is als verwacht
    Check titel van homepage

Het telefoonnummer in de footer is als verwacht
    Check telefoonnummer in de footer

Het aantal trainingen in categorie Test Automation is als verwacht
    Check aantal trainingen

BDD example
    Given login page is open 
        
