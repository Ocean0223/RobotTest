*** Settings ***
Documentation  US-11-02;US-11-03;US-11-04;US-11-05;US-11-06;US-11-07 - Test WFH Masked Verification
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
${VERIFY_ROLE}    Hotline Onsite

${BRAND}   TM
${SEARCH}  msisdn

*** Test Cases ***

Login to Globe
    [Documentation]     Login to UD Web Page
    [Tags]  Login User
    Log to Console   ${BRAND} User 
    GlobeLoginKeywords.Open Globe Login Page
    GlobeLoginKeywords.User Login    ${VERIFY_ROLE}

Test Search Page
    [Documentation]     Initialize Search Option
    [Tags]  Search Page
    SearchPageTCs.Verify Dashboard Page
    SearchPageTCs.Search Account in Dashboard        ${BRAND}    ${SEARCH}
    SearchPageTCs.Validate Subscriber Data           ${BRAND}

Test Brands Header
    [Documentation]     Validate User's Masked Header Details
    [Tags]  Header Details
    BrandsHeaderTCs.Redirect to Agents Dashboard
    ${data}=  BrandsHeaderTCs.Get Customer Masked Information       ${BRAND}
    Run Keyword If  "${BRAND}"=="Prepaid" or "${BRAND}"=="TM"                                 BrandsHeaderTCs.Validate Prepaid Headers       ${data}
    ...  ELSE IF  "${BRAND}"=="Postpaid Regular 1" or "${BRAND}"=="Postpaid Platinum"         BrandsHeaderTCs.Validate Postpaid Headers      ${data}
    ...  ELSE IF  "${BRAND}"=="Postpaid Regular 2"                                            BrandsHeaderTCs.Validate Postpaid Headers      ${data}
    ...  ELSE IF  "${BRAND}"=="HPW"                                                           BrandsHeaderTCs.Validate HPW Headers           ${data}
    ...  ELSE IF  "${BRAND}"=="LTP" or "${BRAND}"=="MSP"                                      BrandsHeaderTCs.Validate LTP/MSP Headers       ${data}

Test Verification Tab
    [Documentation]     Validate User's Masked Verification Details Tab
    [Tags]  Verification Details
    VerificationTCs.Redirect to Verification Details Tab
    ${data}=  BrandsHeaderTCs.Get Customer Masked Information       ${BRAND}
    Run Keyword If  "${BRAND}"=="Postpaid Regular 1" or "${BRAND}"=="Postpaid Platinum"       VerificationTCs.Validate Postpaid     ${data}
    ...  ELSE IF  "${BRAND}"=="Postpaid Regular 2"                                            VerificationTCs.Validate Postpaid     ${data}
    ...  ELSE IF  "${BRAND}"=="HPW"                                                           VerificationTCs.Validate HPW

Logout User
    GlobeLogout.Perform Logout