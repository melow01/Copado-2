*** Settings ***

Documentation                   New test suite
Library                         QForce
Library                         String
Library                         DateTime
Library                         RequestsLibrary
Library                         Collections
Suite Setup                     Open Browser                ${loginURL}              chrome
Suite Teardown                  Close All Browsers
Resource                        File.resource

*** Test Cases ***
Validation check
    Login salesforce

    Lead record Verification    Technology                  www.cyntexa.com
    Lead record Verification    Technology                  ${Empty}



*** Keywords ***
Lead record Verification
    [Arguments]                 ${Industry}                 ${Web}

    IF                          "${Web}" == "${Empty}"
        Run Keyword And Expect Error                        *Bad Request*                         Backend Lead Creation    ${Industry}    ${Web}
        Log To Console          Negative Test case passed
    ELSE
        ${Lead}                     ${Random_Comp}              ${Lead_Name}=            Backend Lead Creation    ${Industry}    ${Web}
        GoTo                    ${domain}/lightning/r/Lead/${Lead}/view
        ClickText               Details
        Run Keyword And Warn On Failure                     VerifyField              Name                     ${Lead_Name}
        VerifyField             Industry                    ${Industry}
        VerifyField             Website                     ${Web}
    END




    








