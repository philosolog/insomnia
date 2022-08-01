local sleepy = getgenv().sleepy
local sleepyapi = {}

sleepyapi.version = "1"
sleepyapi.log = function(message)
	-- game.GetService("TestService"):Message(message, nil, nil)
	printconsole(message, 255, 184, 65)
end
sleepyapi.tween = function(time, position) -- ?: Does this tween with a time offset?
	game:GetService("TweenService"):Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = position}):Play()
	task.wait(time)
end
sleepyapi.approach = function(position) -- walk to position (not pathfinding) -- TODO: Rework this; it used to be ":MoveTo()"
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(v3) + Vector3.new(0, 2, 0))
end
sleepyapi.exists = function(object)
	if object ~= nil then
		return true
	end
end
sleepyapi.notify = function(title, description, duration)
	pcall(function()
		sleepyapi.log(title..", "..description)
		game.StarterGui:SetCore("SendNotification", {
			Title = title or "sleepy";
			Text = description or "";
			Duration = duration or 1;
		})
	end)
end
sleepyapi.search = {
	["by_name"] = function(a, b)
		for _,v in pairs(a:GetDescendants()) do
			if v.Name == b then
				return v
			end
		end

		warn(b.." could not be found")
	end,
	["by_material"] = function(a, b, c)
		pcall(function()
			local size = c

			if c+1-1 == nil or c < 1 or c == nil then
				size = 1 
			elseif c == 0 then
				size = math.huge
			end

			for _, v in pairs(a:GetDescendants()) do
				if v:IsA(b) then
					local objects = {}

					table.insert(objects, v)

					if #objects == size then
						return objects
					end
				end
			end

			warn(c.." of "..b.." could not be found")
		end)
	end
}
sleepyapi.pathfind = function(target)
	local PathfindingService = game:GetService("PathfindingService")
	local Humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid
	local Root = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	local path = PathfindingService:CreatePath({
		AgentCanJump = true,
		WaypointSpacing = 1
	})
	
	path:ComputeAsync(Root.Position, target)
	
	local waypoints = path:GetWaypoints()
	
	for i, waypoint in ipairs(waypoints) do
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(waypoint.Position) -- !: It used to utilize ":MoveTo()".
		task.wait()
		--game:GetService("Players").LocalPlayer.Character.Humanoid.MoveToFinished:wait()
		if waypoint.Action == Enum.PathWaypointAction.Jump then
			Humanoid.Jump = true
		end
	end
end
sleepyapi.request = request or (syn and syn.request) or http_request
-- sleepyapi.returncode = function(string) -- ?: Necessary?
--     return loadstring(game:HttpGet(string))()
-- end
sleepyapi.utilities = function(name)
	print(tostring(sleepy.repository.."/utilities/"..name..".lua"))
	
	if game:HttpGet(tostring(sleepy.repository.."/utilities/"..name..".lua")) then
		return loadstring(tostring(sleepy.repository.."/utilities/"..name..".lua"))
	end
end

return sleepyapi