*** Settings ***
Documentation    Suite de test pour la création et la gestion des assistances techniques
Library   ../Resources/Libs/TestLib.py
Resource    ../Resources/Keywords/keyword.robot

Test Setup    Open Browser to Login Page
Test Teardown    Close Browser

*** Test Cases ***

Tri_AT    Comment    Tri des fiches AT par colonnes
    [Tags]    Tri AT
    ConnexionOk
    Hide_Nav    Assistance technique

    @{items}=    Create List
    ${count}=    Set Variable    0
    FOR    ${i}    IN RANGE    3    16

    ${count}    Evaluate    ${count}+1

    ${header}=    Get Table Cell    ${tableau}    1    ${i}    #Récupération des entête de tableaux et affichage pour vérification

    Append To List    ${items}    ${header}

    Log To Console    Entête${SPACE}${count+1}:${SPACE} @{items}[${count-1}]     #affichage des entetes dans la console

    Click Element    //td[contains(text(),"@{items}[${count-1}]")]
    sleep    1s
    Element Attribute Value Should Be    //td[contains(text(),"@{items}[${count-1}]")]    class    st-sort-ascent    #Vérif du tri ascendant

    Click Element    //td[contains(text(),"@{items}[${count-1}]")]
    sleep    1s
    Element Attribute Value Should Be    //td[contains(text(),"@{items}[${count-1}]")]    class    st-sort-descent    #Vérif du tri descendant
    sleep    1s
    Click Element    //td[contains(text(),"@{items}[${count-1}]")]
    Element Attribute Value Should Be    //td[contains(text(),"@{items}[${count-1}]")]    class    ${EMPTY}
    END
    Logout

Verif_AT_Form    Comment    Verification des élements  de la page listant les AT
    [Tags]    Vérif. tabelau AT
    Connexion_Nav_AT

    @{items}=    Create List
    ${count}=    Set Variable    0
    FOR    ${i}    IN RANGE    3    16

	    ${count}    Evaluate    ${count}+1

	    ${header}=    Get Table Cell    ${tableau}    1    ${i}    #Récupération des entête de tableaux et affichage pour vérification

	    Append To List    ${items}    ${header}

	    Log To Console    Entête${SPACE}${count+1}:${SPACE} @{items}[${count-1}]     #affichage des entetes dans la console
    END
    Set Screenshot Directory    ${output_screens}
    Click Element    xpath://td[contains(text(),'Date réception')]
    Capture Page Screenshot    ${output_screens}/pageAT.png
    Logout

