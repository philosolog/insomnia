local VirtualUser = game:GetService("VirtualUser")

game:GetService("Players").LocalPlayer.Idled:Connect(function() 
	VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
	VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)