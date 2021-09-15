*** Settings ***
Documentation    Communications Spiels
...    As a Globe frontliner, I should be able to send spiel(Communications) to the customer.
Library          SeleniumLibrary
Resource      ../Resources/OpenCloseBrowserKeywords.robot
Resource      ../Resources/GlobeLoginKeywords.robot
Resource      ../Resources/CustomKeywords.robot
# Resource     ../Resources/header_links/header_links.robot
Library          Dialogs
Library          Collections
Library       ../libraries/Spiels.py
Library          DataDriver  file=../fixtures/udaa_fixtures.xlsx  sheet_name=Comm-Spiels-Testdata

Suite Setup      GlobeLoginKeywords.Open Chrome Goto Login Page
Suite Teardown   OpenCloseBrowserKeywords.CloseTheBrowser
Test Setup      GlobeLoginKeywords.Valid Username Valid Password    Hotline Manager
Test Teardown   GlobeLoginKeywords.LogOut User
#Suite Setup      GlobeLoginKeywords.Goto Login Page and LogIn    ${ROLE}
#Suite Teardown   OpenCloseBrowserKeywords.CloseTheBrowser
#Test Setup      Logs
#Test Teardown   Search for another account
Test Template    Test Communications

*** Variables ***
${ROLE}                    Store Manager    # Hotline Manager    #
${MOBTELNO}                9173016930
${XPATH_AUDITLOGS}         //span[@class='my-account__text']
${SEARCH}                  //input[@name='search']
${SEARCH_AGAIN}            //a[normalize-space()='Search']
${VIEWDETAILS_LINK}        //span[@class='item-accounts__view']
${XPATH_ALERT_CANCEL_BUTTON}  //a[normalize-space()='CANCEL']
${XPATH_ALERT_OK_BUTTON}   //a[normalize-space()='OK']
${BRAND}    ${EMPTY}
${PAGE_TITLE_DASHBOARD}       Dashboard
${XPATH_COMMUNICATIONS_TAB}   //a[normalize-space()='Communications']
${PAGE_TITLE_COMMUNICATIONS}  Communications
${XPATH_SEND_BUTTON}    //button[normalize-space()='SEND']
${XPATH_TABLE}          //div[@class='table-list__body']/div
${COL1}                 /div/p
${ITEMS}                /div/ul/li
${XPATH_SMS_TEXT}       //p[@class='send-sms__desc__text']
${XPATH_CONFIRMATION_BOX}  //div[@class='modal-container']
${XPATH_YES}            //a[normalize-space()='Yes']
${XPATH_NO}             //a[normalize-space()='No']
${XPATH_OK}             //a[normalize-space()='OK']
${XPATH_CANCEL}         //button[normalize-space()='Cancel']
${SUCCESS_MESSAGE}      Sent SMS successfully!
${XPATH_SEND_DISABLED_BUTTON}  //button[@class='btn btn--blue send-btn disabled']
${XLSHEET}    aaa

*** Test Cases ***
Test Communications ${xlbrand} - ${xlmobileno}

*** Keywords ***
Test Communications
    [Arguments]    ${xlbrand}    ${xlmobileno}
    Initialize    ${xlbrand}

    Given I am in Search Accounts page
    And I enter customer number in Search box    ${xlbrand}    ${xlmobileno}
    And I click View Details link
    Then I am redirected to Dashboard page
    When I click the Communications tab
    Then I am redirected to Communications page
    When I Click on CANCEL button
    Then Confirmation Box will be displayed
    When I click on YES button
    Then All dropdown box will reset
    And Can send SMS message Spiels    ${xlbrand}

I am in Search Accounts page
    Write Logs    \n- Given I am in Search Accounts page
    Page Title Should Be    Search Accounts

I enter customer number in Search box
    [Arguments]    ${xlbrand}    ${mobtelno}
    Write Logs    - And I enter ${mobtelno} in Search box

    IF    '${xlbrand}' == 'BROADBAND'
        Click Elm    //span[contains(text(),'Landline/Service Number')]
    ELSE
        Click Elm    //span[contains(text(),'Mobile Number')]
    END

    Type Text   //input[@name='search']  ${mobtelno}
    Press Keys    //input[@name='search']    ENTER
    ${BRAND} =    Convert To Upper Case  ${xlbrand}
    Set Global Variable    ${BRAND}

I click View Details link
    Write Logs    - And I click View Details link
    Wait Until Element Is Visible    //div[@class='account-group']    60s
    Click Elm    //span[@class='item-accounts__view']

I am redirected to Dashboard page
    Write Logs    - Then I am redirected to Dashboard page
    Page Title Should Be    ${PAGE_TITLE_DASHBOARD}
    Sleep    3s

I click the Communications tab
    Write Logs    - When I click the Communications tab
    Click Elm    ${XPATH_COMMUNICATIONS_TAB}

