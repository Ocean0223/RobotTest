*** Settings ***
Documentation    US-01-01 - Test Login Page
Library    Collections
Resource    ../Resources/OpenCloseBrowserKeywords.robot
Resource    ../Resources/GlobeLoginKeywords.robot

Suite Setup      OpenCloseBrowserKeywords.OpenChromeBrowser
Suite Teardown   OpenCloseBrowserKeywords.CloseTheBrowser
Test Setup       GlobeLoginKeywords.Open Globe Login Page
Test Teardown    GlobeLoginKeywords.Close Globe Login Page

*** Variables ***
${ROLE}    Hotline Manager

*** Test Cases ***
Login Valid Username Invalid Password
    [Documentation]     Test Login with Invalid Password
    [Tags]  Login User
    @{list} =  GlobeLoginKeywords.Valid Username InValid Password    ${ROLE}
    Write Logs     @{list}

Login InValid Username Valid Password
    [Documentation]     Test Login with Invalid Username
    [Tags]  Login User
    @{list}    ${label} =  GlobeLoginKeywords.InValid Username Valid Password    ${ROLE}
    Write Logs     @{list}    ${label}

Login InValid Username InValid Password
    [Documentation]     Test Login with Invalid Username and Password
    [Tags]  Login User
    @{list}    ${label} =  GlobeLoginKeywords.InValid Username InValid Password    ${ROLE}
    Write Logs     @{list}    ${label}

Login Blank Username Valid Password
    [Documentation]     Test Login with Blank Username
    [Tags]  Login User
    @{list}    ${label} =  GlobeLoginKeywords.Blank Username Valid Password    ${ROLE}
    Write Logs     @{list}    ${label}

Login Valid Username Blank Password
    [Documentation]     Test Login with Blank Password
    [Tags]  Login User
    @{list}    ${label} =  GlobeLoginKeywords.Valid Username Blank Password    ${ROLE}
    Write Logs     @{list}    ${label}

Login Blank Username Blank Password
    [Documentation]     Test Login with Blank Username and Password
    [Tags]  Login User
    @{list}    ${label} =  GlobeLoginKeywords.Blank Username Blank Password    ${ROLE}
    Write Logs     @{list}    ${label}

LogIn Valid Username Valid Password
    [Documentation]     Test Login with Valid Username and Password
    [Tags]  Login User
    @{list}    ${label} =  GlobeLoginKeywords.Valid Username Valid Password    ${ROLE}
    Write Logs     @{list}    ${label}
    sleep    10s

*** Keywords ***
Write Logs
    [Arguments]     @{list}
    ${txt}=    Catenate     Role:  ${list}[0]
    ...    Username:    ${list}[1]
    ...    Password:    ${list}[2]
    Log    ${txt}
    Log to console    ..
    Log to console    ${txt}
    Log to console    ${list}[4]

