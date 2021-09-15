*** Settings ***
Documentation  US-20-02 - Test Audit Logs using Filters
Resource    ../Resources/search_page/SearchPageTCs.robot
Resource    ../../Resources/audit_logs/AuditLogsTCs.robot
Resource    ../Resources/OpenCloseBrowserKeywords.robot
Resource    ../Resources/GlobeLoginKeywords.robot
Resource    ../Resources/GlobeLogout.robot

Suite Setup    OpenCloseBrowserKeywords.OpenChromeBrowser
Suite Teardown   OpenCloseBrowserKeywords.CloseTheBrowser
Library  Collections

*** Variables ***
${AUDIT_ROLE}    Hotline Manager
${BRAND}    TM
${SEARCH}   msisdn

*** Test Cases ***

Login to Globe
    [Documentation]     Login to UD Web Page
    [Tags]  Login User
    GlobeLoginKeywords.Open Globe Login Page
    GlobeLoginKeywords.User Login    ${AUDIT_ROLE}

Test Search Page
    [Documentation]     Search the User from Search Page
    [Tags]  Search User
    SearchPageTCs.Verify Dashboard Page
    SearchPageTCs.Search Account in Dashboard        ${BRAND}    ${SEARCH}
    AuditLogsTCs.Verify Search Loaded

Redirect to Audit Logs Page
    [Documentation]     Redirect User to Audit Logs Page
    [Tags]  Audit Logs Page
    AuditLogsTCs.Redirect to Audit Logs Page

Validate the Date Filter
    [Documentation]     Verify Date Picker is Functional
    [Tags]  Date Picker
    AuditLogsTCs.Verify Current Date form Date Filter

Validate Network ID and Subscriber Number Text Fields
    [Documentation]     Verify Network ID Search Texts
    [Tags]  Network ID Search Texts
    AuditLogsTCs.Validate Functionality of Search Network ID            ${AUDIT_ROLE}
    AuditLogsTCs.Validate Functionality of Search Subscriber Number     ${BRAND}

Validate the Funtionality of Actions
    [Documentation]     Verify the Function of Actions
    [Tags]  Verify Action
    AuditLogsTCs.Check Default Action and Dropdown List
    AuditLogsTCs.Verify The List from Action Dropdown

Logout User
    GlobeLogout.Perform Logout