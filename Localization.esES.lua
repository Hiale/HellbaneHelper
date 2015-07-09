if GetLocale() ~= "esES" then return end
HellbaneHelperLocals = {}
local L = HellbaneHelperLocals
local addon = ...

SLASH_HELLBANEHELPER1 = "/hh"
SLASH_HELLBANEHELPER2 = "/hellbane"
SLASH_HELLBANEHELPER2 = "/hellbanehelper"

L.UNITS = {
	[39287] = { keywords = {"garramuerte"}, subzones = {"Aktar's Post", "Ruins of Kra'nak"} },
	[39288] = { keywords = {"horropuño"}, subzones = {"Rangari Refuge"} },
	[39289] = { keywords = {"fatalitas"}, subzones = {"Warcamp Gromdar"} },
	[39290] = { keywords = {"venganza"}, subzones = {"Temple of Sha'naar"} }
}

L.TANAAN_JUNGLE_ZONE = "Selva de Tanaan"

L.NOTIFICATION_YOU_1 = "Hellbane Helper: Ha sido encontrado un grupo con tu palabra clave: "
L.NOTIFICATION_YOU_2 = " Nombre del grupo: "

L.WARNING_ENABLED_TEXT = "Hellbane Helper: Se ha activado PGF."
L.WARNING_DISABLED_TEXT = "Hellbane Helper: Se ha desactivado PGF."
L.WARNING_UNELIGIBLE_TEXT = "Hellbane Helper: No ha sido posible inscribirte porque no eres el lider de un grupo."