Créer AT    Comment    Création Assistance Technique
    [Tags]    CréaAT
    AT Form

    @{el}    Get WebElements    css:div.col-sm-5.form-group.label-static

    :FOR    ${index}    ${value}    IN ENUMERATE    @{el}
            Log To Console    ${index}:${value}

    END

    ${titre}=     FakerLibrary.Sentence    nb_words=6    variable_nb_words=False
    Input Text    css:#titre    ${titre}    #saisie champs Titre

    ${a}    Set Variable    0
    ${locator}    Set Variable    xpath:(//input[@type='radio'])[1]

    @{items}    Extraction    ${value.text}

    :FOR    ${index}    ${choise}    IN ENUMERATE    @{items}


        ${choises}=     Run Keyword If    ${index}>=1    Evaluate    [${choise}.strip() for ${choise} in @{items}]    #clear whitespace in value

        ${a}    Evaluate    ${a}+1
        Run Keyword If    ${index}!=0    Log To Console    Radio button available ${a-1}: ${choise}    #Affichage des radio button disponible
#        Run Keyword If    1<${index}<3        Click Button   xpath://input[@value='${choises}[${a-1}]' and @type='radio']  #vérif. que les radios button sont cliquable
        Run Keyword If    0<${index}<=3    Click Button    xpath:(//input[@type='radio'])[${index}]
        ...    ELSE IF    "${locator}" == "xpath:(//input[@type='radio'])[1]"    Click Button    xpath:(//input[@type='radio'])[2]
#        Run Keyword If    ${index}>1     Select Radio Button    676${i-1}    ${choises}[${a-2}]
#        Run Keyword If    ${index}>0    Page Should Contain Radio Button    identifier:676${i}    ${choises}[${a-1}]

    END

    :FOR    ${i}    IN RANGE    2    5


        Click Button    xpath:(${AT_btn_radio_type_xpath})[${i}]    #vérif de la disponibilité des boutons radio


        Run Keyword If    ${i}==2    Mouse Over    //li/a[contains(text(),'ABEI')]            #vérif selection Client
#      Run Keyword If    ${i}==2    Mouse Down     //li/a[contains(text(),'ABEI')]
        Run Keyword If    ${i}==2    Click Element    //li/a[contains(text(),'ABEI')]

       Run Keyword If    ${i}==4    Mouse Over    //li/a[contains(text(),'Reçu')]    #vérif selection Statut
       Run Keyword If    ${i}==4    Click Element    //li/a[contains(text(),'Reçu')]


       Run Keyword If    ${i}==3    Mouse Over    //li[7]/a[contains(text(), "AIX")]    #vérif selection Agence
       Run Keyword If    ${i}==3    Click Element    //li[7]/a[contains(text(), "AIX")]

    END
    Input Text    id:description    Description pour test creation AT     #Description AT
    Element Should Be Visible    //button[@class='btn btn-raised btn-info' and @type='submit']
    DatePlus_AT    date_presentation
    Click Button    ${Submit}    #valider la création de l'AT
    Logout
verif AO
    AT Form
    Logout


ModifAT    Comment    Modification AT et vérification des regles de saisi du champ numéro AO
    [Tags]    Mofif AT
    ConnexionOk
    Click Element    ${menu_burger}
    Page Should Contain Element    ${tableau}/tbody

    @{elemen}=    Get WebElements    ${tableau}//tbody
    Log To Console    ${elemen}

    :FOR    ${i}    IN    @{elemen}

        @{item}=    Extraction    ${i.text}
     END
    ${nbre_entre}=    Get Element Count    ${btn_edit}

    Log To Console    nombre d'entrée:${SPACE} ${nbre_entre}

    ${line2mod}=    Random Int    0    25     #tirage aléatoire d'un nombre pour le choix de la ligne à modifier

    Wait Until Element Is Visible    ${btn_edit}

    Click Element    xpath://tbody//tr[${line2mod}]//td[1]//a[1]//i[1]

    Click Element    xpath://input[@type='radio' and @value='ATG']


    ${AO}=    FakerLibrary.License Plate
    Input Text    id:numero-ao   ${AO}
    Click Button    xpath:${btn_update}
    Wait Until Page Contains Element    xpath:${msg_update}    #vérif message confirmation de modification réussi
   Logout

SupprAT
    ConnexionOk
    Click Element    xpath:${menu_burger}
    Wait Until Page Contains Element     xpath:${btn_edit}

    ${line}=    FakerLibrary.Random Int    1    25    #tirage aléatoire d'un nombre pour la ligne à supprimer

    Click Element    xpath://tbody//tr[${line}]//td[1]//a[2]//i[1]    #clic sur l'icone poubelle pour suppression
    Page Should Contain Element    ${modal_xpath}

#    Wait Until Element Is Not Visible    //div[@id='deleteModal']//div[@class='modal-content']
    Element Should Contain    ${modal_content_xpath}    ${modal_msg}
    Element Should Be Visible    ${btn_annuler_suppr_xpath}    #bouton annuler
    Element Should Be Visible    ${btn_Suppr}    #bouton supprimer pour confirmer la suppression de la fiche

    Click Element    ${btn_annuler_suppr_xpath}      #clic sur le bouton "Annuler"


    Wait Until Element Is Not Visible    xpath//div[@class='modal-backdrop fade in']
    Wait Until Element Is Visible    xpath://tbody//tr[${line}]//td[1]//a[2]//i[1]
    Click Element    xpath://tbody//tr[${line}]//td[1]//a[2]//i[1]

    Click Element    ${close_modal}    # Annulation de la suppression en cliquant sur la croix pour fermer la fenetre modal

    Wait Until Element Is Visible    xpath://tbody//tr[${line}]//td[1]//a[2]//i[1]
    Click Element    xpath://tbody//tr[${line}]//td[1]//a[2]//i[1]

    Click Element    ${btn_Suppr}    #clic sur le bouton "Supprimer"

    Capture Page Screenshot    ${output_screens}/confirmSuppr.png

    ${msg}=    Get Text    ${msg_update}

    Log To Console    ${msg}

    Logout

SearchFilter_AT    Comment    Recherche par filtre et réinitilaisation des filtres
    ConnexionOk
    Click Element    ${menu_burger}
    @{col}=    FakerLibrary.Random Sample    3,7,8,9,10,11,12,13,14,15    1
    Log To Console    ${col}
    ${filter_char}=    Random Letters    length=3
    ${filter_int}=    Random Int    0    999

    Run Keyword If    ${col}!=[3]    Input Text    xpath://th${col}//input[1]    ${filter_char}
    ...    ELSE IF    ${col}==[3]    Input Text    xpath://th${col}//input[1]     ${filter_int}

    Capture Page Screenshot    ${output_screens}/filterAT.png

    Click Element    xpath:${btn_refresh_page}    #Reset filter
    Wait Until Page Contains Element     ${btn_edit}
    Capture Page Screenshot    ${output_screens}/filteReset.png
    Logout

Search_AT    Comment    Recherche multicritères
    ConnexionOk
    Click Element    ${menu_burger}
    Wait Until Page Contains Element     ${btn_edit}

    ${filter}=    FakerLibrary.Random Letters    length=3
    Input Text    css:#search    ${filter}    #saisie 3 caractères dans le formulaire
    Capture Page Screenshot    ${output_screens}/searchMulti-char.png

    ${filterDigit}=    FakerLibrary.Random Int    0    999
    Input Text    css:#search    ${filterDigit}    #saisie 2 chiffres dans le formulaire

    Capture Page Screenshot    ${output_screens}/searchMulti-digit.png

    Clear Element Text    css:#search
    Capture Page Screenshot    ${output_screens}/searchMulti-clear.png
    Logout
Date AT    Comment    date du jour
    AT Form
#    ${elem}=    Get WebElements    locator
    Click Element    ${reception_xpath}
    Click Element    //td[@class='today day']
    Click Element    ${reponse_xpath}
    Click Element    //td[@class='today day']
    Click Element    ${presentation_xpath}
    Click Element    //td[@class='today day']
    Click Element    ${demarrage_xpath}
    Click Element    //td[@class='today day']
    Click Element    ${cloture_xpath}
    Click Element    //td[@class='today day']

DateKO    Comment    dates incohérentes ou au format europeéen
    [Tags]    Date invalide

   AT Form
    Click Element    ${reception_xpath}
    Click Element    //td[@class='today day']

    Click Element    ${reponse_xpath}
     ${date}=    FakerLibrary.Past Date    start_date=-2d    tzinfo=None

     ${drep}=    Convert Date    '${date}'    result_format=%Y-%m-%d    exclude_millis=yes

    Input Text    ${reponse_xpath}    ${drep}      #date de réponse

    Click Element    ${presentation_xpath}
    ${dpres}=    FakerLibrary.Past Date    start_date=-1d
    ${dshow}=    Convert Date    '${dpres}'    result_format=%Y-%m-%d    exclude_millis=yes
    Input Text    ${presentation_xpath}    ${dshow}  #date pésentation

    Click Element    ${demarrage_xpath}
    ${ddeb}=    FakerLibrary.Date Between    start_date=+4d    end_date=+5d
    ${dstart}=    Convert Date    '${ddeb}'    result_format=%Y-%m-%d    exclude_millis=yes
    Input Text  ${demarrage_xpath}    ${dstart}    #date début

    Click Element    ${cloture_xpath}
    ${dfin}=    FakerLibrary.Date Between    start_date=+7   end_date=+13d
    ${dEnd}=    Convert Date    '${dfin}'    result_format=%Y-%m-%d    exclude_millis=yes
    Input Text    ${cloture_xpath}    ${dEnd}    #date Fin
    Capture Page Screenshot    ${OUTPUT_DIR}/dateko.png
    Logout