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
Validate Title Box
    [Arguments]     ${title}
    Log to console  Title Box:  ${title}
    Wait Until Element Is Visible    //h3[contains(text(),'${title}')]    120 s
    Element Text Should Be           //h3[contains(text(),'${title}')]    ${title}
    Sleep                            2 s

Validate Load Balance Text
    Log to console  Load Balance Text:
    ${status}=    Get Element Status         //p[@class='load-balance__as-text']
    Run Keyword If  ${status} is ${TRUE}
    ...     Wait Until Element Is Visible    //p[@class='load-balance__as-text']    120 s
    Sleep                            2 s

Validate Expiry Date
    Log to console  Expiry Date:
    ${status}=    Get Element Status    //p[@class='text-small']
    Run Keyword If  ${status} is ${TRUE}
    ...     Wait Until Element Is Visible    //p[@class='text-small']    120 s
    Sleep                            2 s

Validate Load Balance Amount
    Log to console  Load Balance Amount:
    ${status}=    Get Element Status         //p[@class='load-balance__amount']
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //p[@class='load-balance__amount']    120 s
    Sleep                            2 s

Validate Loading History
    Log to console  Loading History:
    ${status}=    Get Element Status         //span[contains(text(),'View loading history')] 
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //span[contains(text(),'View loading history')]     120 s
    Sleep                            2 s

Validate Last Load Amount
    Log to console  Loading History:
    ${status}=    Get Element Status         //p[contains(text(),'Last Load Amount')] 
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //p[contains(text(),'Last Load Amount')]    120 s
    Sleep                            2 s

Validate Last Load Date
    Log to console  Load Date:
    ${status}=    Get Element Status         //p[contains(text(),'Last Load Date')] 
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //p[contains(text(),'Last Load Date')]    120 s
    Sleep                            2 s

Validate Data Allowance
    Log to console  Data Allowance:
    ${status}=    Get Element Status         //h4[@class='usage-data__info__title--prepaid'] 
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //h4[@class='usage-data__info__title--prepaid']    120 s
    Sleep                            2 s

Validate As of Today
    Log to console  Validate As of Today:
    ${status}=    Get Element Status         //p[@class='usage-data__info__desc'] 
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //p[@class='usage-data__info__desc']    120 s
    Sleep                            2 s

Validate Data Left
    Log to console  Data Left:
    ${status}=    Get Element Status         //p[@class='usage-data__data-left']
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //p[@class='usage-data__data-left']    120 s
    Sleep                            2 s

Validate Data Total
    Log to console  Data Total:
    ${status}=    Get Element Status         //p[@class='usage-data__data-total']//p[@class='usage-data__data-total']
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //p[@class='usage-data__data-total']    120 s
    Sleep                            2 s

Validate Data Renewal
    Log to console  Data Renewal:
    ${status}=    Get Element Status         //p[@class='usage-data__data-renewal']
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //p[@class='usage-data__data-renewal']    120 s
    Sleep                            2 s

Validate Data Duck
    Log to console  Data Duck:
    ${status}=    Get Element Status    //span[@class='glass__duck']//img[@class='img-responsive']
    Run Keyword If  ${status} is ${TRUE}
    ...     Wait Until Element Is Visible    //span[@class='glass__duck']//img[@class='img-responsive']    120 s
    Sleep                            2 s

Click App Data Tab
    Log to console  App Data Tab:
    Wait Until Element Is Visible    //div[@id='app-data']    120 s
    Click Element                    //div[@id='app-data']
    Sleep                            2 s
    
Get App Data Promo Name
    Log to console  App Data Promo Name:
    ${status}=    Get Element Status    //div[@class='item-detail']/p[@class='category']
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //div[@class='item-detail']/p[@class='category']    120 s
    Sleep                            2 s

Validate No Data Promos
    Log to console  No Data Promos:
    ${status}=    Get Element Status         //p[@class='usage-data__no-data']
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //p[@class='usage-data__no-data']    120 s
    Sleep                            2 s

