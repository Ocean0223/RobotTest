*** Settings ***
Documentation    Search Page Controller 
Library  SeleniumLibrary
Library  Collections
Library  String
Library  DateTime
Library  ../../libraries/SearchPage.py
Library  ../../libraries/HeaderDetails.py

*** Variables ***
${LOAD_BALANCE_HEADER}                             xpath=//h3[contains(text(),'Load Balance')]
${DETAILS_LINKS}                                   xpath=//span[@class='item-accounts__view']
${SUBSCRIBER_MSISDN}                               xpath=//p[@class='account-info__tel']/span[0]

*** Keywords ***
Get Customer Information From Fixtures
    [Arguments]     ${BRAND}
    @{data}=  Get Header Detail    ${BRAND}
    [Return]  @{data}

Get Customer Masked Information From Fixtures
    [Arguments]     ${BRAND}
    @{data}=  Get Header Detail Masked   ${BRAND}
    [Return]  @{data}

View Details
    Wait Until Element Is Visible    ${DETAILS_LINKS}    120 s
    Element Text Should Be           ${DETAILS_LINKS}    View Details
    Click Element                    ${DETAILS_LINKS}
    Sleep                            2 s

Agents Dashboard Header
    [Arguments]     ${value}
    Wait Until Element Is Visible    xpath=//h3[contains(text(),'${value}')]    120 s
    Element Text Should Be           xpath=//h3[contains(text(),'${value}')]    ${value}
    Sleep                            2 s

Validate Subscribers MSISDN
    [Arguments]     ${MSISDN}
    Log to console  msisdn_filtered:  ${MSISDN}
    Wait Until Element Is Visible    //span[contains(text(),'${MSISDN}')]    120 s
    Element Text Should Be           //span[contains(text(),'${MSISDN}')]    ${MSISDN}
    Sleep                            2 s

Validate Subscriber Name
    [Arguments]     ${name}
    Log to console  name:  ${name}
    Wait Until Element Is Visible    //span[@class='account-info__name']    120 s
    Element Text Should Be           //span[@class='account-info__name']    ${name}
    Sleep                            2 s

Validate Avatar Icon
    [Arguments]     ${initial}
    Log to console  initial:  ${initial}
    Wait Until Element Is Visible    //div[@class='avatar__inner']//span[contains(text(),'${initial}')]    120 s
    Sleep                            2 s

Validate Line Status
    [Arguments]     ${status}
    Log to console  status:  ${status}
    Wait Until Element Is Visible    //span[@class='account-info__line-status']//span[@class='status-text status-text__active'][contains(text(),'${status}')]    120 s
    Sleep                            2 s

Validate DUO Number
    [Arguments]     ${number}
    Log to console  number:  ${number}
    Wait Until Element Is Visible    //span[@class='account-info__tel'][contains(text(),'${number}')]    120 s
    Element Text Should Be           //span[@class='account-info__tel'][contains(text(),'${number}')]    ${number}
    Sleep                            2 s

Validate Account Status
    [Arguments]     ${status}
    Log to console  acc status:  ${status}
    Wait Until Element Is Visible    //span[@class='account-info__tel status-text status-text__active']    120 s
    Element Text Should Be           xpath=//span[@class='account-info__tel status-text status-text__active']    ${status}
    Sleep                            2 s

Validate Credit Limit
    [Arguments]     ${limit}
    Log to console  limit:  ${limit}
    Wait Until Element Is Visible    //span[@class='account-info__tel'][contains(text(),'₱${limit}')]    120 s
    Sleep                            2 s

Validate Plan Name
    [Arguments]     ${name}
    Log to console  Plan Name:  ${name}
    Wait Until Element Is Visible    //div[@class='spending-limit__inner fade-in']//div[@class='plan-name']//span[@class='plan-name__title'][contains(text(),'${name}')]    120 s
    Sleep                            2 s

Validate HPW Name
    [Arguments]     ${name}
    Log to console  HPW Name:  ${name}
    Wait Until Element Is Visible    xpath=//span[@class='account-info__name']    120 s
    Element Text Should Be           xpath=//span[@class='account-info__name']    ${name}
    Sleep                            2 s

