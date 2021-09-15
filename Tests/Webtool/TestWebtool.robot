*** Settings ***
Documentation  US-17-01;US-17-02;US-17-03;US-17-05;US-17-06;US-17-07 - Test Webtool Verification Using Manager Users
Resource    ../Resources/search_page/SearchPageTCs.robot
Resource    ../Resources/brands_header/BrandsHeaderTCs.robot
Resource    ../../Resources/dashboard/DashboardTCs.robot
Resource    ../../Resources/Webtool/WebtoolTC.robot
Resource    ../../Resources/OpenCloseBrowserKeywords.robot
Resource    ../../Resources/GlobeLoginKeywords.robot
Resource    ../Resources/GlobeLogout.robot

Suite Setup    OpenCloseBrowserKeywords.OpenChromeBrowser
Suite Teardown   OpenCloseBrowserKeywords.CloseTheBrowser
Library  Collections

*** Variables ***
${WEBTOOL_ROLE}    Hotline Manager
${BRAND}   TM
${SEARCH}   msisdn

*** Test Cases ***

Login to Globe
    [Documentation]     Login to UD Web Page
    [Tags]  Login User
    GlobeLoginKeywords.Open Globe Login Page
    GlobeLoginKeywords.User Login    ${WEBTOOL_ROLE}

Test Search Page
    [Documentation]     Search for the User's Credentials
    [Tags]  Search User's Credentials
    SearchPageTCs.Verify Dashboard Page
    Search Account in Dashboard     ${BRAND}   ${SEARCH}

Test Brands Header
    [Documentation]     Data Preparation and Redirect to Dashboard
    [Tags]  Go to Dashboard
    BrandsHeaderTCs.Redirect to Agents Dashboard

Test Webtool Verification
    [Documentation]     Verify the Contents of User's Webtool
    [Tags]  Webtool Verification
    WebtoolTC.Redirect to Webtool Tab
    Run Keyword If  "${BRAND}"=="Prepaid" or "${BRAND}"=="TM"                                 WebtoolTC.Verify Webtool Prepaid/TM Labels and Hyperlink
    ...  ELSE IF  "${BRAND}"=="Postpaid Regular 1" or "${BRAND}"=="Postpaid Platinum"         WebtoolTC.Verify Webtool Postpaid Regular and Platinum Labels and Hyperlink
    ...  ELSE IF  "${BRAND}"=="MSP" or "${BRAND}"=="LTP"                                      WebtoolTC.Verify Webtool LTP/MSP Labels and Hyperlink
    ...  ELSE IF  "${BRAND}"=="HPW"                                                           WebtoolTC.Verify Webtool Broadband/HPW Labels and Hyperlink

Logout User
    GlobeLogout.Perform Logout