Validate Sad Face
    Log to console  Sad Face:
    ${status}=    Get Element Status          //div[@class='block-error-prepaid__wrap-check']//[@class='img-data']
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible        //div[@class='block-error-prepaid__wrap-check']//[@class='img-data']    120 s
    Sleep                            2 s

Validate Text Usages
    Log to console  Text Usages:
    ${status}=    Get Element Status          //h3[contains(text(),'Text Usages')]
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible        //h3[contains(text(),'Text Usages')]    120 s
    Sleep                            2 s

Validate Text Usages Inclusions
    Log to console  Text Usages Inclusions:
    ${status}=    Get Element Status          //div[@class='gptm-item__upper gptm-item-height--texts']
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible        //div[@class='gptm-item__upper gptm-item-height--texts']    120 s
    Sleep                            2 s

Validate Call Usages
    Log to console  Call Usages:
    ${status}=    Get Element Status          //h3[contains(text(),'Call Usages')]
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible        //h3[contains(text(),'Call Usages')]    120 s
    Sleep                            2 s

Validate Call Usages Inclusions
    Log to console  Text Usages Inclusions:
    ${status}=    Get Element Status          //div[@class='gptm-item__upper gptm-item-height--calls']
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible        //div[@class='gptm-item__upper gptm-item-height--calls']    120 s
    Sleep                            2 s

Validate LTP Plan Name
    Log to console  LTP Plan Name:
    ${status}=    Get Element Status          //p[contains(text(),'Plan Name:')]
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible        //p[contains(text(),'Plan Name:')]    120 s
    Sleep                            2 s

Validate LTP Contract Expiry
    Log to console  LTP Contract Expiry:
    ${status}=    Get Element Status          //p[contains(text(),'Contract Expiry:')]
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible        //p[contains(text(),'Contract Expiry:')]    120 s
    Sleep                            2 s

Validate LTP Contract Duration
    Log to console  Contract Duration:
    ${status}=    Get Element Status          //p[contains(text(),'Contract Duration:')]
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible        //p[contains(text(),'Contract Duration:')]    120 s
    Sleep                            2 s

Validate LTP Details
    Log to console  LTP Details:
    ${status}=    Get Element Status          //strong[contains(text(),'LTP Details')]
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible        //strong[contains(text(),'LTP Details')]    120 s
    Sleep                            2 s

Validate LTP Loading Amount
    Log to console  Loading Amount:
    ${status}=    Get Element Status          //p[contains(text(),'Loading Amount:')]
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible        //p[contains(text(),'Loading Amount:')]    120 s
    Sleep                            2 s

Validate LTP Starts On
    Log to console  Starts On:
    ${status}=    Get Element Status          //p[contains(text(),'Starts On:')]
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible        //p[contains(text(),'Starts On:')]    120 s
    Sleep                            2 s

Validate LTP Frequency
    Log to console  Frequency:
    ${status}=    Get Element Status          //p[contains(text(),'Frequency:')]
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible        //p[contains(text(),'Frequency:')]    120 s
    Sleep                            2 s

Validate LTP Every
    Log to console  Every:
    ${status}=    Get Element Status          //p[contains(text(),'Every:')]
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible        //p[contains(text(),'Every:')]    120 s
    Sleep                            2 s

Validate View Bill Button
    Log to console  View Bill Button:
    ${status}=    Get Element Status              //button[@class='btn btn--blue right btn--not-full btn--mgb btn'] 
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible            //button[@class='btn btn--blue right btn--not-full btn--mgb btn']     120 s
    Sleep                            2 s

Validate Resend Bill Button
    Log to console  Resend Bill Button:
    ${status}=    Get Element Status           //button[@class='btn btn btn--blue right btn--not-full'] 
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible         //button[@class='btn btn btn--blue right btn--not-full']     120 s
    Sleep                            2 s

Validate Request Billing Statement
    Log to console  Resend Bill Button:
    ${status}=    Get Element Status           //span[contains(text(),'Request For Billing Statement')] 
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible         //span[contains(text(),'Request For Billing Statement')]     120 s
    Sleep                            2 s