Validate HPW MSISDN
    [Arguments]     ${MSISDN}
    Log to console  HPW Name:        ${MSISDN}
    Wait Until Element Is Visible    xpath=//strong[@class='highlight-value']    120 s
    Element Text Should Be           xpath=//strong[@class='highlight-value']    ${MSISDN}
    Sleep                            2 s

Validate Subscribers Email Address
    [Arguments]     ${email}
    Log to console  email:  ${email}
    Wait Until Element Is Visible    //span[contains(text(),'${email}')]    120 s
    Element Text Should Be           //span[contains(text(),'${email}')]    ${email}
    Sleep                            2 s

Validate Subscribers Reward Points
    [Arguments]     ${points}
    Log to console  points:  ${points}
    Wait Until Element Is Visible    //span[@class='account-info__tel'][contains(text(),'${points} Points')]    120 s
    Element Text Should Be           //span[@class='account-info__tel'][contains(text(),'${points} Points')]    ${points} Points
    Sleep                            2 s


#####BROADBAND KEYWORDS####
Validate Broadband Full Name
    [Arguments]     ${fullname}
    Wait Until Element Is Visible    //span[@class='account-info__name' and contains(text(),'${fullname}')]    120 s
    Element Text Should Be           //span[@class='account-info__name' and contains(text(),'${fullname}')]    ${fullname}
    Sleep                            2 s
Validate Broadband Landline Number
    [Arguments]     ${landline}
    Wait Until Element Is Visible    //strong[contains(text(),'${landline}')]    120 s
    Element Text Should Be           //strong[contains(text(),'${landline}')]    ${landline}
    Sleep                            2 s

Validate Broadband Line Status
    [Arguments]     ${line_status}
    Wait Until Element Is Visible    //strong[contains(text(),'${line_status}')]    120 s
    Element Text Should Be           //strong[contains(text(),'${line_status}')]    ${line_status}
    Sleep                            2 s

Validate Broadband Account Number
    [Arguments]     ${account}
    Wait Until Element Is Visible    //strong[contains(text(),'${account}')]    120 s
    Element Text Should Be           //strong[contains(text(),'${account}')]    ${account}
    Sleep                            2 s

Validate Broadband Account Status
    [Arguments]     ${account_status}
    Wait Until Element Is Visible    //strong[contains(text(),'${account_status}')]    120 s
    Element Text Should Be           //strong[contains(text(),'${account_status}')]    ${account_status}
    Sleep                            2 s

BrandsHeader.Validate Broadband Duo
    Wait Until Element Is Visible    //label[@class='account-info__label' and contains(text(),' DUO #')]    120 s
    Element Text Should Be           //label[@class='account-info__label' and contains(text(),' DUO #')]    DUO #:

BrandsHeader.Validate Broadband Shp
    Wait Until Element Is Visible    //label[@class='account-info__label' and contains(text(),' SHP #')]    120 s
    Element Text Should Be           //label[@class='account-info__label' and contains(text(),' SHP #')]    SHP #:

Validate Broadband Number
    [Arguments]     ${contact_no}
    IF  '${contact_no}' != 'n/a'
    BrandsHeader.Validate Broadband Valid Number    ${contact_no}
    ELSE
    BrandsHeader.Validate Broadband N/A Number  ${contact_no}
    END

Validate Broadband N/A Number
    [Arguments]     ${contact_no}
    Wait Until Element Is Visible    //strong[contains(text(),'n/a')]    120 s
    Element Text Should be           //strong[contains(text(),'n/a')]    n/a
    Sleep                            2 s

Validate Broadband Valid Number
    [Arguments]     ${contact_no}
    Wait Until Element Is Visible    //strong[contains(text(),'0${contact_no}')]    120 s
    Element Text Should be           //strong[contains(text(),'0${contact_no}')]     0${contact_no}
    Sleep                            2 s

