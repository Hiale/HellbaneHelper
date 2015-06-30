local addon = ...
local L = PGFinderLocals

options = CreateFrame("Frame", addon .. "OptionFrame", InterefaceOPtionsFramePanelContainer)
options.name = "Premade Group Finder"
options:Hide()
	local title = options:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(L.OPTIONS_TITLE)
	
	local author = options:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	author:SetPoint("TOPLEFT", 450, -20)
	author:SetText(L.OPTIONS_AUTHOR)
	
	local version = options:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	version:SetPoint("TOPLEFT", author, "BOTTOMLEFT", 0, -10)
	version:SetText(L.OPTIONS_VERSION)
	
	local enabledButton = CreateFrame("CheckButton", "EnabledCheckButton", options, "OptionsCheckButtonTemplate")
	enabledButton:SetSize(26, 26)
	enabledButton:SetPoint("TOPLEFT", 450, -130)
	enabledButton:HookScript("OnClick", function(frame)
		if frame:GetChecked() then
			ENABLED = true
			PlaySound("igMainMenuOptionCheckBoxOn")
			DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00" .. L.WARNING_ENABLED_TEXT)
		else
			ENABLED = false
			PlaySound("igMainMenuOptionCheckBoxOff")
			DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000" .. L.WARNING_DISABLED_TEXT)
		end
	end)
	
	local enabledText = options:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	enabledText:SetPoint("TOPLEFT", enabledButton, "TOPLEFT", 30, -7)
	enabledText:SetText(L.OPTIONS_ENABLED)
	
	local auto_signButton = CreateFrame("CheckButton", "Auto_SignCheckButton", options, "OptionsCheckButtonTemplate")
	auto_signButton:SetSize(26, 26)
	auto_signButton:SetPoint("TOPLEFT", 450, -160)
	auto_signButton:HookScript("OnClick", function(frame)
		if frame:GetChecked() then
			AUTO_SIGN = true
			if not SOUND_NOTIFICATION and not WHISPER_NOTIFICATION and not GUILD_NOTIFICATION and not ENABLED then
				ENABLED = true
				enabledButton:SetChecked(ENABLED)
				DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00" .. L.WARNING_ENABLED_TEXT)
			end
			PlaySound("igMainMenuOptionCheckBoxOn")
		else
			AUTO_SIGN = false
			if not SOUND_NOTIFICATION and not WHISPER_NOTIFICATION and not GUILD_NOTIFICATION and ENABLED then
				ENABLED = false
				enabledButton:SetChecked(ENABLED)
				DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000" .. L.WARNING_DISABLED_TEXT)
			end
			PlaySound("igMainMenuOptionCheckBoxOff")
		end
	end)
	
	local auto_signText = options:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	auto_signText:SetPoint("TOPLEFT", auto_signButton, "TOPLEFT", 30, -7)
	auto_signText:SetText(L.OPTIONS_AUTO_SIGN)
	
	local search_loginButton = CreateFrame("CheckButton", "search_loginCheckButton", options, "OptionsCheckButtonTemplate")
	search_loginButton:SetSize(26, 26)
	search_loginButton:SetPoint("TOPLEFT", 450, -190)
	search_loginButton:HookScript("OnClick", function(frame)
		if frame:GetChecked() then
			SEARCH_LOGIN = true
			PlaySound("igMainMenuOptionCheckBoxOn")
		else
			SEARCH_LOGIN = false
			PlaySound("igMainMenuOptionCheckBoxOff")
		end
	end)
	
	local search_loginText = options:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	search_loginText:SetPoint("TOPLEFT", search_loginButton, "TOPLEFT", 30, -7)
	search_loginText:SetText(L.OPTIONS_SEARCH_LOGIN_TEXT)
	
	local notificationText = options:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	notificationText:SetPoint("TOPLEFT", 450, -220)
	notificationText:SetText(L.OPTIONS_NOTIFICATIONS)
	
	local whisperButton = CreateFrame("CheckButton", "WhisperCheckButton", options, "OptionsCheckButtonTemplate")
	whisperButton:SetSize(26, 26)
	whisperButton:SetPoint("TOPLEFT", 450, -235)
	whisperButton:HookScript("OnClick", function(frame)
		if frame:GetChecked() then
			WHISPER_NOTIFICATION = true
			if not AUTO_SIGN and not SOUND_NOTIFICATION and not GUILD_NOTIFICATION and not ENABLED then
				ENABLED = true
				enabledButton:SetChecked(ENABLED)
				DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00" .. L.WARNING_ENABLED_TEXT)
			end
			PlaySound("igMainMenuOptionCheckBoxOn")
		else
			WHISPER_NOTIFICATION = false
			if not SOUND_NOTIFICATION and not AUTO_SIGN and not GUILD_NOTIFICATION and ENABLED then
				ENABLED = false
				enabledButton:SetChecked(ENABLED)
				DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000" .. L.WARNING_DISABLED_TEXT)
			end
			PlaySound("igMainMenuOptionCheckBoxOff")
		end
	end)
	
	local whisperText = options:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	whisperText:SetPoint("TOPLEFT", whisperButton, "TOPLEFT", 30, -7)
	whisperText:SetText(L.OPTIONS_WHISPER_NOTIFICATION)
	
	local soundButton = CreateFrame("CheckButton", "SoundCheckButton", options, "OptionsCheckButtonTemplate")
	soundButton:SetSize(26, 26)
	soundButton:SetPoint("TOPLEFT", 450, -265)
	soundButton:HookScript("OnClick", function(frame)
		if frame:GetChecked() then
			SOUND_NOTIFICATION = true
			if not AUTO_SIGN and not WHISPER_NOTIFICATION and not GUILD_NOTIFICATION and not ENABLED then
				ENABLED = true
				enabledButton:SetChecked(ENABLED)
				DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00" .. L.WARNING_ENABLED_TEXT)
			end
			PlaySound("igMainMenuOptionCheckBoxOn")
		else
			SOUND_NOTIFICATION = false
			if not AUTO_SIGN and not WHISPER_NOTIFICATION and not GUILD_NOTIFICATION and ENABLED then
				ENABLED = false
				enabledButton:SetChecked(ENABLED)
				DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000" .. L.WARNING_DISABLED_TEXT)
			end
			PlaySound("igMainMenuOptionCheckBoxOff")
		end
	end)
	
	local soundText = options:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	soundText:SetPoint("TOPLEFT", soundButton, "TOPLEFT", 30, -7)
	soundText:SetText(L.OPTIONS_SOUND_NOTIFICATION)
	
	local guildButton = CreateFrame("CheckButton", "guildCheckButton", options, "OptionsCheckButtonTemplate")
	guildButton:SetSize(26, 26)
	guildButton:SetPoint("TOPLEFT", 450, -295)
	guildButton:HookScript("OnClick", function(frame)
		if frame:GetChecked() then
			GUILD_NOTIFICATION = true
			if not AUTO_SIGN and not WHISPER_NOTIFICATION and not SOUND_NOTIFICATION and not ENABLED then
				ENABLED = true
				enabledButton:SetChecked(ENABLED)
				DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00" .. L.WARNING_ENABLED_TEXT)
				PlaySound("igMainMenuOptionCheckBoxOn")
			end
		else
			GUILD_NOTIFICATION = false
			if not AUTO_SIGN and not WHISPER_NOTIFICATION and not SOUND_NOTIFICATION and ENABLED then
				ENABLED = false
				enabledButton:SetChecked(ENABLED)
				DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000" .. L.WARNING_DISABLED_TEXT)
			end
			PlaySound("igMainMenuOptionCheckBoxOff")
		end
	end)
	
	guildText = options:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	guildText:SetPoint("TOPLEFT", guildButton, "TOPLEFT", 30, -7)
	guildText:SetText(L.OPTIONS_GUILD_NOTIFICATION_TEXT)
	
	local intervalText = options:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	intervalText:SetPoint("TOPLEFT", 450, -330)
	intervalText:SetText(L.OPTIONS_INTERVAL)
	
	local intervalEdit = CreateFrame("EditBox", "IntervalEditBox", options, "InputBoxTemplate")
	intervalEdit:SetPoint("TOPLEFT", intervalText, "TOPLEFT", 5, -15)
	intervalEdit:SetAutoFocus(false)
	intervalEdit:EnableMouse(true)
	intervalEdit:SetSize(50, 20)
	intervalEdit:SetMaxLetters(4)
	intervalEdit:SetScript("OnEscapePressed", function(frame)
		frame:ClearFocus()
	end)
	intervalEdit:SetScript("OnEnterPressed", function(frame)
		local value = frame:GetNumber()
		if value > 0 then
			INTERVAL = value
		end
		frame:ClearFocus()
	end)
	
	local keywordText = options:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	keywordText:SetPoint("TOPLEFT", 50, -100)
	keywordText:SetText(L.OPTIONS_KEYWORDS)
	
	local keywordList = CreateFrame("EditBox", "KeywordEditBoxListFrame", options)
	keywordList:SetAutoFocus(false)
	keywordList:SetMultiLine(true)
	keywordList:EnableMouse(false)
	keywordList:SetFontObject(GameFontNormal)
	keywordList:SetMaxLetters(999999)
	keywordList:SetHeight(250)
	keywordList:SetWidth(165)
	keywordList:SetJustifyV("TOP")
	keywordList:SetJustifyH("LEFT")
	keywordList:Show()
	
	local keywordScroll = CreateFrame("ScrollFrame", "KeywordScrollFrame", options, "UIPanelScrollFrameTemplate")
	keywordScroll:SetSize(165, 280)
	keywordScroll:SetPoint("TOPLEFT", keywordText, "TOPLEFT", -20, -30)
	keywordScroll:SetScrollChild(keywordList)
	
	local keywordListBackdrop = CreateFrame("Frame", "KeywordListBackdrop", options)
	keywordListBackdrop:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = {left = 3, right = 3, top = 3, bottom = 3}
	})
	keywordListBackdrop:SetBackdropColor(0, 0, 0, 1)
	keywordListBackdrop:SetSize(180, 300)
	keywordListBackdrop:SetPoint("TOPLEFT", keywordText, "TOPLEFT", -30, -20)
	
	local keywordEdit = CreateFrame("EditBox", "KeywordEditBox", options, "InputBoxTemplate")
	keywordEdit:SetPoint("TOPLEFT", keywordText, "BOTTOMLEFT", -15, -320)
	keywordEdit:SetAutoFocus(false)
	keywordEdit:SetSize(150, 20)
	keywordEdit:SetText("")
	keywordEdit:SetScript("OnEscapePressed", function (frame)
		frame:SetText("")
		frame:ClearFocus()
	end)
	keywordEdit:SetScript("OnEnterPressed", function(frame)
		KeywordButton:Click()
	end)
	
	local keywordButton = CreateFrame("Button", "KeywordButton", options, "UIPanelButtonTemplate")
	keywordButton:SetSize(155, 20)
	keywordButton:SetPoint("TOPLEFT", keywordEdit, "TOPLEFT", -5, -25)
	keywordButton:SetText(L.OPTIONS_BUTTON_TEXT)
	keywordButton:HookScript("OnClick", function(frame)
		if keywordEdit:GetText() ~= nil then
			local keyword = string.lower(keywordEdit:GetText())
			local exists = contains(keywords, keyword)
			if keyword ~= nil and keyword ~= "" and not exists then
				updateList(keywords, keyword, true)
				keywordList:SetText(toString(keywords))
			elseif keyword ~= nil and keyword ~= "" and exists then
				updateList(keywords, keyword, false)
				keywordList:SetText(toString(keywords))
			end
			keywordEdit:SetText("")
		end
	end)
	
	local friendText = options:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	friendText:SetPoint("TOPLEFT", 290, -100)
	friendText:SetText(L.OPTIONS_FRIENDS)
	
	local friendList = CreateFrame("EditBox", "FriendEditBoxListFrame", options)
	friendList:SetAutoFocus(false)
	friendList:SetMultiLine(true)
	friendList:EnableMouse(false)
	friendList:SetFontObject(GameFontNormal)
	friendList:SetMaxLetters(999999)
	friendList:SetHeight(250)
	friendList:SetWidth(165)
	friendList:SetJustifyV("TOP")
	friendList:SetJustifyH("LEFT")
	friendList:Show()
	
	local friendScroll = CreateFrame("ScrollFrame", "FriendScrollFrame", options, "UIPanelScrollFrameTemplate")
	friendScroll:SetSize(165, 280)
	friendScroll:SetPoint("TOPLEFT", friendText, "TOPLEFT", -35, -30)
	friendScroll:SetScrollChild(friendList)
	
	local friendListBackdrop = CreateFrame("Frame", "FriendListBackdrop", options)
	friendListBackdrop:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = {left = 3, right = 3, top = 5, bottom = 3}
	})
	friendListBackdrop:SetBackdropColor(0, 0, 0, 1)
	friendListBackdrop:SetSize(180, 300)
	friendListBackdrop:SetPoint("TOPLEFT", friendText, "TOPLEFT", -45, -20)
	
	local friendEdit = CreateFrame("EditBox", "FriendEditBox", options, "InputBoxTemplate")
	friendEdit:SetPoint("TOPLEFT", friendText, "BOTTOMLEFT", -25, -320)
	friendEdit:SetAutoFocus(false)
	friendEdit:SetSize(150, 20)
	friendEdit:SetText("")
	friendEdit:SetScript("OnEscapePressed", function (frame)
		frame:SetText("")
		frame:ClearFocus()
	end)
	friendEdit:SetScript("OnEnterPressed", function(frame)
		FriendButton:Click()
	end)
	
	local friendButton = CreateFrame("Button", "FriendButton", options, "UIPanelButtonTemplate")
	friendButton:SetSize(155, 20)
	friendButton:SetPoint("TOPLEFT", friendEdit, "TOPLEFT", -5, -25)
	friendButton:SetText(L.OPTIONS_BUTTON_TEXT)
	friendButton:HookScript("OnClick", function(frame)
		if friendEdit:GetText() ~= nil then
			local friend = string.lower(friendEdit:GetText())
			local exists = contains(friends, friend)
			if friend ~= nil and friend ~= "" and not exists then
				updateList(friends, friend, true)
				friendList:SetText(toString(friends))
			elseif friend ~= nil and friend ~= "" and exists then
				updateList(friends, friend, false)
				friendList:SetText(toString(friends))
			end
			friendEdit:SetText("")
		end
	end)
	options:SetScript("OnShow", function(options)
		intervalEdit:SetText(INTERVAL)
		soundButton:SetChecked(SOUND_NOTIFICATION)
		enabledButton:SetChecked(ENABLED)
		auto_signButton:SetChecked(AUTO_SIGN)
		whisperButton:SetChecked(WHISPER_NOTIFICATION)
		search_loginButton:SetChecked(SEARCH_LOGIN)
		guildButton:SetChecked(GUILD_NOTIFICATION)
		keywordList:SetText(toString(keywords))
		friendList:SetText(toString(friends))
	end)
function updateList(arr, value, add)
	local exists = contains(arr, value)
	if value ~= nil and add ~= nil then
		if add and not exists then
			arr[findIndex(arr)] = value
		elseif not add and exists then
			arr[exists] = nil
		end
	end
end

InterfaceOptions_AddCategory(options)
