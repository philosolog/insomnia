-- TODO: Add compatibility for shitploits.
-- TODO: Maybe look into not using getgenv() because it doesn't share variables across differently executed (not loadstring) scripts? -- Possibly use shared, _G, etc..?

local HttpService = game:GetService("HttpService")

getgenv().sleepy = {
	time = time or tick or (os and os.time) or warn("missing time function"),
	repository = "https://raw.githubusercontent.com/philosolog/sleepy-pbe/main",
	version = "1", -- TODO: Comment a repository-based version value?
	sleepyapi = nil,
	bracketv3 = nil,
	loaded = false,
	gameFolder = nil,
	killed = false,
	current_time = nil,
	sleepygame = {
		autoload = false,
		windowName = HttpService:GenerateGUID(false), -- TODO: Make compatibility for multiple GUI names.
	},
}

local sleepy = getgenv().sleepy

sleepy.sleepygame.autoload = getgenv().autoload -- TODO: Make compatible with shitploits that don't have "shared". Also, nest "autoload" into a sleepy table.
sleepy.sleepyapi = loadstring(game:HttpGet(sleepy.repository.."/API/sleepyapi.lua"))()
sleepy.bracketv3 = loadstring(game:HttpGet(sleepy.repository.."/API/bracketv3.lua"))()

local sleepyapi = sleepy.sleepyapi
local Player = game.Players.LocalPlayer

if not isfolder("sleepy") then 
	makefolder("sleepy")
end
if sleepy.loaded == true then -- TODO: Reload the GUI through editing getgenv() variables.
	return sleepyapi.notify("sleepy", "already loaded")
end

sleepyapi.utilities("anti-afk")

repeat -- !: Don't edit this... -- It doesn't load otherwise.. :\
	task.wait()
until Player.Character

if game:HttpGet(tostring(sleepy.repository.."/games/"..game.PlaceId.."/main.lua")) then
	sleepy.gameFolder = sleepy.repository.."/games/"..game.PlaceId

    if not isfolder("sleepy/"..game.PlaceId.."/configurations") then  -- TODO: Keep accessible user-based presets.
		makefolder("sleepy/"..game.PlaceId.."/configurations")
	end

	loadstring(game:HttpGet(sleepy.repository.."/games/"..game.PlaceId.."/main.lua"))()
end
if isfile("sleepy/discord.txt") == false then 
	sleepyapi.request({
		Url = "http://127.0.0.1:6463/rpc?v=1",
		Method = "POST",
		Headers = {["Content-Type"] = "application/json", ["Origin"] = "https://discord.com"},
		Body = game:GetService("HttpService"):JSONEncode({
			cmd = "INVITE_BROWSER",
			args = {code = "aVgrSFCHpu"},
			nonce = game:GetService("HttpService"):GenerateGUID(false)	
		}),
		writefile("sleepy/discord.txt", "https://discord.com/aVgrSFCHpu")
	})
end

sleepy.loaded = true
sleepy.current_time = time()

sleepyapi.notify("sleepy", "load success")
-- TODO: Create dynamic links for githubusercontent references.