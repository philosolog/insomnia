-- TODO: Simplify ":GetService()" calls.
local sleepyapi = loadstring(game:HttpGet("https://raw.githubusercontent.com/philosolog/sleepy-pbe/main/API/sleepyapi.lua"))()
local library = sleepyapi.returncode("https://raw.githubusercontent.com/philosolog/sleepy-pbe/main/API/bracketv3.lua")
local bssapi = sleepyapi.returncode("https://raw.githubusercontent.com/philosolog/sleepy-pbe/main/games/Bee-Swarm-Simulator/bssapi.lua")

if not isfolder("sleepy") then makefolder("sleepy") end

local GuiService = game:GetService("GuiService")
local playerstatsevent = game:GetService("ReplicatedStorage").Events.RetrievePlayerStats
local statstable = playerstatsevent:InvokeServer()
local monsterspawners = game:GetService("Workspace").MonsterSpawners
local rarename
function rtsg() tab = game.ReplicatedStorage.Events.RetrievePlayerStats:InvokeServer() return tab end
function maskequip(mask) local ohString1 = "Equip" local ohTable2 = { ["Mute"] = false, ["Type"] = mask, ["Category"] = "Accessory"} game:GetService("ReplicatedStorage").Events.ItemPackageEvent:InvokeServer(ohString1, ohTable2) end
local lasttouched = nil
local done = true
local hi = false
local temptable = {
    version = "1",
    blackfield = "Ant Field",
    redfields = {},
    bluefields = {},
    whitefields = {},
    shouldiconvertballoonnow = false,
    balloondetected = false,
    puffshroomdetected = false,
    magnitude = 70,
    blacklist = {},
    running = false,
    configname = "",
    tokenpath = game:GetService("Workspace").Collectibles,
    started = {
        vicious = false,
        mondo = false,
        windy = false,
        ant = false,
        monsters = false
    },
    detected = {
        vicious = false,
        windy = false
    },
    tokensfarm = false,
    converting = false,
    honeystart = 0,
    grib = nil,
    gribpos = CFrame.new(0,0,0),
    honeycurrent = statstable.Totals.Honey,
    dead = false,
    float = false,
    pepsigodmode = false,
    pepsiautodig = false,
    alpha = false,
    beta = false,
    myhiveis = false,
    invis = false,
    windy = nil,
    sprouts = {
        detected = false,
        coords
    },
    cache = {
        autofarm = false,
        killmondo = false,
        vicious = false,
        windy = false
    },
    allplanters = {},
    planters = {
        planter = {},
        cframe = {},
        activeplanters = {
            type = {},
            id = {}
        }
    },
    monstertypes = {"Ladybug", "Rhino", "Spider", "Scorpion", "Mantis", "Werewolf"},
    ["stopapypa"] = function(path, part)
        local Closest
        for i,v in next, path:GetChildren() do
            if v.Name ~= "PlanterBulb" then
                if Closest == nil then
                    Closest = v.Soil
                else
                    if (part.Position - v.Soil.Position).magnitude < (Closest.Position - part.Position).magnitude then
                        Closest = v.Soil
                    end
                end
            end
        end
        return Closest
    end,
    coconuts = {},
    crosshairs = {},
    crosshair = false,
    coconut = false,
    act = 0,
    ['touchedfunction'] = function(v)
        if lasttouched ~= v then
            if v.Parent.Name == "FlowerZones" then
                if v:FindFirstChild("ColorGroup") then
                    if tostring(v.ColorGroup.Value) == "Red" then
                        maskequip("Demon Mask")
                    elseif tostring(v.ColorGroup.Value) == "Blue" then
                        maskequip("Diamond Mask")
                    end
                else
                    maskequip("Gummy Mask")
                end
                lasttouched = v
            end
        end
    end,
    runningfor = 0,
    oldtool = rtsg()["EquippedCollector"],
    ['gacf'] = function(part, st)
        coordd = CFrame.new(part.Position.X, part.Position.Y+st, part.Position.Z)
        return coordd
    end
}
local planterst = {
    plantername = {},
    planterid = {}
}

for i,v in next, temptable.blacklist do if v == sleepyapi.nickname then game.Players.LocalPlayer:Kick("") end end -- TODO: Add a blacklist-kick message.
if temptable.honeystart == 0 then temptable.honeystart = statstable.Totals.Honey end

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

local floatpad = Instance.new("Part", game:GetService("Workspace"))
floatpad.CanCollide = false
floatpad.Anchored = true
floatpad.Transparency = 1
floatpad.Name = "FloatPad"

local cocopad = Instance.new("Part", game:GetService("Workspace"))
cocopad.Name = "Coconut Part"
cocopad.Anchored = true
cocopad.Transparency = 1
cocopad.Size = Vector3.new(10, 1, 10)
cocopad.Position = Vector3.new(-307.52117919922, 105.91863250732, 467.86791992188)

local antpart = Instance.new("Part", workspace)
antpart.Name = "Ant Autofarm Part"
antpart.Position = Vector3.new(96, 47, 553)
antpart.Anchored = true
antpart.Size = Vector3.new(128, 1, 50)
antpart.Transparency = 1
antpart.CanCollide = false

getgenv().sleepy = {
    rares = {},
    priority = {},
    bestfields = {
        red = "Pepper Patch",
        white = "Coconut Field",
        blue = "Stump Field"
    },
    blacklistedfields = {},
    killersleepy = {},
    toggles = {
        autofarm = false,
        farmclosestleaf = false,
        farmbubbles = false,
        autodig = false,
        farmrares = false,
        rgbui = false,
        farmflower = false,
        farmfuzzy = false,
        farmcoco = false,
        farmflame = false,
        farmclouds = false,
        killmondo = false,
        killvicious = false,
        loopspeed = false,
        loopjump = false,
        autoquest = false,
        autoboosters = false,
        autodispense = false,
        clock = false,
        freeantpass = false,
        honeystorm = false,
        autodoquest = false,
        disableseperators = false,
        npctoggle = false,
        loopfarmspeed = false,
        mobquests = false,
        traincrab = false,
        avoidmobs = false,
        farmsprouts = false,
        farmunderballoons = false,
        farmsnowflakes = false,
        collectgingerbreads = false,
        collectcrosshairs = false,
        farmpuffshrooms = false,
        tptonpc = false,
        donotfarmtokens = false,
        convertballoons = false,
        autostockings = false,
        autosamovar = false,
        autoonettart = false,
        autocandles = false,
        autofeast = false,
        autoplanters = false,
        autokillmobs = false,
        autoant = false,
        killwindy = false,
        godmode = false,
    },
    vars = {
        field = "Mountain Top Field",
        convertat = 100,
        farmspeed = 60,
        prefer = "Tokens",
        walkspeed = 70,
        jumppower = 70,
        npcprefer = "All Quests",
        farmtype = "Walk",
        monstertimer = 3
    },
    dispensesettings = {
        blub = false,
        straw = false,
        treat = false,
        coconut = false,
        glue = false,
        rj = false,
        white = false,
        red = false,
        blue = false
    }
}
local defaultsleepy = sleepy

function statsget() local StatCache = require(game.ReplicatedStorage.ClientStatCache) local stats = StatCache:Get() return stats end
function farm(trying)
    if getgenv().sleepy.toggles.loopfarmspeed then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().sleepy.vars.farmspeed end
    sleepyapi.humanoid():MoveTo(trying.Position) 
    repeat task.wait() until (trying.Position-sleepyapi.humanoidrootpart().Position).magnitude <=4 or not IsToken(trying) or not temptable.running
end
function disableall()
    if getgenv().sleepy.toggles.autofarm and not temptable.converting then
        temptable.cache.autofarm = true
        getgenv().sleepy.toggles.autofarm = false
    end
    if getgenv().sleepy.toggles.killmondo and not temptable.started.mondo then
        getgenv().sleepy.toggles.killmondo = false
        temptable.cache.killmondo = true
    end
    if getgenv().sleepy.toggles.killvicious and not temptable.started.vicious then
        getgenv().sleepy.toggles.killvicious = false
        temptable.cache.vicious = true
    end
    if getgenv().sleepy.toggles.killwindy and not temptable.started.windy then
        getgenv().sleepy.toggles.killwindy = false
        temptable.cache.windy = true
    end
end
function enableall()
    if temptable.cache.autofarm then
        getgenv().sleepy.toggles.autofarm = true
        temptable.cache.autofarm = false
    end
    if temptable.cache.killmondo then
        getgenv().sleepy.toggles.killmondo = true
        temptable.cache.killmondo = false
    end
    if temptable.cache.vicious then
        getgenv().sleepy.toggles.killvicious = true
        temptable.cache.vicious = false
    end
    if temptable.cache.windy then
        getgenv().sleepy.toggles.killwindy = true
        temptable.cache.windy = false
    end