Validate Promo Subscriptions
    Log to console  Resend Bill Button:
    ${status}=    Get Element Status           //div[@class='error-block__desc'] 
    Run Keyword If  ${status} is ${TRUE}
    ...  Promo Subscriptions Error Message
    Sleep                            2 s

Promo Subscriptions Error Message
    Wait Until Element Is Visible    //div[@class='error-block__desc']    120 s
    Element Text Should Be           //div[@class='error-block__desc']    We are experiencing difficulty connecting to our server. Please try again later.
    Sleep                            3 s

Validate Spending Limit
    Log to console  Validate Spending Limit:
    ${status}=    Get Element Status              //div[@class='spending-limit__inner fade-in']//div[@class='spending-limit__info spending-limit__info--modify']//div[@class='row']//div[@class='col-md-12']//h4[@class='spending-limit__info__title'][contains(text(),'Spending Limit')] 
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible            //div[@class='spending-limit__inner fade-in']//div[@class='spending-limit__info spending-limit__info--modify']//div[@class='row']//div[@class='col-md-12']//h4[@class='spending-limit__info__title'][contains(text(),'Spending Limit')]     120 s
    Sleep                            2 s

Validate Plan Name
    Log to console  Validate Plan Name:
    ${status}=    Get Element Status              //div[@class='spending-limit__inner fade-in']//div[@class='plan-name']//span[@class='plan-name__title'] 
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible            //div[@class='spending-limit__inner fade-in']//div[@class='plan-name']//span[@class='plan-name__title']     120 s
    Sleep                            2 s

Validate From (Specific date) to present
    Log to console  From (Specific date) to present:
    ${status}=    Get Element Status              //div[@class='row spending-limit__info__date']//div[@class='col-md-6']//p[contains(text(),'to')] 
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible            //div[@class='row spending-limit__info__date']//div[@class='col-md-6']//p[contains(text(),'to')]     120 s
    Sleep                            2 s

Validate Resets on (Specific Date)
    Log to console  Validate Resets on (Specific Date):
    ${status}=    Get Element Status              //p[@class='spending-limit__excess-usage__note'] 
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible            //p[@class='spending-limit__excess-usage__note']     120 s
    Sleep                            2 s

Validate Excess Usage
    Log to console  Validate Excess Usage:
    ${status}=    Get Element Status              //div[@class='data-process__status data-process__status--overlap']//span[contains(text(),'Excess Usage')] 
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible            //div[@class='data-process__status data-process__status--overlap']//span[contains(text(),'Excess Usage')]     120 s
    Sleep                            2 s

Validate Excess Usage Breakdown
    Log to console  Validate Excess Usage Breakdown:
    ${status}=    Get Element Status              //span[contains(text(),'View Excess Usage Breakdown')] 
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible            //span[contains(text(),'View Excess Usage Breakdown')]     120 s
    Sleep                            2 s

Validate Other Data Promo
    Log to console  Validate Other Data Promo:
    ${status}=    Get Element Status         //div[contains(@class,'hidden-sm hidden-xs')]//li[@class, 'my-plan-usage__main-data__item']//p[@class, 'title-main']
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible       //div[contains(@class,'hidden-sm hidden-xs')]//li[@class, 'my-plan-usage__main-data__item']//p[@class, 'title-main']    120 s
    Sleep                            2 s

Validate (Number of GB) left out of Number of GB)
    Log to console  Validate (Number of GB) left out of Number of GB):
    ${status}=    Get Element Status    //div[@class='item-detail']/div[@class='data']
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //div[@class='item-detail']/div[@class='data']    120 s
    Sleep                            2 s
    
Validate Data Promo Expiry Date
    Log to console  Validate (Number of GB) left out of Number of GB):
    ${status}=    Get Element Status    //div[@class='item-detail']/div[@class='date']
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //div[@class='item-detail']/div[@class='date']    120 s
    Sleep                            2 s

Validate Bills Payment Amount To Pay
    Log to console  Bills Payment Amount To Pay:
    ${status}=    Get Element Status      //p[contains(text(),'Amount to pay:')]
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //p[contains(text(),'Amount to pay:')]    120 s
    Sleep                            2 s

