def get_variables(arg=None):
    variables = {
        # RDV
        # =======================================================================
        'rdv_h2_title': "//h2[contains(text(),'Rendez-vous')]",
        'rdv_form_title': "Ajout d'un rendez-vous",
        'filter_data_to_display_rdv': "//button[contains(text(),'9 selected')]",
        'rdv_client_field_xpath': "//input[@id='client']",
        'rdv_objet_field_xpath': "//input[@id='objet']",
        'rdv_agence_field_xpath': "//input[@id='agence']",
        'rdv_lieu_field_xpath': "//input[@id='lieu']",
        'rdv_date_field_xpath': "//input[@id='date_rvs']",
        'rdv_descript_field_xpath': "//div[@id='description']//div[@class='simditor-body']",
        'rdv_organisateur_field_xpath': "//input[@id='organisateur']",

        'rdv_IG_title_xpath': "//h3[contains(text(),'Informations générales')]",
        'rdv_pdate_title_xpath': "//h3[contains(text(),'Participants / Dates')]",
        'rdv_participant_input_xpath': "//input[@id='participant']",
        'rdv_nextdate_input_xpath': "//input[@id='date_next_rvs']",
        'rdv_CR_title_xpath': "//h3[contains(text(),'CR / Action')]",
        'rdv_descrip_field_xpath': "//div[@id='description']//p",
        'rdv_action_label_xpath': "//label[contains(text(),'Action(s)')]",
    }
    return variables
