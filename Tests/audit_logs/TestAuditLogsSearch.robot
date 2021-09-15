*** Settings ***
Documentation  US-21-01;US-21-02; US-21-03; US-21-04; US-21-05 - Test Audit Logs Search Users by Searched Subscriber No.
#              US-22-01;US-22-03;US-22-04;US-22-05;US-22-06;US-22-07 - Test Audit Logs Search Users by View Details
Resource    ../../Resources/search_page/SearchPageTCs.robot
Resource    ../../Resources/audit_logs/AuditLogsTCs.robot
Resource    ../Resources/OpenCloseBrowserKeywords.robot
Resource    ../../Resources/GlobeLoginKeywords.robot
Resource    ../../Resources/GlobeLogout.robot

Suite Setup    OpenCloseBrowserKeywords.OpenChromeBrowser
Suite Teardown   OpenCloseBrowserKeywords.CloseTheBrowser
Library  Collections

*** Variables ***
${AUDIT_ROLE}    Hotline Manager
${ACTION}   Searched Subscriber No

*** Test Cases ***

Login to Globe
    [Documentation]     Login to Web Page
    [Tags]  Login User
    GlobeLoginKeywords.Open Globe Login Page
    GlobeLoginKeywords.User Login    ${AUDIT_ROLE}

Test Search Page
    [Documentation]     Search the User from Search Page
    [Tags]  Search User
    SearchPageTCs.Verify Dashboard Page

Redirect to Audit Logs Page
    [Documentation]     Redirect to Audit Logs Page
    [Tags]  Audit Logs Page
    AuditLogsTCs.Redirect to Audit Logs Page

Search Items in Audit Log for "View Loading History w/ Filter"
    ${parameter}=   Set Variable    View Loading History w/ Filter
    AuditLogsTCs.Search Data in Audit Log    ${parameter}

Search Items in Audit Log for "Visit Load History"
    ${parameter}=   Set Variable    Visit Load History
    AuditLogsTCs.Search Data in Audit Log    ${parameter}

Search Items in Audit Log for "Sending of Spiels"
    ${parameter}=   Set Variable    Sending of Spiels
    AuditLogsTCs.Search Data in Audit Log    ${parameter}

Logout User
    GlobeLogout.Perform Logout