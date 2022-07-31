-- TODO: Add compatibility for shitploits.

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
	game = {
		autoload = false
	},
}

local sleepy = getgenv().sleepy

sleepy.game.autoload = sleepy.temporary.autoload or false
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

sleepy.loaded = true
sleepy.current_time = time()

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
-- TODO: Create dynamic links for githubusercontent references.