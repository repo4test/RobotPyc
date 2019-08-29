def get_variables(arg=None):
    variables = {
        # Navigation elements
        # =======================================================================

        'menu_burger': "//em[@class='glyphicon glyphicon-menu-hamburger icon']",
        'nav_bar': "css:ul.nav.navbar-nav",
        'menu_burger2': "//button[@class='navbar-expand-toggle noPreventDefault']",
        'expand': "css:button.navbar-expand-toggle",
        'tableau': "//table[@class='responsive-table striped tableListe table-edit']",

        'logout': "class:log-out",
        'Recherche': "css:#search",

        'dropdown2': "id:dropdown-2"
    }
    return variables