end
function gettoken(v3)
    if not v3 then
        v3 = fieldposition
    end
    task.wait()
    for e,r in next, game:GetService("Workspace").Collectibles:GetChildren() do
        if tonumber((r.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude) <= temptable.magnitude/1.4 and (v3-r.Position).magnitude <= temptable.magnitude then
            farm(r)
        end
    end
end
function makesprinklers()
    sprinkler = rtsg().EquippedSprinkler
    e = 1
    if sprinkler == "Basic Sprinkler" or sprinkler == "The Supreme Saturator" then
        e = 1
    elseif sprinkler == "Silver Soakers" then
        e = 2
    elseif sprinkler == "Golden Gushers" then
        e = 3
    elseif sprinkler == "Diamond Drenchers" then
        e = 4
    end
    for i = 1, e do
        k = sleepyapi.humanoid().JumpPower
        if e ~= 1 then sleepyapi.humanoid().JumpPower = 70 sleepyapi.humanoid().Jump = true task.wait(.2) end
        game.ReplicatedStorage.Events.PlayerActivesCommand:FireServer({["Name"] = "Sprinkler Builder"})
        if e ~= 1 then sleepyapi.humanoid().JumpPower = k task.wait(1) end
    end
end
function killmobs()
    for i,v in pairs(game:GetService("Workspace").MonsterSpawners:GetChildren()) do
        if v:FindFirstChild("Territory") then
            if v.Name ~= "Commando Chick" and v.Name ~= "CoconutCrab" and v.Name ~= "StumpSnail" and v.Name ~= "TunnelBear" and v.Name ~= "King Beetle Cave" and not v.Name:match("CaveMonster") and not v:FindFirstChild("TimerLabel", true).Visible then
                if v.Name:match("Werewolf") then
                    monsterpart = game:GetService("Workspace").Territories.WerewolfPlateau.w
                elseif v.Name:match("Mushroom") then
                    monsterpart = game:GetService("Workspace").Territories.MushroomZone.Part
                else
                    monsterpart = v.Territory.Value
                end
                sleepyapi.humanoidrootpart().CFrame = monsterpart.CFrame
                repeat sleepyapi.humanoidrootpart().CFrame = monsterpart.CFrame avoidmob() task.wait(1) until v:FindFirstChild("TimerLabel", true).Visible
                for i = 1, 4 do gettoken(monsterpart.Position) end
            end
        end
    end
end
function IsToken(token)
    if not token then
        return false
    end
    if not token.Parent then return false end
    if token then
        if token.Orientation.Z ~= 0 then
            return false
        end
        if token:FindFirstChild("FrontDecal") then
        else
            return false
        end
        if not token.Name == "C" then
            return false
        end
        if not token:IsA("Part") then
            return false
        end
        return true
    else
        return false
    end
end
function check(ok)
    if not ok then
        return false
    end
    if not ok.Parent then return false end
    return true
end
function getplanters()
    table.clear(planterst.plantername)
    table.clear(planterst.planterid)
    for i,v in pairs(debug.getupvalues(require(game:GetService("ReplicatedStorage").LocalPlanters).LoadPlanter)[4]) do 
        if v.GrowthPercent == 1 and v.IsMine then
            table.insert(planterst.plantername, v.Type)
            table.insert(planterst.planterid, v.ActorID)
        end
    end
end
function farmant()
    antpart.CanCollide = true
    temptable.started.ant = true
    anttable = {left = true, right = false}
    temptable.oldtool = rtsg()['EquippedCollector']
    game.ReplicatedStorage.Events.ItemPackageEvent:InvokeServer("Equip",{["Mute"] = true,["Type"] = "Spark Staff",["Category"] = "Collector"})
    game.ReplicatedStorage.Events.ToyEvent:FireServer("Ant Challenge")
    getgenv().sleepy.toggles.autodig = true
    acl = CFrame.new(127, 48, 547)
    acr = CFrame.new(65, 48, 534)
    task.wait(1)
    game.ReplicatedStorage.Events.PlayerActivesCommand:FireServer({["Name"] = "Sprinkler Builder"})
    sleepyapi.humanoidrootpart().CFrame = sleepyapi.humanoidrootpart().CFrame + Vector3.new(0, 15, 0)
    task.wait(3)
    repeat
        task.wait()
        for i,v in next, game.Workspace.Toys["Ant Challenge"].Obstacles:GetChildren() do
            if v:FindFirstChild("Root") then
                if (v.Root.Position-sleepyapi.humanoidrootpart().Position).magnitude <= 40 and anttable.left then
                    sleepyapi.humanoidrootpart().CFrame = acr
                    anttable.left = false anttable.right = true
                    wait(.1)
                elseif (v.Root.Position-sleepyapi.humanoidrootpart().Position).magnitude <= 40 and anttable.right then
                    sleepyapi.humanoidrootpart().CFrame = acl
                    anttable.left = true anttable.right = false
                    wait(.1)
                end
            end
        end
    until game:GetService("Workspace").Toys["Ant Challenge"].Busy.Value == false
    task.wait(1)
    game.ReplicatedStorage.Events.ItemPackageEvent:InvokeServer("Equip",{["Mute"] = true,["Type"] = temptable.oldtool,["Category"] = "Collector"})
    temptable.started.ant = false
    antpart.CanCollide = false
end
function collectplanters()
    getplanters()
    for i,v in pairs(planterst.plantername) do
        if sleepyapi.partwithnamepart(v, game:GetService("Workspace").Planters) and sleepyapi.partwithnamepart(v, game:GetService("Workspace").Planters):FindFirstChild("Soil") then
            soil = sleepyapi.partwithnamepart(v, game:GetService("Workspace").Planters).Soil
            sleepyapi.humanoidrootpart().CFrame = soil.CFrame
            game:GetService("ReplicatedStorage").Events.PlanterModelCollect:FireServer(planterst.planterid[i])
            task.wait(.5)
            game:GetService("ReplicatedStorage").Events.PlayerActivesCommand:FireServer({["Name"] = v.." Planter"})
            for i = 1, 5 do gettoken(soil.Position) end
            task.wait(2)
        end
    end
end
function getprioritytokens()
    task.wait()
    if temptable.running == false then
        for e,r in next, game:GetService("Workspace").Collectibles:GetChildren() do
            if r:FindFirstChildOfClass("Decal") then
                local aaaaaaaa = string.split(r:FindFirstChildOfClass("Decal").Texture, 'rbxassetid://')[2]
                if aaaaaaaa ~= nil and sleepyapi.findvalue(getgenv().sleepy.priority, aaaaaaaa) then
                    if r.Name == game.Players.LocalPlayer.Name and not r:FindFirstChild("got it") or tonumber((r.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude) <= temptable.magnitude/1.4 and not r:FindFirstChild("got it") then
                        farm(r) local val = Instance.new("IntValue",r) val.Name = "got it" break
                    end
                end
            end
        end
    end
end
function gethiveballoon()
    task.wait()
    result = false
    for i,hive in next, game:GetService("Workspace").Honeycombs:GetChildren() do
        task.wait()
        if hive:FindFirstChild("Owner") and hive:FindFirstChild("SpawnPos") then
            if tostring(hive.Owner.Value) == game.Players.LocalPlayer.Name then
                for e,balloon in next, game:GetService("Workspace").Balloons.HiveBalloons:GetChildren() do
                    task.wait()
                    if balloon:FindFirstChild("BalloonRoot") then
                        if (balloon.BalloonRoot.Position-hive.SpawnPos.Value.Position).magnitude < 15 then
                            result = true
                            break
                        end
                    end
                end
            end
        end
    end
    return result
end
function converthoney()
    task.wait(0)
    if temptable.converting then
        if game.Players.LocalPlayer.PlayerGui.ScreenGui.ActivateButton.TextBox.Text ~= "Stop Making Honey" and game.Players.LocalPlayer.PlayerGui.ScreenGui.ActivateButton.BackgroundColor3 ~= Color3.new(201, 39, 28) or (game:GetService("Players").LocalPlayer.SpawnPos.Value.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 10 then
            sleepyapi.tween(1, game:GetService("Players").LocalPlayer.SpawnPos.Value * CFrame.fromEulerAnglesXYZ(0, 110, 0) + Vector3.new(0, 0, 9))
            task.wait(.9)
            if game.Players.LocalPlayer.PlayerGui.ScreenGui.ActivateButton.TextBox.Text ~= "Stop Making Honey" and game.Players.LocalPlayer.PlayerGui.ScreenGui.ActivateButton.BackgroundColor3 ~= Color3.new(201, 39, 28) or (game:GetService("Players").LocalPlayer.SpawnPos.Value.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 10 then game:GetService("ReplicatedStorage").Events.PlayerHiveCommand:FireServer("ToggleHoneyMaking") end
            task.wait(.1)
        end
    end
end
function closestleaf()
    for i,v in next, game.Workspace.Flowers:GetChildren() do
        if temptable.running == false and tonumber((v.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude) < temptable.magnitude/1.4 then
            farm(v)
            break
        end
    end
end
function getbubble()
    for i,v in next, game.workspace.Particles:GetChildren() do
        if string.find(v.Name, "Bubble") and temptable.running == false and tonumber((v.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude) < temptable.magnitude/1.4 then
            farm(v)
            break
        end
    end
end
function getballoons()
    for i,v in next, game:GetService("Workspace").Balloons.FieldBalloons:GetChildren() do
        if v:FindFirstChild("BalloonRoot") and v:FindFirstChild("PlayerName") then
            if v:FindFirstChild("PlayerName").Value == game.Players.LocalPlayer.Name then
                if tonumber((v.BalloonRoot.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude) < temptable.magnitude/1.4 then
                    sleepyapi.walkTo(v.BalloonRoot.Position)
                end
            end
        end
    end
end
function getflower()
    flowerrrr = flowertable[math.random(#flowertable)]
    if tonumber((flowerrrr-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude) <= temptable.magnitude/1.4 and tonumber((flowerrrr-fieldposition).magnitude) <= temptable.magnitude/1.4 then 
        if temptable.running == false then 
            if getgenv().sleepy.toggles.loopfarmspeed then 
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().sleepy.vars.farmspeed 
            end 
            sleepyapi.walkTo(flowerrrr) 
        end 
    end
end
function getcloud()
    for i,v in next, game:GetService("Workspace").Clouds:GetChildren() do
        e = v:FindFirstChild("Plane")
        if e and tonumber((e.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude) < temptable.magnitude/1.4 then
            sleepyapi.walkTo(e.Position)
        end
    end
end
function getcoco(v)
    if temptable.coconut then repeat task.wait() until not temptable.coconut end
    temptable.coconut = true
    sleepyapi.tween(.1, v.CFrame)
    repeat task.wait() sleepyapi.walkTo(v.Position) until not v.Parent
    task.wait(.1)
    temptable.coconut = false
    table.remove(temptable.coconuts, table.find(temptable.coconuts, v))
end
function getfuzzy()
    pcall(function()
        for i,v in next, game.workspace.Particles:GetChildren() do
            if v.Name == "DustBunnyInstance" and temptable.running == false and tonumber((v.Plane.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude) < temptable.magnitude/1.4 then
                if v:FindFirstChild("Plane") then
                    farm(v:FindFirstChild("Plane"))
                    break
                end
            end
        end
    end)
end
function getflame()
    for i,v in next, game:GetService("Workspace").PlayerFlames:GetChildren() do
        if tonumber((v.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude) < temptable.magnitude/1.4 then
            farm(v)
            break
        end
    end
end
function avoidmob()
    for i,v in next, game:GetService("Workspace").Monsters:GetChildren() do
        if v:FindFirstChild("Head") then
            if (v.Head.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude < 30 and sleepyapi.humanoid():GetState() ~= Enum.HumanoidStateType.Freefall then
                game.Players.LocalPlayer.Character.Humanoid.Jump = true
            end
        end
    end
end
function getcrosshairs(v)
    if v.BrickColor ~= BrickColor.new("Lime green") and v.BrickColor ~= BrickColor.new("Flint") then
    if temptable.crosshair then repeat task.wait() until not temptable.crosshair end
    temptable.crosshair = true
    sleepyapi.walkTo(v.Position)
    repeat task.wait() sleepyapi.walkTo(v.Position) until not v.Parent or v.BrickColor == BrickColor.new("Forest green")
    task.wait(.1)
    temptable.crosshair = false
    table.remove(temptable.crosshairs, table.find(temptable.crosshairs, v))
    else
        table.remove(temptable.crosshairs, table.find(temptable.crosshairs, v))
    end
end
function makequests()
    for i,v in next, game:GetService("Workspace").NPCs:GetChildren() do
        if v.Name ~= "Ant Challenge Info" and v.Name ~= "Bubble Bee Man 2" and v.Name ~= "Wind Shrine" and v.Name ~= "Gummy Bear" then if v:FindFirstChild("Platform") then if v.Platform:FindFirstChild("AlertPos") then if v.Platform.AlertPos:FindFirstChild("AlertGui") then if v.Platform.AlertPos.AlertGui:FindFirstChild("ImageLabel") then
            image = v.Platform.AlertPos.AlertGui.ImageLabel
            button = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.ActivateButton.MouseButton1Click
            if image.ImageTransparency == 0 then
                if getgenv().sleepy.toggles.tptonpc then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Platform.Position.X, v.Platform.Position.Y+3, v.Platform.Position.Z)
                    task.wait(1)
                else
                    sleepyapi.tween(2,CFrame.new(v.Platform.Position.X, v.Platform.Position.Y+3, v.Platform.Position.Z))
                    task.wait(3)
                end
                for b,z in next, getconnections(button) do    z.Function()    end
                task.wait(8)
                if image.ImageTransparency == 0 then
                    for b,z in next, getconnections(button) do    z.Function()    end
                end
                task.wait(2)
            end
        end     
    end end end end end
end

-- *: sleepy
local Config = { WindowName = "🌙 sleepy | v"..temptable.version, Color = Color3.fromRGB(255, 184, 65), Keybind = Enum.KeyCode.KeypadOne}
local Window = library:CreateWindow(Config, game:GetService("CoreGui"))

-- *: home
local hometab = Window:CreateTab("home")
local information = hometab:CreateSection("info")
local gainedhoneylabel = information:CreateLabel("🍯: 0")
local uisection = hometab:CreateSection("ui")
local gui_killer = uisection:CreateButton("kill gui ⚠️", function()
	game:GetService("CoreGui"):FindFirstChild(_G.windowname).Enabled = false -- TODO: Use ":Destroy()";  -- Check paths if GUI object becomes nil.
end) -- TODO: Add keybind compatibility.
local rejoiner = uisection:CreateButton("rejoin game", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/philosolog/sleepy-pbe/main/utilities/rejoiner.lua"))()end) -- TODO: Add keybind compatibility.

information:CreateLabel("⚠️ = unsafe/experimental")
information:CreateLabel("⚙ = configurable")
information:CreateButton("discord server", function() setclipboard("https://discord.gg/aVgrSFCHpu") end)

-- *: collect
local farmtab = Window:CreateTab("collect")
local farmo = farmtab:CreateSection("farm")
local fielddropdown = farmo:CreateDropdown("field", fieldstable, function(String) getgenv().sleepy.vars.field = String end) fielddropdown:SetOption(fieldstable[8])
local autofarmtoggle = farmo:CreateToggle("autofarm ⚙", nil, function(State) getgenv().sleepy.toggles.autofarm = State end) autofarmtoggle:CreateKeybind("KeypadTwo", function(Key) end) -- TODO: Make "Best," "Rotate," and "Quests" field options.
local farmt = farmtab:CreateSection("misc.")

convertatslider = farmo:CreateSlider("% until convert", 0, 100, 100, false, function(Value) getgenv().sleepy.vars.convertat = Value end)

farmo:CreateToggle("quests ⚙", nil, function(State) getgenv().sleepy.toggles.autodoquest = State end) -- TODO: Add compatibility to other non-field quests. (kill mobs, use items). Maybe put this feature in autofarm settings?
farmo:CreateToggle("dig", nil, function(State) getgenv().sleepy.toggles.autodig = State end)
farmo:CreateToggle("sprinkler", nil, function(State) getgenv().sleepy.toggles.autosprinkler = State end)
farmo:CreateToggle("bubbles", nil, function(State) getgenv().sleepy.toggles.farmbubbles = State end)
farmo:CreateToggle("flames", nil, function(State) getgenv().sleepy.toggles.farmflame = State end)
farmo:CreateToggle("precise crosshairs", nil, function(State) getgenv().sleepy.toggles.collectcrosshairs = State end)
farmo:CreateToggle("fuzzy bombs", nil, function(State) getgenv().sleepy.toggles.farmfuzzy = State end)
farmo:CreateToggle("balloons", nil, function(State) getgenv().sleepy.toggles.farmunderballoons = State end)
farmo:CreateToggle("clouds", nil, function(State) getgenv().sleepy.toggles.farmclouds = State end)
farmo:CreateToggle("leaves", nil, function(State) getgenv().sleepy.toggles.farmclosestleaf = State end) -- TODO: Create a setting for distances. (close, far leaves)
farmt:CreateToggle("dispensers ⚙", nil, function(State) getgenv().sleepy.toggles.autodispense = State end)
farmt:CreateToggle("field boosters ⚙", nil, function(State) getgenv().sleepy.toggles.autoboosters = State end)
farmt:CreateToggle("weath clock", nil, function(State) getgenv().sleepy.toggles.clock = State end)
--farmt:CreateToggle("Auto Gingerbread Bears", nil, function(State) getgenv().sleepy.toggles.collectgingerbreads = State end)
--farmt:CreateToggle("Auto Samovar", nil, function(State) getgenv().sleepy.toggles.autosamovar = State end)
--farmt:CreateToggle("Auto Stockings", nil, function(State) getgenv().sleepy.toggles.autostockings = State end)
--farmt:CreateToggle("Auto Honey Candles", nil, function(State) getgenv().sleepy.toggles.autocandles = State end)
--farmt:CreateToggle("Auto Beesmas Feast", nil, function(State) getgenv().sleepy.toggles.autofeast = State end)
--farmt:CreateToggle("Auto Onett's Lid Art", nil, function(State) getgenv().sleepy.toggles.autoonettart = State end)
farmt:CreateToggle("ant passes", nil, function(State) getgenv().sleepy.toggles.freeantpass = State end)
farmt:CreateToggle("planters", nil, function(State) getgenv().sleepy.toggles.autoplanters = State end):AddToolTip("Will re-plant your planters after converting, if they hit 100%")
farmt:CreateToggle("sprouts", nil, function(State) getgenv().sleepy.toggles.farmsprouts = State end)
farmt:CreateToggle("puffshrooms", nil, function(State) getgenv().sleepy.toggles.farmpuffshrooms = State end)
--farmt:CreateToggle("snowflakes ⚠️", nil, function(State) getgenv().sleepy.toggles.farmsnowflakes = State end)
farmt:CreateToggle("tp to rare tokens ⚠️", nil, function(State) getgenv().sleepy.toggles.farmrares = State end)
-- farmt:CreateToggle("skip dialogue ⚙", nil, function(State) getgenv().sleepy.toggles.autoquest = State end) -- TODO: Make a skip dialogue button; enable it on auto-quests. 
farmt:CreateToggle("honeystorm", nil, function(State) getgenv().sleepy.toggles.honeystorm = State end)
farmt:CreateToggle("coconuts/meteors", nil, function(State) getgenv().sleepy.toggles.farmcoco = State end) -- TODO: Create a separate toggle for meteors.

-- * battle
local combtab = Window:CreateTab("battle")
local mobkill = combtab:CreateSection("bosses") -- TODO: Add boss rotation autofarming capabilities.
local amks = combtab:CreateSection("mobs")

mobkill:CreateToggle("Coconut Crab", nil, function(State) if State then sleepyapi.humanoidrootpart().CFrame = CFrame.new(-307.52117919922, 107.91863250732, 467.86791992188) end end)
mobkill:CreateToggle("Stump Snail", nil, function(State) fd = game.Workspace.FlowerZones['Stump Field'] if State then sleepyapi.humanoidrootpart().CFrame = CFrame.new(fd.Position.X, fd.Position.Y-6, fd.Position.Z) else sleepyapi.humanoidrootpart().CFrame = CFrame.new(fd.Position.X, fd.Position.Y+2, fd.Position.Z) end end)
mobkill:CreateToggle("Mondo Chick", nil, function(State) getgenv().sleepy.toggles.killmondo = State end)
mobkill:CreateToggle("Vicious Bee", nil, function(State) getgenv().sleepy.toggles.killvicious = State end)
mobkill:CreateToggle("Windy Bee", nil, function(State) getgenv().sleepy.toggles.killwindy = State end)
-- TODO: mobkill:CreateToggle("Auto Ant", nil, function(State) getgenv().sleepy.toggles.autoant = State end):AddToolTip("You Need Spark Stuff 😋; Goes to Ant Challenge after pollen converting")
-- TODO: Add a Commando Chick autofarm.
amks:CreateToggle("battle points", nil, function(State) getgenv().sleepy.toggles.autokillmobs = State end):AddToolTip("farms after x conversions")
amks:CreateTextBox('farm after x conversions', 'default = 3', true, function(Value) getgenv().sleepy.vars.monstertimer = tonumber(Value) end)
amks:CreateToggle("avoid mobs", nil, function(State) getgenv().sleepy.toggles.avoidmobs = State end)

-- *: tp
local wayptab = Window:CreateTab("tp")
local wayp = wayptab:CreateSection("Waypoints")

wayp:CreateDropdown("Field Teleports", fieldstable, function(Option) game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").FlowerZones:FindFirstChild(Option).CFrame end)
wayp:CreateDropdown("Monster Teleports", spawnerstable, function(Option) d = game:GetService("Workspace").MonsterSpawners:FindFirstChild(Option) game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(d.Position.X, d.Position.Y+3, d.Position.Z) end)
wayp:CreateDropdown("Toys Teleports", toystable, function(Option) d = game:GetService("Workspace").Toys:FindFirstChild(Option).Platform game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(d.Position.X, d.Position.Y+3, d.Position.Z) end)
wayp:CreateButton("Teleport to hive", function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.SpawnPos.Value end)

-- *: misc
local misctab = Window:CreateTab("misc")
local miscc = misctab:CreateSection("Misc")
local wstoggle = miscc:CreateToggle("Walk Speed", nil, function(State) getgenv().sleepy.toggles.loopspeed = State end) wstoggle:CreateKeybind("K", function(Key) end)
local jptoggle = miscc:CreateToggle("Jump Power", nil, function(State) getgenv().sleepy.toggles.loopjump = State end) jptoggle:CreateKeybind("L", function(Key) end)
local misco = misctab:CreateSection("Other")
local extras = misctab:CreateSection("Extras")

miscc:CreateButton("Ant Challenge Semi-Godmode", function() sleepyapi.tween(1, CFrame.new(93.4228, 32.3983, 553.128)) task.wait(1) game.ReplicatedStorage.Events.ToyEvent:FireServer("Ant Challenge") game.Players.LocalPlayer.Character.HumanoidRootPart.Position = Vector3.new(93.4228, 42.3983, 553.128) task.wait(2) game.Players.LocalPlayer.Character.Humanoid.Name = 1 local l = game.Players.LocalPlayer.Character["1"]:Clone() l.Parent = game.Players.LocalPlayer.Character l.Name = "Humanoid" task.wait() game.Players.LocalPlayer.Character["1"]:Destroy() sleepyapi.tween(1, CFrame.new(93.4228, 32.3983, 553.128)) task.wait(8) sleepyapi.tween(1, CFrame.new(93.4228, 32.3983, 553.128)) end)
miscc:CreateToggle("Godmode", nil, function(State) getgenv().sleepy.toggles.godmode = State if State then bssapi:Godmode(true) else bssapi:Godmode(false) end end)
misco:CreateDropdown("Equip Accesories", accesoriestable, function(Option) local ohString1 = "Equip" local ohTable2 = { ["Mute"] = false, ["Type"] = Option, ["Category"] = "Accessory" } game:GetService("ReplicatedStorage").Events.ItemPackageEvent:InvokeServer(ohString1, ohTable2) end)
misco:CreateDropdown("Equip Masks", masktable, function(Option) local ohString1 = "Equip" local ohTable2 = { ["Mute"] = false, ["Type"] = Option, ["Category"] = "Accessory" } game:GetService("ReplicatedStorage").Events.ItemPackageEvent:InvokeServer(ohString1, ohTable2) end)
misco:CreateDropdown("Equip Collectors", collectorstable, function(Option) local ohString1 = "Equip" local ohTable2 = { ["Mute"] = false, ["Type"] = Option, ["Category"] = "Collector" } game:GetService("ReplicatedStorage").Events.ItemPackageEvent:InvokeServer(ohString1, ohTable2) end)
misco:CreateDropdown("Generate Amulet", {"Supreme Star Amulet", "Diamond Star Amulet", "Gold Star Amulet","Silver Star Amulet","Bronze Star Amulet","Moon Amulet"}, function(Option) local A_1 = Option.." Generator" local Event = game:GetService("ReplicatedStorage").Events.ToyEvent Event:FireServer(A_1) end)
misco:CreateButton("Export Stats Table", function() local StatCache = require(game.ReplicatedStorage.ClientStatCache)writefile("Stats_"..sleepyapi.nickname..".json", StatCache:Encode()) end)
extras:CreateButton("fullbright", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/philosolog/sleepy-pbe/main/utilities/fullbright.lua"))()end)
extras:CreateButton("unlock fps", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/philosolog/sleepy-pbe/main/utilities/fps-unlocker.lua"))()end) -- TODO: Display tooltip on effects with synx built-in fpsunlocker. Also display what the feature may do to the game. Create settings for toggling specific objects.
extras:CreateTextBox("glider speed", "", true, function(Value) local StatCache = require(game.ReplicatedStorage.ClientStatCache) local stats = StatCache:Get() stats.EquippedParachute = "Glider" local module = require(game:GetService("ReplicatedStorage").Parachutes) local st = module.GetStat local glidersTable = getupvalues(st) glidersTable[1]["Glider"].Speed = Value setupvalue(st, st[1]'Glider', glidersTable) end)
extras:CreateTextBox("glider float", "", true, function(Value) local StatCache = require(game.ReplicatedStorage.ClientStatCache) local stats = StatCache:Get() stats.EquippedParachute = "Glider" local module = require(game:GetService("ReplicatedStorage").Parachutes) local st = module.GetStat local glidersTable = getupvalues(st) glidersTable[1]["Glider"].Float = Value setupvalue(st, st[1]'Glider', glidersTable) end)
extras:CreateButton("invisibility", function(State) sleepyapi.teleport(CFrame.new(0,0,0)) wait(1) if game.Players.LocalPlayer.Character:FindFirstChild('LowerTorso') then Root = game.Players.LocalPlayer.Character.LowerTorso.Root:Clone() game.Players.LocalPlayer.Character.LowerTorso.Root:Destroy() Root.Parent = game.Players.LocalPlayer.Character.LowerTorso sleepyapi.teleport(game:GetService("Players").LocalPlayer.SpawnPos.Value) end end)
extras:CreateToggle("float", nil, function(State) temptable.float = State end)

-- *: settings
local setttab = Window:CreateTab("settings")
local farmsettings = setttab:CreateSection("Autofarm Settings")
local raresettings = setttab:CreateSection("Tokens Settings")
local dispsettings = setttab:CreateSection("Auto Dispenser & Auto Boosters Settings")
local guisettings = setttab:CreateSection("GUI Settings")
local uitoggle = guisettings:CreateToggle("UI Toggle", nil, function(State) Window:Toggle(State) end) uitoggle:CreateKeybind(tostring(Config.Keybind):gsub("Enum.KeyCode.", ""), function(Key) Config.Keybind = Enum.KeyCode[Key] end) uitoggle:SetState(true)
local themes = guisettings:CreateDropdown("Image", {"Default","Hearts","Abstract","Hexagon","Circles","Lace With Flowers","Floral"}, function(Name) if Name == "Default" then Window:SetBackground("2151741365") elseif Name == "Hearts" then Window:SetBackground("6073763717") elseif Name == "Abstract" then Window:SetBackground("6073743871") elseif Name == "Hexagon" then Window:SetBackground("6073628839") elseif Name == "Circles" then Window:SetBackground("6071579801") elseif Name == "Lace With Flowers" then Window:SetBackground("6071575925") elseif Name == "Floral" then Window:SetBackground("5553946656") end end)themes:SetOption("Default")
local sleepys = setttab:CreateSection("Configs")
local fieldsettings = setttab:CreateSection("Fields Settings")
local aqs = setttab:CreateSection("Auto Quest Settings")
local pts = setttab:CreateSection("Autofarm Priority Tokens")

farmsettings:CreateTextBox("Autofarming Walkspeed", "Default Value = 60", true, function(Value) getgenv().sleepy.vars.farmspeed = Value end)
farmsettings:CreateToggle("^ Loop Speed On Autofarming",nil, function(State) getgenv().sleepy.toggles.loopfarmspeed = State end)
farmsettings:CreateToggle("Don't Walk In Field",nil, function(State) getgenv().sleepy.toggles.farmflower = State end)
farmsettings:CreateToggle("Convert Hive Balloon",nil, function(State) getgenv().sleepy.toggles.convertballoons = State end)
farmsettings:CreateToggle("Don't Farm Tokens",nil, function(State) getgenv().sleepy.toggles.donotfarmtokens = State end)
farmsettings:CreateSlider("Walk Speed", 0, 120, 70, false, function(Value) getgenv().sleepy.vars.walkspeed = Value end)
farmsettings:CreateSlider("Jump Power", 0, 120, 70, false, function(Value) getgenv().sleepy.vars.jumppower = Value end)
raresettings:CreateTextBox("Asset ID", 'rbxassetid', false, function(Value) rarename = Value end)
raresettings:CreateButton("Add Token To Rares List", function()
    table.insert(getgenv().sleepy.rares, rarename)
    game:GetService("CoreGui"):FindFirstChild(_G.windowname).Main:FindFirstChild("Rares List D",true):Destroy()
    raresettings:CreateDropdown("Rares List", getgenv().sleepy.rares, function(Option) end)
end)
raresettings:CreateButton("Remove Token From Rares List", function()
    table.remove(getgenv().sleepy.rares, sleepyapi.tablefind(getgenv().sleepy.rares, rarename))
    game:GetService("CoreGui"):FindFirstChild(_G.windowname).Main:FindFirstChild("Rares List D",true):Destroy()
    raresettings:CreateDropdown("Rares List", getgenv().sleepy.rares, function(Option) end)
end)
raresettings:CreateDropdown("Rares List", getgenv().sleepy.rares, function(Option) end)
dispsettings:CreateToggle("Royal Jelly Dispenser", nil, function(State) getgenv().sleepy.dispensesettings.rj = not getgenv().sleepy.dispensesettings.rj end)
dispsettings:CreateToggle("Blueberry Dispenser", nil,  function(State) getgenv().sleepy.dispensesettings.blub = not getgenv().sleepy.dispensesettings.blub end)
dispsettings:CreateToggle("Strawberry Dispenser", nil,  function(State) getgenv().sleepy.dispensesettings.straw = not getgenv().sleepy.dispensesettings.straw end)
dispsettings:CreateToggle("Treat Dispenser", nil,  function(State) getgenv().sleepy.dispensesettings.treat = not getgenv().sleepy.dispensesettings.treat end)
dispsettings:CreateToggle("Coconut Dispenser", nil,  function(State) getgenv().sleepy.dispensesettings.coconut = not getgenv().sleepy.dispensesettings.coconut end)
dispsettings:CreateToggle("Glue Dispenser", nil,  function(State) getgenv().sleepy.dispensesettings.glue = not getgenv().sleepy.dispensesettings.glue end)
dispsettings:CreateToggle("Mountain Top Booster", nil,  function(State) getgenv().sleepy.dispensesettings.white = not getgenv().sleepy.dispensesettings.white end)
dispsettings:CreateToggle("Blue Field Booster", nil,  function(State) getgenv().sleepy.dispensesettings.blue = not getgenv().sleepy.dispensesettings.blue end)
dispsettings:CreateToggle("Red Field Booster", nil,  function(State) getgenv().sleepy.dispensesettings.red = not getgenv().sleepy.dispensesettings.red end)
guisettings:CreateColorpicker("UI Color", function(Color) Window:ChangeColor(Color) end)
sleepys:CreateTextBox("Config Name", 'ex: stumpconfig', false, function(Value) temptable.configname = Value end)
sleepys:CreateButton("Load Config", function() getgenv().sleepy = game:service'HttpService':JSONDecode(readfile("sleepy/BSS_"..temptable.configname..".json")) end)
sleepys:CreateButton("Save Config", function() writefile("sleepy/BSS_"..temptable.configname..".json",game:service'HttpService':JSONEncode(sleepy)) end)
sleepys:CreateButton("Reset Config", function() getgenv().sleepy = defaultsleepy end)
fieldsettings:CreateDropdown("Best White Field", temptable.whitefields, function(Option) getgenv().sleepy.bestfields.white = Option end)
fieldsettings:CreateDropdown("Best Red Field", temptable.redfields, function(Option) getgenv().sleepy.bestfields.red = Option end)
fieldsettings:CreateDropdown("Best Blue Field", temptable.bluefields, function(Option) getgenv().sleepy.bestfields.blue = Option end)
fieldsettings:CreateDropdown("Field", fieldstable, function(Option) temptable.blackfield = Option end)
fieldsettings:CreateButton("Add Field To Blacklist", function() table.insert(getgenv().sleepy.blacklistedfields, temptable.blackfield) game:GetService("CoreGui"):FindFirstChild(_G.windowname).Main:FindFirstChild("Blacklisted Fields D",true):Destroy() fieldsettings:CreateDropdown("Blacklisted Fields", getgenv().sleepy.blacklistedfields, function(Option) end) end)
fieldsettings:CreateButton("Remove Field From Blacklist", function() table.remove(getgenv().sleepy.blacklistedfields, sleepyapi.tablefind(getgenv().sleepy.blacklistedfields, temptable.blackfield)) game:GetService("CoreGui"):FindFirstChild(_G.windowname).Main:FindFirstChild("Blacklisted Fields D",true):Destroy() fieldsettings:CreateDropdown("Blacklisted Fields", getgenv().sleepy.blacklistedfields, function(Option) end) end)
fieldsettings:CreateDropdown("Blacklisted Fields", getgenv().sleepy.blacklistedfields, function(Option) end)
aqs:CreateDropdown("Do NPC Quests", {'All Quests', 'Bucko Bee', 'Brown Bear', 'Riley Bee', 'Polar Bear'}, function(Option) getgenv().sleepy.vars.npcprefer = Option end)
aqs:CreateToggle("Teleport To NPC", nil, function(State) getgenv().sleepy.toggles.tptonpc = State end)
pts:CreateTextBox("Asset ID", 'rbxassetid', false, function(Value) rarename = Value end)
pts:CreateButton("Add Token To Priority List", function() table.insert(getgenv().sleepy.priority, rarename) game:GetService("CoreGui"):FindFirstChild(_G.windowname).Main:FindFirstChild("Priority List D",true):Destroy() pts:CreateDropdown("Priority List", getgenv().sleepy.priority, function(Option) end) end)
pts:CreateButton("Remove Token From Priority List", function() table.remove(getgenv().sleepy.priority, sleepyapi.tablefind(getgenv().sleepy.priority, rarename)) game:GetService("CoreGui"):FindFirstChild(_G.windowname).Main:FindFirstChild("Priority List D",true):Destroy() pts:CreateDropdown("Priority List", getgenv().sleepy.priority, function(Option) end) end)
pts:CreateDropdown("Priority List", getgenv().sleepy.priority, function(Option) end)

-- TODO: Move listeners into modules.
task.spawn(function() while task.wait() do
    if getgenv().sleepy.toggles.autofarm then
        --if getgenv().sleepy.toggles.farmcoco then getcoco() end
        --if getgenv().sleepy.toggles.collectcrosshairs then getcrosshairs() end
        if getgenv().sleepy.toggles.farmflame then getflame() end
        if getgenv().sleepy.toggles.farmfuzzy then getfuzzy() end
    end
end end)
game.Workspace.Particles.ChildAdded:Connect(function(v)
    if not temptable.started.vicious and not temptable.started.ant then
        if v.Name == "WarningDisk" and not temptable.started.vicious and getgenv().sleepy.toggles.autofarm and not temptable.started.ant and getgenv().sleepy.toggles.farmcoco and (v.Position-sleepyapi.humanoidrootpart().Position).magnitude < temptable.magnitude and not temptable.converting then
            table.insert(temptable.coconuts, v)
            getcoco(v)
            gettoken()
        elseif v.Name == "Crosshair" and v ~= nil and v.BrickColor ~= BrickColor.new("Forest green") and not temptable.started.ant and v.BrickColor ~= BrickColor.new("Flint") and (v.Position-sleepyapi.humanoidrootpart().Position).magnitude < temptable.magnitude and getgenv().sleepy.toggles.autofarm and getgenv().sleepy.toggles.collectcrosshairs and not temptable.converting then
            if #temptable.crosshairs <= 3 then
                table.insert(temptable.crosshairs, v)
                getcrosshairs(v)
                gettoken()
            end
        end
    end
end)
task.spawn(function() while task.wait() do
    if getgenv().sleepy.toggles.autofarm then
        temptable.magnitude = 70
        if game.Players.LocalPlayer.Character:FindFirstChild("ProgressLabel",true) then
        local pollenprglbl = game.Players.LocalPlayer.Character:FindFirstChild("ProgressLabel",true)
        maxpollen = tonumber(pollenprglbl.Text:match("%d+$"))
        local pollencount = game.Players.LocalPlayer.CoreStats.Pollen.Value
        pollenpercentage = pollencount/maxpollen*100
        fieldselected = game:GetService("Workspace").FlowerZones[getgenv().sleepy.vars.field]
        if getgenv().sleepy.toggles.autodoquest and game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Menus.Children.Quests.Content:FindFirstChild("Frame") then
            for i,v in next, game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Menus.Children.Quests:GetDescendants() do
                if v.Name == "Description" then
                    if string.match(v.Parent.Parent.TitleBar.Text, getgenv().sleepy.vars.npcprefer) or getgenv().sleepy.vars.npcprefer == "All Quests" and not string.find(v.Text, "Puffshroom") then
                        pollentypes = {'White Pollen', "Red Pollen", "Blue Pollen", "Blue Flowers", "Red Flowers", "White Flowers"}
                        text = v.Text
                        if sleepyapi.returnvalue(fieldstable, text) and not string.find(v.Text, "Complete!") and not sleepyapi.findvalue(getgenv().sleepy.blacklistedfields, sleepyapi.returnvalue(fieldstable, text)) then
                            d = sleepyapi.returnvalue(fieldstable, text)
                            fieldselected = game:GetService("Workspace").FlowerZones[d]
                            break
                        elseif sleepyapi.returnvalue(pollentypes, text) and not string.find(v.Text, 'Complete!') then
                            d = sleepyapi.returnvalue(pollentypes, text)
                            if d == "Blue Flowers" or d == "Blue Pollen" then
                                fieldselected = game:GetService("Workspace").FlowerZones[getgenv().sleepy.bestfields.blue]
                                break
                            elseif d == "White Flowers" or d == "White Pollen" then
                                fieldselected = game:GetService("Workspace").FlowerZones[getgenv().sleepy.bestfields.white]
                                break
                            elseif d == "Red Flowers" or d == "Red Pollen" then
                                fieldselected = game:GetService("Workspace").FlowerZones[getgenv().sleepy.bestfields.red]
                                break
                            end
                        end
                    end
                end
            end
        else
            fieldselected = game:GetService("Workspace").FlowerZones[getgenv().sleepy.vars.field]
        end
        fieldpos = CFrame.new(fieldselected.Position.X, fieldselected.Position.Y+3, fieldselected.Position.Z)
        fieldposition = fieldselected.Position
        if temptable.sprouts.detected and temptable.sprouts.coords and getgenv().sleepy.toggles.farmsprouts then
            fieldposition = temptable.sprouts.coords.Position
            fieldpos = temptable.sprouts.coords
        end
        if getgenv().sleepy.toggles.farmpuffshrooms and game.Workspace.Happenings.Puffshrooms:FindFirstChildOfClass("Model") then 
            if sleepyapi.partwithnamepart("Mythic", game.Workspace.Happenings.Puffshrooms) then
                temptable.magnitude = 25 
                fieldpos = sleepyapi.partwithnamepart("Mythic", game.Workspace.Happenings.Puffshrooms):FindFirstChild("Puffball Stem").CFrame
                fieldposition = fieldpos.Position
            elseif sleepyapi.partwithnamepart("Legendary", game.Workspace.Happenings.Puffshrooms) then
                temptable.magnitude = 25 
                fieldpos = sleepyapi.partwithnamepart("Legendary", game.Workspace.Happenings.Puffshrooms):FindFirstChild("Puffball Stem").CFrame
                fieldposition = fieldpos.Position
            elseif sleepyapi.partwithnamepart("Epic", game.Workspace.Happenings.Puffshrooms) then
                temptable.magnitude = 25 
                fieldpos = sleepyapi.partwithnamepart("Epic", game.Workspace.Happenings.Puffshrooms):FindFirstChild("Puffball Stem").CFrame
                fieldposition = fieldpos.Position
            elseif sleepyapi.partwithnamepart("Rare", game.Workspace.Happenings.Puffshrooms) then
                temptable.magnitude = 25 
                fieldpos = sleepyapi.partwithnamepart("Rare", game.Workspace.Happenings.Puffshrooms):FindFirstChild("Puffball Stem").CFrame
                fieldposition = fieldpos.Position
            else
                temptable.magnitude = 25 
                fieldpos = sleepyapi.getbiggestmodel(game.Workspace.Happenings.Puffshrooms):FindFirstChild("Puffball Stem").CFrame
                fieldposition = fieldpos.Position
            end
        end
        if tonumber(pollenpercentage) < tonumber(getgenv().sleepy.vars.convertat) then
            if not temptable.tokensfarm then
                sleepyapi.tween(2, fieldpos)
                task.wait(2)
                temptable.tokensfarm = true
                if getgenv().sleepy.toggles.autosprinkler then makesprinklers() end
            else
                if getgenv().sleepy.toggles.killmondo then
                    while getgenv().sleepy.toggles.killmondo and game.Workspace.Monsters:FindFirstChild("Mondo Chick (Lvl 8)") and not temptable.started.vicious and not temptable.started.monsters do
                        temptable.started.mondo = true
                        while game.Workspace.Monsters:FindFirstChild("Mondo Chick (Lvl 8)") do
                            disableall()
                            game:GetService("Workspace").Map.Ground.HighBlock.CanCollide = false 
                            mondopition = game.Workspace.Monsters["Mondo Chick (Lvl 8)"].Head.Position
                            sleepyapi.tween(1, CFrame.new(mondopition.x, mondopition.y - 60, mondopition.z))
                            task.wait(1)
                            temptable.float = true
                        end
                        task.wait(.5) game:GetService("Workspace").Map.Ground.HighBlock.CanCollide = true temptable.float = false sleepyapi.tween(.5, CFrame.new(73.2, 176.35, -167)) task.wait(1)
                        for i = 0, 50 do 
                            gettoken(CFrame.new(73.2, 176.35, -167).Position) 
                        end 
                        enableall() 
                        sleepyapi.tween(2, fieldpos) 
                        temptable.started.mondo = false
                    end
                end
                if (fieldposition-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > temptable.magnitude then
                    sleepyapi.tween(2, fieldpos)
                    task.wait(2)
                    if getgenv().sleepy.toggles.autosprinkler then makesprinklers() end
                end
                getprioritytokens()
                if getgenv().sleepy.toggles.avoidmobs then avoidmob() end
                if getgenv().sleepy.toggles.farmclosestleaf then closestleaf() end
                if getgenv().sleepy.toggles.farmbubbles then getbubble() end
                if getgenv().sleepy.toggles.farmclouds then getcloud() end
                if getgenv().sleepy.toggles.farmunderballoons then getballoons() end
                if not getgenv().sleepy.toggles.donotfarmtokens and done then gettoken() end
                if not getgenv().sleepy.toggles.farmflower then getflower() end
            end
        elseif tonumber(pollenpercentage) >= tonumber(getgenv().sleepy.vars.convertat) then
            temptable.tokensfarm = false
            sleepyapi.tween(2, game:GetService("Players").LocalPlayer.SpawnPos.Value * CFrame.fromEulerAnglesXYZ(0, 110, 0) + Vector3.new(0, 0, 9))
            task.wait(2)
            temptable.converting = true
            repeat
                converthoney()
            until game.Players.LocalPlayer.CoreStats.Pollen.Value == 0
            if getgenv().sleepy.toggles.convertballoons and gethiveballoon() then
                task.wait(6)
                repeat
                    task.wait()
                    converthoney()
                until gethiveballoon() == false or not getgenv().sleepy.toggles.convertballoons
            end
            temptable.converting = false
            temptable.act = temptable.act + 1
            task.wait(6)
            if getgenv().sleepy.toggles.autoant and not game:GetService("Workspace").Toys["Ant Challenge"].Busy.Value and rtsg().Eggs.AntPass > 0 then farmant() end
            if getgenv().sleepy.toggles.autoquest then makequests() end
            if getgenv().sleepy.toggles.autoplanters then collectplanters() end
            if getgenv().sleepy.toggles.autokillmobs then 
                if temptable.act >= getgenv().sleepy.vars.monstertimer then
                    temptable.started.monsters = true
                    temptable.act = 0
                    killmobs() 
                    temptable.started.monsters = false
                end
            end
        end
    end
end end end)
task.spawn(function()
    while task.wait(1) do
		if getgenv().sleepy.toggles.killvicious and temptable.detected.vicious and temptable.converting == false and not temptable.started.monsters then
            temptable.started.vicious = true
            disableall()
			local vichumanoid = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
			for i,v in next, game.workspace.Particles:GetChildren() do
				for x in string.gmatch(v.Name, "Vicious") do
					if string.find(v.Name, "Vicious") then
						sleepyapi.tween(1,CFrame.new(v.Position.x, v.Position.y, v.Position.z)) task.wait(1)
						sleepyapi.tween(0.5, CFrame.new(v.Position.x, v.Position.y, v.Position.z)) task.wait(.5)
					end
				end
			end
			for i,v in next, game.workspace.Particles:GetChildren() do
				for x in string.gmatch(v.Name, "Vicious") do
                    while getgenv().sleepy.toggles.killvicious and temptable.detected.vicious do task.wait() if string.find(v.Name, "Vicious") then
                        for i=1, 4 do temptable.float = true vichumanoid.CFrame = CFrame.new(v.Position.x+10, v.Position.y, v.Position.z) task.wait(.3)
                        end
                    end end
                end
			end
            enableall()
			task.wait(1)
			temptable.float = false
            temptable.started.vicious = false
		end
	end
end)
task.spawn(function() while task.wait() do
    if getgenv().sleepy.toggles.killwindy and temptable.detected.windy and not temptable.converting and not temptable.started.vicious and not temptable.started.mondo and not temptable.started.monsters then
        temptable.started.windy = true
        wlvl = "" aw = false awb = false -- some variable for autowindy, yk?
        disableall()
        while getgenv().sleepy.toggles.killwindy and temptable.detected.windy do
            if not aw then
                for i,v in pairs(workspace.Monsters:GetChildren()) do
                    if string.find(v.Name, "Windy") then wlvl = v.Name aw = true -- we found windy!
                    end
                end
            end
            if aw then
                for i,v in pairs(workspace.Monsters:GetChildren()) do
                    if string.find(v.Name, "Windy") then
                        if v.Name ~= wlvl then
                            temptable.float = false task.wait(5) for i =1, 5 do gettoken(sleepyapi.humanoidrootpart().Position) end -- collect tokens :yessir:
                            wlvl = v.Name
                        end
                    end
                end
            end
            if not awb then sleepyapi.tween(1,temptable.gacf(temptable.windy, 5)) task.wait(1) awb = true end
            if awb and temptable.windy.Name == "Windy" then
                sleepyapi.humanoidrootpart().CFrame = temptable.gacf(temptable.windy, 25) temptable.float = true task.wait()
            end
        end 
        enableall()
        temptable.float = false
        temptable.started.windy = false
    end
end end)
task.spawn(function() while task.wait(0.001) do
    if getgenv().sleepy.toggles.traincrab then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-259, 111.8, 496.4) * CFrame.fromEulerAnglesXYZ(0, 110, 90) temptable.float = true temptable.float = false end
    if getgenv().sleepy.toggles.farmrares then for k,v in next, game.workspace.Collectibles:GetChildren() do if v.CFrame.YVector.Y == 1 then if v.Transparency == 0 then decal = v:FindFirstChildOfClass("Decal") for e,r in next, getgenv().sleepy.rares do if decal.Texture == r or decal.Texture == "rbxassetid://"..r then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame break end end end end end end
    if getgenv().sleepy.toggles.autodig then workspace.NPCs.Onett.Onett["Porcelain Dipper"].ClickEvent:FireServer() if game.Players.LocalPlayer then if game.Players.LocalPlayer.Character then if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild("ClickEvent", true) then clickevent = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild("ClickEvent", true) or nil end end end if clickevent then clickevent:FireServer() end end end
end end)
game:GetService("Workspace").Particles.Folder2.ChildAdded:Connect(function(child)
    if child.Name == "Sprout" then
        temptable.sprouts.detected = true
        temptable.sprouts.coords = child.CFrame
    end
end)
game:GetService("Workspace").Particles.Folder2.ChildRemoved:Connect(function(child)
    if child.Name == "Sprout" then
        task.wait(30)
        temptable.sprouts.detected = false
        temptable.sprouts.coords = ""
    end
end)
Workspace.Particles.ChildAdded:Connect(function(instance)
    if string.find(instance.Name, "Vicious") then
        temptable.detected.vicious = true
    end
end)
Workspace.Particles.ChildRemoved:Connect(function(instance)
    if string.find(instance.Name, "Vicious") then
        temptable.detected.vicious = false
    end
end)
game:GetService("Workspace").NPCBees.ChildAdded:Connect(function(v)
    if v.Name == "Windy" then
        task.wait(3) temptable.windy = v temptable.detected.windy = true
    end
end)
game:GetService("Workspace").NPCBees.ChildRemoved:Connect(function(v)
    if v.Name == "Windy" then
        task.wait(3) temptable.windy = nil temptable.detected.windy = false
    end
end)
task.spawn(function() while task.wait(.1) do
    if not temptable.converting then
        if getgenv().sleepy.toggles.autosamovar then
            game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Samovar")
            platformm = game:GetService("Workspace").Toys.Samovar.Platform
            for i,v in pairs(game.Workspace.Collectibles:GetChildren()) do
                if (v.Position-platformm.Position).magnitude < 25 and v.CFrame.YVector.Y == 1 then
                    sleepyapi.humanoidrootpart().CFrame = v.CFrame
                end
            end
        end
        if getgenv().sleepy.toggles.autostockings then
            game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Stockings")
            platformm = game:GetService("Workspace").Toys.Stockings.Platform
            for i,v in pairs(game.Workspace.Collectibles:GetChildren()) do
                if (v.Position-platformm.Position).magnitude < 25 and v.CFrame.YVector.Y == 1 then
                    sleepyapi.humanoidrootpart().CFrame = v.CFrame
                end
            end
        end
        if getgenv().sleepy.toggles.autoonettart then
            game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Onett's Lid Art")
            platformm = game:GetService("Workspace").Toys["Onett's Lid Art"].Platform
            for i,v in pairs(game.Workspace.Collectibles:GetChildren()) do
                if (v.Position-platformm.Position).magnitude < 25 and v.CFrame.YVector.Y == 1 then
                    sleepyapi.humanoidrootpart().CFrame = v.CFrame
                end
            end
        end
        if getgenv().sleepy.toggles.autocandles then
            game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Honeyday Candles")
            platformm = game:GetService("Workspace").Toys["Honeyday Candles"].Platform
            for i,v in pairs(game.Workspace.Collectibles:GetChildren()) do
                if (v.Position-platformm.Position).magnitude < 25 and v.CFrame.YVector.Y == 1 then
                    sleepyapi.humanoidrootpart().CFrame = v.CFrame
                end
            end
        end
        if getgenv().sleepy.toggles.autofeast then
            game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Beesmas Feast")
            platformm = game:GetService("Workspace").Toys["Beesmas Feast"].Platform
            for i,v in pairs(game.Workspace.Collectibles:GetChildren()) do
                if (v.Position-platformm.Position).magnitude < 25 and v.CFrame.YVector.Y == 1 then
                    sleepyapi.humanoidrootpart().CFrame = v.CFrame
                end
            end
        end
    end
end end)
task.spawn(function() while task.wait(1) do
    temptable.runningfor = temptable.runningfor + 1
    temptable.honeycurrent = statsget().Totals.Honey
    if getgenv().sleepy.toggles.honeystorm then game.ReplicatedStorage.Events.ToyEvent:FireServer("Honeystorm") end
    if getgenv().sleepy.toggles.collectgingerbreads then game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Gingerbread House") end
    if getgenv().sleepy.toggles.autodispense then
        if getgenv().sleepy.dispensesettings.rj then local A_1 = "Free Royal Jelly Dispenser" local Event = game:GetService("ReplicatedStorage").Events.ToyEvent Event:FireServer(A_1) end
        if getgenv().sleepy.dispensesettings.blub then game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Blueberry Dispenser") end
        if getgenv().sleepy.dispensesettings.straw then game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Strawberry Dispenser") end
        if getgenv().sleepy.dispensesettings.treat then game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Treat Dispenser") end
        if getgenv().sleepy.dispensesettings.coconut then game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Coconut Dispenser") end
        if getgenv().sleepy.dispensesettings.glue then game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Glue Dispenser") end
    end
    if getgenv().sleepy.toggles.autoboosters then 
        if getgenv().sleepy.dispensesettings.white then game.ReplicatedStorage.Events.ToyEvent:FireServer("Field Booster") end
        if getgenv().sleepy.dispensesettings.red then game.ReplicatedStorage.Events.ToyEvent:FireServer("Red Field Booster") end
        if getgenv().sleepy.dispensesettings.blue then game.ReplicatedStorage.Events.ToyEvent:FireServer("Blue Field Booster") end
    end
    if getgenv().sleepy.toggles.clock then game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Wealth Clock") end
    if getgenv().sleepy.toggles.freeantpass then game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Free Ant Pass Dispenser") end
    gainedhoneylabel:UpdateText("🍯: "..sleepyapi.suffixstring(temptable.honeycurrent - temptable.honeystart))
end end)
game:GetService('RunService').Heartbeat:connect(function() 
    if getgenv().sleepy.toggles.autoquest then firesignal(game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.NPC.ButtonOverlay.MouseButton1Click) end
    if getgenv().sleepy.toggles.loopspeed then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().sleepy.vars.walkspeed end
    if getgenv().sleepy.toggles.loopjump then game.Players.LocalPlayer.Character.Humanoid.JumpPower = getgenv().sleepy.vars.jumppower end
end)
game:GetService('RunService').Heartbeat:connect(function()
    for i,v in next, game.Players.LocalPlayer.PlayerGui.ScreenGui:WaitForChild("MinigameLayer"):GetChildren() do for k,q in next, v:WaitForChild("GuiGrid"):GetDescendants() do if q.Name == "ObjContent" or q.Name == "ObjImage" then q.Visible = true end end end
end)
game:GetService('RunService').Heartbeat:connect(function() 
    if temptable.float then game.Players.LocalPlayer.Character.Humanoid.BodyTypeScale.Value = 0 floatpad.CanCollide = true floatpad.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X, game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y-3.75, game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z) task.wait(0)  else floatpad.CanCollide = false end
end)

local vu = game:GetService("VirtualUser") -- TODO: Move this anti-afk into a module.

game:GetService("Players").LocalPlayer.Idled:connect(function() vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)task.wait(1)vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
task.spawn(function()while task.wait() do
    if getgenv().sleepy.toggles.farmsnowflakes then
        task.wait(3)
        for i,v in next, temptable.tokenpath:GetChildren() do
            if v:FindFirstChildOfClass("Decal") and v:FindFirstChildOfClass("Decal").Texture == "rbxassetid://6087969886" and v.Transparency == 0 then
                sleepyapi.humanoidrootpart().CFrame = CFrame.new(v.Position.X, v.Position.Y+3, v.Position.Z)
                break
            end
        end
    end
end end)
game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
    humanoid = char:WaitForChild("Humanoid")
    humanoid.Died:Connect(function()
        if getgenv().sleepy.toggles.autofarm then
            temptable.dead = true
            getgenv().sleepy.toggles.autofarm = false
            temptable.converting = false
            temptable.farmtoken = false
        end
        if temptable.dead then
            task.wait(25)
            temptable.dead = false
            getgenv().sleepy.toggles.autofarm = true local player = game.Players.LocalPlayer
            temptable.converting = false
            temptable.tokensfarm = true
        end
    end)
end)
for _,v in next, game.workspace.Collectibles:GetChildren() do
    if string.find(v.Name,"") then
        v:Destroy()
    end
end 
task.spawn(function() while task.wait() do
    pos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    task.wait(0.00001)
    currentSpeed = (pos-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
    if currentSpeed > 0 then
        temptable.running = true
    else
        temptable.running = false
    end
end end)

hives = game.Workspace.Honeycombs:GetChildren() for i = #hives, 1, -1 do  v = game.Workspace.Honeycombs:GetChildren()[i] if v.Owner.Value == nil then game.ReplicatedStorage.Events.ClaimHive:FireServer(v.HiveID.Value) end end

if _G.autoload then if isfile("sleepy/BSS_".._G.autoload..".json") then getgenv().sleepy = game:service'HttpService':JSONDecode(readfile("sleepy/BSS_".._G.autoload..".json")) end end

for _, part in next, workspace:FindFirstChild("FieldDecos"):GetDescendants() do if part:IsA("BasePart") then part.CanCollide = false part.Transparency = part.Transparency < 0.5 and 0.5 or part.Transparency task.wait() end end
for _, part in next, workspace:FindFirstChild("Decorations"):GetDescendants() do if part:IsA("BasePart") and (part.Parent.Name == "Bush" or part.Parent.Name == "Blue Flower") then part.CanCollide = false part.Transparency = part.Transparency < 0.5 and 0.5 or part.Transparency task.wait() end end
for i,v in next, workspace.Decorations.Misc:GetDescendants() do if v.Parent.Name == "Mushroom" then v.CanCollide = false v.Transparency = 0.5 end end