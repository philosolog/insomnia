if not isfolder("sleepy") then makefolder("sleepy") end

local sleepyapi = loadstring(game:HttpGet(getgenv().sleepy.repository.."/API/sleepyapi.lua"))()
local library = sleepyapi.returncode(getgenv().sleepy.repository.."/API/bracketv3.lua")
local bssapi = sleepyapi.returncode(getgenv().sleepy.repository.."/games/Bee-Swarm-Simulator/bssapi.lua")
local RetrievePlayerStats = game:GetService("ReplicatedStorage").Events.RetrievePlayerStats
local statsTable = RetrievePlayerStats:InvokeServer()
local specialchar = (utf8 and utf8.char and utf8.char(9492)) or "\226\148\148"
function rtsg() tab = game.ReplicatedStorage.Events.RetrievePlayerStats:InvokeServer() return tab end
function maskequip(mask) local ohString1 = "Equip" local ohTable2 = { ["Mute"] = false, ["Type"] = mask, ["Category"] = "Accessory"} game:GetService("ReplicatedStorage").Events.ItemPackageEvent:InvokeServer(ohString1, ohTable2) end

for i,v in next, temptable.blacklist do if v == sleepyapi.nickname then game.Players.LocalPlayer:Kick("") end end -- TODO: Add a blacklist-kick message.

for i,v in next, game:GetService("Workspace").MonsterSpawners:GetDescendants() do if v.Name == "TimerAttachment" then v.Name = "Attachment" end end
for i,v in next, game:GetService("Workspace").MonsterSpawners:GetChildren() do if v.Name == "RoseBush" then v.Name = "ScorpionBush" elseif v.Name == "RoseBush2" then v.Name = "ScorpionBush2" end end
for i,v in next, game:GetService("Workspace").FlowerZones:GetChildren() do if v:FindFirstChild("ColorGroup") then if v:FindFirstChild("ColorGroup").Value == "Red" then table.insert(temptable.redfields, v.Name) elseif v:FindFirstChild("ColorGroup").Value == "Blue" then table.insert(temptable.bluefields, v.Name) end else table.insert(temptable.whitefields, v.Name) end end
local flowertable = {}
for _,z in next, game:GetService("Workspace").Flowers:GetChildren() do table.insert(flowertable, z.Position) end
local masktable = {}
for _,v in next, game:GetService("ReplicatedStorage").Accessories:GetChildren() do if string.match(v.Name, "Mask") then table.insert(masktable, v.Name) end end
local collectorstable = {}
for _,v in next, getupvalues(require(game:GetService("ReplicatedStorage").Collectors).Exists) do for e,r in next, v do table.insert(collectorstable, e) end end
local fieldstable = {}
for _,v in next, game:GetService("Workspace").FlowerZones:GetChildren() do table.insert(fieldstable, v.Name) end
local toystable = {}
for _,v in next, game:GetService("Workspace").Toys:GetChildren() do table.insert(toystable, v.Name) end
local spawnerstable = {}
for _,v in next, game:GetService("Workspace").MonsterSpawners:GetChildren() do table.insert(spawnerstable, v.Name) end
local accesoriestable = {}
for _,v in next, game:GetService("ReplicatedStorage").Accessories:GetChildren() do if v.Name ~= "UpdateMeter" then table.insert(accesoriestable, v.Name) end end
for i,v in pairs(getupvalues(require(game:GetService("ReplicatedStorage").PlanterTypes).GetTypes)) do for e,z in pairs(v) do table.insert(temptable.allplanters, e) end end

table.sort(fieldstable)
table.sort(accesoriestable)
table.sort(toystable)
table.sort(spawnerstable)
table.sort(masktable)
table.sort(temptable.allplanters)
table.sort(collectorstable)

getgenv().Player = {}

local defaultsleepy = getgenv().Player

function statsget() local StatCache = require(game.ReplicatedStorage.ClientStatCache) local stats = StatCache:Get() return stats end

-- *: sleepy
local Config = { WindowName = "🌙 sleepy | v"..temptable.version, Color = Color3.fromRGB(255, 184, 65), Keybind = Enum.KeyCode.KeypadOne}
local Window = library:CreateWindow(Config, game:GetService("CoreGui"))

