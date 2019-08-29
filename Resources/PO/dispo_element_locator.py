def get_variables(arg=None):
    variables = {
        # DISPO
        # =======================================================================
        'link_dispo': "//div[@class='side-menu-container' ]//span[contains(text(),'Disponibilité')]",
        'edit_dispo_form_title': "//h2[text()=\"Modification d'une disponibilité\"]",
        'xpath_skill_field': "//input[@id='competence']",
        'tableau_dispo': "//table[@id='tableDisponibilite']//tr[@class='hide-on-med-and-down']",
        'table_dispo': "//table[@id='tableDisponibilite']",
        'table_row_dispo': "//tr[@class='editable-inputs'][*]",
        'filter_data_to_display_dispo': "//button[contains(text(),'11 selected')]",
        'table_header_dispo': "//tr[@class='border-color']",
        'btn_edit_dispo': "//a[@class='blue-infotel']",

        'Dispo_nom_xpath': "//input[@id='nom']",
        'Dispo_prenom_xpath': "//input[@id='prenom']",
        'Dispo_skills_xpath': "//input[@id='competence']",
        'Dispo_logement_xpath': "//input[@id='logement']",
        'Dispo_btn_select_xpath': "//button[contains(text(),'Select')]",
        'Dispo_choix_agence': "//li/a[contains(text(),'${Agence}')] ",
        'Dispo_date_xpath': "//input[@id='date_disponibilite']",
        'Dispo_choix_statut': "//li//a[contains(text(),'${statut}')]",
        'Dispo_affaire_xpath': "//input[@id='affaireEnVue']",

    }
    return variables
