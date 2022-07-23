-- TODO: Create a loader.
-- local function TDAH_fake_script() -- MainHub.Animate 
-- 	-- TODO: Create a loading animation.
-- 	if isfile(game.PlaceId..'_sleepy.txt') == false then (syn and syn.request or http_request)({ Url = "http://127.0.0.1:6463/rpc?v=1",Method = "POST",Headers = {["Content-Type"] = "application/json",["Origin"] = "https://discord.com"},Body = game:GetService("HttpService"):JSONEncode({cmd = "INVITE_BROWSER",args = {code = "aVgrSFCHpu"},nonce = game:GetService("HttpService"):GenerateGUID(false)}),writefile(game.PlaceId..'_sleepy.txt', "discord")})end
--     loadstring(game:HttpGet('https://raw.githubusercontent.com/philosolog/sleepy-pbe/main/main.lua'))()
-- 	game.CoreGui.MainHub:Destroy()
-- end

-- coroutine.wrap(TDAH_fake_script)()
task.wait(11)

if isfile(game.PlaceId..'_sleepy.txt') == false then (syn and syn.request or http_request)({ Url = "http://127.0.0.1:6463/rpc?v=1",Method = "POST",Headers = {["Content-Type"] = "application/json",["Origin"] = "https://discord.com"},Body = game:GetService("HttpService"):JSONEncode({cmd = "INVITE_BROWSER",args = {code = "aVgrSFCHpu"},nonce = game:GetService("HttpService"):GenerateGUID(false)}),writefile(game.PlaceId..'_sleepy.txt', "discord")})end

loadstring(game:HttpGet('https://raw.githubusercontent.com/philosolog/sleepy-pbe/main/main.lua'))()