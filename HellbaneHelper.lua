--[[
	This addon is made for finding premade groups accordingly to the demand of the user.
	Author: Anton Ronsjö / Ant-Kazzak
	Version: 2.0
]]
-- SAVEDVARIABLES:
-- keywords Storing all keywords
-- friends Storing all friends
-- INTERVAL Interval between the searches
-- ENABLED Checks if addon is enabled
-- SAVEDVARIABLESPERCHARACTER
-- playerName Name of the player
local addon = ... -- The name of the addon folder
local L = HellbaneHelperLocals -- Strings
local f = CreateFrame("Frame") -- Addon Frame
local ticks = 0 -- Time elapsed since last search
local C_LFGList = C_LFGList -- The C_LFGList
local foundGroups = {} -- Groups that the player and its friends has been notified about
local categories = {
	"Questing", 
	"Dungeons", 
	"Raids", 
	"Arenas", 
	nil, 
	"Custom", 
	"Arena Skirmishes", 
	"Battlegrounds", 
	"Rated Battlegrounds", 
	"Ashran"
}

-- Hiale
local units = {
	[39288] = { keywords = {"terrorfist"}, subzones = {"Rangari Refuge"} },
	[39287] = { keywords = {"deathtalon"}, subzones = {"Aktar's Post", "Ruins of Kra'nak"} },
	[39290] = { keywords = {"vengeance", "veng"}, subzones = {"Temple of Sha'naar"} },
	[39289] = { keywords = {"doomroller"}, subzones = {"Warcamp Gromdar"} }
}

local keywords = {}
local correctZone = false
local oldRemainingUnitsCount = 0
local oldTargetUnitsCount = 0
-- Hiale

--[[
	Reads all commands with the prefix SLASH-PREMADEGROUPFINDER and responds accordingly
	@param(msg) string / The message sent by the user
	@param(editbox)
]]
local function handler(msg, editbox)
	InterfaceOptionsFrame_OpenToCategory(options)
end
--SlashCmdList["PREMADEGROUPFINDER"] = handler
f:RegisterEvent("LFG_LIST_SEARCH_RESULTS_RECEIVED")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("LFG_LIST_SEARCH_RESULT_UPDATED")
-- Hiale
f:RegisterEvent("ZONE_CHANGED_NEW_AREA")
f:RegisterEvent("ZONE_CHANGED")
-- Hiale

-- Hiale
local function UpdateKeywords(keywordsArray)
	for k, v in pairs(keywords) do
		keywords[k] = nil
	end	
	
	--DEFAULT_CHAT_FRAME:AddMessage("Searching following keywords:")
	for _, keyword in pairs(keywordsArray) do
		table.insert(keywords, keyword)			
		--DEFAULT_CHAT_FRAME:AddMessage(keyword)			
	end
end

local function PrintStatus()
	for k, v in pairs(units) do	
		local killStatus
		if IsQuestFlaggedCompleted(k) then
			killStatus = "|cFFFF0000dead"
		else
			killStatus = "|cFF00FF00alive"
		end
		DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFFFF" .. v["keywords"][1] .. ": " .. killStatus)
	end	
end

local function GetRemainingUnits(targetUnits, updateKeywords)
	local remainingUnitsCount = 0	
	local aggregatedKeywords = {}
	for k, v in pairs(targetUnits) do
		if not IsQuestFlaggedCompleted(k) then
			if updateKeywords then
				for _, keyword in pairs(v["keywords"]) do
					table.insert(aggregatedKeywords, keyword)				
				end
			end
		end
	end
	
	for k, v in pairs(units) do
		if not IsQuestFlaggedCompleted(k) then
			remainingUnitsCount = remainingUnitsCount + 1
		end
	end
	
	if updateKeywords then
		UpdateKeywords(aggregatedKeywords)
	end
	
	if remainingUnitsCount ~= oldRemainingUnitsCount then
		if correctZone then
			PrintStatus()
		end
		oldRemainingUnitsCount = remainingUnitsCount
	end
	return remainingUnitsCount
end
-- Hiale

