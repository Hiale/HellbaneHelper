if GetLocale() ~= "deDE" then return end
HellbaneHelperLocals = {}
local L = HellbaneHelperLocals
local addon = ...

SLASH_HELLBANEHELPER1 = "/hh"
SLASH_HELLBANEHELPER2 = "/hellbane"
SLASH_HELLBANEHELPER2 = "/hellbanehelper"

L.UNITS = {
	[39287] = { keywords = {"todeskralle"}, subzones = {"Aktar's Post", "Ruins of Kra'nak"} },
	[39288] = { keywords = {"terrorfaust"}, subzones = {"Rangari Refuge"} },
	[39289] = { keywords = {"walze"}, subzones = {"Warcamp Gromdar"} },
	[39290] = { keywords = {"rache"}, subzones = {"Temple of Sha'naar"} }
}

L.TANAAN_JUNGLE_ZONE = "Tanaandschungel"

L.NOTIFICATION_YOU = "Hellbane Helper: Eine Gruppe wurde gefunden: "
L.AUTO_SIGN_TEXT = "Es wird versucht der Gruppe beizutreten."

L.WARNING_ENABLED_TEXT = "Hellbane Helper ist aktiviert!"
L.WARNING_DISABLED_TEXT = "Hellbane Helper ist deaktiviert!"
L.WARNING_UNELIGIBLE_TEXT = "Hellbane Helper kann dich nicht anmelden, da du nicht der Anführer dieser Gruppe oder Raid bist."
L.WARNING_LOGIN_TEXT = "Hellbane Helper " .. GetAddOnMetadata(addon, "Version") .. " wurde geladen!"
L.WARNING_CHANGED_CATEGORY = "Hellbane Helper sucht im: "