-- *: home
local hometab = Window:CreateTab("home")
local information = hometab:CreateSection("info")
local descriptionLabel = information:CreateLabel("by philosolog and defin")
local elapsedtime = information:CreateLabel("⌛: 0") -- TODO: Create labels for the last elapsed time between hive conversions.
local gainedhoneylabel = information:CreateLabel("🍯: 0")
local uisection = hometab:CreateSection("ui")
local gui_killer = uisection:CreateButton("kill gui ⚠️", function()
	-- getgenv().Player = nil
	game:GetService("CoreGui"):FindFirstChild(getgenv().windowname).Enabled = false -- TODO: Use ":Destroy()";  -- Check paths if GUI object becomes nil.
end) -- TODO: Add keybind compatibility.
local rejoiner = uisection:CreateButton("rejoin game", function() loadstring(game:HttpGet(getgenv().sleepy.repository.."/utilities/rejoiner.lua"))()end) -- TODO: Add keybind compatibility.
local uitoggle = uisection:CreateToggle("visibility", nil, function(State) Window:Toggle(State) end) uitoggle:CreateKeybind(tostring(Config.Keybind):gsub("Enum.KeyCode.", ""), function(Key) Config.Keybind = Enum.KeyCode[Key] end) uitoggle:SetState(true)
local homeWindow_configSection = hometab:CreateSection("config")

information:CreateLabel("⚠️ = experimental")
information:CreateButton("discord server", function() setclipboard("https://discord.gg/aVgrSFCHpu") end)
-- TODO: Add auto-loading of configs.
homeWindow_configSection:CreateTextBox("name", 'ex: autofarmconfig', false, function(Value) temptable.configname = Value end)
homeWindow_configSection:CreateButton("load", function() getgenv().Player = game:service'HttpService':JSONDecode(readfile("sleepy/BSS_"..temptable.configname..".json")) end)
homeWindow_configSection:CreateButton("save", function() writefile("sleepy/BSS_"..temptable.configname..".json",game:service'HttpService':JSONEncode(getgenv().Player)) end)
homeWindow_configSection:CreateButton("reset", function() getgenv().Player = defaultsleepy end)

-- *: collect
local collectTab = Window:CreateTab("collect")
local collectTab_farmSection = collectTab:CreateSection("farm")
local fielddropdown = collectTab_farmSection:CreateDropdown("field", fieldstable, function(String) getgenv().Player.vars.field = String end) fielddropdown:SetOption(fieldstable[8])
local autocollectTab_otherSectionToggle = collectTab_farmSection:CreateToggle("autofarm", nil, function(State) getgenv().Player.toggles.autofarm = State end) autocollectTab_otherSectionToggle:CreateKeybind("KeypadTwo", function(Key) end) -- TODO: Make "Best," "Rotate," and "Quests" field options.
local collectTab_convertSection = collectTab:CreateSection("convert")
local collectTab_itemsSection = collectTab:CreateSection("items")
local collectTab_puffshroomsSection = collectTab:CreateSection("puffshrooms")
local collectTab_plantersSection = collectTab:CreateSection("planters")
local collectTab_sproutsSection = collectTab:CreateSection("sprouts")
local collectTab_boostersSection = collectTab:CreateSection("boosters")
local collectTab_dispensersSection = collectTab:CreateSection("dispensers")
local collectTab_otherSection = collectTab:CreateSection("other")

