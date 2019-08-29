def get_variables(arg=None):
    common_locators = {
        # Common elements
        # =======================================================================

        'timeout': '10s',
        'Submit': "//button[@class='btn btn-raised btn-info' and @type='submit']",
        'btn_add': "css:a#button_add",
        'btn_update': "//button[@class='btn btn-raised btn-info']",

        'btn_download': "//a[@id='button_download']",
        'btn_cloud_download': "//i[@class='fa fa-cloud-download icon fa-2x']",
        'btn_download_1': "//i[@class='fa fa-download icon fa-2x']",

        'btn_upload': "//i[@class='fa fa-upload icon fa-2x']",
        'btn_upload_1': "//a[@id='button_upload']",

        'btn_edit': "//i[@class='fa fa-pencil icon fa-lg']",
        'btn_trash': "//i[@class='fa fa-trash icon fa-lg']",
        'btn_reset_filter': "//div[@class='dropdown-toggle refresh-button']",
        'btn_refresh_page': "//div[@class='dropdown-toggle refresh-button']",

        'filter_row_under_theader': "//tr[@class='hide-on-med-and-down']",
        'filter_in_column': "//input[@type='search'][1]",

        'modal_content_xpath': "//div[@id='deleteModal']",
        'modal_msg': 'Voulez-vous supprimer l\'élement?',
        'btn_annuler_suppr_xpath': "//div[@id='deleteModal']//button[@class='btn btn-raised btn-danger'][contains(text(),'Annuler')]",
        'btn_annuler_suppr_xpath_1': "//button[@class='btn btn-raised btn-danger']",
        'btn_Suppr': "//button[contains(text(),'Supprimer')]",
        'modal_xpath': "//div[@id='deleteModal']//div[@class='modal-content']",

        'close_modal': "//div[@id='deleteModal']//button[@class='close']",
        'close_icon': "//span[contains(text(),'×')]",

        'btn_annuler_creation_xpath': "//a[@class='btn btn-raised btn-danger']",
        'delete_modal': "//div[@id='deleteModal']",
        'msg_update': "//div[@class='alert alert-dismissible alert-success']",
        'fade_element': "//div[@class='modal-backdrop fade']",
    }
    return common_locators
