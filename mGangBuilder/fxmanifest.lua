shared_script "_sh_ac.lua"





fx_version 'cerulean'
games { 'gta5' };
author 'Matt'
lua54 'yes'

shared_scripts {
	'config.lua',
    '@es_extended/imports.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/**.lua',
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
    "client/**.lua",
}

server_scripts {
	'@es_extended/locale.lua',
    '@oxmysql/lib/MySQL.lua',
	'locales/**.lua',
    "server/**.lua",
}

escrow_ignore { 
    "config.lua", 
    "locales/**.lua" 
}



dependency '/assetpacks'



shared_script '_sh_anti_trigger.lua'