collectTab_farmSection:CreateToggle("quests", nil, function(State) getgenv().Player.toggles.autodoquest = State end) -- TODO: Fix this feature. Add compatibility to other non-field quests. (kill mobs, use items). Maybe put this feature in autofarm settings?
collectTab_farmSection:CreateToggle("dig", nil, function(State) getgenv().Player.toggles.autodig = State end)
collectTab_farmSection:CreateToggle("sprinkler", nil, function(State) getgenv().Player.toggles.autosprinkler = State end)
collectTab_farmSection:CreateToggle("don't collect tokens",nil, function(State) getgenv().Player.toggles.donotcollectTab_otherSectionokens = State end) -- TODO: Make this customizable.
collectTab_farmSection:CreateToggle("rare tokens ⚠️", nil, function(State) getgenv().Player.toggles.farmrares = State end) -- TODO: Add settings to TP or walk to rares. Also, create a user-input list for types of tokens to collect and how.
collectTab_farmSection:CreateToggle("bubbles", nil, function(State) getgenv().Player.toggles.farmbubbles = State end)
collectTab_farmSection:CreateToggle("flames", nil, function(State) getgenv().Player.toggles.farmflame = State end)
collectTab_farmSection:CreateToggle("precise targets", nil, function(State) getgenv().Player.toggles.collectcrosshairs = State end)
collectTab_farmSection:CreateToggle("fuzzy bombs", nil, function(State) getgenv().Player.toggles.farmfuzzy = State end)
collectTab_farmSection:CreateToggle("balloons", nil, function(State) getgenv().Player.toggles.farmunderballoons = State end)
collectTab_farmSection:CreateToggle("clouds", nil, function(State) getgenv().Player.toggles.farmclouds = State end)
collectTab_farmSection:CreateToggle("leaves", nil, function(State) getgenv().Player.toggles.farmclosestleaf = State end) -- TODO: Create a setting for distances. (close, far leaves)
collectTab_convertSection:CreateToggle("active ⚠️", nil, function(State) end) -- TODO
collectTab_convertSection:CreateSlider("% until convert", 0, 100, 100, false, function(Value) getgenv().Player.vars.convertat = Value end)
collectTab_convertSection:CreateToggle("use ant passes ⚠️", nil, function(State) end) -- TODO
collectTab_convertSection:CreateToggle("use tickets ⚠️", nil, function(State) end) -- TODO
collectTab_convertSection:CreateToggle("hive balloon",nil, function(State) getgenv().Player.toggles.convertballoons = State end) -- TODO: Check if it is possible to accelerate balloon growth when autofarming. (in sync with SSA)
collectTab_itemsSection:CreateToggle("tickets ⚠️", nil, function(State) getgenv().Player.toggles.freeantpass = State end)
collectTab_itemsSection:CreateToggle("wealth clock", nil, function(State) getgenv().Player.toggles.clock = State end)
collectTab_itemsSection:CreateToggle("ant passes", nil, function(State) getgenv().Player.toggles.freeantpass = State end)
collectTab_puffshroomsSection:CreateToggle("farm", nil, function(State) getgenv().Player.toggles.farmpuffshrooms = State end) -- TODO: Create better puffshroom autofarm AI.
collectTab_plantersSection:CreateToggle("replant", nil, function(State) getgenv().Player.toggles.autoplanters = State end):AddToolTip("replants planters at 100%") -- TODO: Account for planter rotation.
collectTab_sproutsSection:CreateToggle("farm", nil, function(State) getgenv().Player.toggles.farmsprouts = State end)
collectTab_boostersSection:CreateToggle("active", nil, function(State) getgenv().Player.toggles.autoboosters = State end) -- TODO: Add keybinding.
collectTab_boostersSection:CreateToggle("Mountain Top Booster", nil,  function(State) getgenv().Player.dispensesettings.white = not getgenv().Player.dispensesettings.white end)
collectTab_boostersSection:CreateToggle("Blue Field Booster", nil,  function(State) getgenv().Player.dispensesettings.blue = not getgenv().Player.dispensesettings.blue end)
collectTab_boostersSection:CreateToggle("Red Field Booster", nil,  function(State) getgenv().Player.dispensesettings.red = not getgenv().Player.dispensesettings.red end)
collectTab_dispensersSection:CreateToggle("active", nil, function(State) getgenv().Player.toggles.autodispense = State end) -- TODO: Allow list-adding of dispensers and keybinding.
collectTab_dispensersSection:CreateToggle("Royal Jelly Dispenser", nil, function(State) getgenv().Player.dispensesettings.rj = not getgenv().Player.dispensesettings.rj end)
collectTab_dispensersSection:CreateToggle("Blueberry Dispenser", nil,  function(State) getgenv().Player.dispensesettings.blub = not getgenv().Player.dispensesettings.blub end)
collectTab_dispensersSection:CreateToggle("Strawberry Dispenser", nil,  function(State) getgenv().Player.dispensesettings.straw = not getgenv().Player.dispensesettings.straw end)
collectTab_dispensersSection:CreateToggle("Treat Dispenser", nil,  function(State) getgenv().Player.dispensesettings.treat = not getgenv().Player.dispensesettings.treat end)
collectTab_dispensersSection:CreateToggle("Coconut Dispenser", nil,  function(State) getgenv().Player.dispensesettings.coconut = not getgenv().Player.dispensesettings.coconut end)
collectTab_dispensersSection:CreateToggle("Glue Dispenser", nil,  function(State) getgenv().Player.dispensesettings.glue = not getgenv().Player.dispensesettings.glue end)
collectTab_otherSection:CreateToggle("coconuts/meteors", nil, function(State) getgenv().Player.toggles.farmcoco = State end) -- TODO: Create a separate toggle for meteors.
collectTab_otherSection:CreateToggle("honeystorm", nil, function(State) getgenv().Player.toggles.honeystorm = State end)
--collectTab_otherSection:CreateToggle("Auto Gingerbread Bears", nil, function(State) getgenv().Player.toggles.collectgingerbreads = State end)
--collectTab_otherSection:CreateToggle("Auto Samovar", nil, function(State) getgenv().Player.toggles.autosamovar = State end)
--collectTab_otherSection:CreateToggle("Auto Stockings", nil, function(State) getgenv().Player.toggles.autostockings = State end)
--collectTab_otherSection:CreateToggle("Auto Honey Candles", nil, function(State) getgenv().Player.toggles.autocandles = State end)
--collectTab_otherSection:CreateToggle("Auto Beesmas Feast", nil, function(State) getgenv().Player.toggles.autofeast = State end)
--collectTab_otherSection:CreateToggle("Auto Onett's Lid Art", nil, function(State) getgenv().Player.toggles.autoonettart = State end)
--collectTab_otherSection:CreateToggle("snowflakes ⚠️", nil, function(State) getgenv().Player.toggles.farmsnowflakes = State end)

