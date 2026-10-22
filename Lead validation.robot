*** Settings ***

Documentation                   New test suite
Library                         QForce
Library                         String
Library                         DateTime
Library                         RequestsLibrary
Library                         Collections
Suite Setup                     Open Browser          ${loginURL}        chrome
Suite Teardown                  Close All Browsers
Resource                        File.resource




*** Test Cases ***
Validation check
    Login salesforce

    Lead record Verification    Technology            www.cyntexa.com


    ClickText                   Edit Website
    TypeText                    Website               ${Empty}
    ClickText                   Save
    Wait Until Keyword Succeeds                       2x                 3s            VerifyText                  We hit a snag
    Wait Until Keyword Succeeds                       2x                 3s            VerifyText                  Provide Website URL for Technology leads
    # Lead record Verification                        Technology         ${Empty}

Lead Creation 
    ${Random}    Get Current Date    result_format=%H:%M
    ${Lead_Name}           Catenate            Garvansh    ${Random}
    ${Random_Comp}    Catenate            Comp        ${Random}
    Login salesforce

    Lead record Generation      ${Lead_Name}              Test             ${Random_Comp}
    Lead record Generation      ${Lead_Name}                 Test             ${Random_Comp}














