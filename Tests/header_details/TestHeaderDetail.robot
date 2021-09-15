*** Settings ***
Documentation  US-09-02;US-09-03;US-09-04;;US-09-05;US-09-06;US-09-07 - Test and Validate User Header Details
Resource    ../Resources/search_page/SearchPageTCs.robot
Resource    ../Resources/brands_header/BrandsHeaderTCs.robot
Resource    ../Resources/OpenCloseBrowserKeywords.robot
Resource    ../Resources/GlobeLoginKeywords.robot
Resource    ../Resources/GlobeLogout.robot

Suite Setup    OpenCloseBrowserKeywords.OpenChromeBrowser
Suite Teardown   OpenCloseBrowserKeywords.CloseTheBrowser
Library  Collections

*** Variables ***
${HEADER_ROLE}    Hotline Manager

${BRAND}   TM
${SEARCH}  msisdn

*** Test Cases ***

Login to Globe
    [Documentation]     Login to UD Web Page
    [Tags]  Login User
    Log to Console   ${BRAND} User 
    GlobeLoginKeywords.Open Globe Login Page
    GlobeLoginKeywords.User Login    ${HEADER_ROLE}

Test Search Page
    [Documentation]     Initialize Search Option
    [Tags]  Search Page
    SearchPageTCs.Verify Dashboard Page
    SearchPageTCs.Search Account in Dashboard        ${BRAND}    ${SEARCH}
    SearchPageTCs.Validate Subscriber Data           ${BRAND}

Test Brands Header
    [Documentation]     Validate User's Header Details
    [Tags]  Header Details
    BrandsHeaderTCs.Redirect to Agents Dashboard
    # ${data}=  BrandsHeaderTCs.Get Customer Information  ${BRAND}
    ${data}=  BrandsHeaderTCs.Get Customer Information             ${BRAND}
    Run Keyword If  "${BRAND}"=="Prepaid" or "${BRAND}"=="TM"                                 BrandsHeaderTCs.Validate Prepaid Headers       ${data}
    ...  ELSE IF  "${BRAND}"=="Postpaid Regular 1" or "${BRAND}"=="Postpaid Platinum"         BrandsHeaderTCs.Validate Postpaid Headers      ${data}
    ...  ELSE IF  "${BRAND}"=="HPW"                                                           BrandsHeaderTCs.Validate HPW Headers           ${data}
    ...  ELSE IF  "${BRAND}"=="LTP" or "${BRAND}"=="MSP"                                      BrandsHeaderTCs.Validate LTP/MSP Headers       ${data}

Logout User
    GlobeLogout.Perform Logout