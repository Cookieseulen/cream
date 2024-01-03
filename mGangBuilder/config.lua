Config = {
	Legacy_1_9 = false,
	Locale = 'fr', -- fr / en

	AnimationLeverLesMains = "missminuteman_1ig_2",
	AnimationMains = "handsup_enter",

	openBuildermenu = { -- Permission pour ouvrir le menu principal (Builder) / Permission to open main menu
		{
			rankname = 'admin',
		},
		{
			rankname = 'superadmin',
		},
	},
	openGestionmenu = { -- Permission pour ouvrir le menu de gestion des gangs / Permission to open gang management menu
		{
			rankname = 'admin',
		},
		{
			rankname = 'superadmin',
		},
	},

	Marker = { -- Marker pour les points des gangs / Marker Type
		Type = 1,
		LargeurProfondeurHauteur = vector3(2.0, 2.0, 0.45), -- X, Y, Z
		AjustementHauteur = 0, -- Height Adjustment
		Opacity = 170,
		Saute = false, -- Jump
		CameraSuivie = false, -- Followed Camera
		Rotation = false, 
	},

	ArmeEnItem = false, -- TRUE si vous utilisez  esx_weaponsync / TRUE if you use  esx_weaponsync

	MenuGang = { -- Option du menu gang / F7
 		menuGang = true, -- TRUE si vous voulez le menu gang intégré / TRUE if you want the gang menu
		Crochetage = true, -- Lock picking
		Fouille = true, -- Search
		Ligoter = true, -- tie up
	},

	MenuBoss = { -- Argent du gang dans le menu du boss / Gang money in the boss menu
		Argent = true,
	},
	MenuCoffre = { -- Argent du gang dans le coffre / Gang money in the chest menu
		Argent = false,
	},

	Command = {
		BuilderGang = "gangbuilder",  -- Commande pour ouvrir le builder / Command to open the builder
		GestionGang = "gestiongang",  -- Commande pour ouvrir la gestion des gangs / Command to manage the gang
	},

	WebHooksDiscord = {
		-- Chest Item Webhooks
		coffreitem = true,
		coffreitemLink = "https://discord.com/api/webhooks/1144465930676617307/l6os9ccoj4reRoI1yvKY-KbsQ8nW-EFjtJrEY-dSHKDPB_abJBHQilKLC_busoCqbtZi",
		-- Chest Gun Webhooks
		coffrearme = true,
		coffrearmeLink = "https://discord.com/api/webhooks/1144466079100448929/1vHhBXpF91sHVGyrbVzY97wBSieGcca115JZflDOy70ef5WxJOeiJSWjsga4nESGnsze",
		-- Money Webhooks
		boss = true,
		bossLink = "https://discord.com/api/webhooks/1144466166887231538/X9jfpy_OwibS_0bXpyM3h8FU2mrTl9OLCOErd2lcJDgB44w7sIoHa9tknphOyAfy0HHv",
		-- Create Gang Webhooks
		creagang = false,
		creagangLink = "webhooks_link",
		-- Delete Gang Webhooks
		supprgang = false,
		supprgangLink = "webhooks_link"
		

	}
}