*** Settings ***
Library                         String
Library                         DateTime
Library                         QForce
Library                         QWeb

*** Variables ***
${loginURL}                     https://login.salesforce.com/
${username}                     garvanshcrt@cyntexa.com
${password}                     @GARVANSH123
${passkey}                      6LDY93R809

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

Backend Lead Creation
    [Arguments]    ${Industry_Name}    ${Website}
    ${Random}    Get Current Date    result_format=%H:%M
    ${String}    Generate Random String    8    [LOWER]
    ${Test_website}                        Set Variable    www.${String}.com
    ${Lead_Name}           Catenate            Garvansh    ${Random}
    ${Random_Comp}    Catenate            Comp        ${Random}

    Wait Until Keyword Succeeds           2x          3s    ClientAuthenticate    ${domain}    ${ClientId}    ${ClientSecret}
    
    # Lead record creation
    ${Lead}                        CreateRecord       Lead                        LastName=${Lead_Name}                Company=${Random_Comp}    Industry=${Industry_Name}    Website=${Website}
    Log To Console                 recordId:${Lead}
    RETURN                        ${Lead}             ${Lead_Name}                ${Random_Comp}
Lead record Verification
    [Arguments]                 ${Industry}                 ${Web}

    IF                          "${Web}" == "${Empty}"
        ${error_msg}=           Run Keyword And Expect Error                            *                        Backend Lead Creation    ${Industry}    ${Web}
        Should Contain          ${error_msg}                Provide Website URL for Technology leads
        Log To Console          Negative Test case passed
    ELSE
        ${Lead}                 ${Random_Comp}              ${Lead_Name}=               Backend Lead Creation    ${Industry}    ${Web}
        GoTo                    ${domain}/lightning/r/Lead/${Lead}/view
        ClickText               Details
        Run Keyword And Warn On Failure                     VerifyField                 Name                     ${Lead_Name}
        VerifyField             Industry                    ${Industry}
        VerifyField             Website                     ${Web}
    END

Lead record Generation 

    [Arguments]    ${First_Name}    ${Last_Name}    ${Company}
    ${Random}    Get Current Date    result_format=%H:%M
    ${Lead_Name}           Catenate            Garvansh    ${Random}
    ${Random_Comp}    Catenate            Comp        ${Random}
    
    ClickText      Leads
    ClickText      New
    UseModal       On
    ClickText      First Name
    TypeText       First Name       ${First_Name}
    CLickText      Last Name
    TypeText       Last Name        ${Last_Name}
    ClickText      Company
    TypeText       Company          ${Company}
    ClickText      Save             partial_match=False
    ClickText      Details
    Run Keyword And Warn On Failure                 VerifyField    Name             ${First_Name} 
    VerifyField    Company          ${Company}
    
