*** Settings ***

Documentation                   New test suite
Library                         QForce
Library                         String
Library                         DateTime
Library                         RequestsLibrary
Library                         Collections
Suite Setup                     Open Browser                ${loginURL}    chrome
Suite Teardown                  Close All Browsers
Resource                        File.resource

*** Test Cases ***
    Login salesforce
    Lead record Verification    Technology    www.cyntexa.com
    Lead record Verification    
    


*** Keywords ***
Lead record Verification
    [Arguments]    ${Industry}    ${Web}
    ${Lead}        ${Random_Comp}    ${Lead_Name}=       Backend Lead Creation    ${Industry}    ${Web} 

    GoTo           ${domain}/lightning/r/Lead/${Lead}/view
    ClickText      Details
    Run Keyword And Warn On Failure  VerifyField    Name                  ${Lead_Name} 
    VerifyField    Industry              ${Industry}
    VerifyField    Website               ${Web}  
    

    



