*** Settings ***
Documentation  Bills and Payment Hotline Manager
Resource    ../../Resources/search_page/SearchPageTCs.robot
Resource    ../../Resources/brands_header/BrandsHeaderTCs.robot
Resource    ../../Resources/bills_and_payment/BillsAndPaymentTCs.robot
Resource    ../../Resources/OpenCloseBrowserKeywords.robot
Resource    ../../Resources/GlobeLoginKeywords.robot
Resource    ../../Resources/GlobeLogout.robot

Suite Setup    OpenCloseBrowserKeywords.OpenChromeBrowser
Suite Teardown   OpenCloseBrowserKeywords.CloseTheBrowser
Library  Collections

*** Variables ***
${ROLE}    Hotline Manager

# ${BRAND}   TM
${SEARCH}  msisdn

*** Test Cases ***

# Test Bills and Payment for LTP and MSP
#     [Tags]    LTP and MSP
#     ${data}=  BrandsHeaderTCs.Get Customer Information             MSP
#     Log to Console   LTP and MSP
#     GlobeLoginKeywords.Open Globe Login Page
#     GlobeLoginKeywords.User Login    ${ROLE}
#     SearchPageTCs.Verify Dashboard Page
#     SearchPageTCs.Search Account in Dashboard        MSP    ${SEARCH}
#     SearchPageTCs.Validate Subscriber Data           MSP
#     BrandsHeaderTCs.Redirect to Agents Dashboard
#     BillsAndPaymentTCs.Bills and Payment for LTP and MSP    ${data}
#     GlobeLogout.Perform Logout
#     Check # of window tabs open

Test Bills and Payment for Postpaid Regular
    [Tags]    Postpaid Regular
    Log to Console   Postpaid Regular
    GlobeLoginKeywords.Open Globe Login Page
    GlobeLoginKeywords.User Login    ${ROLE}
    SearchPageTCs.Verify Dashboard Page
    SearchPageTCs.Search Account in Dashboard        Postpaid Regular 1   ${SEARCH}
    SearchPageTCs.Validate Subscriber Data           Postpaid Regular 1
    BrandsHeaderTCs.Redirect to Agents Dashboard
    BillsAndPaymentTCs.Bills and Payment for Postpaid
    GlobeLogout.Perform Logout
    Check # of window tabs open

Test Bills and Payment for Postpaid Platinum
    [Tags]    Postpaid Platinum
    Log to Console   Postpaid Platinum
    GlobeLoginKeywords.Open Globe Login Page
    GlobeLoginKeywords.User Login    ${ROLE}
    SearchPageTCs.Verify Dashboard Page
    SearchPageTCs.Search Account in Dashboard        Postpaid Platinum   ${SEARCH}
    SearchPageTCs.Validate Subscriber Data           Postpaid Platinum
    BrandsHeaderTCs.Redirect to Agents Dashboard
    BillsAndPaymentTCs.Bills and Payment for Postpaid
    GlobeLogout.Perform Logout

*** Keywords ***
Check # of window tabs open
    @{title_var}        Get Window Titles
    Log to console  Get Window Titles: ${title_var}
    Switch Window       ${title_var}[1]
    Page Should Contain  ${title_var}[1]
    close window
    Switch Window       ${title_var}[0]
    Sleep  2 s
