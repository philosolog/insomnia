getgenv().start_time = tick()
getgenv().github_repository = "https://raw.githubusercontent.com/philosolog/sleepy-pbe/main/"

if game.PlaceId == 1537690962 then
    loadstring(game:HttpGet(getgenv().github_repository.."main.lua"))()
end

-- TODO: Create dynamic links for githubusercontent references.