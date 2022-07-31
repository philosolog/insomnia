local HttpService = game:GetService("HttpService")
local sleepy = getgenv().sleepy
local sleepyapi = sleepy.sleepyapi
local bracketv3 = sleepy.bracketv3
local gameFolder = sleepy.gameFolder
local sleepygame = sleepy.sleepygame
local utilities = sleepyapi.utilities
local temporary = {
	configurationName = nil,
}
local default_configuration = {

}

sleepygame = {
	version = "1",
	bssapi = loadstring(gameFolder.."/bssapi.lua"),
	configuration = nil,
}

local configuration = sleepygame.configuration

if sleepy.autoload == false then
	configuration = default_configuration
else
	if typeof(sleepy.autoload) == "string" then
		if isfile("sleepy/"..game.PlaceId.."/"..temporary.configurationName..".json") then
			configuration = HttpService:JSONDecode(readfile("sleepy/"..game.PlaceId.."/"..temporary.configurationName..".json"))
		else
			sleepyapi.notify("load configuration", temporary.configurationName.." does not exist")
		end
	else
		sleepyapi.notify("autoload", "invalid autoload string")
	end
end

-- *: sleepy
local windowConfiguration = {
	WindowName = "🌙 sleepy | v"..sleepygame.version,
	Color = Color3.fromRGB(255, 184, 65),
	Keybind = Enum.KeyCode.F1,
}
local window = bracketv3:CreateWindow(windowConfiguration, game:GetService("CoreGui"))

-- *: home
local homeTab = window:CreateTab("home")
local homeTab_infoTab = homeTab:CreateSection("info")
local homeTab_infoTab_creditsLabel = homeTab_infoTab:CreateLabel("by philosolog and definedM")
local homeTab_infoTab_timeLabel = homeTab_infoTab:CreateLabel("⌛: 0") -- TODO: Create labels for the last elapsed time between hive conversions.
local homeTab_infoTab_honeyLabel = homeTab_infoTab:CreateLabel("🍯: 0")
local homeTab_uiSection = homeTab:CreateSection("ui")
local homeTab_uiSection_killguiButton = homeTab_uiSection:CreateButton("kill gui ⚠️", function()
	sleepy.killed = true
	game:GetService("CoreGui"):FindFirstChild(sleepy.sleepygame.windowName):Destroy() -- TODO: Use ":Destroy()";  -- Check paths if GUI object becomes nil.
end) -- TODO: Add keybind compatibility.
local homeTab_uiSection_rejoingameButton = homeTab_uiSection:CreateButton("rejoin game", function()
	utilities("rejoingame")
end) -- TODO: Add keybind compatibility.
local homeTab_uiSection_toggleuiToggle = homeTab_uiSection:CreateToggle("toggle ui", nil, function(state)
	window:Toggle(state)
end)
local homeWindow_configSection = homeTab:CreateSection("config")

homeTab_infoTab:CreateLabel("⚠️ = experimental")
homeTab_infoTab:CreateButton("discord server", function() setclipboard("https://discord.gg/aVgrSFCHpu") end)
homeTab_uiSection_toggleuiToggle:CreateKeybind(tostring(windowConfiguration.Keybind):gsub("Enum.KeyCode.", ""), function(Key)
	windowConfiguration.Keybind = Enum.KeyCode[Key]
end)
homeTab_uiSection_toggleuiToggle:SetState(true)
-- TODO: Add auto-loading of configs.
homeWindow_configSection:CreateTextBox("name", 'ex: sleepyautofarm', false, function(value)
	temporary.configurationName = value
end)
homeWindow_configSection:CreateButton("load", function()
	if isfile("sleepy/"..game.PlaceId.."/"..temporary.configurationName..".json") then
		configuration = HttpService:JSONDecode(readfile("sleepy/"..game.PlaceId.."/"..temporary.configurationName..".json"))
	else
		sleepyapi.notify("load configuration", temporary.configurationName.." does not exist")
	end
end)
homeWindow_configSection:CreateButton("save", function()
	if temporary.configurationName and temporary.configurationName ~= "" then -- TODO: Check if writefile is possible. (check for invalid characters)
		writefile("sleepy/"..game.PlaceId.."/"..temporary.configurationName..".json", HttpService:JSONEncode(configuration))
	else
		sleepyapi.notify("save configuration", "invalid name")
	end
end)
homeWindow_configSection:CreateButton("reset", function()
	configuration = default_configuration
end)

-- *: collect
local collectTab = window:CreateTab("collect")
local collectTab_farmSection = collectTab:CreateSection("farm")
-- local collectTab_farmSection_fieldDropdown = collectTab_farmSection:CreateDropdown("field", fieldTable, function(string)
	-- SELECTEDFIELD = string
-- end)
local collectTab_farmSectionToggle = collectTab_farmSection:CreateToggle("autofarm", nil, function(state)
	-- AUTOFARM = state
end)
local collectTab_convertSection = collectTab:CreateSection("convert")

-- collectTab_farmSection_fieldDropdown:SetOption(fieldTable[8])
collectTab_farmSectionToggle:CreateKeybind("F2", function(key)
	-- ?: What would "key" be?
end) -- TODO: Make "Best," "Rotate," and "Quests" field options.
collectTab_farmSection:CreateToggle("quests", nil, function(state)
	-- AUTOQUEST = state
end) -- TODO: Fix this feature. Add compatibility to other non-field quests. (kill mobs, use items). Maybe put this feature in autofarm settings?
collectTab_farmSection:CreateToggle("dig", nil, function(state)
	-- AUTODIG = state
end)
collectTab_farmSection:CreateToggle("sprinkler", nil, function(state)
	-- AUTOSPRINKLER = state
end)
collectTab_convertSection:CreateToggle("active ⚠️", nil, function(state)
	-- CONVERT = state
end) -- TODO
collectTab_convertSection:CreateSlider("% until convert", 0, 100, 100, false, function(value)
	-- CONVERTAT = value
end)
collectTab_convertSection:CreateToggle("use ant passes ⚠️", nil, function(state)
	-- USEANTPASSES = state
end) -- TODO
collectTab_convertSection:CreateToggle("use tickets ⚠️", nil, function(state)
	-- USETICKETS = state
end) -- TODO
collectTab_convertSection:CreateToggle("hive balloon",nil, function(state)
	-- CONVERTBALLOONS = state
end) -- TODO: Check if it is possible to accelerate balloon growth when autofarming. (in sync with SSA)