I am redirected to Communications page
    Write Logs    - Then I am redirected to Communications page
    Page Title Should Be    ${PAGE_TITLE_COMMUNICATIONS}

    ${ELEMENT_COUNT} =    Get Element Count    ${XPATH_TABLE}
    ${TOTAL_TRXNS} =    Evaluate    ${ELEMENT_COUNT} + 1
    Set Global Variable    ${TOTAL_TRXNS}
    @{TRXN_ITEMS}    Create List
    FOR    ${i}    IN RANGE    1    ${TOTAL_TRXNS}
        ${xcol1} =    Catenate    SEPARATOR=    ${XPATH_TABLE}    [${i}]    ${COL1}
        ${xcol2} =    Catenate    SEPARATOR=    ${XPATH_TABLE}    [${i}]    ${COL2}
        ${t} =    Get Text    ${xcol1}
        Append To List    ${TRXN_ITEMS}    ${t}
    END
    Set Global Variable     ${TRXN_ITEMS}

Can send SMS message Spiels
    [Arguments]    ${xlbrand}
    ${i}    Set Variable    0
    FOR    ${transaction}    IN    @{TRXN_ITEMS}
	    ${i} =    Evaluate    ${i} + 1
        ${dropdown_items}  ${xli}  ${xcol2} =    Get Items Setting    ${i}    ${transaction}
        ${ii} =  Set Variable  1
        FOR    ${subcategory}    IN    @{dropdown_items}
            ${ii} =    Evaluate    ${ii} + 1
            ${spiel} =    Select An Item From Dropdown list    ${subcategory}  ${ii}  ${xli}  ${xcol2}
            ${result} =    Spiel Category and Dropdown Items are Verified    ${xlbrand}    ${transaction}    ${subcategory}    ${spiel}
            IF  ${result}
                Write Logs    - Spiel VERIFIED in list
            ELSE
                Write Logs    - Warning: Spiel NOT VERIFIED in list (check excelfile: fixtures.xlsx - sheetname:${XLSHEET})
            END
            And I click SEND button
            Then Confirmation Box will be displayed
            When I click on NO button
            Then I will be redirected to Commmunications Page
            When I click SEND button
            Then Confirmation Box will be displayed
            When I click on YES button
            Then Success message is displayed
            When I click on OK button
            Then I will be redirected to Commmunications Page
            And SEND button is disabled
            ${xcol2} =    Catenate    SEPARATOR=    ${XPATH_TABLE}    [${i}]    ${COL2}
            Scroll To Element Plus Yoffset    ${xcol2}    0
            Click Elm    ${xcol2}
            Sleep    1s
        END
        Click Elm    ${xcol2}
    END

Select An Item From Dropdown list
    [Arguments]    ${item}  ${ii}  ${xli}  ${xcol2}
    ${xli_t} =    Catenate    SEPARATOR=    ${xli}    [${ii}]
    ${tt} =    Get Text    ${xli_t}
    Click Elm    ${xli_t}
    Write Logs    ▒░ ${tt}
    Scroll To Bottom Of Page
    ${sms} =    Get Text    ${XPATH_SMS_TEXT}
    Write Logs    ▒░ SMS Message:\n${sms}
    Click Elm    ${xcol2}
    [Return]    ${sms}

Get Items Setting
    [Arguments]   ${i}    ${item}
    ${xcol1} =    Catenate    SEPARATOR=    ${XPATH_TABLE}    [${i}]    ${COL1}
    ${xcol2} =    Catenate    SEPARATOR=    ${XPATH_TABLE}    [${i}]    ${COL2}
    ${t} =    Get Text    ${xcol1}
    Write Logs    ------------------------------------------------------------
    Write Logs    Transaction Type: ${t}\n
    Click Elm    ${xcol2}
    Sleep    1s
    ${xli} =    Catenate    SEPARATOR=    ${xcol2}    ${ITEMS}
    ${cc} =    Get Element Count    ${xli}
    @{dropdown_items}    Create List
    FOR    ${ii}    IN RANGE    2    ${cc} + 1
        ${xli_t} =    Catenate    SEPARATOR=    ${xli}    [${ii}]
        ${tt} =    Get Text    ${xli_t}
        Append To List    ${dropdown_items}    ${tt}
    END
    [Return]    ${dropdown_items}    ${xli}    ${xcol2}

Spiel Category and Dropdown Items are Verified
    [Arguments]    ${xlbrand}    ${transaction}    ${subcategory}    ${txt}
    Write Logs    - When Spiel Category and Dropdown Items are Verified
    ${result}    Spiels.verify spiel    ${XLSHEET}    ${transaction}    ${subcategory}    ${txt}
    [Return]    ${result}

I click SEND button
    Write Logs    - When I click Send button
    Scroll To Bottom Of Page
    Click Btn    ${XPATH_SEND_BUTTON}

