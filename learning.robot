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
    # Duplicate check
    #                           ${Random_Time}              Get Current Date
    #                           ${Dynamic_name}             Catenate       Garvansh      ${Random_Time}
    #                           Login salesforce
    #                           ClickText                   Contacts
    #                           ClickText                   New
    #                           ClickText                   Last Name
    #                           TypeText                    Last Name      ${Dynamic_name}
    #                           ScrollTo                    xpath\=//label[text()\='Email']
    #                           TypeText                    Email          Duplicate@mail123.com
    #                           ClickText                   Save           partial_match=False

    # Opportunity stage check
    # Login salesforce
    # ${popup_exists}           GetElementCount             xpath\=//button[contains(text(),'Dismiss')]
    # IF                        ${popup_exists} > 0
    #                           ClickText                   Dismiss
    # END
    # CLickText                 Opportunities

    # FOR                       ${Opportunities}            IN             @{Opportunities}
    #                           ${Stage}                    GetText        xpath\=
    #                           IF

    #                           END

    # END
Direct record creation
    Backend Record Creation
    ${Accounts}    ${DynamicContact}=    Backend record creation 
    Login salesforce
    GoTo                        ${domain}/lightning/r/Account/${Accounts}/view
    ClickText                   Details
    Run Keyword And Warn On Failure                         VerifyField    Phone         1234567899
    ClickText                   Related
    Wait Until Keyword Succeeds                             3x             5s            VerifyText           ${DynamicContact}
    ClickText                   ${DynamicContact}
    ClickText                   Details
    DeleteRecord                Account                     ${Accounts}