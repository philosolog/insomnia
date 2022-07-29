getgenv().sleepy = {
	time = time or tick or (os and os.time) or warn("missing time function"),
	repository = "https://raw.githubusercontent.com/philosolog/sleepy-pbe/main",
	version = "1", -- TODO: Comment a repository-based version value??
	killed = false
}

local sleepy = getgenv().sleepy
local Player = game.Players.LocalPlayer

if not isfolder("sleepy") then 
	makefolder("sleepy")
end

shared.autoload = shared.autoload or false

repeat
	task.wait()
until Player.Character

pcall(function()
	warn("loading sleepy v"..sleepy.version, "\nscript:", script, "Debug Info;")
	print(debug.traceback())
end)

if shared.sleepy then
	return warn("sleepy is already loaded") -- TODO: Notify the player that sleepy is already loaded.
end

local current_time = time()
if game:HttpGet(sleepy.repository.."/"..game.PlaceId) then -- TODO: Keep accessible user-based presets.
    if not isfolder("sleepy/"..game.PlaceId.."/configurations") then 
		makefolder("sleepy/"..game.PlaceId.."/configurations")
	end
	
	sleepy.Bee_Swarm_Simulator = {
		version = "1", -- TODO: Comment a repository-based version value??
		gui = {},
		home = nil,
		dogui = true, -- Set to false if you do not want to see a gui at all.
		cooldowns = {},
		interests = {},
		fdcool = current_time,
		mbcool = current_time,
		stingercool = current_time,
		coconutcool = current_time,
		getsuperrares = true,
		spawns = {},
		dis = {},
		running = true,
		maytp = true,
		fieldblacklist = {
			Ant = true
		},
		godwhitelist = {
			-- Coconut = true
		},
		mods = {
			shortcuts = true,
			stucktp = true,
			showercatch = true,
			tokens = true,
			rj = false,
			fd = false,
			farming = false,
			marshbee = false,
			tprare = false,
			sq = false,
			dostingers = false,
			farmmc = false,
			sprouts = true,
			god = false,
			usecoconuts = false,
			fleehp = false,
			autobuy = false,
			cannonspam = false,
			fireflies = true,
			cb = false,
			spin = false,
			donate = false,
			ignoretball = false,
			icticket = false,
			farmsb = false,
			farmcc = false,
			farmbp = false,
			scoop = false,
			nosprinklers = false,
			tcrab = false,
			tpleef = false,
			tpspark = false,
			aq = false,
			mobtp = false,
			cq = false,
			icfull = false,
			tsnail = false,
			tchick = false,
			sproutspam = false,
			walking = false,
			farmvb = false,
			farmwb = false,
			dispense = false,
			instantconvert = false,
			earlyconvert = false,
			feeding = false,
			--fleewhenlow = false,
			ws = false,
			jp = false,
			dig = false
		},
		values = {
			feedingmute = true,
			blenderitem = "BlueExtract",
			pitem = "BlueExtract",
			--fleenotarget = false,
			rjgstop = true,
			blenderqty = 1,
			windamount = 1,
			earlyconvert = 95,
			usecoconutsf = true,
			rotatetime = 120,
			inve = "",
			inveb = "",
			feeder = "Treat",
			sproutnight = false,
			sproutrate = 20,
			sproutsingle = true,
			scooppanic = false,
			tokendist = 80,
			spin = 50,
			--fleeat = 15,
			buyrate = 1.5,
			fdf = true,
			marshbeef = true,
			stingercheck = true,
			pamount = 1,
			dws = 0x10,
			rjbt = {},
			rjt = false,
			panickb = true,
			panic = Enum.KeyCode.F4,
			homekey = Enum.KeyCode.Backquote,
			hivetp = true,
			ws = 120,
			tplow = 40,
			field = "Auto",
			file = "configuration",
			feedrate = 1.5,
			jp = 90,
			djp = 0x32
		},
		teleports = {
			["Wind Shrine"] = CFrame.new(-481, 143, 411),
			["Extreme Memory Match"] = CFrame.new(-404, 114, 546),
			["Sprinkler Shop"] = CFrame.new(-389, 71, 2),
			["Spirit Bear"] = CFrame.new(-365, 99, 479),
			["Petal Shop"] = CFrame.new(-498, 52, 480),
			["Tunnel Bear"] = CFrame.new(388, 7, -49),
			["King Beetle"] = CFrame.new(220, 5, 146),
			["Red HQ/Shop"] = CFrame.new(-322, 21, 202),
			["Treat Shop"] = CFrame.new(-230, 7, 88),
			["Mega Memory Match"] = CFrame.new(-430, 71, -53),
			["Ant Field"] = CFrame.new(94, 33, 550),
			["Blender"] = CFrame.new(-427, 71, 39),
			["Ace Shop"] = CFrame.new(-481, 70, 0),
			["Coconut Shop"] = CFrame.new(-138, 70, 506),
			["Mountain Top Shop"] = CFrame.new(-18, 177, -136),
			["Edge"] = CFrame.new(-3068, 4, -3066),
			["Night Memory Match"] = CFrame.new(-17, 313, -270),
			["Memory Match"] = CFrame.new(136, 70, -95),
			["Sprout Shop"] = CFrame.new(351, 93, -80),
			["Stick Bug"] = CFrame.new(-128, 51, 147),
			["Noob Shop"] = CFrame.new(106, 6, 291),
			["Ant Challenge"] = CFrame.new(91, 35, 503),
			["Blue HQ/Shop"] = CFrame.new(310, 5, 104),
			["Intermediate Shop"] = CFrame.new(155, 70, -175),
			["Star Amulets"] = CFrame.new(131, 66, 319),
			["Ticket Shop"] = CFrame.new(-233, 19, 417),
			["Moon Amulet"] = CFrame.new(21, 90, -56),
			["Demon Mask"] = CFrame.new(300, 13, 272),
			["Diamond Mask"] = CFrame.new(-336, 132, -385),
			["Gummy Lair"] = CFrame.new(273, 25261, -745),
			["Black Bear"] = CFrame.new(-259, 6, 294),
			["Panda Bear"] = CFrame.new(104, 36, 49),
			["Riley Bee"] = CFrame.new(-361, 74, 212),
			["Brown Bear"] = CFrame.new(280, 46, 237),
			["Mother Bear"] = CFrame.new(-184, 6, 89),
			["Bucko Bee"] = CFrame.new(302, 62, 105),
			["Polar Bear"] = CFrame.new(-106, 120, -77),
			["Onett"] = CFrame.new(-9, 233, -519),
			["Market Boost"] = CFrame.new(171, 176, -294),
			["Science Bear"] = CFrame.new(269, 103, 20),
			["Gumdrop Shop"] = CFrame.new(68, 22, 37),
			["Stinger Shop"] = CFrame.new(87, 34, 454),
			["Stickbug"] = CFrame.new(-129, 50, 147),
			["Honey Bee"] = CFrame.new(-389, 90, -229),
			["Field Booster"] = CFrame.new(-38, 177, -189),
			["Meteor Shower"] = CFrame.new(160, 127, -160),
			["Bubble Bee Man"] = CFrame.new(89, 312, -278)
		},
		rares = { -- 3 = Very Rare (Teleport to it immediately), 2 = Rare, 1 = low priority, 0 = ignore completely
			[2314214749] = 3, -- stinger
			[3967304192] = 3, -- spiritpetal
			[2028603146] = 3, -- startreat
			[4483267595] = 3, -- neon berry
			[4483236276] = 3, -- bitter berry
			[2306224708] = 2, -- mooncharm
			[4520736128] = 3, -- atomic treat
			[4528640710] = 3, -- box of frogs
			[2319943273] = 3, -- starjelly
			[1674686518] = 3, -- Ticket
			[1674871631] = 3, -- Ticket
			[1987257040] = 3, -- gifted diamond egg
			[1987253833] = 3, -- gifted silver egg
			[1987255318] = 3, -- gifted golden egg
			[2007771339] = 3, -- star basic egg
			[2529092020] = 3, -- Magic Bean (sprout)
			[2584584968] = 3, -- Enzymes
			[1471882621] = 2, -- RoyalJelly
			[1471850677] = 3, -- Diamond egg
			[1471848094] = 3, -- Silver egg
			[1471849394] = 3, -- Gold egg
			[1471846464] = 3, -- Basic egg
			[3081760043] = 3, -- plastic egg
			[2863122826] = 3, -- micro-converter
			[2060626811] = 3, -- ant pass
			[2659216738] = 2, -- present
			[4520739302] = 3, -- Mythic Egg
			[2495936060] = 3, -- blue extract
			[2028574353] = 1, -- treat
			[2545746569] = 3, -- oil
			[3036899811] = 3, -- Robo Pass
			[2676671613] = 3, -- night bell
			[3835877932] = 3, -- tropical drink
			[2542899798] = 3, -- glitter
			[2495935291] = 3, -- red extract
			[1472135114] = 0, -- Honey
			[3030569073] = 3, -- cloud vial
			[3036899811] = 3, -- rpass
			[2676715441] = 3, -- festive sprout
			[3080740120] = 3, -- jelly beans
			[2863468407] = 3, -- field dice
			[2504978518] = 3, -- glue
			[2594434716] = 3, -- translator
			[3027672238] = 3, -- marshmallo bee
			[3012679515] = 2, -- Coconut
			[1629547638] = 2, -- Token link
			[3582519526] = 2, -- Tornado (wind bee token, collects tokens)
			[4889322534] = 2, -- Fuzzy bombs
			[1671281844] = 2, -- photon bee
			[2305425690] = 2, -- Puppy bond giver
			[2000457501] = 2, -- Inspire (2x pollen)
			[3582501342] = 2, -- Cloud
			[2319083910] = 2, -- Vicious spikes
			[1472256444] = 2, -- Baby bee loot bonus
			[177997841] = 2, -- bear bee morph
			[1442764904] = 2, -- Gummy storm+
		},
		blacklisted_mobs = {
			["CaveMonster1"] = true,
			["CaveMonster2"] = true,
			["TunnelBear"] = true,
			["StumpSnail"] = true,
			["King Beetle Cave"] = true,
			["CoconutCrab"] = true,
			["Commando Chick"] = true
		},
		toy_cd = {
			["Memory Match"] = true,
			["Night Memory Match"] = true,
			["Mega Memory Match"] = true,
			["Extreme Memory Match"] = true
		},
		lastmicro = 0,
		beeinfo = {},
		beenames = {},
		btypes = {},
		fields = {},
		fieldnames = {},
		fieldinfo = {},
		reversefield = {},
		przones = {},
		pzones = {},
		zones = shared.zones or workspace:FindFirstChild("FlowerZones"),
		allowfarm = true,
		quests = {},
		npcs = {},
		datastuffs = {},
		knowndecals = {}
	}

	loadstring(game:HttpGet(sleepy.repository.."/games/"..game.PlaceId.."/main.lua"))()
end

if isfile("sleepy/discord.txt") == false then 
	(syn and syn.request or http_request)({
		Url = "http://127.0.0.1:6463/rpc?v=1",
		Method = "POST",
		Headers = {["Content-Type"] = "application/json", ["Origin"] = "https://discord.com"},
		Body = game:GetService("HttpService"):JSONEncode({
			cmd = "INVITE_BROWSER",
			args = {code = "aVgrSFCHpu"},
			nonce = game:GetService("HttpService"):GenerateGUID(false)	
		}),
		writefile("sleepy/discord.txt", "https://discord.com/aVgrSFCHpu")
	})
end
-- TODO: Create dynamic links for githubusercontent references.