*** Settings ***
##  Resources for tests
Library  SeleniumLibrary
Library  String
Library  Collections
Library  DateTime
Library  FakerLibrary   locale=fr_FR

Variables    ../PO/nav_element_locator.py
Variables    ../PO/login_element_locator.py
Variables    ../PO/common_element_locator.py
Variables    ../PO/at_element_locator.py
Variables    ../PO/aer_element_locator.py
Variables    ../PO/dispo_element_locator.py
Variables    ../PO/rdv_element_locator.py
Variables    ../PO/kpi_element_locator.py
Variables    ../PO/var.py

Resource    common.robot

*** Keywords ***

Check Login Page
    [Documentation]     Open login page and check elements
    #Alert Should Be Present
    Title Should Be    ${Site_Title}
    Page Should Contain Element    partial link:${Site_Title}
    Page Should Contain Element    ${app_version}
    Page Should Contain Element    ${login_page_title}
    Element Should Be Visible    ${user_id_path}
    Element Should Be Visible    ${user_pwd_path}
    Page Should Contain Checkbox    ${user_pwd_path}    #id:password
    Page Should Contain    Afficher le mot de passe
    Element Should Be Visible    ${btn_connexion}

Hide_Nav
    [Arguments]    ${element}
    ${click_menu_element}=    Set Variable    //div[@class='side-menu-container' ]//span[contains(text(),'${element}')]
    Click Element    ${click_menu_element}
    Click Element    ${menu_burger}


Invalid Login With
    [Arguments]    ${user_id}    ${user_pwd}
    Input Text    ${user_id_path}    ${user_id}
    Input Password   ${user_pwd_path}    ${user_pwd}
    Click Button    ${btn_connexion}
    Page Should Contain Element    ${error_msg_login}
Connexion_Nav
    ConnexionOk
    Page Should Contain Element    ${nav_bar}
    Set Browser Implicit Wait    ${timeout}

Connexion_Nav_AT
    ConnexionOk
    Click link    ${link_AT}
    Click Element    ${menu_burger}

    Page Should Contain Element    ${AT_page_title}
    Element Should Be Visible    ${Recherche}
    Page Should Contain Button    ${Filtre_AT}
    Element Should Be Visible    ${tableau}
    Element Should Be Visible    ${btn_add}
    Element Should Be Visible    ${btn_cloud_download}
    Element Should Be Visible    ${btn_upload}

Connexion_ Nav_Dispo
    ConnexionOk

    Click Element    ${link_dispo}
    Click Element    ${menu_burger}
    Wait Until Element Is Visible    ${table_row_dispo}
    Title Should Be    Disponibilites

    Page Should Contain    Disponibilité
    Page Should Contain Element    ${Recherche}     #vérif de la présence du formulaire de recherche multi-critères
    Page Should Contain Element    ${filter_data_to_display_dispo}    #check liste de selection tri

    Page Should Contain Element    ${table_dispo}    #vérif de la présence du tableau listant les disponibilités saisies
    Page Should Contain Element    ${btn_add}    #Check bouton ajout nouvelle disponibilité
    Page Should Contain Element    ${btn_download_1}    #Check bouton exporter et télechager les disponibilités

Check SubMenu Indicateurs
    ConnexionOk


    Click Link    link:@{main_menu_items}[4]

    Wait Until Element Is Visible    id:dropdown-2

    # Page Should Contain Link    css:#dropdown-2    AER
    # Page Should Contain Link    css:#dropdown-2    Assistance technique

    Element Should Contain    ${dropdown2}    AER
    Element Should Contain    ${dropdown2}    Assistance technique
    Click Link    link:@{main_menu_items}[4]


AT Form    Comment    Formaulaire d'ajout assistance technique et vérif des éléments de la page
    ConnexionOk
    Click Element    ${menu_burger}
    Wait Until Element Is Visible    ${tableau}
    Click Element    ${btn_add}
    Page Should Contain Element    ${AT_section_info_xpath}
    Page Should Contain Element    ${AT_section_dates_xpath}
    Page Should Contain Element    ${AT_section_posi_xpath}
    Page Should Contain    Ajout d'une assistance technique    #vérif titre du formulaire
    Page Should Contain Textfield    ${AT_AO-num_xpath}    #vérif champs saisie numéro AO
    Page Should Contain Textfield    ${AT_AO-titre_xpath}    #vérif champs saisie Titre
    Page Should Contain Element    ${AT_radio-btn_xpath}    #vérif radio bouton type  AO

