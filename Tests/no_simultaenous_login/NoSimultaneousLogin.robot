*** Settings ***
Documentation  US-13-01 - Test Login 2 Same Users in 2 Different Browsers
Library        SeleniumLibrary
Library     ../libraries/webdriverinstall.py
Library        Collections
Resource    ../Resources/GlobeLoginKeywords.robot
Resource    ../Resources/OpenCloseBrowserKeywords.robot
Library        DataDriver  ../fixtures/udaa_fixtures.xlsx  sheet_name=TestSimultaneousLogin
Library        OperatingSystem

Test Setup       Logger
Test Teardown    Logger    # OpenCloseBrowserKeywords.CloseAllBrowsers
Test Template    Log 2 Same Accounts In A Browser

*** Variables ***
${ROLE}    RBA Account
${BROWSER1}    browserOne
${BROWSER2}    browserTwo

*** Test Cases ***
Simultaneous Login - ${xlrole}

*** Keywords ***
Log 2 Same Accounts In A Browser
    [Documentation]     Test Login with 2 Same Account
    [Tags]  No Simultaenous Login
    [Arguments]  ${xlrole}
    First Browser LogIn    ${xlrole}
    Second Browser LogIn   ${xlrole}
    Handle Browsers
    # ${status} =    Run Keyword And Return Status    Wait Until Element Is Visible   //div[@class='session-invalid']
    Write Logs    \n-- User logged in another browser\n-- User in first browser has been logged out

First Browser LogIn
    [Documentation]     Test Login in First Browser
    [Tags]  No Simultaenous Login
    [Arguments]  ${xlrole}
    Write Logs    \n-- Login with First Browser
    Open Chrome Browser
    LogIn Account    ${xlrole}
    Wait to Login

Second Browser LogIn
    [Documentation]     Test Login in Second Browser
    [Tags]  No Simultaenous Login
    [Arguments]  ${xlrole}
    Write Logs    \n-- Login with Second Browser
    Open Chrome Browser
    set window position    500    30
    LogIn Account    ${xlrole}
    Wait to Login

Handle Browsers
    [Documentation]     Test Browser Handling
    [Tags]  No Simultaenous Login
    @{handles}    get browser ids
    switch browser    ${handles}[0]
    reload page
    sleep    2s
    Close Browser
    switch browser    ${handles}[1]
    sleep    1s
    Close Browser

LogIn Account
    [Documentation]     Test Login Account
    [Tags]  No Simultaenous Login
    [Arguments]    ${role}
    GlobeLoginKeywords.Open Globe Login Page
    GlobeLoginKeywords.Valid Username Valid Password    ${role}

Open Chrome Browser
    [Documentation]     Test Open Browser
    [Tags]  No Simultaenous Login
    ${chromedriver_path}=  webdriverinstall.get_chromedriver_path
    Log To Console    open chrome browser
    Create Webdriver    Chrome    executable_path=${chromedriver_path}

Wait to Login
    [Documentation]     Wait Login Results
    [Tags]  No Simultaenous Login
    set selenium speed    1s
    FOR    ${i}    IN RANGE    1    999
        ${status} =    run keyword and return status    title should be    Login
        IF    '${status}' == 'False'
            exit for loop
        END
    END
    set selenium speed    0s

Logger
    log    wait...
