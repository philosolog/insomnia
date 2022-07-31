local VirtualUser = game:GetService("VirtualUser")

game:GetService("Players").LocalPlayer.Idled:Connect(function()
	VirtualUser:MoveMouse(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)