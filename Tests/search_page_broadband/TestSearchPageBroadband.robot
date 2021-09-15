*** Settings ***
Documentation    US-07-04 - Broadband Search Page
Resource    ../Resources/search_page/SearchPageTCs.robot
# Resource    ../../Resources/search_page/BrandsHeaderTCs.robot
Resource    ../Resources/OpenCloseBrowserKeywords.robot
Resource    ../Resources/GlobeLoginKeywords.robot
Resource    ../Resources/GlobeLogout.robot

Suite Setup    OpenCloseBrowserKeywords.OpenChromeBrowser
Suite Teardown   OpenCloseBrowserKeywords.CloseTheBrowser
Library  Collections

*** Variables ***
${SEARCH_ROLE}    Store Manager

${ID}   1
${SEARCH}  landline service no
${LINE}

*** Test Cases ***

Test Search Page
    GlobeLoginKeywords.Open Globe Login Page
    GlobeLoginKeywords.User Login    ${SEARCH_ROLE}

Search From Dashboard
    [Documentation]     Search the Landline or Account Number
    [Tags]  Search Landline or Account
    SearchPageTCs.Verify Dashboard Page
    SearchPageTCs.Initialize Radio Button  ${SEARCH}

Validate Search Dashboard Negative Testing
    [Documentation]     Validate Negative Test Scenarios
    [Tags]  Negative Testing
    SearchPage.Validate Search Field Is Required
    Run Keyword If  "${SEARCH}"=="account no"  SearchPageTCs.Invalid Account Number
    Run Keyword If  "${SEARCH}"=="account no"  SearchPageTCs.Invalid Account Number Found
    Run Keyword If  "${SEARCH}"=="landline service no"  SearchPageTCs.Invalid Broadband Number
    Run Keyword If  "${SEARCH}"=="landline service no"  SearchPageTCs.Invalid Landline Number Found

Validate Watermarks for Onsite Users
    [Documentation]     Validate Watermarks When Onsite Users are used
    [Tags]  Validate Watermarks
    Run Keyword If  "${SEARCH_ROLE}"=="Hotline Onsite"  SearchPageTCs.Check If Has Watermarks Hotline
    Run Keyword If  "${SEARCH_ROLE}"=="Store Onsite"  SearchPageTCs.Check If Has Watermarks Store

Validate Date From Dashboard
    [Documentation]     Validate the Data From the Dashboard
    [Tags]  Data Validation
    SearchPageTCs.Search Broadband in Dashboard     ${ID}    ${SEARCH}
    SearchPageTCs.Validate Broadband Data   ${ID}   ${LINE}
    GlobeLogout.Perform Logout
