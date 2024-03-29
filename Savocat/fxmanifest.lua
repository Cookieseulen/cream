fx_version 'cerulean'
games { 'gta5' };

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
}

client_scripts {
    '@es_extended/locale.lua',
    'client/cl_boss.lua',
    'client/cl_garage.lua',
    'client/cl_menu.lua',
    'client/cl_vestiaires.lua',
    'client/cl_accueil.lua',
}

server_script {
    'server/server.lua',
}

dependencies {
	'es_extended'
}