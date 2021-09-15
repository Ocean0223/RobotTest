*** Settings ***
Documentation  Header Details
Resource    ../Resources/search_page/SearchPageTCs.robot
Resource    ../Resources/brands_header/BrandsHeaderTCs.robot
Resource    ../Resources/dashboard/DashboardTCs.robot
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
    Log to Console   ${BRAND} User
    GlobeLoginKeywords.Open Globe Login Page
    GlobeLoginKeywords.User Login    ${HEADER_ROLE}

Test Search Page
    SearchPageTCs.Verify Dashboard Page
    SearchPageTCs.Search Account in Dashboard        ${BRAND}    ${SEARCH}
    SearchPageTCs.Validate Subscriber Data           ${BRAND}

Test Brands Header
    BrandsHeaderTCs.Redirect to Agents Dashboard
    ${data}=  BrandsHeaderTCs.Get Customer Information             ${BRAND}
    Run Keyword If  "${BRAND}"=="Prepaid" or "${BRAND}"=="TM"                                 BrandsHeaderTCs.Validate Prepaid Headers       ${data}
    ...  ELSE IF  "${BRAND}"=="Postpaid Regular 1" or "${BRAND}"=="Postpaid Platinum"         BrandsHeaderTCs.Validate Postpaid Headers      ${data}
    ...  ELSE IF  "${BRAND}"=="HPW"                                                           BrandsHeaderTCs.Validate HPW Headers           ${data}
    ...  ELSE IF  "${BRAND}"=="LTP" or "${BRAND}"=="MSP"                                      BrandsHeaderTCs.Validate LTP/MSP Headers       ${data}

Test Dashboard
    Run Keyword If  "${BRAND}"=="Prepaid" or "${BRAND}"=="TM"                                 DashboardTCs.Validate Prepaid Dashboard
    ...  ELSE IF  "${BRAND}"=="Postpaid Regular 1"                                            DashboardTCs.Validate Postpaid Regular Dashboard
    ...  ELSE IF  "${BRAND}"=="Postpaid Platinum"                                             DashboardTCs.Validate Postpaid Platinum Dashboard
    ...  ELSE IF  "${BRAND}"=="LTP" or "${BRAND}"=="MSP"                                      DashboardTCs.Validate LTP/MSP Dashboard

Logout User
    GlobeLogout.Perform Logout