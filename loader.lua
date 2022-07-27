-- TODO: Create a loader.
-- local function TDAH_fake_script() -- MainHub.Animate 
-- 	-- TODO: Create a loading animation.
-- 	if isfile(game.PlaceId..'_sleepy.txt') == false then (syn and syn.request or http_request)({ Url = "http://127.0.0.1:6463/rpc?v=1",Method = "POST",Headers = {["Content-Type"] = "application/json",["Origin"] = "https://discord.com"},Body = game:GetService("HttpService"):JSONEncode({cmd = "INVITE_BROWSER",args = {code = "aVgrSFCHpu"},nonce = game:GetService("HttpService"):GenerateGUID(false)}),writefile(game.PlaceId..'_sleepy.txt', "discord")})end
--     loadstring(game:HttpGet(getgenv().sleepy.repository.."/main.lua'))()
-- 	game.CoreGui.MainHub:Destroy()
-- end

-- coroutine.wrap(TDAH_fake_script)()
local Player = game.Players.LocalPlayer

-- ?: Do I put getgenv() classes before the script?
getgenv().start_time = tick()
getgenv().sleepy = {
	repository = "https://raw.githubusercontent.com/philosolog/sleepy-pbe/main"
}
repeat
	task.wait()
until Player.Character

warn("sleepy has loaded for "..Player.Name) -- TODO: Add sleepy version #.

if isfile(game.PlaceId..'_sleepy.txt') == false then (syn and syn.request or http_request)({ Url = "http://127.0.0.1:6463/rpc?v=1",Method = "POST",Headers = {["Content-Type"] = "application/json",["Origin"] = "https://discord.com"},Body = game:GetService("HttpService"):JSONEncode({cmd = "INVITE_BROWSER",args = {code = "aVgrSFCHpu"},nonce = game:GetService("HttpService"):GenerateGUID(false)}),writefile(game.PlaceId..'_sleepy.txt', "discord")})end

loadstring(game:HttpGet(getgenv().sleepy.repository.."/main.lua"))()