HellbaneHelperLocals = {}
local L = HellbaneHelperLocals
local addon = ...

SLASH_PREMADEGROUPFINDER1 = "/pgf"
SLASH_PREMADEGROUPFINDER2 = "/premadefinder"
SLASH_PREMADEGROUPFINDER3 = "/premadegroupfinder"

L.OPTIONS_TITLE = "Premade Group Finder"
L.OPTIONS_AUTHOR = "Author: " .. GetAddOnMetadata(addon, "Author") 
L.OPTIONS_VERSION = "Version: " .. GetAddOnMetadata(addon, "Version")
L.OPTIONS_FRIENDS = "Your friends"
L.OPTIONS_KEYWORDS = "Your keywords"
L.OPTIONS_ENABLED = "Enabled"
L.OPTIONS_AUTO_SIGN = "Auto sign up"
L.OPTIONS_SEARCH_LOGIN_TEXT = "Auto search on login"
L.OPTIONS_NOTIFICATIONS = "Notifications: "
L.OPTIONS_WHISPER_NOTIFICATION = "Whisper notification"
L.OPTIONS_SOUND_NOTIFICATION = "Sound notification"
L.OPTIONS_GUILD_NOTIFICATION_TEXT = "Guild notification"
L.OPTIONS_INTERVAL = "Refresh rate (in seconds):"
L.OPTIONS_BUTTON_TEXT = "Add/Remove"

L.NOTIFICATION_YOU = "PGF: a group has been found: "
L.NOTIFICATION_FRIENDS_1 = "PGF: a premade group that "
L.NOTIFICATION_FRIENDS_2 = " is tracking has been found. Please make your friend confirm that he or she has seen this message. Group name: "
L.NOTIFICATION_GUILD = "PGF: found a group named: "

L.WARNING_ENABLED_TEXT = "PGF: has been enabled!"
L.WARNING_DISABLED_TEXT = "PGF: has been disabled!"
L.WARNING_UNELIGIBLE_TEXT = "PGF: could not sign you up since you are not the leader of the group/raid."
L.WARNING_SEARCH_LOGIN_TEXT = "PGF: has started searching for premade groups matching your keywords in the last category you used."
L.WARNING_LOGIN_TEXT = "Premade Group Finder " .. GetAddOnMetadata(addon, "Version") .. " has been loaded!"
L.WARNING_CHANGED_CATEGORY = "PGF: now searching in: "