Validate Bills Payment Due
    Log to console  Bills Payment Due:
    ${status}=    Get Element Status    //h3[contains(@class,'bill-and-payment__for__title')]
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //h3[contains(@class,'bill-and-payment__for__title')]    120 s
    Sleep                            2 s

Validate Bills Payment Thank You!
    Log to console  Validate Bills Payment Thank You!:
    ${status}=    Get Element Status    //p[contains(@class,'text-small')]
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //p[contains(@class,'text-small')]    120 s
    Sleep                            2 s

Validate Bills Payment Last Payment Amount Text
    Log to console  Validate Bills Payment Last Payment Amount:
    ${status}=    Get Element Status    //p[contains(text(),'Last Payment Amount:')]
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //p[contains(text(),'Last Payment Amount:')]    120 s
    Sleep                            2 s

Validate Bills Payment Last Payment Amount Value
    Log to console  Validate Bills Payment Last Payment Amount:
    ${status}=    Get Element Status    //p[contains(@class,'bill-and-payment__group--lastamount')]
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //p[contains(@class,'bill-and-payment__group--lastamount')]    120 s
    Sleep                            2 s

Validate Bills Payment Last Payment Due Text
    Log to console  Validate Bills Payment Last Payment Due Text:
    ${status}=    Get Element Status    //p[contains(text(),'Last Payment Date:')]
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //p[contains(text(),'Last Payment Date:')]    120 s
    Sleep                            2 s

Validate Bills Payment Last Payment Due Value
    Log to console  Validate Bills Payment Last Payment Due Value:
    ${status}=    Get Element Status    //p[contains(@class,'bill-and-payment__group--lastdate')]
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //p[contains(@class,'bill-and-payment__group--lastdate')]    120 s
    Sleep                            2 s

Validate Amount to Pay Under Charges Bill
    Log to console  Validate Amount to Pay:
    ${status}=    Get Element Status    //p[@class='charges-title mr-t-20']
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //p[@class='charges-title mr-t-20']    120 s
    Sleep                            2 s

Validate Charges for the current bill
    Log to console  Validate Charges for the current bill:
    ${status}=    Get Element Status    //p[contains(text(),'Charges for the current bill')]
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //p[contains(text(),'Charges for the current bill')]    120 s
    Sleep                            2 s

Validate View Resend Bill Button
    Log to console  Validate View Resend Bill Button:
    ${status}=    Get Element Status    //div[contains(@class,'col-md-5 hidden-xs hidden-sm text-right')]//div[contains(@class,'charges-current-bill__download-bill clearfix')]//button[contains(@class,'btn btn btn--blue')][contains(text(),'RESEND BILL')]
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //div[contains(@class,'col-md-5 hidden-xs hidden-sm text-right')]//div[contains(@class,'charges-current-bill__download-bill clearfix')]//button[contains(@class,'btn btn btn--blue')][contains(text(),'RESEND BILL')]    120 s
    Sleep                            2 s

Validate Charges for this month
    Log to console  Validate Charges for this month:
    ${status}=    Get Element Status      //p[contains(text(),'Charges for this month')]
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //p[contains(text(),'Charges for this month')]    120 s
    Sleep                            2 s

Validate Remaining Balance (due immediately)
    Log to console  Validate Remaining Balance (due immediately):
    ${status}=    Get Element Status      //p[contains(text(),'Remaining Balance (due immediately)')]
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //p[contains(text(),'Remaining Balance (due immediately)')]    120 s
    Sleep                            2 s

Validate Amount to Pay
    Log to console  Validate Amount to Pay:
    ${status}=    Get Element Status      //p[contains(@class,'charges-title mr-t-20')]
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //p[contains(@class,'charges-title mr-t-20')]    120 s
    Sleep                            2 s

Validate Plan & Add-ons Item
    Log to console  Validate Plan & Add-ons Item:
    ${status}=    Get Element Status      //div[@class='promos__heading-block']//div[@class='row']//div[@class='col-md-12']//div[@class='heading-block heading-block--has-spacing']
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //div[@class='promos__heading-block']//div[@class='row']//div[@class='col-md-12']//div[@class='heading-block heading-block--has-spacing']    120 s
    Sleep                            2 s

