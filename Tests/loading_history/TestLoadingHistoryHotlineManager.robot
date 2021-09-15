*** Settings ***
Documentation  Bills and Payment Hotline Manager
Resource    ../../Resources/search_page/SearchPageTCs.robot
Resource    ../../Resources/brands_header/BrandsHeaderTCs.robot
Resource    ../../Resources/bills_and_payment/BillsAndPaymentTCs.robot
Resource    ../../Resources/loading_history/LoadingHistoryTCs.robot
Resource    ../../Resources/OpenCloseBrowserKeywords.robot
Resource    ../../Resources/GlobeLoginKeywords.robot
Resource    ../../Resources/GlobeLogout.robot

Suite Setup    OpenCloseBrowserKeywords.OpenChromeBrowser
Suite Teardown   OpenCloseBrowserKeywords.CloseTheBrowser
Library  Collections

*** Variables ***
${ROLE}    Store Manager

# ${BRAND}   TM
${SEARCH}  msisdn

*** Test Cases ***

Test Loading History For Prepaid
    [Tags]    Prepaid
    Log to Console   Prepaid
    GlobeLoginKeywords.Open Globe Login Page
    GlobeLoginKeywords.User Login    ${ROLE}
    SearchPageTCs.Verify Dashboard Page
    SearchPageTCs.Search Account in Dashboard        Prepaid   ${SEARCH}
    SearchPageTCs.Validate Subscriber Data           Prepaid
    BrandsHeaderTCs.Redirect to Agents Dashboard
    LoadingHistoryTCs.Loading History validation for Prepaid
    GlobeLogout.Perform Logout

Test Loading History For Prepaid Negative Scenario
    [Tags]    Prepaid
    Log to Console   Prepaid
    GlobeLoginKeywords.Open Globe Login Page
    GlobeLoginKeywords.User Login    ${ROLE}
    SearchPageTCs.Verify Dashboard Page
    SearchPageTCs.Search Account in Dashboard        Prepaid 1  ${SEARCH}
    SearchPageTCs.Validate Subscriber Data           Prepaid 1
    BrandsHeaderTCs.Redirect to Agents Dashboard
    LoadingHistoryTCs.Loading History validation for Prepaid With No Data in Table
    GlobeLogout.Perform Logout

Test Loading History For TM
    [Tags]    TM
    Log to Console   TM
    GlobeLoginKeywords.Open Globe Login Page
    GlobeLoginKeywords.User Login    ${ROLE}
    SearchPageTCs.Verify Dashboard Page
    SearchPageTCs.Search Account in Dashboard        TM   ${SEARCH}
    SearchPageTCs.Validate Subscriber Data           TM
    BrandsHeaderTCs.Redirect to Agents Dashboard
    LoadingHistoryTCs.Loading History validation for Prepaid
    GlobeLogout.Perform Logout
