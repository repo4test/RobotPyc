*** Settings ***
Documentation    Suite de test pour la connexion à l'espace utilisateur du site CCO

Resource  ../Resources/Keywords/keyword.robot

#Suite Setup    Open Browser to Login Page
#Suite Teardown    Close Browser
Test Setup    Open Browser to Login Page
Test Teardown    Close Browser


*** Test Cases ***
Login ko
    [Template]    Invalid Login with
    ${EMPTY}    ${EMPTY}
    testeur    ${EMPTY}
    ${EMPTY}    gd.201907
    invalid    invalid
    Admin    invalid
    aung    admin123
