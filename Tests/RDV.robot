*** Settings ***
Documentation    Suite de test pour la création et la gestion des rendez-vous
Library   ../Resources/Libs/TestLib.py
Resource  ../Resources/Keywords/keyword.robot

Test Setup    Open Browser to Login Page
Test Teardown    Close Browser

*** Test Cases ***
List_RDV    Comment  vérification des éléments de la page listant les rendez-vous
    [Tags]    List RDV
    ConnexionOk
    Hide_Nav    Rendez-vous
    Page Should Contain Element    ${rdv_h2_title}
    Page Should Contain Textfield    ${Recherche}
    Page Should Contain Element    ${filter_data_to_display_rdv}
    Page Should Contain Element    ${tableau}    #tableau des RDV
    Page Should Contain Link    ${btn_add}    #vérif bouton d'ajout RDV



    @{items}=    Create List
    ${count}=    Set Variable    0
    FOR    ${i}    IN RANGE    2    11
    ${count}    Evaluate    ${count}+1

    ${header}=    Get Table Cell    ${tableau}    1    ${i}    #Récupration des entêtes de tableaux et affichage pour vérification

    Append To List    ${items}    ${header}

    Log To Console    Entête${SPACE}${count+1}:${SPACE} @{items}[${count-1}]     #affichage des entetes dans la console

    END

    Page Should Contain Element    ${filter_row_under_theader}

    ## Vérification des zones de recherche sous chaque colonne
    ${chars}=   Generate Random String    3    [LETTERS]
    ${int}=    Random Int    0    50
    FOR    ${i}    IN RANGE    2    11
        Page Should Contain Element    //th[${i}]//input[1]

        Run Keyword If    ${i}<=4    Input Text  //th[${i}]//input[1]    ${int}
        ...    ELSE IF    ${i}>4    Input Text    //th[${i}]//input[1]    ${chars}
        Clear Element Text    //th[${i}]//input[1]

    END

    Page Should Contain Element    //tbody//tr[1]//td[1]//a[1]${btn_edit}   #vérif de la présence de l'icone de modification AER
    Page Should Contain Element    //tbody//tr[1]//td[1]//a[2]${btn_trash}    #vérif icone de suppression

    Logout

Tri_RDV
    [Tags]    Tri RDV

    ConnexionOk
    Hide_Nav    Rendez-vous

    @{items}=    Create List
    ${count}=    Set Variable    0
    FOR    ${i}    IN RANGE    2    11
    ${count}    Evaluate    ${count}+1

    ${header}=    Get Table Cell    ${tableau}    1    ${i}    #Récupration des entêtes de tableaux et affichage pour vérification

    Append To List    ${items}    ${header}
    END

    Element Attribute Value Should Be    //td[text()='${items}[0]']    class    st-sort-descent    #vérif. du tri descendant sur les ID par défaut

    :FOR    ${col}    IN    @{items}

     Click Element    //td[contains(text(),"${col}")]
     Sleep    1s
     Run Keyword If    '${col}' == 'ID'    Element Attribute Value Should Be    //td[contains(text(),"${col}")]    class    ${EMPTY}    #Aucun Tri
    ...    ELSE IF   '${col}' != 'ID'    Element Attribute Value Should Be    //td[contains(text(),"${col}")]    class    st-sort-ascent

     Click Element    //td[contains(text(),"${col}")]
     sleep    1s    #pause 1 seconde car application trop lente (temps pour charger les élements)
     Run Keyword If   '${col}' == 'ID'    Element Attribute Value Should Be    //td[contains(text(),"${col}")]    class    st-sort-ascent
     ...    ELSE IF   '${col}' != 'ID'    Element Attribute Value Should Be    //td[contains(text(),"${col}")]    class    st-sort-descent


     Click Element    //td[contains(text(),"${col}")]
     Sleep    1s
     Run Keyword If   '${col}' == 'ID'    Element Attribute Value Should Be    //td[contains(text(),"${col}")]    class    st-sort-descent
     ...    ELSE IF    '${col}' != 'ID'    Element Attribute Value Should Be    //td[contains(text(),"${col}")]    class    ${EMPTY}


    END
    Logout
