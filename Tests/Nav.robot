*** Settings ***
Library   ../Resources/Libs/TestLib.py
Resource  ../Resources/Keywords/keyword.robot

Documentation    Suite de test pour la  navigation dans le site CCO

Test Setup    Open Browser to Login Page
Test Teardown    Close Browser

*** Test Cases ***
Navigation
    #[Arguments]    @{Menu_items}
    [Tags]    Check MainMenu Links

    Connexion_Nav

    :FOR     ${a}    IN    @{main_menu_items}

        Page Should Contain Link    link:${\n}${a}

    END

    ${count_elemn}    Get Element Count    css:div.side-menu-container
    Comment    Affichage du nombre de webElement récuperer
    Log To Console    ${count_elemn}

    ${list_nav}   Get WebElements  css:div.side-menu-container

    :FOR    ${a}    IN    @{list_nav}
        @{items_nav}    Extraction    ${a.text}

        Set Test Variable    @{items_nav}


    END

    Log To Console    ${\n}
    Log To Console    Menu principale
    Comment    *Affichage  des liens disponibles dans le Menu
    ${count}    Set Variable    0
    :FOR    ${i}    IN    @{items_nav}
        Element Should Contain    css:div.side-menu-container    ${i}

        ${count}    Evaluate     ${count}+1

        Log    ${i}

        Log To Console    lien${SPACE}${count}: ${i}

    END

CheckIndicateurs
    Check SubMenu Indicateurs

Check SubMenu KanbanPOC
    [Tags]    SubMenu Kanban

    ConnexionOk
    Click Element    css:span.icon.fa.fa-table

    Wait Until Element Is Visible    css:div#dropdown-3

    @{webElem}    Get WebElements    css:div#dropdown-3

    :FOR    ${i}    IN    @{webElem}
	     Page Should Contain Link    ${i}

	END

     @{list_kanban}    Extraction    ${i.text}
     # Log To Console    @{list_kanban}[0]
     # Log To Console    @{list_kanban}[1]
     ${counter}    Set Variable    0
    :FOR    ${link}    IN    @{list_kanban}


        ${counter}    Evaluate    ${counter}+1

	    #${links}    Evaluate    [${link}.strip() for ${link} in  @{list_kanban}]

        ${links}    Strip String    ${link}    mode=both
        Click Link    link:${links}

    END
Check SubMenu_Admin
    [Tags]    SubMenu Admin

    ConnexionOk
    Click Element    css:span.icon.fa.fa-road
    @{elements}    Get WebElements  id:dropdown-admin
    :FOR    ${i}    IN    @{elements}

        Page Should Contain Link    ${i}

    END

	    ${count}    Set Variable    0
	    @{list_admin}    Extraction    ${i.text}

   :FOR       ${item}        IN     @{list_admin}

		     ${count}    Evaluate     ${count}+1
		     #${items}    Evaluate    [${item}.strip() for ${item} in @{list_admin}]
		#     Set Test Variable    ${items}
		     ${items}    Evaluate    [${item}.strip() for ${item} in @{list_admin}]

		     Run Keyword If    ${count}==2    Click Element    css:em.fa.fa-fw.fa-desktop

		     Run Keyword If    '${items}[${count-1}]' != 'Configuration'    Click Link    link:${items}[${count-1}]
		     Set Browser Implicit Wait    10s

	END