Position_AT    Comment    formulaire de saisie du positionnement AT
    AT Form
    Page Should Contain Element    ${AT_section_posi_xpath}
    ${words}=    FakerLibrary.Sentence    nb_words=3
    Input Text    ${AT_xpath_prestataire}    ${words}

    Input Text    ${AT_xpath_action}    ${words}

    Input Text    ${AT_xpath_profil}    ${words}

    Input Text    ${AT_xpath_tjm}    ${words}
DatePlus_AT
    [Arguments]    ${id_date_presentation}
	Comment    Chronologiques
    Click Element    ${reception_xpath}
    Click Element    //td[@class='today day']

    Click Element    ${reponse_xpath}
     ${date}=    FakerLibrary.Future Date    end_date=+1d    tzinfo=None

     ${drep}=    Convert Date    '${date}'    result_format=%Y-%m-%d    exclude_millis=yes

    Input Text    ${reponse_xpath}    ${drep}      #date de réponse

    Click Element    //input[@id='${id_date_presentation}']
    ${dpres}=    FakerLibrary.Date Between    start_date=+2d    end_date=+3d
    ${dshow}=    Convert Date    '${dpres}'    result_format=%Y-%m-%d    exclude_millis=yes

    Input Text    //input[@id='${id_date_presentation}']    ${dshow}  #date pésentation

    Click Element    ${demarrage_xpath}
    ${ddeb}=    FakerLibrary.Date Between    start_date=+4d    end_date=+5d
    ${dstart}=    Convert Date    '${ddeb}'    result_format=%Y-%m-%d    exclude_millis=yes
    Input Text  ${demarrage_xpath}    ${dstart}    #date début

    Click Element    ${cloture_xpath}
    ${dfin}=    FakerLibrary.Date Between    start_date=+7   end_date=+13d
    ${dEnd}=    Convert Date    '${dfin}'    result_format=%Y-%m-%d    exclude_millis=yes
    Input Text    ${cloture_xpath}    ${dEnd}    #date Fin
    Capture Page Screenshot    ${OUTPUT_DIR}/dateplus.png

Creation_Dispo
    [Arguments]    ${statut}

     Click Element    //tr[@class='border-color']//a[1]    #bouton Ajouter une disponibilité
    ${nom}=    Last Name
    ${prenom}=    First Name
    ${skills}=    Skill
    ${date_dispo}=   Get Current Date    result_format=%Y-%m-%d
    ${loge}=    City
    ${business}=    Bs
    ${Agence}=    Agence


    Input Text    ${Dispo_nom_xpath}    ${nom}
    Input Text    ${Dispo_prenom_xpath}    ${prenom}
    Input Text    ${Dispo_skills_xpath}    ${skills}
    Input Text    ${Dispo_logement_xpath}    ${loge}    #logement

    Click Element    ${Dispo_btn_select_xpath}
    Click Element    //li/a[contains(text(),'${Agence}')]      #choix de l'agence

    Click Button    ${Dispo_date_xpath}
    Input Text    ${Dispo_date_xpath}    ${date_dispo}    #remplissage date = date du jour

    Click Button    ${Dispo_btn_select_xpath}
    Click Link    //li/a[contains(text(),'${statut}')]    #passage du statut en paramètre

    Input Text    ${Dispo_affaire_xpath}    ${business}

    Element Should Be Visible    ${btn_update}    #Bouton "Valider" la création
    Element Should Be Visible    ${btn_annuler_creation_xpath}    #Bouton "Annuler"

    Click Button    ${btn_update}


