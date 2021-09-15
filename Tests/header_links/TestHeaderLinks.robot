*** Settings ***
Documentation    Header Links
...    As a frontliner I want to be able to send Links to the customer once a day per each link in order to avoid spamming the customer.
Library          SeleniumLibrary
Resource      ../Resources/OpenCloseBrowserKeywords.robot
Resource      ../Resources/GlobeLoginKeywords.robot
Resource      ../Resources/CustomKeywords.robot
# Resource      ../Resources/header_links/header_links.robot
Library          Dialogs
Library          OperatingSystem
Library          DataDriver  file=../fixtures/udaa_fixtures.xlsx  sheet_name=TestDataHeaderLinks

Suite Setup      GlobeLoginKeywords.Open Chrome Goto Login Page
Suite Teardown   OpenCloseBrowserKeywords.CloseTheBrowser
Test Setup      GlobeLoginKeywords.Valid Username Valid Password    Hotline Onsite
Test Teardown   GlobeLoginKeywords.LogOut User
#Suite Setup      GlobeLoginKeywords.Goto Login Page and LogIn    ${ROLE}
#Suite Teardown   OpenCloseBrowserKeywords.CloseTheBrowser
#Test Setup      Logs
#Test Teardown   Search for another account
Test Template    Test Headers Link

*** Variables ***
${ROLE}        Store Manager    # Hotline Manager    #
${MOBTELNO}    9178016980
${XPATH_AUDITLOGS}     //span[@class='my-account__text']
${SEARCH}              //input[@name='search']
${SEARCH_AGAIN}        //a[normalize-space()='Search']
${VIEWDETAILS_LINK}    //span[@class='item-accounts__view']
${XPATH_REWARDS_POINTS_SEND_LINK}    //button[@name='rewardsAppLink']
${XPATH_GLOBEONE_SEND_LINK}    //button[@name='globeOneLink']
${XPATH_GLOBE@HOME_SEND_LINK}    //button[@name='globeHomeLink']//strong[contains(text(),'Send Link')]
${XPATH_ALERT_CANCEL_BUTTON}    //a[normalize-space()='CANCEL']
${XPATH_ALERT_OK_BUTTON}    //a[normalize-space()='OK']
${REWARDS_LINK_ENABLED}    ${True}
${GLOBEONE_LINK_ENABLED}   ${True}
${GLOBE@HOME_LINK_ENABLED}   ${True}
${BRAND}    ${EMPTY}

*** Test Cases ***
Test Header Links ${xlbrand} - ${xlmobileno}

*** Keywords ***
Test Headers Link
    [Arguments]    ${xlbrand}    ${xlmobileno}
    Search a Customer number    ${xlbrand}    ${xlmobileno}
    ${BRAND} =    Convert To Upper Case  ${xlbrand}
    Set Global Variable    ${BRAND}
    IF    '${BRAND}' == 'BROADBAND'
        Verify if the Globe@Home link is displayed
    ELSE
        Verify if the Rewards Points text is displayed
    END
    Verify if the GlobeOne link is displayed
    The user should be able to send Links to the customer
    Once the spiel is sent it should be disabled; each spiel is allowed to be sent once a day

Search a Customer number
    [Arguments]    ${xlbrand}    ${mobtelno}
    Write Logs    \n- Search A Customer number
    Page Title Should Be    Search Accounts
    Search a number    ${xlbrand}    ${mobtelno}
    Click View Details Link

Verify if the Rewards Points text is displayed
    Write Logs    - Verify if the Rewards Points text is displayed
    Rewards Points text is displayed

Verify if the GlobeOne link is displayed
    Write Logs    - Verify if the Globe One link is displayed
    GlobeOne link is displayed

Verify if the Globe@Home link is displayed
    Write Logs    - Verify if the Globe@Home link is displayed
    Globe@Home link is displayed

The user should be able to send Links to the customer
    Write Logs    - The user should be able to send Links to the customer
    IF    '${BRAND}' == 'BROADBAND'
        Globe@Home Send Link
    ELSE
        Send Rewards Points Link
    END
    GlobeOne Send Link

Once the spiel is sent it should be disabled; each spiel is allowed to be sent once a day
    Write Logs    - Once the spiel is sent it should be disabled; each spiel is allowed to be sent once a day
    Links are disabled

Search A Number
    [Arguments]    ${xlbrand}    ${mobtelno}
    IF    '${xlbrand}' == 'BROADBAND'
        Click Elm    //span[contains(text(),'Landline/Service Number')]
    ELSE
        Click Elm    //span[contains(text(),'Mobile Number')]
    END
    Type Text   //input[@name='search']  ${mobtelno}
    Press Keys    //input[@name='search']    ENTER

Click View Details Link
    Wait Until Element Is Visible    //div[@class='account-group']    60s
    Click Elm    //span[@class='item-accounts__view']
    Page Title Should Be    Dashboard
    Sleep    3s

Rewards Points text is displayed
    Wait Until Keyword Succeeds    10x    2s
    ...    Page Should Contain    Rewards Points
    Page Should Contain Element    ${XPATH_REWARDS_POINTS_SEND_LINK}

GlobeOne link is displayed
    Wait Until Keyword Succeeds    10x    2s
    ...    Page Should Contain    GlobeOne Link
    Page Should Contain Element   ${XPATH_GLOBEONE_SEND_LINK}

Globe@Home link is displayed
    Wait Until Keyword Succeeds    10x    2s
    ...    Page Should Contain    Globe@Home Link
    Page Should Contain Element   ${XPATH_GLOBE@HOME_SEND_LINK}