Create_RDV
    [Tags]    Création RDV
    RDV_Form
    ${date}=    Future Date    end_date=+30d, tzinfo=None
    ${date_rdv}=    Convert Date    '${date}'    result_format=%Y-%m-%d    exclude_millis=yes
    ${objet}=    Bs
    ${agence}=    Agence
    Log To Console    ${agence}
    ${client}=    Company
    ${cr}=     Sentences    nb=4    ext_word_list={}
    ${act}=    Sentences    nb=3    ext_word_list={}

    Input Text    ${rdv_client_field_xpath}    ${client}
    Input Text    ${rdv_objet_field_xpath}    ${objet}
    Input Text    ${rdv_agence_field_xpath}    ${agence}

    Input Text    ${rdv_date_field_xpath}    ${date_rdv}

    Click Element    ${rdv_descript_field_xpath}
    Input Text    ${rdv_descript_field_xpath}      ${cr}
    Input Text    ${rdv_descript_field_xpath}    ${act}
    Click Button    ${btn_update}
    Page Should Contain Element    ${msg_update}
    Logout

Modif_RDV    Comment    Modification d'un rendez-vous
    [Tags]    Modif RDV
    ConnexionOk
    Hide_Nav    Rendez-vous


    ${nbre_entre}=    Get Element Count    ${btn_edit}

    ${line2mod}=    Random Int    0    ${nbre_entre}     #tirage aléatoire d'un nombre pour le choix de la ligne à modifier

    ${organisateur}=    Last Name

    Click Element    //tbody//tr[${line2mod}]//td[1]//a[1]//i[1]

    Click Element    ${rdv_organisateur_field_xpath}
    Input Text    ${rdv_organisateur_field_xpath}    ${organisateur}
    ${url}=    Get Location
    ${line}=    Convert To List    ${url}

    Click Button    ${btn_update}


    Page Should Contain    Le rendez-vous avec l'identifiant ${line}[-2]${line}[-1] a été mis à jour


    Page Should Contain Element    ${msg_update}
    Logout

Supp_RDV
    [Tags]    Supprimer RDV
    ConnexionOk
    Hide_Nav    Rendez-vous
    ${nbre_entre}=    Get Element Count    ${btn_edit}
    ${line}=    FakerLibrary.Random Int    2    ${nbre_entre}    1    #tirage aléatoire d'un nombre pour la ligne à supprimer


    Click Element    xpath://tbody//tr[${line}]//td[1]//a[2]//i[1]    #clic sur l'icone poubelle pour suppression
    Page Should Contain Element    ${modal_xpath}

#    Wait Until Element Is Not Visible    //div[@id='deleteModal']//div[@class='modal-content']
   Wait Until Element Contains    ${modal_xpath}    ${modal_msg}
    Element Should Be Visible    ${btn_annuler_suppr_xpath_1}    #bouton annuler
    Element Should Be Visible    ${btn_Suppr}    #bouton supprimer pour confirmer la suppression de la fiche

    Click Element    ${btn_annuler_suppr_xpath_1}      #clic sur le bouton "Annuler"


    Wait Until Element Is Not Visible    ${fade_element}
    Wait Until Element Is Visible    xpath://tbody//tr[${line}]//td[1]//a[2]//i[1]
    Click Element    xpath://tbody//tr[${line}]//td[1]//a[2]//i[1]

    Click Element    ${close_modal}    # Annulation de la suppression en cliquant sur la croix pour fermer la fenetre modal

    Wait Until Element Is Visible    xpath://tbody//tr[${line}]//td[1]//a[2]//i[1]


    #${trash}=    FakerLibrary.Random Int    2    ${nbre_entre}    1    #tirage aléatoire d'un nombre pour la ligne à supprimer


    #${id_trash}=    Get Table Cell    //table[@class='responsive-table striped tableListe table-edit']    ${trash}    2
    Click Element    xpath://tbody//tr[${line}]//td[1]//a[2]//i[1]

    Click Button    ${btn_update}    #clic sur le bouton "Supprimer"

    ${msg}=    Get Text    ${msg_update}

    Log    ${msg}
    Log To Console    ${msg}