AER_Form    Comment    Formulaire de saisie AER
    [Tags]    AER Form

    Hide_Nav    AER
    Click Link    ${btn_add}    #bouton ajout AER

    Page Should Contain    ${aer_form_title}
    #Informations générales
    Page Should Contain Textfield    ${aer_AO_input_xpath}
    Page Should Contain Textfield    ${aer_titre_input_xpath}

    Click Element    ${aer_radi-btn_public_xpath}    #vérif des boutons radio

    Click Element    ${aer_radio-btn_prive_xpath}

    Click Element    ${aer_AOsimple-checkbox_xpath}


    Page Should Contain Element    ${aer_client_choix_xpath}
    Page Should Contain Element    ${aer_agence_choix_xpath}
    Page Should Contain Element    ${aer_statut_choix_xpath}
    Page Should Contain Element    ${aer_responsable_choix_xpath}
    Page Should Contain Element    ${aer_descrip_text_xpath}

    #Dates
    Page Should Contain Textfield    ${aer_reception_input_xpath}
    Page Should Contain Textfield    ${aer_reponse_input_xpath}
    Page Should Contain Textfield    ${aer_soutenance_input_xpath}
    Page Should Contain Textfield    ${aer_demarrage_input_xpath}
    Page Should Contain Textfield    ${aer_cloture_input_xpath}

   #positionnement

   Page Should Contain Element    ${aer_profil_input_xpath}
   Page Should Contain Element    ${aer_montant_input_xpath}
   Page Should Contain Element    ${aer_type_input_xpath}

  #Sécurité
  ${elem}=    Get WebElements    ${aer_security_form_xpath}

  :FOR    ${i}    IN    @{elem}
      Log To Console    ${i.text}
   END

  @{list_elem}=    Extraction    ${i.text}
   Log To Console    ${list_elem}
  :FOR    ${i}    ${value}    IN ENUMERATE    @{list_elem}
      Element Should Contain    (${aer_primary_panel})[4]     ${value}

      #${rand}=    Random Int    0    26    1

      #Run Keyword If    ${i} >=5    Click Element    (//input[@type='radio'])[${rand}]
  END

  #GO/NOGO
  Page Should Contain Element    ${aer_gonogo_header_xpath}
  Page Should Contain Element    ${aer_statut_label_path}

  ${radio}=    Get WebElements    (${aer_primary-radio_xpath})[2]
  :FOR    ${i}    IN    @{radio}
      Log    ${i.text}

   END
   @{list_radio}=    Extraction    ${i.text}

   :FOR    ${index}    ${value}    IN ENUMERATE    @{list_radio}

       ${striped}=    Strip String     ${value}    both
       Run Keyword If    ${index} != 0    Click Element    //label[contains(text(),'${striped}')]
       ...    ELSE IF    ${index} == 0    Click Element    //label[contains(text(),'${striped}')]

   END

  Page Should Contain Element    ${aer_gonogo_input_xpath}
  Element Should Be Visible    ${aer_btn_cancel_xpath}
  Element Should Be Disabled    ${Submit}

RDV_Form
        ConnexionOk
    Hide_Nav    Rendez-vous
    Click Element    ${btn_add}
    Page Should Contain    ${rdv_form_title}

    Page Should Contain Element    ${rdv_IG_title_xpath}
    Page Should Contain Textfield    ${rdv_client_field_xpath}
    Page Should Contain Textfield    ${rdv_objet_field_xpath}
    Page Should Contain Textfield    ${rdv_agence_field_xpath}
    Page Should Contain Textfield    ${rdv_lieu_field_xpath}

    Page Should Contain Element    ${rdv_pdate_title_xpath}
    Page Should Contain Textfield    ${rdv_organisateur_field_xpath}
    Page Should Contain Element    ${rdv_participant_input_xpath}
    Page Should Contain Element    ${rdv_date_field_xpath}
    Page Should Contain Element    ${rdv_nextdate_input_xpath}

    Page Should Contain Element    ${rdv_CR_title_xpath}
    Page Should Contain Element    ${rdv_descrip_field_xpath}
    Page Should Contain Element    ${rdv_action_label_xpath}
    Page Should Contain Element    ${rdv_organisateur_field_xpath}


    Page Should Contain Element    ${btn_annuler_creation_xpath}
    Element Should Be Disabled    ${Submit}
