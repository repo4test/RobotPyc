def get_variables(arg=None):
    variables = {
        # Indicateurs
        # =======================================================================
        'kpi_aerlink_xpath': "//div[@id='dropdown-2']//a[contains(text(),'AER')]",
        'kpi_atlink_xpath': "//div[@id='dropdown-2']//a[contains(text(),'Assistance technique')]",
        'indicateur_menu_xpath': "//span[contains(text(),'Indicateurs')]",

    }
    return variables
