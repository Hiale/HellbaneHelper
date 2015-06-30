local addon = ...
local L = HellbaneHelperLocals

--[[
	Finds an index in a table that is not used
	param(arr) table / Table that needs to get empty indexes
]]
function findIndex(arr)
	local size = getSize(arr)
	for i = 0, size do
		if arr[i] == nil then
			return i
		end
	end
	return size
end
--[[
	Prints the containings of a table
	param(arr) table / Values to print
	param(str) string / Information about the values held by arr
]]
function toString(arr)
	local i = 0
	local sb = ""
	for k, v in pairs(arr) do
		i = i + 1
		sb = sb .. i .. ". " .. v .. "\n"
	end
	return sb
end

--[[
	Checking if a table contains a given value and if it does, what index is the value located at
	param(arr) table
	param(value) T - value to check exists
	return boolean or integer / returns false if the table does not contain the value otherwise it returns the index of where the value is locatedd
]]
function contains(arr, value)
	if value == nil then
		return false
	end
	for k, v in pairs(arr) do
		if v == value then
			return k
		end
	end
	return false
end
--[[
	Returns the size of a table
	param(arr) table
	returns integer / The size of the table
]]
function getSize(arr)
	local count = 0
	for k, v in pairs(arr) do
		count = count + 1
	end
	return count
end
--[[
	Sends notifications to chosen online friends that a group containing a given keyword has been created through whispers and battle net
	param(name) string / Name of the friend to notified
]]
function pmFriend(name, groupName)
	if name:find("#") and BNConnected() then
		local nameStart, nameEnd = name:find("#")
		local BNName = name:sub(0, nameEnd-1)
		local pID = GetAutoCompletePresenceID(BNName)
		local presenceID, presenceName, battleTag, isBattleTagPresence, toonName, toonID, client, isOnline, lastOnline, isAFK, isDND, messageText, noteText, isRIDFriend, broadcastTime, canSoR = BNGetFriendInfoByID(pID)
		if isOnline then
			BNSendWhisper(presenceID, L.NOTIFICATION_FRIENDS_1 .. playerName .. L.NOTIFICATION_FRIENDS_2 .. groupName)
		end
	elseif name:find(" ") and BNConnected() then
		local pID = GetAutoCompletePresenceID(name)
		if pID ~= nil then
			local presenceID, presenceName, battleTag, isBattleTagPresence, toonName, toonID, client, isOnline, lastOnline, isAFK, isDND, messageText, noteText, isRIDFriend, broadcastTime, canSoR = BNGetFriendInfoByID(pID)
			if isOnline then
				BNSendWhisper(presenceID, L.NOTIFICATION_FRIENDS_1 .. playerName .. L.NOTIFICATION_FRIENDS_2 .. groupName)
			end
		end
	else
		if UnitIsConnected(name) ~= nil then
			SendChatMessage(L.NOTIFICATION_FRIENDS_1 .. playerName .. L.NOTIFICATION_FRIENDS_2 .. groupName, "WHISPER", nil, name)
		end
	end
end
--[[
	Checks if the player is eligible to sign up for a premade group.
	returns false if person is in a group and is not a leader and true if person is not in a group or is in a group but is leader
]]
function isEligibleToSign()
	if IsInGroup() and not UnitIsGroupLeader("player") then
		DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000" .. L.WARNING_UNELIGIBLE_TEXT)
		return false
	else
		return true
	end
end
function split(keyword)
	local words = {}
	local count = 0
	for word in keyword:gmatch("%S+") do
		words[count] = word
		count = count + 1
	end
	return words
end
function isMatch(name, keywords)
	local splitName = split(name)
	local matched = false
	local skip = false
	for i, j in pairs(keywords) do
		local splitKey = split(j)
		skip = false
		if not matched then
			for a, b in pairs(splitKey) do
				if not skip then
					for c, d in pairs(splitName) do
						if d:find(b) then
							matched = true
							skip = false
							break
						end
						skip = true
						matched = false
					end
				else
					break
				end	
			end
		else
			break
		end
	end
	return matched
end
function getGroupRating(players)
end
function getGroupAchievements(players, achievement)
end