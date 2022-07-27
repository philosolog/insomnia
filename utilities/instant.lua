--[[
insert something like this into main script

gui:Toggle("Enable Auto Instant Converter", function(State
  sleepy.toggles.doautoinstantconvert = State
end)
gui:Label("Instant Convert Settings") --or dont add this and the below lines and just place in settings

local methodsTable = sleepy.vars.convertMethods
gui:Slider("convert at backpack % or something along these lines", 0, 100, function(percent)
  sleepy.vars.convertwhenfull = percent
end)
gui:Toggle("Use Micro Converters", function(State)
  if State == false then pcall(table.remove(methodsTable, table.find(methodsTable, "micro"))) return end
  methodsTable[#methodsTable+1] = "micro"
end)
shared.PepsiSwarm.gui.main:Toggle("Use Ant Passes", function(State)
  if State == false then pcall(table.remove(methodsTable, table.find(methodsTable, "antpass"))) return end
  methodsTable[#methodsTable+1] = "antpass"
end)
shared.PepsiSwarm.gui.main:Toggle(specialchar .. " \t Use Tickets", function(State)
  if State == false then pcall(table.remove(methodsTable, table.find(methodsTable, "tickets"))) return end
  methodsTable[#methodsTable+1] = "tickets"
end)
]]


--we do a little forkig from pepsi (sory but tyyty pepsi)
--do loadstring(thisScript)(scriptArgs <table>, otherArgs<table>) might add this to a format guideline thingy
local scriptArgs = {...}
local getInventory = scriptArgs[1] --function that gets inventory (provided from sleepy-pbe/games/Bee-Swarm-Simulator/bssapi.lua)


scriptArgs = nil

eventWhenBackpackFull.Event:Connect(function() --fill in the event
  if not sleepy.toggles.doautoinstantconvert then return end
  
  local chosenItem
  	for i, v in pairs(bss:getInventory()) do --require BSS api script first
		if Item.ItemAmountHere > 0 then 
			chosenItem = Item 
		end
	end
end)

--below is a script reference to use
--[[
if shared.PepsiSwarm.mods.instantconvert and inventory and not shared.PepsiSwarm.panic then
  shared.PepsiSwarm.honey = true
  local micros = tonumber(rawget(inventory, "Micro-Converter") or 0)
  local ap = tonumber(rawget(inventory, "AntPass") or 0) -- Kinda funny how ant challenge empties your container
  local t = tonumber(rawget(inventory, "Ticket") or 0)
  local text = Pepsi.Obj(Toys, "Ant Challenge", "TimeBoard", "Gui", "TextLabel", "GetPropertyChangedSignal", {"Text"})
  if micros < 15 and shared.PepsiSwarm.mods.icap and ap > 9 and (text and not Pepsi.WaitUntil(text, 1.8)) then -- Never cap it.
    shared.PepsiSwarm.honey = true
    ToyEvent:FireServer("Ant Challenge")
    taskwait(2)
    ToyEvent:FireServer("Tunnel Portal")
    for k = 1, 20 do
      shared.PepsiSwarm.honey = true
      local g = Pepsi.Obj(Pepsi.Lp, "PlayerGui", "ScreenGui", "RewardsPopUp")
      if g then
        g.Visible = false
      else
        break
      end
      taskwait(0.15)
    end
    return true
  elseif not shared.PepsiSwarm.mods.icfull and micros > 0 or micros > (shared.micro_full or 5) then -- Use micros first
    shared.PepsiSwarm.honey = true
    if time() - shared.PepsiSwarm.lastmicro > 3 then
      shared.PepsiSwarm.lastmicro = time()
      PlayerActivesCommand:FireServer({
        Name = "Micro-Converter"
      })
    end
    return taskwait(0.05) and true
  elseif shared.PepsiSwarm.mods.icap and (not shared.PepsiSwarm.mods.icfull and ap > 0 or ap > 9) and (text and not Pepsi.WaitUntil(text, 1.8)) then
    shared.PepsiSwarm.honey = true
    ToyEvent:FireServer("Ant Challenge")
    taskwait(2)
    ToyEvent:FireServer("Tunnel Portal")
    for k = 1, 20 do
      local g = Pepsi.Obj(Pepsi.Lp, "PlayerGui", "ScreenGui", "RewardsPopUp")
      if g then
        g.Visible = false
      else
        break
      end
      taskwait(0.15)
    end
    return true
  elseif t > 0 and shared.PepsiSwarm.mods.icticket then -- Damn, you need a larger container
    shared.PepsiSwarm.honey = true
    for _, converter in ipairs({
      "Instant Converter",
      "Instant Converter B",
      "Instant Converter C"
    }) do
      shared.PepsiSwarm.honey = true
      if not rawget(shared.PepsiSwarm.cooldowns, converter) then
        rawset(shared.PepsiSwarm.cooldowns, converter, true)
        ToyEvent:FireServer(converter)
        Pepsi.delay(0x393, rawset, shared.PepsiSwarm.cooldowns, converter, nil)
        return taskwait(3) and true
      end
      sleep(1)
    end
  end
end
]]