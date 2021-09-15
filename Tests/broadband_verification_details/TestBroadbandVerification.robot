*** Settings ***
Documentation  US-10-03; US-11-01 - Test Broadband Verification Using Manager Users
Resource    ../Resources/search_page/SearchPageTCs.robot
Resource    ../Resources/brands_header/BrandsHeaderTCs.robot
Resource    ../Resources/verification/VerificationTCs.robot
Resource    ../Resources/OpenCloseBrowserKeywords.robot
Resource    ../Resources/GlobeLoginKeywords.robot
Resource    ../Resources/GlobeLogout.robot

Suite Setup    OpenCloseBrowserKeywords.OpenChromeBrowser
Suite Teardown   OpenCloseBrowserKeywords.CloseTheBrowser
Library  Collections

*** Variables ***
${VERIFY_ROLE}    Hotline Manager

${ID}   7
${SEARCH}

*** Test Cases ***

Login to Globe
    [Documentation]     Login to UD Web Page
    [Tags]  Login User
    GlobeLoginKeywords.Open Globe Login Page
    GlobeLoginKeywords.User Login    ${VERIFY_ROLE}

Test Search Page
    [Documentation]     Search the Landline or Account Number
    [Tags]  Search Landline or Account
    SearchPageTCs.Verify Dashboard Page
    SearchPageTCs.Search Broadband in Dashboard     ${ID}    ${SEARCH}
    #Run Keyword If  "${HEADER_ROLE}"=="Hotline Onsite"  SearchPageTCs.Check If Has Watermarks Hotline
    #Run Keyword If  "${HEADER_ROLE}"=="Store Onsite"    SearchPageTCs.Check If Has Watermarks Store
    BrandsHeaderTCs.Redirect to Agents Dashboard

Test Validate Primary Details
    [Documentation]     Verify the Broadband Primary Details in the Dashboard
    [Tags]  Validate Primary Details
    Run Keyword If  "${VERIFY_ROLE}"=="Hotline Manager" or "${VERIFY_ROLE}"=="Store Manager"  BrandsHeaderTCs.Validate Broadband Primary Details      ${ID}
    ...  ELSE IF  "${VERIFY_ROLE}"=="Hotline Onsite" or "${VERIFY_ROLE}"=="Store Onsite"    BrandsHeaderTCs.Validate Broadband Primary Masked Details  ${ID}

Test Validate Secondary Details
    [Documentation]     Verify the Broadband Secondary Details in the Dashboard
    [Tags]  Validate Secondary Details
    Run Keyword If  "${VERIFY_ROLE}"=="Hotline Manager" or "${VERIFY_ROLE}"=="Store Manager"  BrandsHeaderTCs.Validate Broadband Secondary Details      ${ID}
    ...  ELSE IF  "${VERIFY_ROLE}"=="Hotline Onsite" or "${VERIFY_ROLE}"=="Store Onsite"    BrandsHeaderTCs.Validate Broadband Secondary Masked Details  ${ID}


Test Verification Tab
    [Documentation]     Verify the Contents of Verification Details
    [Tags]  Verification Details
    VerificationTCs.Redirect to Verification Details Tab

Test Account Verification Details
    [Documentation]     Verify the Account of Verification Details
    [Tags]  Account Verification Details
    Run Keyword If  "${VERIFY_ROLE}"=="Hotline Manager" or "${VERIFY_ROLE}"=="Store Manager"  VerificationTCs.Validate Broadband Account Verification Details      ${ID}
    ...  ELSE IF  "${VERIFY_ROLE}"=="Hotline Onsite" or "${VERIFY_ROLE}"=="Store Onsite"    VerificationTCs.Validate Broadband Masked Account Verification Details  ${ID}

Test Contract Verification Details
    [Documentation]     Verify the Contract of Verification Details
    [Tags]  Account Contract Details
    Validate Broadband Contract Verification Details     ${ID}

Test Billing Verification Details
    [Documentation]     Verify the Billing of Verification Details
    [Tags]  Billing Verification Details
    Run Keyword If  "${VERIFY_ROLE}"=="Hotline Manager" or "${VERIFY_ROLE}"=="Store Manager"  VerificationTCs.Validate Broadband Billing Verification Details    ${ID}
    ...  ELSE IF  "${VERIFY_ROLE}"=="Hotline Onsite" or "${VERIFY_ROLE}"=="Store Onsite"    VerificationTCs.Validate Broadband Masked Billing Verification Details  ${ID}

Logout User
    GlobeLogout.Perform Logout