Validate Plan & Add-ons Item Group
    Log to console  Validate Plan & Add-ons Item Group:
    ${status}=    Get Element Status      //div[@class='plan-item__upper']
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible    //div[@class='plan-item__upper']    120 s
    Sleep                            2 s


Get Element Status
    [Arguments]     ${element}
    ${status}=      Run Keyword And Return Status   Page Should Contain Element         ${element}
    [Return]  ${status}


####BROADBAND KEYWORDS####

Validate Broadband Plan Name
    [Arguments]     ${plan_name}
    Wait Until Element Is Visible    //span[contains(text(),'${plan_name}')]    120 s
    Element Text Should Be           //span[contains(text(),'${plan_name}')]    ${plan_name}
    Sleep                            3 s

Validate Broadband Speed
    [Arguments]     ${speed}
    Wait Until Element Is Visible    //div[contains(text(),'Speed: ${speed}')]    120 s
    Element Text Should Be           //div[contains(text(),'Speed: ${speed}')]    Speed: ${speed}
    Sleep                            3 s

Validate Broadband Technology
    [Arguments]     ${technology}
    ${technology}=    Convert To Upper Case   ${technology}
    Wait Until Element Is Visible    //div[contains(text(),'Technology: ${technology}')]    120 s
    Element Text Should Be           //div[contains(text(),'Technology: ${technology}')]    Technology: ${technology}
    Sleep                            3 s

Validate No Data is Displayed
    Wait Until Element Is Visible     //div[@class='error-block__desc']    120 s
    Sleep                            3

Validate Broadband Amount to Pay
    Wait Until Element Is Visible    //p[contains(text(),'Amount to pay:')]    120 s
    Element Text Should Be           //p[contains(text(),'Amount to pay:')]    Amount to pay:
    Sleep                            3 s

Validate Broadband Amount Due
    Wait Until Element Is Visible    //p[@class='text-small']    120 s
    Sleep                            3 s

Validate Broadband Last Payment Amount
    Wait Until Element Is Visible    //p[contains(text(),'Last Payment Amount:')]    120 s
    Sleep                            3 s

Validate Broadband Last Payment Date
    Wait Until Element Is Visible    //p[contains(text(),'Last Payment Date:')]    120 s
    Sleep                            3 s

Validate Broadband View Bill Button
    ${status}=    Get Element Status              //button[@class='btn btn btn--blue btn--mgb']
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible            //button[@class='btn btn btn--blue btn--mgb']     120 s
    Sleep                            3 s

Validate Charges for the Current Bill Title
    Wait Until Element Is Visible    //p[contains(text(),'Charges for the current bill')]   120 s
    Element Text Should Be           //p[contains(text(),'Charges for the current bill')]    Charges for the current bill
    Sleep                            3 s

Validate Broadband Charges for Month
    Wait Until Element Is Visible    //p[contains(text(),'Charges for this month')]    120 s
    Sleep                            3 s

Validate Broadband Remaining Due
    Wait Until Element Is Visible    //p[contains(text(),'Remaining Balance (due immediately)')]    120 s
    Sleep                            3 s

Validate Broadband Charges Amount to Pay
    Wait Until Element Is Visible    //p[@class="charges-title mr-t-20"]    120 s
    Sleep                            3 s

Validate Broadband Number of GB
    ${status}=    Get Element Status    //p[3][@class='title-unli']
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible  //p[3][@class='title-unli']
    Sleep                            3 s

Validate Broadband Total Data Consumption
    ${status}=    Get Element Status    //p[1][@class='title-unli']
    Run Keyword If  ${status} is ${TRUE}
    ...  Wait Until Element Is Visible  //p[1][@class='title-unli']
    Sleep                            3 s

Validate Data Unlimited
    ${status}=    Get Element Status    //div[@class='usage-data__interim__thumbnail']//img[@class='img-responsive']
    Run Keyword If  ${status} is ${TRUE}
    ...     Wait Until Element Is Visible    //div[@class='usage-data__interim__thumbnail']//img[@class='img-responsive']    120 s
    Sleep                            2 s
