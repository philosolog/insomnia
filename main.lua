getgenv().sleepy = {
	time = time or tick or (os and os.time) or warn("missing time function"),
	repository = "https://raw.githubusercontent.com/philosolog/sleepy-pbe/main",
	version = "1", -- TODO: Comment a repository-based version value??
	killed = false
}

local sleepy = getgenv().sleepy
local unsupported_executor = false
local Player = game.Players.LocalPlayer

if not shared or type(shared) ~= "table" then
	unsupported_executor = true
	shared = {unsupported_executor = true}

	warn("sleepy doesn't support your executor") -- TODO: Denote the executor's name, if possible.
	
	if getgenv then
		getgenv().shared = {unsupported_executor = true}
	end
	if getfenv then -- Some really reallllly bad exploits have shared envrionments...
		getfenv().shared = {unsupported_executor = true}
	end
elseif shared.unsupported_executor then
	unsupported_executor = true
end
if not isfolder("sleepy") then 
	makefolder("sleepy")
end

shared.autoload = shared.autoload or false

repeat
	task.wait()
until Player.Character



pcall(function()
	warn("loading sleepy v"..sleepy.version, "\nscript:", script, "Debug Info;")
	print(debug.traceback())
end)
if isfile(game.PlaceId..'_sleepy.txt') == false then 
	(syn and syn.request or http_request)({
		Url = "http://127.0.0.1:6463/rpc?v=1",
		Method = "POST",
		Headers = {["Content-Type"] = "application/json", ["Origin"] = "https://discord.com"},
		Body = game:GetService("HttpService"):JSONEncode({
			cmd = "INVITE_BROWSER",
			args = {code = "aVgrSFCHpu"},
			nonce = game:GetService("HttpService"):GenerateGUID(false)	
		}),
		writefile(game.PlaceId..'_sleepy.txt', "discord")
	})
end
if game:HttpGet(sleepy.repository.."/"..game.PlaceId) then -- TODO: Keep accessible user-based presets.
    loadstring(game:HttpGet(sleepy.repository.."/games/"..game.PlaceId.."/main.lua"))()
end

-- TODO: Create dynamic links for githubusercontent references.