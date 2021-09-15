*** Settings ***
Documentation     Search Page Test Cases
Resource     Dashboard.robot
Resource     ../search_page/SearchPage.robot
Resource     ../brands_header/BrandsHeader.robot
Library  Collections


*** Keywords ***
Redirect to Agents Dashboard
    BrandsHeader.View Details

Get Subscriber Data
    [Arguments]     ${BRAND}
    @{data}=  SearchPage.Get Account in Fixtures  ${BRAND}
    Log to console  Subscriber Data: ${data}
    [Return]  @{data}

Validate Prepaid Dashboard
    Dashboard.Validate Title Box    Load Balance
    Dashboard.Validate Expiry Date
    Dashboard.Validate Last Load Amount
    Dashboard.Validate Last Load Date
    Dashboard.Validate Load Balance Amount
    Dashboard.Validate Load Balance Text
    Dashboard.Validate Loading History
    Dashboard.Validate Title Box    Data Usage
    Dashboard.Validate Expiry Date
    Dashboard.Validate Data Allowance
    Dashboard.Validate Data Left
    Dashboard.Validate Data Total
    Dashboard.Validate Data Renewal
    Dashboard.Validate Data Duck
    Dashboard.Validate No Data Promos
    Dashboard.Validate Sad Face
    Dashboard.Click App Data Tab
    Dashboard.Get App Data Promo Name
    Dashboard.Validate Title Box    Promo Subscriptions
    Dashboard.Validate Text Usages
    Dashboard.Validate Text Usages Inclusions
    Dashboard.Validate Call Usages
    Dashboard.Validate Call Usages Inclusions

Validate Postpaid Regular Dashboard
    Log to console  Validate Postpaid Dashboard:
    Dashboard.Validate Title Box    Plan Details
    Dashboard.Validate Plan Name
    Validate Spending Limit
    Dashboard.Validate From (Specific date) to present
    Dashboard.Validate Resets on (Specific Date)
    Dashboard.Validate Excess Usage
    Dashboard.Validate Excess Usage Breakdown
    Dashboard.Validate Title Box    Data Usage
    Dashboard.Validate As of Today
    Dashboard.Validate Data Allowance
    Dashboard.Validate Data Duck
    Dashboard.Validate Data Left
    Dashboard.Validate Data Total
    Dashboard.Validate Other Data Promo
    Dashboard.Click App Data Tab
    Dashboard.Get App Data Promo Name
    Dashboard.Validate (Number of GB) left out of Number of GB)
    Dashboard.Validate Data Promo Expiry Date
    Dashboard.Validate Title Box    Bills Payment
    Dashboard.Validate Bills Payment Amount To Pay
    Dashboard.Validate Bills Payment Due
    Dashboard.Validate Bills Payment Thank You!
    Dashboard.Validate Bills Payment Last Payment Amount Text
    Dashboard.Validate Bills Payment Last Payment Amount Value
    Dashboard.Validate Bills Payment Last Payment Due Text
    Dashboard.Validate Bills Payment Last Payment Due Value
    Dashboard.Validate Charges for the current bill
    Dashboard.Validate View Bill Button
    Dashboard.Validate View Resend Bill Button
    Dashboard.Validate Charges for this month
    Dashboard.Validate Remaining Balance (due immediately)
    Dashboard.Validate Amount to Pay Under Charges Bill
    Dashboard.Validate Title Box    Plan & Add-ons
    Dashboard.Validate Plan & Add-ons Item
    Dashboard.Validate Plan & Add-ons Item Group

Validate Postpaid Platinum Dashboard
    Log to console  Validate Postpaid Dashboard:
    Dashboard.Validate Title Box    Plan Details
    Dashboard.Validate Plan Name
    Validate Spending Limit
    Dashboard.Validate From (Specific date) to present
    Dashboard.Validate Resets on (Specific Date)
    Dashboard.Validate Excess Usage
    Dashboard.Validate Excess Usage Breakdown
    Dashboard.Validate Title Box    Data Usage
    Dashboard.Validate As of Today
    Dashboard.Validate Data Allowance
    Dashboard.Validate Data Duck
    Dashboard.Validate Data Left
    Dashboard.Validate Data Total
    Dashboard.Validate Other Data Promo
    Dashboard.Click App Data Tab
    Dashboard.Get App Data Promo Name
    Dashboard.Validate (Number of GB) left out of Number of GB)
    Dashboard.Validate Data Promo Expiry Date
    Dashboard.Validate Title Box    Bills Payment
    Dashboard.Validate Bills Payment Amount To Pay
    Dashboard.Validate Bills Payment Due
    Dashboard.Validate Bills Payment Thank You!
    Dashboard.Validate Bills Payment Last Payment Amount Text
    Dashboard.Validate Bills Payment Last Payment Amount Value
    Dashboard.Validate Bills Payment Last Payment Due Text
    Dashboard.Validate Bills Payment Last Payment Due Value
    Dashboard.Validate Charges for the current bill
    Dashboard.Validate View Bill Button
    Dashboard.Validate View Resend Bill Button
    Dashboard.Validate Charges for this month
    Dashboard.Validate Remaining Balance (due immediately)
    Dashboard.Validate Amount to Pay Under Charges Bill

