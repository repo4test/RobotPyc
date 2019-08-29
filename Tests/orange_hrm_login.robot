*** Settings ***
Library    OperatingSystem
Library    SeleniumLibrary
#Library    DataDriver    file=../Resources/orange-hrm-data.csv


Test Setup    Open Browser to Login Page
Test Teardown    Close Browser
Library    OperatingSystem
Library    SeleniumLibrary
#Library    DataDriver    file=../Resources/orange-hrm-data.csv
*** Variables ***
${Url}=    https://opensource-demo.orangehrmlive.com/
@{Browser}=    Firefox  Chrome

*** Keywords ***
Open Browser to Login Page
     Open Browser    ${Url}    @{Browser}
     Page Should Contain Element    //div[@id='divLogo']//img
     Maximize Browser Window

Invalid Login With
    [Arguments]     ${user_id}     ${user_pwd}
    Input Text    id=txtUsername    ${user_id}
    Input Password   id=txtPassword    ${user_pwd}
    Click Button    //input[@id='btnLogin']
    Page Should Contain Element    //span[@id='spanMessage']
    ${Msg_Err}=    Get Text    //span[@id='spanMessage']
    Page Should Contain    ${Msg_Err}

Valid Login With
    [Arguments]     ${user_id}     ${user_pwd}
    Input Text    id=txtUsername    ${user_id}
    Input Password   id=txtPassword    ${user_pwd}
    Click Button    //input[@id='btnLogin']
    Wait Until Page Contains Element    //h1[contains(text(),'Tableau de bord')]
    Page Should Contain Image    //div[@id='branding']//a//img
    Click Link    //a[@id='welcome']
    Wait Until Element Is Visible    //div[@id='welcome-menu' and @class='panelContainer']
    Sleep   2s
    Click Link    //a[contains(text(),'Déconnexion')]

*** Test Cases ***
Login_ko
    [Template]    Invalid Login With
    ${EMPTY}    ${EMPTY}
    guda    ${EMPTY}
    ${EMPTY}    gd.201907
    invalid    invalid
    Admin    invalid
    aung    admin123

Login_ok
     [Template]    Valid Login With
     Admin    admin123