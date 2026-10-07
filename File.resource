*** Settings ***
Library                         String
Library                         DateTime
Library                         QForce
Library                         QWeb

*** Variables ***
${loginURL}                     https://login.salesforce.com/
${username}                     garvanshcrt@cyntexa.com
${password}                     @MITTAL123
${passkey}                      N6UNWU7URS

${domain}                       https://orgfarm-55fe4cdac9-dev-ed.develop.my.salesforce.com
${ClientId}                     3MVG91oqviqJKoEFP0o2GjFFWVIq5JktxHDTBhZfoeOt6xL75qlB5MOxA8.3wDFU7HWHZ9HIyH4nd5C2nNZEu
${ClientSecret}                 8FF9D5E9842AA5FC14B6BC7D08ED531D2CB84C559097CA81CF36F13EC4F3EF41

*** Keywords ***
Login salesforce
    TypeText                    Username                    ${username}
    ClickText                   Log in
    TypeText                    Password                    ${password}
    ClickText                   Log in
    TypeText                    Verification Code           ${passkey}
    ClickText                   Verify
    VerifyText                  Developer Edition

Backend Record Creation 
    [Arguments]                ${Provide_Rating}
    ${Random}=                  Get Current Date            result_format=%H:%M
    ${Dynamic}=                 Catenate                    Garvansh                    ${Random}
    ${DynamicContact}=          Catenate                    Gcon-                       ${Random}
    Wait Until Keyword Succeeds                             2x                          3s                          ClientAuthenticate       ${domain}      ${ClientId}         ${client_secret}

    ${Accounts}                 Create record               Account                     Name=${Dynamic}             Rating=${Provide_Rating}
    Log To Console              AccountId: ${Accounts}
    UpdateRecord                Account                     ${Accounts}                 Phone=1234567899

    ${Contacts}                 Create record               Contact                     LastName=${DynamicContact}                           AccountId=${Accounts}
    Log To Console              ContactId: ${Contacts}

    ${Query}                    QueryRecords                query= Select id,Name from Account Where CreatedDate = TODAY Order By CreatedDate Desc limit 1
    RETURN                      ${Accounts}                 ${DynamicContact}