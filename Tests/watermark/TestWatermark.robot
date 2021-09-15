*** Settings ***
Documentation  US-08-01 - Test Watermark on SearchPage
Resource    ../Resources/search_page/SearchPageTCs.robot
Resource    ../Resources/OpenCloseBrowserKeywords.robot
Resource    ../Resources/GlobeLoginKeywords.robot
Resource    ../Resources/GlobeLogout.robot

Suite Setup    OpenCloseBrowserKeywords.OpenChromeBrowser
Suite Teardown   OpenCloseBrowserKeywords.CloseTheBrowser
Library  Collections

*** Variables ***
${SEARCH_ROLE}    Hotline Onsite

*** Test Cases ***

Log In To Globe UD
    [Documentation]     Login to UD Web Page
    [Tags]  Login User
    GlobeLoginKeywords.Open Globe Login Page
    GlobeLoginKeywords.User Login    ${SEARCH_ROLE}

Verify Search Page Window
    [Documentation]     Verify Search Window is displayed
    [Tags]  Verify Search Page
    SearchPageTCs.Verify Dashboard Page

Verify Watermark in the Page
    [Documentation]     Verify if the Watermark is Displayed
    [Tags]  Verify Watermarm
    Run Keyword If  "${SEARCH_ROLE}"=="Hotline Onsite"  SearchPageTCs.Check If Has Watermarks Hotline
    Run Keyword If  "${SEARCH_ROLE}"=="Store Onsite"  SearchPageTCs.Check If Has Watermarks Store

Perform Logout
    [Documentation]     Perform Logout
    [Tags]  Logout User
    GlobeLogout.Perform Logout