-- * battle
local combtab = Window:CreateTab("battle")
local mobkill = combtab:CreateSection("bosses") -- TODO: Add boss rotation autofarming capabilities.
local amks = combtab:CreateSection("mobs")

mobkill:CreateToggle("Coconut Crab", nil, function(State) if State then sleepyapi.humanoidrootpart().CFrame = CFrame.new(-307.52117919922, 107.91863250732, 467.86791992188) end end)
mobkill:CreateToggle("Stump Snail", nil, function(State) fd = game.Workspace.FlowerZones['Stump Field'] if State then sleepyapi.humanoidrootpart().CFrame = CFrame.new(fd.Position.X, fd.Position.Y-6, fd.Position.Z) else sleepyapi.humanoidrootpart().CFrame = CFrame.new(fd.Position.X, fd.Position.Y+2, fd.Position.Z) end end)
mobkill:CreateToggle("Mondo Chick", nil, function(State) getgenv().Player.toggles.killmondo = State end)
mobkill:CreateToggle("Rogue Vicious Bee", nil, function(State) getgenv().Player.toggles.killvicious = State end)
mobkill:CreateToggle("Wild Windy Bee", nil, function(State) getgenv().Player.toggles.killwindy = State end)
-- TODO: mobkill:CreateToggle("Auto Ant", nil, function(State) getgenv().Player.toggles.autoant = State end):AddToolTip("You Need Spark Stuff 😋; Goes to Ant Challenge after pollen converting")
-- TODO: Add a Commando Chick autofarm.
amks:CreateToggle("battle points", nil, function(State) getgenv().Player.toggles.autokillmobs = State end):AddToolTip("farms after x conversions")
amks:CreateTextBox('farm after x conversions', 'default = 3', true, function(Value) getgenv().Player.vars.monstertimer = tonumber(Value) end)
amks:CreateToggle("avoid mobs", nil, function(State) getgenv().Player.toggles.avoidmobs = State end)

