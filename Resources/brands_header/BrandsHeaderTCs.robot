*** Settings ***
Documentation     Search Page Test Cases
Resource     BrandsHeader.robot
Resource     ../search_page/SearchPage.robot
Resource     ../dashboard/Dashboard.robot
Library  Collections


*** Keywords ***
Redirect to Agents Dashboard
    BrandsHeader.View Details

Get Subscriber Data
    [Arguments]     ${BRAND}
    @{data}=  SearchPage.Get Account in Fixtures  ${BRAND}
    Log to console  Subscriber Data: ${data}
    [Return]  @{data}

Validate Prepaid Headers
    [Arguments]     ${data}
    Log to console  Validate Prepaid Headers: ${data}
    ${MSISDN}=    Get From Dictionary  @{data}  msisdn
    ${icon}=    Get From Dictionary  @{data}  avatar icon
    BrandsHeader.Validate Subscribers MSISDN    ${MSISDN}
    BrandsHeader.Validate Avatar Icon    ${icon}

Validate Postpaid Headers
    [Arguments]     ${data}
    Log to console  Validate Postpaid Headers: ${data}
    ${MSISDN}=          Get From Dictionary  @{data}  msisdn
    ${icon}=            Get From Dictionary  @{data}  avatar icon
    ${line_status}=     Get From Dictionary  @{data}  line status
    ${duo_no}=          Get From Dictionary  @{data}  duo no
    ${name}=            Get From Dictionary  @{data}  name of customer
    ${account_status}=  Get From Dictionary  @{data}  account status
    ${credit_limit}=    Get From Dictionary  @{data}  credit limit
    BrandsHeader.Validate Subscribers MSISDN    ${MSISDN}
    BrandsHeader.Validate Avatar Icon           ${icon}
    BrandsHeader.Validate Line Status           ${line_status}
    BrandsHeader.Validate Subscriber Name       ${name}
    BrandsHeader.Validate Account Status        ${account_status}
    BrandsHeader.Validate Credit Limit          ${credit_limit}
    ${len}=   Get Length  ${duo_no}
    Log to console  Lenght: ${len}
    Run Keyword If  ${len} != 0     BrandsHeader.Validate DUO Number    ${duo_no}

Validate HPW Headers
    [Arguments]     ${data}
    Log to console  Validate HPW Headers: ${data}
    ${MSISDN}=    Get From Dictionary  @{data}  msisdn
    ${icon}=      Get From Dictionary  @{data}  avatar icon
    # ${reward}=    Get From Dictionary  @{data}    reward points
    ${len}=   Get Length  ${MSISDN}
    ${HPWMSISDN} =  Set Variable If
    ...  ${len}==11  ${MSISDN}
    ...  ${len}==10  0${MSISDN}
    ...  Final else!
    Log to console   HPW MSISD: ${MSISDN}

    BrandsHeader.Validate HPW MSISDN     ${HPWMSISDN}
    BrandsHeader.Validate Avatar Icon    ${icon}
    # BrandsHeader.Validate Subscribers Reward Points      ${reward}
    BrandsHeader.Validate HPW Name   Globe At Home Prepaid WiFi

Validate LTP/MSP Headers
    [Arguments]     ${data}
    Log to console  Validate LTP/MSP Headers: ${data}
    ${MSISDN}=      Get From Dictionary  @{data}    msisdn
    ${icon}=        Get From Dictionary  @{data}    avatar icon
    ${email}=       Get From Dictionary  @{data}    email address
    ${reward}=      Get From Dictionary  @{data}    reward points
    ${name}=        Get From Dictionary  @{data}    name of customer
    BrandsHeader.Validate Subscribers MSISDN             ${MSISDN}
    BrandsHeader.Validate Avatar Icon                    ${icon}
    BrandsHeader.Validate Subscriber Name                ${name}
    BrandsHeader.Validate Subscribers Email Address      ${email}
    BrandsHeader.Validate Subscribers Reward Points      ${reward}

Get Customer Information
    [Arguments]     ${BRAND}
    @{data}=  BrandsHeader.Get Customer Information From Fixtures    ${BRAND}
    [Return]  @{data}

Get Customer Masked Information
    [Arguments]     ${BRAND}
    @{data}=  BrandsHeader.Get Customer Masked Information From Fixtures    ${BRAND}
    Sleep                            3 s
    [Return]  @{data}



####BROADBAND TEST CASE####

Validate Broadband Primary Details
    [Arguments]     ${data}
    @{data}=    SearchPage.Get Broadband in Fixtures    ${data}
    ${icon}=                Get From Dictionary     @{data}    avatar icon
    ${fullname}=            Get From Dictionary     @{data}    full name
    ${landline}=            Get From Dictionary     @{data}    landline service no
    ${line_status}=         Get From Dictionary     @{data}    line status
    ${account}=             Get From Dictionary     @{data}    account no
    ${account_status}=      Get From Dictionary     @{data}    account status
    ${contact_no}=          Get From Dictionary     @{data}    contact no
    ${credit_limit}=        Get From Dictionary     @{data}    credit limit
    Click Less Details
    BrandsHeader.Validate Avatar Icon                  ${icon}
    BrandsHeader.Validate Broadband Full Name          ${fullname}
    BrandsHeader.Validate Broadband Landline Number    ${landline}
    BrandsHeader.Validate Broadband Line Status        ${line_status}
    BrandsHeader.Validate Broadband Account Number     ${account}
    BrandsHeader.Validate Broadband Account Status     ${account_status}
    BrandsHeader.Validate Broadband Duo
    BrandsHeader.Validate Broadband Shp
    BrandsHeader.Validate Broadband Number             ${contact_no}
    BrandsHeader.Validate Broadband Credit Limit        ${credit_limit}

