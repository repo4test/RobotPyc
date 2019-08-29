*** Settings ***
Documentation    Suite de test pour la création et gestion des Activités à engagement de résultat

Library   ../Resources/Libs/TestLib.py
Resource    ../Resources/Keywords/keyword.robot
Test Setup    Open Browser to Login Page
Test Teardown    Close Browser

*** Test Cases ***
ListAER    Comment    Liste les AER saisies et vérifie les éléments de la page

    ConnexionOk
    Hide_Nav    AER
    Page Should Contain Element    ${aer_h2_title}    #check sous-titre de la page
    Page Should Contain Textfield    ${Recherche}    #check du champ de recherche multi-critères
    Page Should Contain Element    ${filter_data_to_display_aer}    #check du bouton de filtre d'acffichage
    Page Should Contain Element    ${tableau}    #tableau des AER
    Page Should Contain Link    ${btn_add}    #vérif bouton d'ajout AER
    Page Should Contain Link    ${btn_download}
    Page Should Contain Link    ${btn_upload_1}


    @{items}=    Create List
    ${count}=    Set Variable    0
    FOR    ${i}    IN RANGE    3    17
    ${count}    Evaluate    ${count}+1

    ${header}=    Get Table Cell    ${tableau}    1    ${i}    #Récupration des entêtes de tableaux et affichage pour vérification

    Append To List    ${items}    ${header}

    Log To Console    Entête${SPACE}${count+1}:${SPACE} @{items}[${count-1}]     #affichage des entetes dans la console

    END


    Comment    Vérification des zones de recherche sous chaque colonne
    FOR    ${i}    IN    3    5    6    9    10    11    12    13    14    15    16
        Page Should Contain Element    //th[${i}]//input[1]
        Click Element    //th[${i}]//input[1]
    END

    Page Should Contain Element    //tbody//tr[1]//td[1]//a[1]${btn_edit}   #vérif de la présence de l'icone de modification AER
    Page Should Contain Element    //tbody//tr[1]//td[1]//a[2]${btn_trash}    #vérif icone de suppression
    Page Should Contain Element    ${filter_row_under_theader}

    ${agency_filter}=    Get Table Cell   ${tableau}    2    4    #filtre agence
    ${type_filter}=    Get Table Cell   ${tableau}    2    7    #filtre type AER
    ${statut_filter}=    Get Table Cell   ${tableau}    2    8    #filtre statut
    Logout

Tri_AER    Comment    Tri des fiches d'AER
    [Tags]    Tri AER
    ConnexionOk
    Hide_Nav    AER


    @{items}=    Create List
    ${count}=    Set Variable    0
    FOR    ${i}    IN RANGE    3    17
    ${count}    Evaluate    ${count}+1

    ${header}=    Get Table Cell    ${tableau}    1    ${i}    #Récupration des entêtes de tableaux et affichage pour vérification

    Append To List    ${items}    ${header}
    END

    Element Attribute Value Should Be    //td[contains(text(),"${items}[7]")]    class    st-sort-descent    #vérif. du tri descendant sur les dates de réception
    :FOR    ${col}    IN    @{items}

     Click Element    //td[contains(text(),"${col}")]
     sleep    1s    #pause 1 seconde car application trop lente (temps pour charger les élements)
     Run Keyword If    '${col}' != 'Date réception'      Element Attribute Value Should Be    //td[contains(text(),"${col}")]    class    st-sort-ascent    #Vérif du tri ascendant

     Click Element    //td[contains(text(),"${col}")]
     Sleep    1s
     Element Attribute Value Should Be    //td[contains(text(),"${col}")]    class    st-sort-descent    #Tri descendant


     Click Element    //td[contains(text(),"${col}")]
     Sleep    1s
     Element Attribute Value Should Be    //td[contains(text(),"${col}")]    class    ${EMPTY}    #Aucun Tri

    END
    Logout

