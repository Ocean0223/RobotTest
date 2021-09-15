*** Settings ***
Documentation       US-07-01;US-07-02;US-07-03;US-07-05;US-07-06;US-07-07 - Test Search Page Using Mobile and Account No.
Resource    ../../Resources/search_page/SearchPageTCs.robot
# Resource    ../../Resources/search_page/BrandsHeaderTCs.robot
Resource    ../../Resources/OpenCloseBrowserKeywords.robot
Resource    ../../Resources/GlobeLoginKeywords.robot
Resource    ../../Resources/GlobeLogout.robot

Suite Setup    OpenCloseBrowserKeywords.OpenChromeBrowser
Suite Teardown   OpenCloseBrowserKeywords.CloseTheBrowser
Library  Collections

*** Variables ***
${SEARCH_ROLE}    Hotline Manager

${BRAND}   TM
${SEARCH}  msisdn

*** Test Cases ***


Login to Globe
    [Documentation]     Login to UD Web Page
    [Tags]  Login User
    GlobeLoginKeywords.Open Globe Login Page
    GlobeLoginKeywords.User Login    ${SEARCH_ROLE}

Test Search Page
    [Documentation]     Initialize Search Option
    [Tags]  Search Page
    SearchPageTCs.Verify Dashboard Page
    SearchPageTCs.Initialize Radio Button  ${SEARCH}

Test Invalid Search Scenarios
    [Documentation]     Perform Negative Test Scenarios
    [Tags]  Search Page
    SearchPageTCs.Invalid Account Number
    Run Keyword If  "${SEARCH}"=="msisdn"  SearchPageTCs.Invalid MSISDN Found
    Run Keyword If  "${SEARCH}"=="account no"  SearchPageTCs.Invalid Account Number Found
    Run Keyword If  "${SEARCH_ROLE}"=="Hotline Onsite"  SearchPageTCs.Check If Has Watermarks Hotline
    Run Keyword If  "${SEARCH_ROLE}"=="Store Onsite"  SearchPageTCs.Check If Has Watermarks Store

Test Valid Search Scenarios
    [Documentation]     Perform Valid Test Scenarios
    [Tags]  Search Page
    SearchPageTCs.Search Account in Dashboard        ${BRAND}    ${SEARCH}
    SearchPageTCs.Validate Subscriber Data           ${BRAND}

Logout User
    GlobeLogout.Perform Logout