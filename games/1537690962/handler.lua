getgenv().paused = false
getgenv().killed = false

local queue = {}
local storage = {
	["autofarm"] = function()
        printconsole("autofarming")
        
        task.wait(1)
	end,
    ["sprout"] = function()
        printconsole("killing sprout")
        
        task.wait(1)
    end,
} -- TODO: Add this to sleepyapi.
local function addaction(name, index)
    if storage[name] then
        if index == nil then
            index = #queue + 1
        end
        
        table.insert(queue, index, {name, storage[name]})
    end
end -- TODO: Add this to sleepyapi.
local function removeaction(name)
    for index, value in pairs(queue) do
        if value[1] == name then
            table.remove(queue, table.find(queue, value))
        end
    end
end -- TODO: Add this to sleepyapi.
local handler = coroutine.wrap(function()
    while task.wait() do
        if getgenv().paused == false then
            if queue[1] then
                queue[1][2]()
            end
        end
		if getgenv().killed == true then
			break
		end
    end

	-- coroutine.yield() -- ?: The coroutine will die after this point... Should it still be yielded?
end) -- ?: Is it possible to run this whole thing without a coroutine?

handler()
addaction("autofarm")
addaction("sprout")
task.wait(2)
removeaction("autofarm")
task.wait(2)
getgenv().paused = true
getgenv().killed = true
printconsole("killed lol")