local lighting = game:GetService("Lighting")
sleepy.lightingData = {}

lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
    lighting.ClockTime = 13
end)
lighting:GetPropertyChangedSignal("OutdoorAmbient"):Connect(function()
    lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
end)
lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
    lighting.FogEnd = 10e6
end)

setmetatable(sleepy.toggles.fullbright, {
    __newindex = function()
        
        return
    end
})