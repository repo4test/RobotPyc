def get_variables(arg=None):
    variables = {
        # AT
        # =======================================================================
        'link_AT': "link:Assistance technique",
        'AT_page_title': "//h2[contains(text(),'Assistance Technique')]",

        'reception_xpath': "//input[@id='date_reception']",
        'reponse_xpath': "//input[@id='date_reponse']",
        'presentation_xpath': "//input[@id='date_presentation']",
        'demarrage_xpath': "//input[@id='date_demarrage']",
        'cloture_xpath': "//input[@id='date_cloture']",
        'Filtre_AT': "css:button.form-control",
        'AT_section_info_xpath': "//h3[contains(text(),'Informations générales')]",
        'AT_section_dates_xpath': "//h3[contains(text(),'Dates')]",
        'AT_section_posi_xpath': "//h3[contains(text(),'Positionnement')]",
        'AT_xpath_prestataire': "id:prestataire",
        'AT_xpath_action': "id:action-en-cours",
        'AT_xpath_profil': "id:code-profil",
        'AT_xpath_tjm': "id:tjm",
        'AT_AO-num_xpath': "css:input#numero-ao",
        'AT_AO-titre_xpath': "css:input#titre",
        'AT_radio-btn_xpath': "css:div.col-sm-5.form-group.label-static",
        'AT_btn_radio_type_xpath': "//button[@class='form-control btn btn-default btn-block dropdown-toggle']",
    }
    return variables