-- *: items
local itemsTab = Window:CreateTab("items")
local itemsTab_inventorySection = itemsTab:CreateSection("TODO: inventory")
local itemsTab_inventorySection = itemsTab:CreateSection("TODO: blend/shop")
local itemsTab_characterSection = itemsTab:CreateSection("character")

itemsTab_characterSection:CreateDropdown("accessories", accesoriestable, function(Option) local ohString1 = "Equip" local ohTable2 = { ["Mute"] = false, ["Type"] = Option, ["Category"] = "Accessory" } game:GetService("ReplicatedStorage").Events.ItemPackageEvent:InvokeServer(ohString1, ohTable2) end)
itemsTab_characterSection:CreateDropdown("masks", masktable, function(Option) local ohString1 = "Equip" local ohTable2 = { ["Mute"] = false, ["Type"] = Option, ["Category"] = "Accessory" } game:GetService("ReplicatedStorage").Events.ItemPackageEvent:InvokeServer(ohString1, ohTable2) end)
itemsTab_characterSection:CreateDropdown("collectors", collectorstable, function(Option) local ohString1 = "Equip" local ohTable2 = { ["Mute"] = false, ["Type"] = Option, ["Category"] = "Collector" } game:GetService("ReplicatedStorage").Events.ItemPackageEvent:InvokeServer(ohString1, ohTable2) end)
itemsTab_characterSection:CreateDropdown("amulet generator", {"Supreme Star Amulet", "Diamond Star Amulet", "Gold Star Amulet","Silver Star Amulet","Bronze Star Amulet","Moon Amulet"}, function(Option) local A_1 = Option.." Generator" local Event = game:GetService("ReplicatedStorage").Events.ToyEvent Event:FireServer(A_1) end) -- TODO: Create a tooltip that warns the user that this WILL cost materials.

-- *: tp
local wayptab = Window:CreateTab("tp")
local wayp = wayptab:CreateSection("locations")