Validate Broadband Secondary Details
    [Arguments]     ${data}
    @{data}=    SearchPage.Get Broadband in Fixtures    ${data}
    ${billing_address}=         Get From Dictionary     @{data}    billing address
    ${installation_address}=    Get From Dictionary     @{data}    installation address
    ${middle_name}=             Get From Dictionary     @{data}    middle name
    ${date_of_birth}=           Get From Dictionary     @{data}    date of birth
    ${plan}=                    Get From Dictionary     @{data}    exact amount of plan
    ${plan_allocation}=         Get From Dictionary     @{data}    plan data allocation
    ${last_payment}=            Get From Dictionary     @{data}    last payment amount
    ${payment_date}=            Get From Dictionary     @{data}    last payment date
    ${email}=                   Get From Dictionary     @{data}    email
    Click More Details
    BrandsHeader.Validate Broadband Billing Address                  ${billing_address}
    BrandsHeader.Validate Broadband Installation Address             ${installation_address}
    BrandsHeader.Validate Broadband Middle Name                      ${middle_name}
    BrandsHeader.Validate Birth Day Keyword                          ${date_of_birth}
    BrandsHeader.Validate Broadband Amount Of Plan                   ${plan}
    BrandsHeader.Validate Broadband Plan Allocation                  ${plan_allocation}
    BrandsHeader.Validate Broadband Last Payment Amount              ${last_payment}
    BrandsHeader.Validate Broadband Last Payment Date                ${payment_date}
    BrandsHeader.Validate Broadband Email                            ${email}

Validate Broadband Primary Masked Details
    [Arguments]     ${data}
    @{data}=    SearchPage.Get Broadband Masked in Fixtures    ${data}
    ${icon}=                Get From Dictionary     @{data}    avatar icon
    ${fullname}=            Get From Dictionary     @{data}    full name
    ${landline}=            Get From Dictionary     @{data}    landline service no
    ${line_status}=         Get From Dictionary     @{data}    line status
    ${account}=             Get From Dictionary     @{data}    account no
    ${account_status}=      Get From Dictionary     @{data}    account status
    ${contact_no}=          Get From Dictionary     @{data}    contact no
    ${credit_limit}=        Get From Dictionary     @{data}    credit limit
    ${name_of_customer}     Get From Dictionary     @{data}    name of customer
    Click Less Details
    BrandsHeader.Validate Avatar Icon                  ${icon}
    BrandsHeader.Validate Broadband Full Name          ${name_of_customer}
    BrandsHeader.Validate Broadband Landline Number    ${landline}
    BrandsHeader.Validate Broadband Line Status        ${line_status}
    BrandsHeader.Validate Broadband Account Number     ${account}
    BrandsHeader.Validate Broadband Account Status     ${account_status}
    BrandsHeader.Validate Broadband Duo
    BrandsHeader.Validate Broadband Shp
    BrandsHeader.Validate Broadband Masked Number       ${contact_no}
    BrandsHeader.Validate Broadband Credit Limit        ${credit_limit}

Validate Broadband Secondary Masked Details
    [Arguments]     ${data}
    @{data}=    SearchPage.Get Broadband Masked in Fixtures    ${data}
    ${billing_address}=         Get From Dictionary     @{data}    address billing
    ${installation_address}=    Get From Dictionary     @{data}    installation billing
    ${middle_name}=             Get From Dictionary     @{data}    middle name
    ${date_of_birth}=           Get From Dictionary     @{data}    date of birth
    ${plan}=                    Get From Dictionary     @{data}    exact amount of plan
    ${plan_allocation}=         Get From Dictionary     @{data}    plan data allocation
    ${last_payment}=            Get From Dictionary     @{data}    last payment amount
    ${payment_date}=            Get From Dictionary     @{data}    last payment date
    ${email}=                   Get From Dictionary     @{data}    email
    Click More Details
    BrandsHeader.Validate Broadband Billing Address                  ${billing_address}
    BrandsHeader.Validate Broadband Installation Address             ${installation_address}
    BrandsHeader.Validate Masked Middle Name                         ${middle_name}
    BrandsHeader.Validate Masked Birth Day Keyword                   ${date_of_birth}
    BrandsHeader.Validate Broadband Amount Of Plan                   ${plan}
    BrandsHeader.Validate Broadband Plan Allocation                  ${plan_allocation}
    BrandsHeader.Validate Broadband Last Payment Amount              ${last_payment}
    BrandsHeader.Validate Broadband Last Payment Date                ${payment_date}
    BrandsHeader.Validate Broadband Email                            ${email}
    Dashboard.Validate View Bill Button
