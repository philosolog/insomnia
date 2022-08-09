getgenv().paused = false
local sleepy = getgenv().sleepy
local sleepyapi = sleepy.sleepyapi
local sleepygame = sleepy.sleepygame
local killed = sleepygame.killed
local queue = 
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

-- addaction("autofarm")
-- addaction("sprout")
-- task.wait(2)
-- removeaction("autofarm")
-- task.wait(2)
-- getgenv().paused = true
-- getgenv().killed = true
-- printconsole("killed lol")