Créer_AER
    ConnexionOk
    AER_Form
    ${titre}=    Bs
    Input Text    //input[@id='titre']    ${titre}
    ${tirage}=    Random Element    elements=('Privé', 'Public')
    Run Keyword If    '${tirage}' == 'Privé'    Click Element    //div[@class='radio radio-primary']//label[contains(text(),'${tirage}')]
    ...    ELSE    Click Element    //div[@class='radio radio-primary']//label[contains(text(),'Public')]

     ${client}=    Client Aer
     ${statut}=    Statut Aer
     ${agence}=    Agence
    :FOR    ${i}    IN RANGE    2    5
        Click Element    (//button[@class='form-control btn btn-default btn-block dropdown-toggle'])[${i}]

       Run Keyword If    ${i} == 2  Click Element    //li/a[contains(text(),"${client}")]

       Run Keyword If    ${i} == 3  Click Element    //li/a[contains(text(),"${agence}")]
       Run Keyword If    ${i} == 4  Click Element    //li/a[contains(text(),"${statut}")]
    END
    ${description}=    Sentences    2
    Input Text    //textarea[@id='description']    ${description}    #description

    DatePlus_AT    date_soutenance

    ${action}=    Sentences    nb=2
    Input Text    //input[@id='code-profil']    ${action}

    ${montant}=    Random Int    100000    1000000
    Input Text    //input[@id='montant']    ${montant}${SPACE}€

    ${type}=    Type Aer
    Click Element  (//button[@class='form-control btn btn-default btn-block dropdown-toggle'])[6]
    Click Element    //a[contains(text(),"${type}")]


    ${radio}=    Get WebElements    (//div[@class='radio radio-primary'])[2]
  :FOR    ${i}    IN    @{radio}
      Log    ${i.text}

   END
   @{list_radio}=    Extraction    ${i.text}

   :FOR    ${index}    ${value}    IN ENUMERATE    @{list_radio}

       ${tirage}=    Random Int    0    3
       ${striped}=    Strip String     ${value}    both
       Run Keyword If    ${tirage} != 0   Click Element    //label[contains(text(),'En attente décision')]
       ...    ELSE    Click Button    //button[@type='submit']

   END

   Logout

Modif AER     Comment    Modification AER et vérification des règles de saisi du champ numéro AO

    [Tags]    Modif  AER
    ConnexionOk
#    Click Element    css:em.glyphicon.glyphicon-menu-hamburger.icon
    Hide_Nav    AER
    Page Should Contain Element    ${tableau}//tbody


    ${nbre_entre}=    Get Element Count    xpath:${btn_edit}

    Log To Console    nombre d'entrée:${SPACE} ${nbre_entre}

    ${line2mod}=    Random Int    0    ${nbre_entre}     #tirage aléatoire d'un nombre pour le choix de la ligne à modifier

    Wait Until Element Is Visible    xpath:${btn_edit}

    Click Element    xpath://tbody//tr[${line2mod}]//td[1]//a[1]//i[1]

    Click Element    //input[@id='code-profil']
    ${action}=    Sentences    nb=2
    Input Text    //input[@id='code-profil']    ${action}


    ${AO}=    FakerLibrary.License Plate
    Input Text    id:numero-ao   ${AO}
    Click Button    xpath:${btn_update}
    Wait Until Page Contains Element    ${btn_update}    #vérif message confirmation de modification réussi
    Logout

Search_Filter_AER    Comment    Recherche par filtrage des données tableau AER
    [Tags]    Filtrage AER

    ConnexionOk
    Hide_Nav    AER

    ${col}=    FakerLibrary.Random Element    elements=(3, 5, 6, 9, 10, 11, 12, 13, 14, 15, 16)

    ${filter_char}=    Random Letters    length=2
    ${filter_int}=    Random Int    0    999

    Run Keyword If    ${col}!=3    Input Text    //th[${col}]//input[1]    ${filter_char}
    ...    ELSE IF    ${col}==3    Input Text    //th[${col}]//input[1]     ${filter_int}
    ...    ELSE IF    ${col}==15    Input Text    //th[${col}]//input[1]     ${filter_int}

    Capture Page Screenshot    ${output_screens}/filterAER.png

    Click Element    xpath:${btn_reset_filter}    #Reset filter
    Wait Until Page Contains Element     xpath:${btn_edit}
    Capture Page Screenshot    ${output_screens}/filteResetAER.png
    Logout

Search_AER    Comment    Recherche multi-critères
    [Tags]    Recherche Multi AER


    ConnexionOk
    Hide_Nav    AER
    Wait Until Page Contains Element     xpath:${btn_edit}

    ${filter}=    FakerLibrary.Random Letters    length=3
    Input Text    css:#search    ${filter}    #saisie 3 caractères dans le formulaire
    Capture Page Screenshot    ${output_screens}/searchAerMulti-char.png

    ${filterDigit}=    FakerLibrary.Random Int    0    999
    Input Text    css:#search    ${filterDigit}    #saisie 2 chiffres dans le formulaire

    Capture Page Screenshot    ${output_screens}/searchAerMulti-digit.png

    Clear Element Text    css:#search
    Capture Page Screenshot    ${output_screens}/searchAerMulti-clear.png
    Logout
SupprAER
    ConnexionOk
    Hide_Nav    AER
    Wait Until Page Contains Element     ${btn_trash}

    ${nbre_entre}=    Get Element Count    xpath:${btn_trash}
    ${line}=    FakerLibrary.Random Int    1    ${nbre_entre}    #tirage aléatoire d'un nombre pour la ligne à supprimer

    Click Element    xpath://tbody//tr[${line}]//td[1]//a[2]//i[1]    #clic sur l'icone poubelle pour suppression
    Page Should Contain Element    ${modal_xpath}

#    Wait Until Element Is Not Visible    //div[@id='deleteModal']//div[@class='modal-content']
    Element Should Contain    ${modal_xpath}    ${modal_msg}
    Element Should Be Visible    ${btn_annuler_suppr_xpath}    #bouton annuler
    Element Should Be Visible    ${btn_Suppr}    #bouton supprimer pour confirmer la suppression de la fiche

    Click Element    ${btn_annuler_suppr_xpath}      #clic sur le bouton "Annuler"


    Wait Until Element Is Not Visible    ${fade_element}
    Wait Until Element Is Visible    xpath://tbody//tr[${line}]//td[1]//a[2]//i[1]
    Click Element    xpath://tbody//tr[${line}]//td[1]//a[2]//i[1]

    Click Element    ${close_modal}    # Annulation de la suppression en cliquant sur la croix pour fermer la fenetre modal

    Wait Until Element Is Visible    xpath://tbody//tr[${line}]//td[1]//a[2]//i[1]
    Click Element    xpath://tbody//tr[${line}]//td[1]//a[2]//i[1]

    Click Element    ${btn_Suppr}    #clic sur le bouton "Supprimer"
    ${msg}=    Get Text    ${msg_update}

    Capture Page Screenshot    ${output_screens}/confirmSupprAER.png

    Log To Console    ${msg}
