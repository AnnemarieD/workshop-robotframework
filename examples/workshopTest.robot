*** Settings ***
Test Template  waarde ${index} uit ${lijst} is gelijk aan ${waarde}

*Variables*
@{auto}   Audi   Fiat   Maserati

*** Keywords ***
waarde ${index} uit ${lijst} is gelijk aan ${waarde}
    Should be equal   @{lijst}[${index}]   ${waarde}

klopt de lijst  
    Log  De lijst klopt

waarde ${index} uit ${lijst} is niet gelijk aan ${waarde}
    Should not be equal   @{lijst}[${index}]   ${waarde}

*** Test Cases ***
Check de lijst
    waarde 0 uit ${auto} is gelijk aan Audi
    waarde 1 uit ${auto} is gelijk aan Fiat
    waarde 2 uit ${auto} is gelijk aan Maserati

De lijst klopt
    Given waarde 0 uit ${auto} is gelijk aan Audi
    And waarde 1 uit ${auto} is gelijk aan Fiat
    And waarde 2 uit ${auto} is gelijk aan Maserati
    Then klopt de lijst

Invalid lijst check met template
    [Template]   waarde ${index} uit ${lijst} is niet gelijk aan ${waarde}
    #index      #lijst      #waarde
    0           ${auto}     Maserati
    1           ${auto}     Audi
    2           ${auto}     Fiat

0 is Maserati         2           ${auto}     Maserati
1 is Audi          0           ${auto}     Audi
2 is Fiat    1           ${auto}     Fiat

Valid lijst met template uit resource
    #index      #lijst      #waarde
    2           ${auto}     Maserati
    0           ${auto}     Audi
    1           ${auto}     Fiat