Send Rewards Points Link
    Wait Until Element is Visible    ${XPATH_REWARDS_POINTS_SEND_LINK}    100s
    Run Keyword And Ignore Error
    ...    Wait Until Element Is Enabled    ${XPATH_REWARDS_POINTS_SEND_LINK}    10s
    ${passed}    ${status} =    Run Keyword And Ignore Error
    ...    Run Keyword And Return Status    Element Should Be Enabled    ${XPATH_REWARDS_POINTS_SEND_LINK}
    IF    ${status} == ${True}
        Click Elm    ${XPATH_REWARDS_POINTS_SEND_LINK}
        Alert Box Are you Sure? Is displayed
        Write Logs    - Cancel button is being clicked
        Alert Box Click Cancel
        Click Elm    ${XPATH_REWARDS_POINTS_SEND_LINK}
        Write Logs    - OK button is being clicked
        Alert Box Click OK
        Alert Box Sent SMS successfully! is displayed
        Set Suite Variable  ${REWARDS_LINK_ENABLED}    ${False}
        Write Logs    -- Send Rewards Points Link has been sent
    ELSE
        Write Logs    -- Send Rewards Points Link is disabled
        sleep    3s
    END

GlobeOne Send Link
    Wait Until Element is Visible    ${XPATH_GLOBEONE_SEND_LINK}    100s
    Run Keyword And Ignore Error
    ...    Wait Until Element Is Enabled    ${XPATH_GLOBEONE_SEND_LINK}    10s
    ${passed}    ${status} =    Run Keyword And Ignore Error
    ...    Run Keyword And Return Status    Element Should Be Enabled   ${XPATH_GLOBEONE_SEND_LINK}
    IF    ${status} == ${True}
        Click Elm    ${XPATH_GLOBEONE_SEND_LINK}
        Alert Box Are you Sure? Is displayed
        Write Logs    - Cancel button is being clicked
        Alert Box Click Cancel
        Click Elm    ${XPATH_GLOBEONE_SEND_LINK}
        Write Logs    - OK button is being clicked
        Alert Box Click OK
        Alert Box Sent SMS successfully! is displayed
        Set Suite Variable  ${GLOBEONE_LINK_ENABLED}    ${False}
        Write Logs    -- GlobeOne Send Link has been sent
    ELSE
        Write Logs    -- GlobeOne Send Link is disabled
        sleep    3s
    END

Globe@Home Send Link
    Wait Until Element is Visible    ${XPATH_GLOBE@HOME_SEND_LINK}    100s
    Run Keyword And Ignore Error
    ...    Wait Until Element Is Enabled    ${XPATH_GLOBE@HOME_SEND_LINK}    10s
    ${passed}    ${status} =    Run Keyword And Ignore Error
    ...    Run Keyword And Return Status    Element Should Be Enabled   ${XPATH_GLOBE@HOME_SEND_LINK}
    IF    ${status} == ${True}
        Click Elm    ${XPATH_GLOBE@HOME_SEND_LINK}
        Alert Box Are you Sure? Is displayed
        Write Logs    - Cancel button is being clicked
        Alert Box Click Cancel
        Click Elm    ${XPATH_GLOBE@HOME_SEND_LINK}
        Write Logs    - OK button is being clicked
        Alert Box Click OK
        Alert Box Sent SMS successfully! is displayed
        Set Suite Variable  ${GLOBE@HOME_LINK_ENABLED}    ${False}
        Write Logs    -- Globe@Home Send Link has been sent
    ELSE
        Write Logs    -- Globe@Home Send Link is disabled
        sleep    3s
    END

Alert Box Are you Sure? Is displayed
    Wait Until Element Is Visible    //div[@class='v--modal-box v--modal']   60s
    Page Should Contain    Are you sure
    Page Should Contain Element   ${XPATH_ALERT_CANCEL_BUTTON}
    Page Should Contain Element   ${XPATH_ALERT_OK_BUTTON}

Alert Box Click OK
    Click Elm    ${XPATH_ALERT_OK_BUTTON}

Alert Box Click Cancel
    Click Elm    ${XPATH_ALERT_CANCEL_BUTTON}

Alert Box Sent SMS successfully! is displayed
    Write Logs    - Alert Box Sent SMS successfully! is displayed
    # Wait Until Element Is Visible    //div[@class='v--modal-box v--modal']   60s
    Wait Until Keyword Succeeds    10x    2s
    ...    Page Should Contain Element    //*[contains(text(),'Sent SMS successfully!')]
    Alert Box Click OK

Links are disabled
    IF    '${BRAND}' == 'BROADBAND'
        IF    ${GLOBE@HOME_LINK_ENABLED} == ${True}
            Write Logs    -- Globe@Home Link is enabled
        ELSE
            Write Logs    -- Globe@Home Link is disabled
        END
    ELSE
        IF    ${REWARDS_LINK_ENABLED} == ${True}
            Write Logs    -- Rewards Points Link is enabled
        ELSE
            Write Logs    -- Rewards Points Link is disabled
        END
    END

    IF    ${GLOBEONE_LINK_ENABLED} == ${True}
        Write Logs    -- GlobeOne Link is enabled
    ELSE
        Write Logs    -- GlobeOne Link is disabled
    END


Search for another account
    Click Elm    ${SEARCH_AGAIN}
    Sleep    5s

Logs
    log to console    wait...