Validate LTP/MSP Dashboard
    Log to console  Validate LTP/MSP Dashboard:
    Dashboard.Validate Title Box    Plan Details
    Dashboard.Validate LTP Contract Duration
    Dashboard.Validate LTP Contract Expiry
    Dashboard.Validate LTP Details
    Dashboard.Validate LTP Every
    Dashboard.Validate LTP Frequency
    Dashboard.Validate LTP Loading Amount
    Dashboard.Validate LTP Plan Name
    Dashboard.Validate LTP Starts On
    Dashboard.Validate Title Box    Data Usage
    Dashboard.Validate Expiry Date
    Dashboard.Validate Data Allowance
    Dashboard.Validate Data Left
    Dashboard.Validate Data Total
    Dashboard.Validate Data Renewal
    Dashboard.Validate Data Duck
    Dashboard.Validate No Data Promos
    Dashboard.Validate Sad Face
    Dashboard.Click App Data Tab
    Dashboard.Get App Data Promo Name
    Dashboard.Validate Title Box    Load Balance
    Dashboard.Validate Expiry Date
    Dashboard.Validate Last Load Amount
    Dashboard.Validate Last Load Date
    Dashboard.Validate Load Balance Amount
    Dashboard.Validate Load Balance Text
    Dashboard.Validate Loading History
    Dashboard.Validate View Bill Button
    Dashboard.Validate Resend Bill Button
    Dashboard.Validate Request Billing Statement
    Dashboard.Validate Promo Subscriptions

Get Customer Information
    [Arguments]     ${BRAND}
    @{data}=  BrandsHeader.Get Customer Information From Fixtures    ${BRAND}
    [Return]  @{data}

Get Customer Masked Information
    [Arguments]     ${BRAND}
    @{data}=  BrandsHeader.Get Customer Masked Information From Fixtures    ${BRAND}
    Sleep                            3 s
    [Return]  @{data}


####BROADBAND Test Cases####

Validate Broadband Plan Details
    [Arguments]    ${data}
    @{data}=    SearchPage.Get Broadband in Fixtures    ${data}
    ${plan_name}=    Get From Dictionary         @{data}    plan name
    ${speed}=        Get From Dictionary         @{data}    speed
    ${technology}=   Get From Dictionary         @{data}   technology
    Dashboard.Validate Title Box    Plan Details
    Dashboard.Validate Broadband Plan Name          ${plan_name}
    Dashboard.Validate Broadband Speed              ${speed}
    Dashboard.Validate Broadband Technology         ${technology}

Validate Broadband Data Usage Details
    [Arguments]    ${data}
    @{data}=    SearchPage.Get Broadband in Fixtures    ${data}
    ${plan_name}=    Get From Dictionary         @{data}    plan name
    Dashboard.Validate Title Box    Data Usage
    Dashboard.Validate Data Duck
    Dashboard.Validate Data Allowance
    Dashboard.Validate Broadband Total Data Consumption
    Dashboard.Validate Broadband Number of GB
    Dashboard.Validate Data Unlimited
    Dashboard.Validate Data Left
    Dashboard.Validate Data Total
    Dashboard.Validate Data Renewal
    Dashboard.Validate No Data Promos
    Dashboard.Validate Sad Face

Validate Broadband Historic Data Usage Details
    Dashboard.Validate No Data is Displayed

Validate Broadband Bills Payment Details
    Dashboard.Validate Title Box    Bills Payment
    Dashboard.Validate Broadband Amount to Pay
    Dashboard.Validate Broadband Amount Due
    Dashboard.Validate Broadband Last Payment Amount
    Dashboard.Validate Broadband Last Payment Date

Validate Broadband Charges for the Current Bill
    Dashboard.Validate Charges for the Current Bill Title
    Dashboard.Validate Broadband Charges for Month
    Dashboard.Validate Broadband Charges Amount to Pay
    Dashboard.Validate Broadband Remaining Due
    Dashboard.Validate Broadband View Bill Button