Validate Broadband Masked Number
    [Arguments]     ${contact_no}
    IF  '${contact_no}' != 'n/a'
    BrandsHeader.Validate Broadband Masked Valid Number    ${contact_no}
    ELSE
    BrandsHeader.Validate Broadband N/A Number  ${contact_no}
    END

Validate Broadband Masked Valid Number
    [Arguments]     ${contact_no}
    Wait Until Element Is Visible    //strong[contains(text(),'*${contact_no}')]    120 s
    Element Text Should be           //strong[contains(text(),'*${contact_no}')]     *${contact_no}
    Sleep                            2 s


Validate Broadband Credit Limit
    [Arguments]     ${credit_limit}
    IF  '${credit_limit}' != 'n/a'
    BrandsHeader.Validate Broadband Valid Credit Limit    ${credit_limit}
    ELSE
    BrandsHeader.Validate Broadband N/A Credit Limit    ${credit_limit}
    END

Validate Broadband N/A Credit Limit
    [Arguments]     ${credit_limit}
    Wait Until Element Is Visible    //span[1]//strong[contains(text(),'n/a')]    120 s
    Element Text Should be           //span[1]//strong[contains(text(),'n/a')]    n/a
    Sleep                            2 s

Validate Broadband Valid Credit Limit
    [Arguments]     ${credit_limit}
    Wait Until Element Is Visible    //span[1]//strong[contains(text(),'₱ ${credit_limit}')]    120 s
    Element Text Should be           //span[1]//strong[contains(text(),'₱ ${credit_limit}')]    ₱ ${credit_limit}
    Sleep                            2 s

Validate Broadband Billing Address
    [Arguments]     ${billing_address}
     Wait Until Element Is Visible      //*[@class='highlight-value' and contains(text(),'${billing_address}')]    120 s
     Sleep                            2 s

Validate Broadband Installation Address
     [Arguments]     ${installation_address}
    Wait Until Element Is Visible      //*[@class='highlight-value' and contains(text(),'${installation_address}')]    120 s
    Sleep                            2 s

Validate Broadband Middle Name
     [Arguments]     ${middle_name}
    Wait Until Element Is Visible       //span[2]//strong[contains(text(),'${middle_name}')]    120 s
    Element Text Should Be             //span[2]//strong[contains(text(),'${middle_name}')]    ${middle_name}
    Sleep                            2 s

Validate Masked Middle Name
    [Arguments]     ${middle_name}
	IF  '${middle_name}' == '.'
	Validate Broadband Mid Name
	ELSE IF     '${middle_name}' == '..'
 	Validate Broadband Masked Mid Name
 	ELSE
	Validate Broadband Middle Name  ${middle_name}
 	END

Validate Broadband Mid Name
    Wait Until Element Is Visible       //span[2]//strong[contains(text(),'*')]    120 s
    Element Text Should Be             //span[2]//strong[contains(text(),'*')]    *
    Sleep                            2 s

Validate Broadband Masked Mid Name
    Wait Until Element Is Visible       //span[2]//strong[contains(text(),'**')]    120 s
    Element Text Should Be             //span[2]//strong[contains(text(),'**')]    **
    Sleep                            2 s

Validate Broadband Date Of Birth
     [Arguments]    ${date_of_birth}
     ${date_of_birth}   Convert Date    ${date_of_birth}    result_format=%b %d, %Y
    Wait Until Element Is Visible       //strong[contains(text(),'${date_of_birth}')]    120 s
    Element Text Should Be             //strong[contains(text(),'${date_of_birth}')]    ${date_of_birth}
    Sleep                            2 s

Validate Broadband N/A Date of Birth
     [Arguments]     ${date_of_birth}
    Wait Until Element Is Visible      //strong[contains(text(),'${date_of_birth}')]    120 s
    Element Text Should Be             //strong[contains(text(),'${date_of_birth}')]    ${date_of_birth}
    Sleep                            2 s

Validate Birth Day Keyword
    [Arguments]     ${date_of_birth}
    IF  '${date_of_birth}' != 'n/a'
    BrandsHeader.Validate Broadband Date Of Birth   ${date_of_birth}
    ELSE
    BrandsHeader.Validate Broadband N/A Date of Birth   ${date_of_birth}
    END

