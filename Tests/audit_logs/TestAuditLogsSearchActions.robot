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
${CODE}     3
${ACTION}   Searched Subscriber No

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

Redirect to Audit Logs Page
    [Documentation]     Redirect to Audit Logs Page
    [Tags]  Audit Logs Page
    AuditLogsTCs.Redirect to Audit Logs Page

Search and Validate Fields using Broadband/Mobile Number
    [Documentation]     Search using User Broadband/Mobile in Action
    [Tags]  Search by Action
    Run Keyword If  "${CODE}"=="Broadband"     AuditLogsTCs.Search and Verify Fields using Broadband Landline No    ${CODE}     ${ACTION}
    ...  ELSE IF  "${CODE}"=="HPW" or "${CODE}"=="Prepaid" or "${CODE}"=="TM"    AuditLogsTCs.Search and Verify Fields for HPW TM and Prepaid using Mobile No       ${CODE}     ${ACTION}
    ...  ELSE IF  "${CODE}"=="Postpaid Regular 1" or "${CODE}"=="Postpaid Platinum"    AuditLogsTCs.Search and Verify Fields LTP MSP Postpaid Regular and Platinum using Mobile No       ${CODE}     ${ACTION}
    ...  ELSE IF  "${CODE}"=="LTP" or "${CODE}"=="MSP"    AuditLogsTCs.Search and Verify Fields LTP MSP Postpaid Regular and Platinum using Mobile No       ${CODE}     ${ACTION}

Search and Validate Fields using Account Number
    [Documentation]     Search using User Account in Action.
    [Tags]  Search by Action
    Run Keyword If  "${CODE}"=="Broadband"     AuditLogsTCs.Search and Verify Fields Broadband Account No      ${CODE}     ${ACTION}
    ...  ELSE IF  "${CODE}"=="Postpaid Regular 1" or "${CODE}"=="Postpaid Platinum"     AuditLogsTCs.Search and Verify Fields LTP MSP Postpaid Regular and Platinum using Account No     ${CODE}     ${ACTION}
    ...  ELSE IF  "${CODE}"=="LTP" or "${CODE}"=="MSP"    AuditLogsTCs.Search and Verify Fields LTP MSP Postpaid Regular and Platinum using Account No       ${CODE}     ${ACTION}

Logout User
    GlobeLogout.Perform Logout