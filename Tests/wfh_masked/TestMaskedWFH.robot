*** Settings ***
Documentation  US-11-02;US-11-03;US-11-04;US-11-05;US-11-06;US-11-07 - Test WFH Masked VerificationHeader Details
Resource    ../Resources/search_page/SearchPageTCs.robot
Resource    ../Resources/brands_header/BrandsHeaderTCs.robot
Resource    ../Resources/wfh/WFHTC.robot
Resource    ../Resources/verification/VerificationTCs.robot
Resource    ../Resources/OpenCloseBrowserKeywords.robot
Resource    ../Resources/GlobeLoginKeywords.robot
Resource    ../Resources/GlobeLogout.robot

Suite Setup    OpenCloseBrowserKeywords.OpenChromeBrowser
Suite Teardown   OpenCloseBrowserKeywords.CloseTheBrowser
Library  Collections

*** Variables ***
${WFH_ROLE}    Hotline Manager

${BRAND}   TM
${SEARCH}  msisdn

*** Test Cases ***

Login to Globe
    [Documentation]     Login to UD Web Page
    [Tags]  Login User
    Log to Console   ${BRAND} User 
    GlobeLoginKeywords.Open Globe Login Page
    GlobeLoginKeywords.User Login    ${WFH_ROLE}

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
    ${data}=  BrandsHeaderTCs.Get Customer Masked Information                                 ${BRAND}
    Run Keyword If  "${BRAND}"=="Prepaid" or "${BRAND}"=="TM"                                 BrandsHeaderTCs.Validate Prepaid Headers       ${data}
    ...  ELSE IF  "${BRAND}"=="Postpaid Regular 1" or "${BRAND}"=="Postpaid Platinum"         BrandsHeaderTCs.Validate Postpaid Headers      ${data}
    ...  ELSE IF  "${BRAND}"=="HPW"                                                           BrandsHeaderTCs.Validate HPW Headers           ${data}
    ...  ELSE IF  "${BRAND}"=="LTP" or "${BRAND}"=="MSP"                                      BrandsHeaderTCs.Validate LTP/MSP Headers       ${data}

Test WFH Brands
    [Documentation]     Validate User's Masked Verification Details Tab
    [Tags]  Verification Details
    ${data}=  BrandsHeaderTCs.Get Customer Masked Information                                 ${BRAND}
    Run Keyword If  "${BRAND}"=="Prepaid" or "${BRAND}"=="TM"                                 WFHTC.Prepaid And TM      ${data}
    ...  ELSE IF  "${BRAND}"=="LTP" or "${BRAND}"=="MSP"                                      WFHTC.LTP and MSP         ${data}
    ...  ELSE IF  "${BRAND}"=="Postpaid Regular 1"                                            WFHTC.Postpaid            ${data}
    ...  ELSE IF  "${BRAND}"=="Postpaid Platinum"                                             WFHTC.Postpaid            ${data}


Test Verification Masked Tab
    [Documentation]     Validate User's Masked Verification Details Tab
    [Tags]  Verification Details
    ${data}=  BrandsHeaderTCs.Get Customer Masked Information             ${BRAND}
    Run Keyword If  "${BRAND}"=="Postpaid Regular 1" or "${BRAND}"=="Postpaid Platinum"       VerificationTCs.Redirect to Verification Details Tab
    ...  ELSE IF  "${BRAND}"=="Postpaid Regular 2"                                            VerificationTCs.Redirect to Verification Details Tab

    Run Keyword If  "${BRAND}"=="Postpaid Regular 1" or "${BRAND}"=="Postpaid Platinum"       VerificationTCs.Validate Postpaid      ${data}
    ...  ELSE IF  "${BRAND}"=="Postpaid Regular 2"                                            VerificationTCs.Validate Postpaid      ${data}

Logout User
    GlobeLogout.Perform Logout