Validate Masked Birth Day Keyword
    [Arguments]     ${date_of_birth}
    IF  '${date_of_birth}' != 'n/a'
    BrandsHeader.Validate Broadband Masked Date Of Birth   ${date_of_birth}
    ELSE
    BrandsHeader.Validate Broadband N/A Date of Birth   ${date_of_birth}
    END

Validate Broadband Masked Date Of Birth
     [Arguments]    ${date_of_birth}
     ${date_of_birth}   Convert Date    ${date_of_birth}    result_format=%b
    Wait Until Element Is Visible       //strong[contains(text(),'${date_of_birth} **, ****')]    120 s
    Element Text Should Be             //strong[contains(text(),'${date_of_birth} **, ****')]    ${date_of_birth} **, ****
    Sleep                            2 s

Validate Broadband Amount Of Plan
    [Arguments]     ${plan}
    Wait Until Element Is Visible      //span[2]//strong[contains(text(),'${plan}')]    120 s
    Element Text Should Be             //span[2]//strong[contains(text(),'${plan}')]    ${plan}
    Sleep                            2 s

Validate Broadband Plan Allocation
    [Arguments]     ${plan_allocation}
    Wait Until Element Is Visible      //strong[contains(text(),'${plan_allocation}')]    120 s
    Element Text Should Be             //strong[contains(text(),'${plan_allocation}')]    ${plan_allocation}
    Sleep                            2 s

BrandsHeader.Validate Broadband Last Payment Amount
    [Arguments]     ${last_payment}
    ${last_payment}=    Catenate    ${last_payment}
    Wait Until Element Is Visible      //strong[contains(text(),'${last_payment}')]    120 s
    Sleep                            2 s

BrandsHeader.Validate Broadband Last Payment Date
    [Arguments]     ${payment_date}
    ${payment_date}   Convert Date     ${payment_date}    result_format=%b %d, %Y
    Wait Until Element Is Visible      //strong[contains(text(),'${payment_date}')]    120 s
    Element Text Should Be             //strong[contains(text(),'${payment_date}')]    ${payment_date}
    Sleep                            2 s

Validate Broadband Email
    [Arguments]      ${email}
    Wait Until Element Is Visible      //strong[contains(text(),'${email}')]    120 s
    Element Text Should Be             //strong[contains(text(),'${email}')]    ${email}
    Sleep                            2 s


Click Less Details
    Wait Until Element Is Visible      //strong[contains(text(),'- LESS DETAILS')]      120 s
    Element Text Should Be             //strong[contains(text(),'- LESS DETAILS')]      - LESS DETAILS
    Sleep                            2 s
    Click Element                      //strong[contains(text(),'- LESS DETAILS')]
    Wait Until Element Is Visible      //strong[contains(text(),'+ MORE DETAILS')]        120 s
    Element Text Should Be             //strong[contains(text(),'+ MORE DETAILS')]        + MORE DETAILS
    Sleep                            2 s

Click More Details
    Wait Until Element Is Visible      //strong[contains(text(),'+ MORE DETAILS')]        120 s
    Element Text Should Be             //strong[contains(text(),'+ MORE DETAILS')]        + MORE DETAILS
    Sleep                            2 s
    Click Element                      //strong[contains(text(),'+ MORE DETAILS')]
    Wait Until Element Is Visible      //strong[contains(text(),'- LESS DETAILS')]      120 s
    Element Text Should Be             //strong[contains(text(),'- LESS DETAILS')]      - LESS DETAILS
    Sleep                            2 s

Validate Details Billing Address
    [Arguments]     ${billing_address}
     Wait Until Element Is Visible      //*[@class='account-information__sub-desc-bb' and contains(text(),'${billing_address}')]    120 s
     Sleep                            2 s

Validate Details Installation Address
     [Arguments]     ${installation_address}
    Wait Until Element Is Visible      //*[@class='account-information__sub-desc-bb' and contains(text(),'${installation_address}')]    120 s
    Sleep                            2 s