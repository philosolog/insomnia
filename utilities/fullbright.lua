local Lighting = game:GetService("Lighting")

Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
    Lighting.ClockTime = 13
end)
Lighting:GetPropertyChangedSignal("OutdoorAmbient"):Connect(function()
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
end)
Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
    Lighting.FogEnd = 10e6
end)

--[[ ?:
setmetatable(getgenv().Player.toggles.fullbright, {
    __newindex = function()
        return
    end
})
]]