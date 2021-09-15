*** Settings ***
Documentation  US-09-01; US-11-01 - Test Broadband Details Using Manager and Onsite Users
Resource    ../Resources/search_page/SearchPageTCs.robot
Resource    ../Resources/brands_header/BrandsHeaderTCs.robot
Resource    ../Resources/OpenCloseBrowserKeywords.robot
Resource    ../Resources/GlobeLoginKeywords.robot
Resource    ../Resources/GlobeLogout.robot

Suite Setup    OpenCloseBrowserKeywords.OpenChromeBrowser
Suite Teardown   OpenCloseBrowserKeywords.CloseTheBrowser
Library  Collections

*** Variables ***
${HEADER_ROLE}    Store Manager

${ID}   1
${SEARCH}  landline service no

*** Test Cases ***

Login to Globe
    [Documentation]     Login to UD Web Page
    [Tags]  Login User
    GlobeLoginKeywords.Open Globe Login Page
    GlobeLoginKeywords.User Login    ${HEADER_ROLE}

Test Search Page
    [Documentation]     Search the Broadband or Account Number
    [Tags]  Search Broadband or Account
    SearchPageTCs.Verify Dashboard Page
    SearchPageTCs.Search Broadband in Dashboard     ${ID}    ${SEARCH}
    Run Keyword If  "${HEADER_ROLE}"=="Hotline Onsite"  SearchPageTCs.Check If Has Watermarks Hotline
    Run Keyword If  "${HEADER_ROLE}"=="Store Onsite"    SearchPageTCs.Check If Has Watermarks Store

Test Validate Primary Details
    [Documentation]     Verify the Broadband Primary Details in the Dashboard
    [Tags]  Validate Primary Details
    BrandsHeaderTCs.Redirect to Agents Dashboard
    Run Keyword If  "${HEADER_ROLE}"=="Hotline Manager" or "${HEADER_ROLE}"=="Store Manager"  BrandsHeaderTCs.Validate Broadband Primary Details      ${ID}
    ...  ELSE IF  "${HEADER_ROLE}"=="Hotline Onsite" or "${HEADER_ROLE}"=="Store Onsite"    BrandsHeaderTCs.Validate Broadband Primary Masked Details  ${ID}

Test Validate Secondary Details
    [Documentation]     Verify the  Secondary Details in the Dashboard
    [Tags]  Validate Secondary Details
    Run Keyword If  "${HEADER_ROLE}"=="Hotline Manager" or "${HEADER_ROLE}"=="Store Manager"  BrandsHeaderTCs.Validate Broadband Secondary Details      ${ID}
    ...  ELSE IF  "${HEADER_ROLE}"=="Hotline Onsite" or "${HEADER_ROLE}"=="Store Onsite"    BrandsHeaderTCs.Validate Broadband Secondary Masked Details  ${ID}