--[[
	Refreshes the LFGList after a given interval
]]
f:SetScript("OnUpdate", function(self, elapsed)
	if ENABLED then
		ticks = ticks + elapsed
		if ticks >= INTERVAL then		
			if correctZone then
				if GetRemainingUnits(units, false) > 0 and not LFGListFrame:IsVisible() then
					if LFGListFrame.SearchPanel.categoryID ~= nil then
						C_LFGList.Search(LFGListFrame.SearchPanel.categoryID, "")
						if LATEST_CATEGORY == nil or LATEST_CATEGORY == "" or LATEST_CATEGORY ~= LFGListFrame.SearchPanel.categoryID then
							LATEST_CATEGORY = LFGListFrame.SearchPanel.categoryID
							DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00" .. L.WARNING_CHANGED_CATEGORY .. categories[LATEST_CATEGORY])
						end
					end
				end
			end
			ticks = 0
		end
	end
end)
--[[
	Tracks LFG_LIST_SEARCH_RESULTS_RECIEVED, ADDON_LOADED and LFG_LIST_SEARCH_RESULT_UPDATED events
	Case LFG_LIST_SEARCH_RESULTS_RECIEVED: Searches through the results in LFGList for group names that matches any of the keywords and then notifying the player about its findings
	CASE ADDON_LOADED: Initiates saved variables and gets current online BN friends
	CASE LFG_LIST_SEARCH_RESULT_UPDATED: Removes the group from found groups if delisted
	CASE PLAYER_LOGIN: Starts searching for groups if search_loginButton is checked
]]
f:SetScript("OnEvent", function(self, event, ...)
	local unit = ...
	if event == "ADDON_LOADED" and unit == "HellbaneHelper" then
		if INTERVAL == nil then INTERVAL = 30 end
		if friends == nil then friends = {} end
		if keywords == nil then keywords = {} end
		if ENABLED == nil then ENABLED = true end
		if playerName == nil then playerName = UnitName("player") end
		if SOUND_NOTIFICATION == nil then SOUND_NOTIFICATION = true end
		if AUTO_SIGN == nil then AUTO_SIGN = true end
		if WHISPER_NOTIFICATION == nil then WHISPER_NOTIFICATION = true end
		if SEARCH_LOGIN == nil then SEARCH_LOGIN = true end
		if GUILD_NOTIFICATION == nil then GUILD_NOTIFICATION = true end
		if LATEST_CATEGORY == nil then LATEST_CATEGORY = "" end
		-- Hiale
		INTERVAL = 2
		GUILD_NOTIFICATION = false
		SEARCH_LOGIN = false
		-- Hiale
	elseif event == "PLAYER_LOGIN" then
		DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00" .. L.WARNING_LOGIN_TEXT)
		if not IsInGuild() and GUILD_NOTIFICATION then
			GUILD_NOTIFICATION = false
		end
		if SEARCH_LOGIN and ENABLED and LATEST_CATEGORY ~= "" and LATEST_CATEGORY ~= nil then
			DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00" .. L.WARNING_SEARCH_LOGIN_TEXT)
			C_LFGList.Search(LATEST_CATEGORY, "")
		end
		-- Hiale
		AUTO_SIGN = false
		GetRemainingUnits(units, true)
		-- Hiale
	elseif event == "LFG_LIST_SEARCH_RESULT_UPDATED" and ENABLED then
		local id, activityID, name, comment, voiceChat, iLvl, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted = C_LFGList.GetSearchResultInfo(unit)
		if name ~= nil then
			name = string.lower(name) -- CASE INSENSITIVE
		end
		if isDelisted and contains(foundGroups, name) ~= false then
			foundGroups[contains(foundGroups, name)] = nil
		end	
	elseif event == "LFG_LIST_SEARCH_RESULTS_RECEIVED" and ENABLED then -- Received reults of a search in LFGList
		local numResults, results = C_LFGList.GetSearchResults()
		for k, v in pairs(results) do
			local id, activityID, name, comment, voiceChat, iLvl, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted = C_LFGList.GetSearchResultInfo(results[k])
			if name ~= nil then
				name = string.lower(name) -- CASE INSENSITIVE
			end
			if not isDelisted and not contains(foundGroups, name) then
				if isMatch(name, keywords) then
					foundGroups[findIndex(foundGroups)] = name
					if AUTO_SIGN and isEligibleToSign() then
						DEFAULT_CHAT_FRAME:AddMessage("Trying to join...")
						C_LFGList.ApplyToGroup(id, "", false, false, true) -- SIGN UP AS DPS
					end
					if SOUND_NOTIFICATION then
						PlaySound("ReadyCheck", "master")
					end
					if GUILD_NOTIFICATION and IsInGuild() then
						SendChatMessage(L.NOTIFICATION_GUILD .. name, "GUILD", nil, nil)
					end
					if WHISPER_NOTIFICATION then
						DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000" .. L.NOTIFICATION_YOU .. name)
						for a, b in pairs(friends) do
							pmFriend(friends[a], name)
						end
					end
				end
			end
		end
	end	
	-- Hiale
	if event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_LOGIN" then
		if GetZoneText() == "Tanaan Jungle" then --ToDo: localize!
			correctZone = true
		else
			correctZone = false
		end
	end
	if event == "ZONE_CHANGED" then
		local subZoneText = GetSubZoneText()
		if subZoneText == "" then
			AUTO_SIGN = false
			GetRemainingUnits(units, true)
		else
			for k, v in pairs(units) do
				for _, subzone in pairs(v["subzones"]) do
					if subZoneText == subzone then
						AUTO_SIGN = true
						local targetUnits = {	[k] = { keywords = v["keywords"], subzones = v["subzones"] } }
						GetRemainingUnits(targetUnits, true)
					end
				end			
			end
		end
	end
	-- Hiale
end)