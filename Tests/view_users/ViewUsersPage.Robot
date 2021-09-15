*** Settings ***
Documentation    US-02-01 - Validate View Users Page
Resource    ../../Resources/RBA/ViewUsersTC.Robot
Resource    ../Resources/OpenCloseBrowserKeywords.robot
Resource    ../Resources/GlobeLoginKeywords.robot
Resource    ../Resources/GlobeLogout.robot

Suite Setup    OpenCloseBrowserKeywords.OpenChromeBrowser
Suite Teardown   OpenCloseBrowserKeywords.CloseTheBrowser
Library  Collections

*** Variables ***
${SEARCH_ROLE}     RBA Account

*** Test Cases ***
Test View Users Page
    [Documentation]     Login to UD Web Page
    [Tags]  Login User
    GlobeLoginKeywords.Open Globe Login Page
    GlobeLoginKeywords.User Login    ${SEARCH_ROLE}
    sleep    30 s

Verify the Dashboard Labels
    [Documentation]     Verify the Dashboard Labels
    [Tags]  Verify the Dashboard Labels
    ViewUsersTC.Verify Dashboard Labels

Click Action From the Table
    [Documentation]     Verify Actions Are Responsive
    [Tags]  Verify the Dashboard Action
    ViewUsersTC.Verify Actions Are Responsive

Select User From Table
    [Documentation]     Select User From Table
    [Tags]  Select User from the Dashboard
    ViewUsersTC.Click User From Any Row

Redirect to User Details Page
    [Documentation]     Redirect to User Details Page
    [Tags]  Redirect to User Details Page
    ViewUsersTC.Verify User Details Page

Verify the User Role in Dashboard
    [Documentation]     Hover to User Role from the Dashboard
    [Tags]  Hover to User Role
    ViewUsersTC.Verify Popover Details

Select Page Row in Dropdown List
    [Documentation]     Select Page Row in Dropdown List
    [Tags]  Select Page Row
    ViewUsers.Select Row from Dropdownlist

Logout User
    GlobeLogout.Perform Logout
