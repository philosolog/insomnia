local TeleportService = game:GetService("TeleportService")
local Player = game:GetService("Players").LocalPlayer

TeleportService:Teleport(game.PlaceId, Player)

-- !: I'm keeping the references unsimplified so I can implement autorejoin for the same private server. (using external tools ig)