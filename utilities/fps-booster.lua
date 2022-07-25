if getgenv().fpsBoosted == true then return end getgenv().fpsBoosted = true -- dont save to vars orelse you'll be unable to do future fps boosts
local lighting = game:GetService("Lighting")

if sethiddenproperty then sethiddenproperty(game:GetService("Lighting"), "Technology", Enum.Technology.Compatibility) end
lighting.ShadowSoftness = 0 -- not useful when the lighting technology already is compatibility, but might as well
lighting.GlobalShadows = false

local beesFolder = workspace:WaitForChild("Bees")
local coinsFolder = workspace:WaitForChild("Collectibles")
local function destroyIf(Parent, destroyPartTab, waitTime)
    for i = 1, #destroyPartTab do
        coroutine.wrap(function()
            local destroyPart = Parent:WaitForChild(destroyPartTab[i], waitTime or 0.5)
            if destroyPart then destroyPart:Destroy() return true end
        end)()
    end
end

local function tokens(token)
    -- token.CanCollide = false -- TODO: Fix this line turning CanCollide false for the floor.
    destroyIf(token, {"Sparkles", "Sound"})
end

local function bees(bee)
    destroyIf(bee, {
        "TopTexture",
        "LeftTexture",
        "RightTexture",
        "BottomTexture",
        "Mohawk"
        --"Wings", destroying these causes them to anchor
        --"Wings_Weld",
    })
    local particles = bee:FindFirstChildOfClass("ParticleEmitter") 
    if particles then
        particles:Destroy() particles = nil
    end
end

local function performanceObj(obj)
    if not obj:IsA("Part") and not obj:IsA("BasePart") then return end
    obj.CastShadow = false
    obj.CanTouch = false
    -- obj.CanQuery = false -- this isnt worth it as you wont be able to interact with hive
    obj.Transparency = ((obj.Transparency > 0.25 or obj.Material == Enum.Material.ForceField) and 1) or 0
    obj.Material = Enum.Material.SmoothPlastic
    obj.Reflectance = 0

    if obj.Parent == beesFolder then 
        bees(obj)
    elseif obj.Parent ~= coinsFolder then
        tokens(obj)
    end
end

for i, v in pairs(workspace:GetDescendants()) do
    performanceObj(v)
    if i%200 == 0 then task.wait() end
end

workspace.DescendantAdded:Connect(performanceObj)
