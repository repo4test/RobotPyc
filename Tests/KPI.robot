*** Settings ***
Documentation    Suite description
Documentation  Suite de test sur les indicateurs de performance
Resource  ../Resources/Keywords/keyword.robot

Suite Setup    Open Browser to Login Page
Suite Teardown    Close Browser

*** Test Cases ***

kpiAER
    [Documentation]  Vérification des indicateurs AER
    [Tags]  KPI AER
    Check SubMenu Indicateurs

    Click Link    link:@{main_menu_items}[4]
    Wait Until Element Is Visible    ${dropdown2}

    Click Element    ${kpi_aerlink_xpath}
    Click Element    ${menu_burger}

kpiAT
    [Documentation]  Vérification des indicateurs AT
    [Tags]  KPI AT
    Click Element    ${menu_burger}

    Click Link    link:@{main_menu_items}[4]
    Wait Until Element Is Visible    ${dropdown2}

    Click Element    ${indicateur_menu_xpath}
    Click Element    ${kpi_atlink_xpath}
    Click Element    ${menu_burger}