def get_variables(arg=None):
    variables = {
        # AER
        # =======================================================================
        'aer_h2_title': "//h2[text()='Activité à engagement de résultat']",
        'aer_form_title': "Ajout d'une activité à engagement de résultat",
        'filter_data_to_display_aer': "//button[contains(text(),'14 selected')]",
        'aer_AO_input_xpath': "//input[@id='numero-ao']",
        'aer_titre_input_xpath': "//input[@id='titre']",
        'aer_radi-btn_public_xpath': "//div[@class='radio radio-primary']//label[contains(text(),'Public')]",
        'aer_radio-btn_prive_xpath': "//div[@class='radio radio-primary']//label[contains(text(),'Privé')]",
        'aer_AOsimple-checkbox_xpath': "//span[@class='checkbox-material']",

        'aer_client_choix_xpath': "//label[contains(text(),'Client *')]",
        'aer_agence_choix_xpath': "//label[contains(text(),'Agence *')]",
        'aer_statut_choix_xpath': "//label[contains(text(),'Statut *')]",
        'aer_responsable_choix_xpath': "//label[contains(text(),'Responsable')]",
        'aer_descrip_text_xpath': "//textarea[@id='description']",
        'aer_contributeur_text_xpath': "//textarea[@id='contributeurs']",

        'aer_reception_input_xpath': "//input[@id='date_reception']",
        'aer_reponse_input_xpath': "//input[@id='date_reponse']",
        'aer_soutenance_input_xpath': "//input[@id='date_soutenance']",
        'aer_demarrage_input_xpath': "//input[@id='date_demarrage']",
        'aer_cloture_input_xpath': "//input[@id='date_cloture']",

        'aer_profil_input_xpath': "//input[@id='code-profil']",
        'aer_montant_input_xpath': "//input[@id='montant']",
        'aer_type_input_xpath': "//label[contains(text(),'Type AER *')]",

        'aer_security_form_xpath': "//div[@class='col-sm-12']",

        'aer_gonogo_header_xpath': "//div//h3[contains(text(),'GO / NOGO')]",
        'aer_gonogo_input_xpath': "//input[@id='date_gonogo']",
        'aer_statut_label_path': "//div[@class='col-sm-6 form-group label-static']//label[@class='control-label'][contains(text(),'Statut *')]",
        'aer_primary-radio_xpath': "//div[@class='radio radio-primary']",
        'aer_btn_cancel_xpath': "//a[@class='btn btn-raised btn-danger']",

        'aer_primary_panel': "//div[@class='panel panel-primary']",

    }
    return variables
