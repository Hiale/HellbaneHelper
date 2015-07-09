--[[
	This addon is made for finding premade groups accordingly to the demand of the user.
	Author: Anton Ronsjö / Ant-Kazzak
	Version: 2.0
]]
-- SAVEDVARIABLES:
-- INTERVAL Interval between the searches
-- ENABLED Checks if addon is enabled
-- SAVEDVARIABLESPERCHARACTER
-- playerName Name of the player
local addon = ... -- The name of the addon folder
local L = HellbaneHelperLocals -- Strings
local f = CreateFrame("Frame") -- Addon Frame
local ticks = 0 -- Time elapsed since last search
local C_LFGList = C_LFGList -- The C_LFGList
local foundGroups = {} -- Groups that the player has been notified about
-- All Blizzard Premade Group categories
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

local units = {
	[39287] = { keywords = {"deathtalon"}, subzones = {} },
	[39288] = { keywords = {"terrorfist", "terror"}, subzones = {} },
	[39289] = { keywords = {"doomroller", "doom"}, subzones = {} },
	[39290] = { keywords = {"vengeance", "veng"}, subzones = {} }
}

local debug = false
local lastEventTime
local keywords = {}
local AUTO_SIGN = false
local correctZone = false
local oldRemainingUnitsCount = 0

local function PrintStatus()
	for k, v in pairs(units) do	
		local killStatus
		if IsQuestFlaggedCompleted(k) then
			killStatus = "|cFFFF0000dead"
		else
			killStatus = "|cFF00FF00alive"
		end
		DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFFFF" .. firstToUpper(v["keywords"][1]) .. ": " .. killStatus)
	end	
end

--[[
	Reads all commands with the prefix SLASH-HELLBANEHELPER and responds accordingly
	@param(msg) string / The message sent by the user
	@param(editbox)
]]
local function handler(msg, editbox)
	msg = string.lower(msg)
	if msg == "enable" then
		ENABLED = true
		DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00" .. L.WARNING_ENABLED_TEXT)
	elseif msg == "disable" then
		ENABLED = false
		DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000" .. L.WARNING_DISABLED_TEXT)
	elseif msg == "status" then
		PrintStatus()
	elseif msg == "debug" then
		debug = not debug
		DEFAULT_CHAT_FRAME:AddMessage("Debug Mode: " .. tostring(debug))
	elseif msg == "eventtime" then
		if lastEventTime == nil then lastEventTime = "(unknown)" end
		DEFAULT_CHAT_FRAME:AddMessage("Last Event Time: " .. lastEventTime)
	end
end
SlashCmdList["HELLBANEHELPER"] = handler
f:RegisterEvent("LFG_LIST_SEARCH_RESULTS_RECEIVED")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("LFG_LIST_SEARCH_RESULT_UPDATED")
f:RegisterEvent("ZONE_CHANGED_NEW_AREA")
f:RegisterEvent("ZONE_CHANGED")

local function UpdateKeywords(keywordsArray)
	for k, v in pairs(keywords) do
		keywords[k] = nil
	end	
	
	if debug then
		DEFAULT_CHAT_FRAME:AddMessage("Searching following keywords:")
	end
	for _, keyword in pairs(keywordsArray) do
		table.insert(keywords, keyword)		
		if debug then
			DEFAULT_CHAT_FRAME:AddMessage(keyword)					
		end
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
		if INTERVAL == nil then INTERVAL = 2 end
		if MAXAGE == nil then MAXAGE = 60 end
		if ENABLED == nil then ENABLED = true end
		if playerName == nil then playerName = UnitName("player") end
		if SOUND_NOTIFICATION == nil then SOUND_NOTIFICATION = true end
		if WHISPER_NOTIFICATION == nil then WHISPER_NOTIFICATION = true end
		if LATEST_CATEGORY == nil then LATEST_CATEGORY = "" end
		if ROLES == nil then
			ROLES = {}
			ROLES.TANK = false
			ROLES.HEALER = false
			ROLES.DPS = true
		end
		if L.UNITS ~= nil then
			units = mergeTables(L.UNITS, units)
		end
	elseif event == "PLAYER_LOGIN" then
		DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00" .. L.WARNING_LOGIN_TEXT)
		AUTO_SIGN = false
		GetRemainingUnits(units, true)
	elseif event == "LFG_LIST_SEARCH_RESULT_UPDATED" and ENABLED then
		local id, activityID, name, comment, voiceChat, iLvl, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted = C_LFGList.GetSearchResultInfo(unit)
		if name ~= nil then
			name = string.lower(name) -- CASE INSENSITIVE
		end
		if isDelisted and contains(foundGroups, name) ~= false then
			foundGroups[contains(foundGroups, name)] = nil
		end	
	elseif event == "LFG_LIST_SEARCH_RESULTS_RECEIVED" and ENABLED and correctZone then -- Received reults of a search in LFGList
		if debug then
			lastEventTime = date("%y-%m-%d %H:%M:%S")
		end
		local numResults, results = C_LFGList.GetSearchResults()
		for k, v in pairs(results) do
			local id, activityID, name, comment, voiceChat, iLvl, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted = C_LFGList.GetSearchResultInfo(results[k])
			if name ~= nil then
				name = string.lower(name) -- CASE INSENSITIVE
			end
			if not isDelisted and not contains(foundGroups, name) then
				if isMatch(name, keywords) and age < MAXAGE then
					foundGroups[findIndex(foundGroups)] = name
					if debug then
						DEFAULT_CHAT_FRAME:AddMessage("Age: " .. tostring(age))						
					end
					if AUTO_SIGN and isEligibleToSign() then
						DEFAULT_CHAT_FRAME:AddMessage(L.AUTO_SIGN_TEXT)
						C_LFGList.ApplyToGroup(id, "", ROLES.TANK, ROLES.HEALER, ROLES.DPS)
					end
					if SOUND_NOTIFICATION then
						PlaySound("ReadyCheck", "master")
					end
					if WHISPER_NOTIFICATION then
						DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000" .. L.NOTIFICATION_YOU .. name)
					end
				end
			end
		end
	end	
	if event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_LOGIN" then
		if GetZoneText() == L.TANAAN_JUNGLE_ZONE then
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
end)