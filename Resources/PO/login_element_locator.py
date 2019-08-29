def get_variables(arg=None):
    variables = {
        # Login page Elements

        'user_id_path': "//input[@id='username']",
        'user_pwd_path': "//input[@id='password']",
        'btn_connexion': "//button[@class='btn btn-raised btn-success']",
        'login': 'aung',
        'pwd': 'Info4QA@',
        'error_msg_login': "//strong[contains(text(),'Erreur de connexion!')]",
        'Site_Url': 'http://vs-cco-rec.ouest.sesame.infotel.com:8080/cco',
        'Site_Title': 'CCO',
        'login_page_title': "css:h3.panel-title",
        'app_version': "class:version",
        'landingPage_Title': "AssistanceTechniques",
        'h2_title': "Assistance Technique",
    }
    return variables
