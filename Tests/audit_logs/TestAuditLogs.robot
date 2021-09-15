*** Settings ***
Documentation  US-20-01 - Test Audit Logs Dashboard Verifications
Resource    ../Resources/search_page/SearchPageTCs.robot
Resource    ../../Resources/audit_logs/AuditLogsTCs.robot
Resource    ../../Resources/OpenCloseBrowserKeywords.robot
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
    [Documentation]     Login to  Web Page
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
    [Documentation]     Redirect to Audit Logs Page
    [Tags]  Audit Logs Page
    AuditLogsTCs.Redirect to Audit Logs Page

Verify Audit Logs Labels from Dashboard
    [Documentation]     Validate the Labels in Audit Logs Dashboard
    [Tags]  Validate Labels
    AuditLogsTCs.Verify Audit Logs Dashboard Labels

Verify Change Rows and Pagination
    [Documentation]     Validate the Rows and Pagination are Functional
    [Tags]  Validate Rows and Pagination
    AuditLogsTCs.Select Rows to Display and Change Pagination

Validate Brand Column Contains TM
    [Documentation]     Validate the TM Brand from the Dashboard
    [Tags]  Validate Brand
    ${BRAND}=   Set Variable    TM
    AuditLogsTCs.Search TM from Dashboard   ${BRAND}

Validate Brand Column Contains Prepaid
    [Documentation]     Validate the Prepaid Brand from the Dashboard
    [Tags]  Validate Brand
    ${BRAND}=   Set Variable    Prepaid
    AuditLogsTCs.Search Prepaid from Dashboard  ${BRAND}

Validate Brand Column Contains Postpaid
    [Documentation]     Validate the Postpaid Brand from the Dashboard
    [Tags]  Validate Brand
    ${BRAND}=   Set Variable    Postpaid Regular 1
    AuditLogsTCs.Search Postpaid from Dashboard  ${BRAND}

Validate Brand Column Contains LTP
    [Documentation]     Validate the LTP Brand from the Dashboard
    [Tags]  Validate Brand
    ${BRAND}=   Set Variable    LTP
    AuditLogsTCs.Search LTP from Dashboard  ${BRAND}

Validate Brand Column Contains HPW
    [Documentation]     Validate the HPW Brand from the Dashboard
    [Tags]  Validate Brand
    ${BRAND}=   Set Variable    HPW
    AuditLogsTCs.Search HPW from Dashboard  ${BRAND}

Validate Brand Column Contains Broadband
    [Documentation]     Validate the Broadband Brand from the Dashboard
    [Tags]  Validate Brand
    ${BRAND}=   Set Variable    7
    AuditLogsTCs.Search Broadband from Dashboard  ${BRAND}

Return to Search Page
    [Documentation]     Return to Search Main Menu
    [Tags]  Search Page Menu
    AuditLogsTCs.Redirect to Search Page

Logout User
    GlobeLogout.Perform Logout