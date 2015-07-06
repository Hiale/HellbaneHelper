if GetLocale() ~= "frFR" then return end
HellbaneHelperLocals = {}
local L = HellbaneHelperLocals
local addon = ...

L.UNITS = {
	[39287] = { keywords = {"serres-mort"}, subzones = {"Aktar's Post", "Ruins of Kra'nak"} },
	[39288] = { keywords = {"poing-de-terreur"}, subzones = {"Rangari Refuge"} },
	[39289] = { keywords = {"compresseur funeste"}, subzones = {"Warcamp Gromdar"} },
	[39290] = { keywords = {"vengeance"}, subzones = {"Temple of Sha'naar"} }
}

L.TANAAN_JUNGLE_ZONE = "Jungle de Tanaan"

L.NOTIFICATION_YOU_1 = "PGF : Un groupe correspondant � votre mot-clef a �t� trouv�"
L.NOTIFICATION_YOU_2 = "Nom du groupe: "

L.WARNING_ENABLED_TEXT = "PGF : a �t� activ�!"
L.WARNING_DISABLED_TEXT = "PGF : a �t� d�sactiv�!"
L.WARNING_UNELIGIBLE_TEXT = "Impossible de vous inscrire car vous n��tes pas le chef du groupe/raid"