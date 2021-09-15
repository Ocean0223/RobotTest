*** Settings ***
Documentation    US-04-01 - Test Create User Functionality
Library          SeleniumLibrary
Resource         ../../Resources/user_manager/UserManager.robot
Resource         ../Resources/OpenCloseBrowserKeywords.robot
Resource         ../Resources/GlobeLoginKeywords.robot
Library          Dialogs
Library          DataDriver  ../fixtures/udaa_fixtures.xlsx  sheet_name=CreateUserGroupRole
Library          OperatingSystem

Suite Setup      OpenCloseBrowserKeywords.OpenChromeBrowser
Suite Teardown   OpenCloseBrowserKeywords.CloseTheBrowser
Test Setup       GlobeLoginKeywords.Login As RBA Account User
Test Teardown    GlobeLoginKeywords.LogOut User
Test Template    Create New User

*** Variables ***
${ROLE}       RBA Account
${USRGROUP}   Hotline
${USRROLE}    Hotline Onsite
${LOGGEDIN}   True
${NETID}

*** Test Cases ***
Create User \n-- Group: ${xlgroup}\n-- Role: ${xlrole}\n-- Location: ${xllocation}\n-- Vendor: ${xlvendor}\n

*** Keywords ***
Create New User
    [Documentation]     Test Create User in UD Web Page
    [Tags]  Create User

    [Arguments]   ${xlgroup}  ${xlrole}  ${xllocation}  ${xlvendor}
    ${fname}  ${mname}  ${lname}  ${NETID} =    UserManager.Get Name From Excel
    UserManager.Click Create New User Button
    UserManager.Cancel Create A User
    UserManager.Verify Label Information
    UserManager.Save Button Is Disabled
    UserManager.Input First Name    ${fname}
    UserManager.Input Middle Name   ${mname}
    UserManager.Input Last Name     ${lname}
    UserManager.Input Network ID    ${NETID}
    UserManager.Select Group        ${xlgroup}
    UserManager.Select Role         ${xlrole}
    UserManager.Select Location     ${xllocation}
    UserManager.Select Vendor       ${xlvendor}
    UserManager.Select Line Of Business
    UserManager.Save Button Is Enabled
    UserManager.Save User Account 1
    UserManager.Confirm Save No
    UserManager.Save User Account 2
    UserManager.Confirm Save Yes
    UserManager.Success Notice
    UserManager.Click Success Notice OK Button
    Create A File    ${NETID}    # Saves the last created network ID

*** Keywords ***
Create A File
    [Arguments]    ${text}
    Create File    temp.txt    ${text}
