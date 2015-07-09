HellbaneHelperLocals = {}
local L = HellbaneHelperLocals
local addon = ...

SLASH_HELLBANEHELPER1 = "/hh"
SLASH_HELLBANEHELPER2 = "/hellbane"
SLASH_HELLBANEHELPER2 = "/hellbanehelper"

L.UNITS = {
	[39287] = { keywords = {}, subzones = {"Aktar's Post", "Ruins of Kra'nak"} }, --deathtalon
	[39288] = { keywords = {}, subzones = {"Rangari Refuge"} }, --terrorfist
	[39289] = { keywords = {}, subzones = {"Warcamp Gromdar"} }, --doomroller
	[39290] = { keywords = {}, subzones = {"Temple of Sha'naar"} } --vengeance
}

L.TANAAN_JUNGLE_ZONE = "Tanaan Jungle"

L.NOTIFICATION_YOU = "Hellbane Helper: a group has been found: "
L.AUTO_SIGN_TEXT = "Trying to join..."

L.WARNING_ENABLED_TEXT = "Hellbane Helper has been enabled!"
L.WARNING_DISABLED_TEXT = "Hellbane Helper has been disabled!"
L.WARNING_UNELIGIBLE_TEXT = "Hellbane Helper: could not sign you up since you are not the leader of the group/raid."
L.WARNING_LOGIN_TEXT = "Hellbane Helper " .. GetAddOnMetadata(addon, "Version") .. " has been loaded!"
L.WARNING_CHANGED_CATEGORY = "Hellbane Helper now searching in: "