Success message is displayed
    Write Logs    - Then Success message is displayed
    Wait Until Page Contains    ${SUCCESS_MESSAGE}    100s
    Page Should Contain    ${SUCCESS_MESSAGE}

Confirmation Box will be displayed
    Write Logs    - Then Confirmation Box will be displayed
    Wait Until Element Is Visible    ${XPATH_CONFIRMATION_BOX}

I click on NO button
    Write Logs    - When I click on NO button
    Click Elm    ${XPATH_NO}

I click on YES button
    Write Logs    - When I click on YES button
    Click Elm    ${XPATH_YES}

I click on OK button
    Write Logs    - When I click on OK button
    Click Elm    ${XPATH_OK}

SEND button is disabled
    Write Logs    - Then SEND button is disabled\n
    Scroll To Bottom Of Page
    Element Should Be Visible    ${XPATH_SEND_DISABLED_BUTTON}
    Sleep    1s

I will be redirected to Commmunications Page
    Write Logs    - Then I will be redirected to Commmunications Page
    Page Title Should Be    ${PAGE_TITLE_COMMUNICATIONS}

I Click on CANCEL button
    Write Logs    - When I Click on CANCEL button
    # ### 1st row (Transaction Type: Account Termination)
    # ### 2nd column (dropdown box)
    # ### 1st item in dropdown box (Letter of Authorization)
    ${xcol2} =    Catenate    SEPARATOR=    ${XPATH_TABLE}    [1]    ${XPATH_PLEASE_SPECIFY}
    Click Elm    ${xcol2}
    ${xcol2} =    Catenate    SEPARATOR=    ${XPATH_TABLE}    [1]    ${COL2}
    Click Elm    ${xcol2}
    Sleep    3s
    Scroll To Bottom Of Page
    Click Btn    ${XPATH_CANCEL}

All dropdown box will reset
    Write Logs    - Then All dropdown box will reset
    ${i}    Set Variable    0
    FOR    ${transaction}    IN    @{TRXN_ITEMS}
	    ${i} =    Evaluate    ${i} + 1
        ${xcol2} =    Catenate    SEPARATOR=    ${XPATH_TABLE}    [${i}]   ${XPATH_PLEASE_SPECIFY}
        ${tt} =    Get Text    ${xcol2}
        IF    '${tt}' != 'Please specify'
            Write Logs    -- ${tt} should have been reset after cancel
        END
    END

Initialize
    [Arguments]    ${xlbrand}
    # Get Sheet List
    ${col2_1}     Set Variable    /div[2]/div/div
    ${col2_2}     Set Variable    /div[2]/div/div/div
    ${pls_specify_1}    Set Variable    /div[2]/div/div/span
    ${pls_specify_2}    Set Variable    /div[2]/div/div/div
    ${COL2}       Set Variable
    ${XPATH_PLEASE_SPECIFY}    Set Variable
    ${XLSHEET}    Set Variable    ${EMPTY}
    ${brand} =    Convert To Upper Case    ${xlbrand}
    ${result} =    Run Keyword And Return Status    Should Contain    ${brand}    POSTPAID
    IF    ${result}
        ${XLSHEET}    Set Variable    Comm-Spiels-Collection-Postpaid
        ${COL2}       Set Variable    ${col2_1}
        ${XPATH_PLEASE_SPECIFY}    Set Variable    ${pls_specify_1}
    END
    ${result} =    Run Keyword And Return Status    Should Contain    ${brand}    PREPAID
    IF    ${result}
        ${XLSHEET}    Set Variable    Comm-Spiels-Collection-Prepaid
        ${COL2}       Set Variable    ${col2_2}
        ${XPATH_PLEASE_SPECIFY}    Set Variable    ${pls_specify_2}
    END
    ${result} =    Run Keyword And Return Status    Should Contain    ${brand}    TM
    IF    ${result}
        ${XLSHEET}    Set Variable    Comm-Spiels-Collection-TM
        ${COL2}       Set Variable    ${col2_2}
        ${XPATH_PLEASE_SPECIFY}    Set Variable    ${pls_specify_2}
    END
    ${result} =    Run Keyword And Return Status    Should Contain    ${brand}    LTPMSP
    IF    ${result}
        ${XLSHEET}    Set Variable    Comm-Spiels-Collection-LTPMSP
        ${COL2}       Set Variable    ${col2_1}
        ${XPATH_PLEASE_SPECIFY}    Set Variable    ${pls_specify_1}
    END
    IF  '${XLSHEET}' == '${EMPTY}'
        Write Logs    --- Error: Brand not found in Sheet names (see fixtures.xlsx)
        Fatal Error
    END
    Set Global Variable    ${XLSHEET}
    Set Global Variable    ${COL2}
    Set Global Variable    ${XPATH_PLEASE_SPECIFY}

