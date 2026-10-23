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
Case management
    Login salesforce
    LaunchApp    Service

    ${My_Case_Id}    ${Contact_name}=    Contact and Case Creation    Garvansh    login issue    web

    Case resolution                        ${My_Case_Id}              ${Contact_name}


    