*** Settings ***
Documentation    Suite de test pour la connexion à l'espace utilisateur du site CCO
Resource    ../Resources/Keywords/common.robot
Resource    ../Resources/Keywords/keyword.robot

Test Setup    Open Browser to Login Page
Test Teardown    Close Browser

*** Test Cases ***
Login_ok_gherkin
    [Template]    Test Gherkin
    ${login}    ${pwd}

Connexion valide    Comment    identifiant et mot de passe valides
    ConnexionOk
    Logout
