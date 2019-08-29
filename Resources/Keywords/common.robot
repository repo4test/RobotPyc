*** Settings ***
Documentation    Suite description
Variables   ../PO/var.py

*** Keywords ***
Open Browser to Login Page

     FOR    ${Browser}    IN    @{Browsers}
        Open Browser    ${Site_Url}    ${Browser}
        Maximize Browser Window
     #Set Selenium Speed    1s
        Check Login Page
     END
ConnexionOk    Comment    Connexion Réussi
    Login Pwd Ok
    Set Browser Implicit Wait    10s
    Wait Until Page Contains    ${h2_title}
    Title Should Be    ${landingPage_Title}
    Page Should Contain Element    ${logout}
    Click Element    ${expand}
Login Pwd Ok
        Input Text    ${user_id_path}    ${login}
        Input Password    ${user_pwd_path}    ${pwd}
        Click Button    ${btn_connexion}
Logout
      Click Element    ${logout}

Test Gherkin
    [Arguments]    ${login}    ${pwd}
    Given Page Should Contain Element    css:input#username
    When Input Text   ${user_id_path}    ${login}
    And Input Password    ${user_pwd_path}    ${pwd}
    And Click Element    ${btn_connexion}
    And Wait Until Page Contains    Assistance Technique
     ${pageTitle}=    Get Title
    Then Title Should Be    ${pageTitle}
    Then Logout