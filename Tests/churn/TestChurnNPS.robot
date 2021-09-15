*** Settings ***
Documentation    US-19-01 As a User I want to see a churn and NPS indicator on the customer details page
...              As a User I want to see a churn indicator on the customer details page
Library          SeleniumLibrary
Resource      ../Resources/OpenCloseBrowserKeywords.robot
Resource      ../Resources/GlobeLoginKeywords.robot
Resource      ../Resources/CustomKeywords.robot
# Resource      ../Resources/header_links/header_links.robot
Library          Dialogs
Library          OperatingSystem
Library          DataDriver  file=../fixtures/udaa_fixtures.xlsx  sheet_name=TestDataChurnNPS

Suite Setup      GlobeLoginKeywords.Open Chrome Goto Login Page
Suite Teardown   OpenCloseBrowserKeywords.CloseTheBrowser
Test Setup      GlobeLoginKeywords.Valid Username Valid Password    Hotline Onsite
Test Teardown   GlobeLoginKeywords.LogOut User
#Suite Setup     GlobeLoginKeywords.Goto Login Page and LogIn    ${ROLE}
#Suite Teardown  OpenCloseBrowserKeywords.CloseTheBrowser
#Test Setup      Logs
#Test Teardown   Search for another account
Test Template   Test Churn and NPS

*** Variables ***
${ROLE}        Hotline Onsite    # Hotline Manager #
${MOBTELNO}    9178016980
${XPATH_AUDITLOGS}     //span[@class='my-account__text']
${SEARCH}              //input[@name='search']
${SEARCH_AGAIN}        //a[normalize-space()='Search']
${XPATH_CHURN}    //div[@class='churn__comp']/div/p[2]
${XPATH_NPS}     //div[@class='detractor__comp']/div/p
${CHURN_FLAG}    ${False}
${NPS_FLAG}      ${False}
${CHURN_TEXT}    ${EMPTY}
${NPS_TEXT}      ${EMPTY}
${LLIST}         ${EMPTY}

*** Test Cases ***
Churn is visible throughout the UD pages\nexcept on the Login and Search page\n${xlbrand} - ${xlmsisdn}

*** Keywords ***
Test Churn and NPS
    [Arguments]    ${xlbrand}    ${xlmsisdn}
    Initialize Variables
    When I Search a Customer number ${xlbrand} ${xlmsisdn}
    And I View Details of the account
    And Check All Navigation Tab for Churn and NPS messages
    Then the Churn and NPS for all tabs are visible and the same

I Search a Customer number ${xlbrand} ${xlmsisdn}
    Write Logs    \n- Search A Customer number
    Page Title Should Be    Search Accounts
    IF    '${xlbrand}' == 'BROADBAND'
        Click Elm    //span[contains(text(),'Landline/Service Number')]
    ELSE
        Click Elm    //span[contains(text(),'Mobile Number')]
    END
    Type Text   //input[@name='search']  ${xlmsisdn}
    Press Keys    //input[@name='search']    ENTER

I View Details of the account
    Click View Details Link

Check All Navigation Tab for Churn and NPS messages
    ${xpath} =    Set Variable    //ul[@class='dashboard-nav__list clearfix']/li
    ${count} =    Get Element Count    ${xpath}
    FOR    ${i}    IN RANGE    1    ${count} + 1
        Wait Until Element Is Visible    (${xpath})[${i}]    50s
        ${tab} =    Get Text    (${xpath})[${i}]
        IF    '${tab}' != 'Search'
            Write Logs    - Check CHURN and NPS in ${tab} Tab
            Click Elm    //a[@title='${tab}']
            Check CHURN and NPS if visible
        END
    END

Click View Details Link
    Wait Until Element Is Visible    //div[@class='account-group']    60s
    Click Elm    //span[@class='item-accounts__view']
    Page Title Should Be    Dashboard
    Sleep    3s

Search for another account
    Click Elm    ${SEARCH_AGAIN}
    Sleep    5s

Check CHURN and NPS if visible
    @{list} =  Create List
    ${CHURN_TEXT}    Check_Messages    ${XPATH_CHURN}    CHURN    10
    ${NPS_TEXT}    Check_Messages    ${XPATH_NPS}    NPS    3
    Append To List    ${list}    CHURN   ${CHURN_TEXT}
    Append To List    ${list}    NPS    ${NPS_TEXT}
    Append To List    ${LLIST}    @{list}

the Churn and NPS for all tabs are visible and the same
    ${len} =    Get Length    ${LLIST}
    ${x1} =    Set Variable    0
    ${x2} =    Set Variable    4
    ${y1} =    Set Variable    4
    ${y2} =    Set Variable    8
    FOR    ${i}    IN RANGE    10
        # log to console    ${x1} ${x2} ${y1} ${y2}
        Lists Should Be Equal    ${LLIST}[${x1}:${x2}]    ${LLIST}[${y1}:${y2}]
        ${x1} =    Evaluate    ${x1} + 4
        ${x2} =    Evaluate    ${x2} + 4
        ${y1} =    Evaluate    ${y1} + 4
        ${y2} =    Evaluate    ${y2} + 4
        IF    ${y2} > ${len}
            ${y1} =    Set Variable    0
            ${y2} =    Set Variable    4
        END
        IF    ${x2} > ${len}
            Exit For Loop
        END
    END

Check_Messages
    [Arguments]    ${xpath}    ${msg}    ${n}
    ${status} =    Run Keyword And Return Status    Wait Until Element Is Visible   ${xpath}    ${n}s
    IF    ${status} == ${True}
        ${count} =    Get Element Count    ${xpath}
        IF    ${count} > 1
            ${msg_txt} =    Get Text    (${xpath})[1]
        ELSE
            ${msg_txt} =    Get Text    ${xpath}
        END
    ELSE
        ${msg_txt}    Set Variable    None
    END
    Write Logs    -- ${msg} - ${msg_txt}
    [Return]    ${msg_txt}

Initialize Variables
    @{LLIST} =    Create List
    Set Global Variable    @{LLIST}

Logs
    log    wait


# #####