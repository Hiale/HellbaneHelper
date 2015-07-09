if GetLocale() ~= "ptBR" then return end
HellbaneHelperLocals = {}
local L = HellbaneHelperLocals
local addon = ...

SLASH_HELLBANEHELPER1 = "/hh"
SLASH_HELLBANEHELPER2 = "/hellbane"
SLASH_HELLBANEHELPER2 = "/hellbanehelper"

L.UNITS = {
	[39287] = { keywords = {"mortísporo"}, subzones = {"Aktar's Post", "Ruins of Kra'nak"} },
	[39288] = { keywords = {"punho do terror"}, subzones = {"Rangari Refuge"} },
	[39289] = { keywords = {"rolador ruinoso"}, subzones = {"Warcamp Gromdar"} },
	[39290] = { keywords = {"vingança"}, subzones = {"Temple of Sha'naar"} }
}

L.TANAAN_JUNGLE_ZONE = "Selva de Tanaan"

L.NOTIFICATION_YOU_1 = "Hellbane Helper: foi encontrado um grupo com a tua palavra-chave: "
L.NOTIFICATION_YOU_2 = " Nome do grupo: "

L.WARNING_ENABLED_TEXT = "Hellbane Helper: foi activado!"
L.WARNING_DISABLED_TEXT = "Hellbane Helper: foi desactivado!"
L.WARNING_UNELIGIBLE_TEXT = "Hellbane Helper: não foi possivel inscrever-te já que não és o lider do grupo/raid."