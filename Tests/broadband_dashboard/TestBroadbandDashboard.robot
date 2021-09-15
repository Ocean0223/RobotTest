*** Settings ***
Documentation  US-15-01 - Test Broadband Dashboard Validation Using Manager Users
Resource    ../Resources/search_page/SearchPageTCs.robot
Resource    ../Resources/brands_header/BrandsHeaderTCs.robot
Resource    ../Resources/dashboard/DashboardTCs.robot
Resource    ../Resources/OpenCloseBrowserKeywords.robot
Resource    ../../Resources/GlobeLoginKeywords.robot
Resource    ../../Resources/GlobeLogout.robot

Suite Setup    OpenCloseBrowserKeywords.OpenChromeBrowser
Suite Teardown   OpenCloseBrowserKeywords.CloseTheBrowser
Library  Collections

*** Variables ***
${DASH_ROLE}    Hotline Manager

${ID}   7
${SEARCH}   landline service no
${LINE}     Active

*** Test Cases ***

Login to Globe
    [Documentation]     Login to UD Web Page
    [Tags]  Login User
    GlobeLoginKeywords.Open Globe Login Page
    GlobeLoginKeywords.User Login    ${DASH_ROLE}

Test Search Page
    [Documentation]     Search the Landline or Account Number
    [Tags]  Search Landline or Account
    SearchPageTCs.Verify Dashboard Page
    SearchPageTCs.Search Broadband in Dashboard     ${ID}   ${SEARCH}

Test Brands Header
    [Documentation]     Data Preparation and Redirect to Dashboard
    [Tags]  Go to Dashboard
    BrandsHeaderTCs.Redirect to Agents Dashboard

Test Plan Details Dashboard
    [Documentation]     Verify the Contents of Plan Details
    [Tags]  Plan Details Verification
    Validate Broadband Plan Details     ${ID}

Test Data Usage Details Dashboard
    [Documentation]     Verify the Contents of Data Usage Details
    [Tags]  Data Usage Verification
    Run Keyword If  "${LINE}"=="Active" or "${LINE}"=="Temporary Disconnected"    Validate Broadband Data Usage Details        ${ID}
    ...  ELSE IF  "${LINE}"=="Historic" or "${LINE}"=="Cancelled"         Validate Broadband Historic Data Usage Details

Test Bills Payment Details Dashboard
    [Documentation]     Verify the Contents of Bills Payment Details
    [Tags]  Bills Payment Verification
    Validate Broadband Bills Payment Details

Test Current Bill Details Dashboard
    [Documentation]     Verify the Contents of Charges for the Current Bill
    [Tags]   Charges for the Current Bill Verification
    Validate Broadband Charges for the Current Bill

Logout User
    GlobeLogout.Perform Logout