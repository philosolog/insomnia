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


eventWhenBackpackFull.Event:Connect(function() --fill in the event
  if not sleepy.toggles.doautoinstantconvert then return end
  
  local chosenItem
  for i, v in pairs(bss:getInventory()) do --require BSS api script first
    if Item.ItemAmountHere > 0 then chosenItem == Item end
  end
end)
