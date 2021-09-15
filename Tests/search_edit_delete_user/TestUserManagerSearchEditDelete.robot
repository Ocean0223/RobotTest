*** Settings ***
Documentation    US-03-01; US-05-01 - Test Search, Edit and Delete Users
Library          SeleniumLibrary
Resource      ../../Resources/user_manager/UserManager.robot
Resource      ../Resources/OpenCloseBrowserKeywords.robot
Resource      ../Resources/GlobeLoginKeywords.robot
Library          Dialogs
Library          OperatingSystem
Library       ../libraries/StoreLocation.py

Suite Setup      OpenCloseBrowserKeywords.OpenChromeBrowser
Suite Teardown   OpenCloseBrowserKeywords.CloseTheBrowser
Test Setup       GlobeLoginKeywords.Login As RBA Account User
Test Teardown    GlobeLoginKeywords.LogOut User

*** Variables ***
${ROLE}       RBA Account
${USRGROUP}   Hotline
${USRROLE}    Hotline Onsite
${LOGGEDIN}   True
${NETID}

*** Test Cases ***
Edit User
    [Documentation]     Test Edit User in UD Web Page
    [Tags]  Edit User
    ${NETID} =    Get File    temp.txt
    UserManager.Search User    ${USER_NETWORKID_NOEXIST_VALUE}
    UserManager.Search User    ${NETID}
    ${fname}  ${mname}  ${lname} =    UserManager.Get Edit Name
    ${group}  ${role}  ${location}  ${vendor} =    UserManager.Get Edit Group Role Loc Vendor
    UserManager.Edit User
    UserManager.Input First Name    ${fname}
    UserManager.Input Middle Name   ${mname}
    UserManager.Input Last Name     ${lname}
    UserManager.Select Group        ${group}
    UserManager.Edit Role         ${role}
    UserManager.Select Location     ${location}
    UserManager.Select Vendor       ${vendor}
    UserManager.Change Expiry Date
    UserManager.Select Line Of Business
    UserManager.Select Line Of Business
    UserManager.Save Button Is Enabled
    UserManager.Save User Account 1
    UserManager.Confirm Save No
    UserManager.Save User Account 2
    UserManager.Confirm Save Yes
    UserManager.Success Notice
    UserManager.Click Success Notice OK Button

Delete User
    [Documentation]     Delete User in UD Web Page
    [Tags]  Delete User
    ${NETID} =    Get File    temp.txt
    UserManager.Search User    ${NETID}
    UserManager.Delete User Select No
    UserManager.Delete User Select Yes
    UserManager.Search User    ${NETID}
    UserManager.Check Deleted Account    ${NETID}

Validate Store Location
    [Documentation]     Identify Valid Store Location in UD Web Page
    [Tags]  Validate Store Location
    Write Logs    \n-- Validate Store Location (match list site from list file)
    @{list1} =    StoreLocation.get user by location

    UserManager.Click Create New User Button
    UserManager.Select Group      Store
    Click XPath    ${CREATE_USER_LOC}
    ${list_count_infile} =    Get Length    ${list1}
    ${list_count_insite} =    get element count    css:div[class='location'] li
    ${no_match_ctr}    Set Variable    0
    ${match_ctr}       Set Variable    0
    @{site_list} =     Create List
    Write Logs    \n-- Location List count in site: ${list_count_insite}
    Write Logs    \n-- Location List count in file: ${list_count_infile}
    FOR    ${i}    IN RANGE    1    ${list_count_insite} + 1
        ${txt} =    Get Text    css:div[class='location'] li:nth-child(${i})
        Append To List    ${site_list}    ${txt}
#        ${count} =    Get Match Count    ${list1}    ${txt}*
#        IF    ${count} > 0
#            Write Logs    ---- Verifying Location: (${txt}) - Match found
#            ${match_ctr} =   Evaluate    ${match_ctr} + 1
#        ELSE
#            Write Logs    ---- Verifying Location: (${txt}) - No Match found
#            ${no_match_ctr} =   Evaluate    ${no_match_ctr} + 1
#        END
    END
    Lists Should Be Equal	${site_list}	${list1}	# ignore_order=True