wayp:CreateButton("hive", function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.SpawnPos.Value end)
wayp:CreateDropdown("fields", fieldstable, function(Option) game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").FlowerZones:FindFirstChild(Option).CFrame end)
wayp:CreateDropdown("monsters", spawnerstable, function(Option) d = game:GetService("Workspace").MonsterSpawners:FindFirstChild(Option) game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(d.Position.X, d.Position.Y+3, d.Position.Z) end)
wayp:CreateDropdown("toys", toystable, function(Option) d = game:GetService("Workspace").Toys:FindFirstChild(Option).Platform game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(d.Position.X, d.Position.Y+3, d.Position.Z) end) -- ?: What are toys?

-- *: misc
local misctab = Window:CreateTab("misc")
local miscc = misctab:CreateSection("character")
local misco = misctab:CreateSection("other")

miscc:CreateButton("Ant Challenge semi-godmode ⚠️", function() sleepyapi.tween(0, CFrame.new(93.4228, 32.3983, 553.128)) task.wait(1) game.ReplicatedStorage.Events.ToyEvent:FireServer("Ant Challenge") game.Players.LocalPlayer.Character.HumanoidRootPart.Position = Vector3.new(93.4228, 42.3983, 553.128) task.wait(2) game.Players.LocalPlayer.Character.Humanoid.Name = 1 local l = game.Players.LocalPlayer.Character["1"]:Clone() l.Parent = game.Players.LocalPlayer.Character l.Name = "Humanoid" task.wait() game.Players.LocalPlayer.Character["1"]:Destroy() sleepyapi.tween(0, CFrame.new(93.4228, 32.3983, 553.128)) task.wait(8) sleepyapi.tween(0, CFrame.new(93.4228, 32.3983, 553.128)) end)
-- TODO: For GSs, add a preset value in the textbox. (find BSS default values)
miscc:CreateTextBox("glider speed", "", true, function(Value) local StatCache = require(game.ReplicatedStorage.ClientStatCache) local stats = StatCache:Get() stats.EquippedParachute = "Glider" local module = require(game:GetService("ReplicatedStorage").Parachutes) local st = module.GetStat local glidersTable = getupvalues(st) glidersTable[1]["Glider"].Speed = Value setupvalue(st, st[1]'Glider', glidersTable) end)
miscc:CreateTextBox("glider slope", "", true, function(Value) local StatCache = require(game.ReplicatedStorage.ClientStatCache) local stats = StatCache:Get() stats.EquippedParachute = "Glider" local module = require(game:GetService("ReplicatedStorage").Parachutes) local st = module.GetStat local glidersTable = getupvalues(st) glidersTable[1]["Glider"].Float = Value setupvalue(st, st[1]'Glider', glidersTable) end)
-- TODO: Make WS and JP keybindable.
miscc:CreateToggle("loop walkspeed", nil, function(State) getgenv().Player.toggles.loopspeed = State end)
miscc:CreateSlider("walkspeed", 0, 120, 70, false, function(Value) getgenv().Player.vars.walkspeed = Value end)
miscc:CreateToggle("loop jumppower", nil, function(State) getgenv().Player.toggles.loopjump = State end)
miscc:CreateSlider("jumppower", 0, 120, 70, false, function(Value) getgenv().Player.vars.jumppower = Value end)
miscc:CreateToggle("float", nil, function(State) temptable.float = State end)
miscc:CreateToggle("godmode", nil, function(State) getgenv().Player.toggles.godmode = State if State then bssapi:Godmode(true) else bssapi:Godmode(false) end end)
miscc:CreateToggle("skip dialogue", nil, function(State) getgenv().Player.toggles.autoquest = State end) -- TODO: Also enable it on auto-quests. 
misco:CreateButton("export stats", function() local StatCache = require(game.ReplicatedStorage.ClientStatCache)writefile("Stats_"..sleepyapi.nickname..".json", StatCache:Encode()) end)
misco:CreateButton("collect treasures ⚠️", function() end)
misco:CreateButton("fullbright", function() loadstring(game:HttpGet(getgenv().sleepy.repository.."/utilities/fullbright.lua"))()end)
misco:CreateButton("boost fps", function() loadstring(game:HttpGet(getgenv().sleepy.repository.."/utilities/fps-booster.lua"))()end) -- TODO: Display tooltip on effects with synx built-in fpsunlocker. Also display what the feature may do to the game. Create settings for toggling specific objects.

game.Workspace.Particles.ChildAdded:Connect(function(v)
    if not temptable.started.vicious and not temptable.started.ant then
        if v.Name == "WarningDisk" and not temptable.started.vicious and getgenv().Player.toggles.autofarm and not temptable.started.ant and getgenv().Player.toggles.farmcoco and (v.Position-sleepyapi.humanoidrootpart().Position).magnitude < temptable.magnitude and not temptable.converting then
            table.insert(temptable.coconuts, v)
            getcoco(v)
            gettoken()
        elseif v.Name == "Crosshair" and v ~= nil and v.BrickColor ~= BrickColor.new("Forest green") and not temptable.started.ant and v.BrickColor ~= BrickColor.new("Flint") and (v.Position-sleepyapi.humanoidrootpart().Position).magnitude < temptable.magnitude and getgenv().Player.toggles.autofarm and getgenv().Player.toggles.collectcrosshairs and not temptable.converting then
            if #temptable.crosshairs <= 3 then
                table.insert(temptable.crosshairs, v)
                getcrosshairs(v)
                gettoken()
            end
        end
    end
end)

local vu = game:GetService("VirtualUser") -- TODO: Move this anti-afk into a module.

game:GetService("Players").LocalPlayer.Idled:connect(function() 
	vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)task.wait(1)vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

hives = game.Workspace.Honeycombs:GetChildren() for i = #hives, 1, -1 do  v = game.Workspace.Honeycombs:GetChildren()[i] if v.Owner.Value == nil then game.ReplicatedStorage.Events.ClaimHive:FireServer(v.HiveID.Value) end end

if getgenv().autoload then if isfile("sleepy/BSS_"..getgenv().autoload..".json") then getgenv().Player = game:service'HttpService':JSONDecode(readfile("sleepy/BSS_"..getgenv().autoload..".json")) end end
