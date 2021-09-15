*** Settings ***
Documentation   US-17-04 - Test Webtool Verification Using Manager Users
Resource    ../Resources/search_page/SearchPageTCs.robot
Resource    ../Resources/brands_header/BrandsHeaderTCs.robot
Resource    ../Resources/dashboard/DashboardTCs.robot
Resource    ../../Resources/Webtool/WebtoolTC.robot
Resource    ../Resources/OpenCloseBrowserKeywords.robot
Resource    ../../Resources/GlobeLoginKeywords.robot
Resource    ../Resources/GlobeLogout.robot

Suite Setup    OpenCloseBrowserKeywords.OpenChromeBrowser
Suite Teardown   OpenCloseBrowserKeywords.CloseTheBrowser
Library  Collections

*** Variables ***
${WEBTOOL_ROLE}    Hotline Manager
${ID}   3
${SEARCH}   landline service no

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
    SearchPageTCs.Search Broadband in Dashboard     ${ID}    ${SEARCH}

Test Brands Header
    [Documentation]     Data Preparation and Redirect to Dashboard
    [Tags]  Go to Dashboard
    BrandsHeaderTCs.Redirect to Agents Dashboard

Test Webtool Verification
    [Documentation]     Verify the Contents of User's Webtool
    [Tags]  Webtool Verification
    WebtoolTC.Redirect to Webtool Tab
    WebtoolTC.Verify Webtool Broadband/HPW Labels and Hyperlink

Logout User
    GlobeLogout.Perform Logout