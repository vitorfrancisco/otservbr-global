local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)
	npcHandler:onCreatureAppear(cid)
end
function onCreatureDisappear(cid)
	npcHandler:onCreatureDisappear(cid)
end
function onCreatureSay(cid, type, msg)
	npcHandler:onCreatureSay(cid, type, msg)
end
function onThink()
	npcHandler:onThink()
end

local voices = {
	{text = "No smuggling aboard this ship! Only 20 pieces of any creature product allowed!"},
	{text = "No fear! The Sea Cat will ship you safely to the mainland!"},
	{text = "All aboard! Prepare to sail!"},
	{text = "Come hell or high water, we'll reach any port I sail you to!"},
	{text = "This island is too small. I need sea water around me."}
}

npcHandler:addModule(VoiceModule:new(voices))

--From topic of the citys name to topic of the "yes" msg
local topicTable = {
	[3] = 13,
	[4] = 14,
	[5] = 15,
	[6] = 16,
	[7] = 17,
	[8] = 18,
	[9] = 19,
	[10] = 20,
	[11] = 21,
	[12] = 22,
	[13] = 23
}

--From topic of final msg "yes" to select town
local townTable = {
	[13] = TOWNS_LIST.AB_DENDRIEL,
	[14] = TOWNS_LIST.ANKRAHMUN,
	[15] = TOWNS_LIST.CARLIN,
	[16] = TOWNS_LIST.DARASHIA,
	[17] = TOWNS_LIST.EDRON,
	[18] = TOWNS_LIST.KAZORDOON,
	[19] = TOWNS_LIST.LIBERTY_BAY,
	[20] = TOWNS_LIST.PORT_HOPE,
	[21] = TOWNS_LIST.SVARGROND,
	[22] = TOWNS_LIST.THAIS,
	[23] = TOWNS_LIST.VENORE
}

local function greetCallback(cid)
	local player = Player(cid)
	npcHandler:setMessage(
		MESSAGE_GREET,
		"Well, well, a new " ..
			player:getVocation():getName():lower() .. "! \z
		Want me to bring you somewhere nice? Just say {yes}."
	)
	return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	if msgcontains(msg, "yes") and npcHandler.topic[cid] == 0 then
		npcHandler:say("Good. Got all you want to take to the mainland, {yes}? Gear, limbs, loot?", cid)
		npcHandler.topic[cid] = 1
	elseif msgcontains(msg, "yes") and npcHandler.topic[cid] == 1 then
		npcHandler:say(
			"Well, I can tell you stuff about {Ab'Dendriel}, {Ankrahmun}, {Carlin}, \z
			{Darashia}, {Edron}, {Kazordoon}, {Liberty Bay}, {Port Hope}, {Svargrond}, {Thais}, {Venore} or {Yalahar}.",
			cid
		)
		npcHandler.topic[cid] = 2
	elseif msgcontains(msg, "ab'dendriel") and npcHandler.topic[cid] == 2 then
		npcHandler:say(
			{
				"Main city of the elves - lots of trees, bug milk and stuff that easily burns ...",
				"... Sorry, just thinking aloud. Ahem. Very cosy and safe I guess if you're fond of nature. \z
					I can {sail} there if you like."
			},
			cid,
			false,
			true,
			10
		)
		npcHandler.topic[cid] = 3
	elseif msgcontains(msg, "ankrahmun") and npcHandler.topic[cid] == 2 then
		if player:isPremium() then
			npcHandler:say(
				"Only for premium travelers! Desert pyramid city close to the ocean, \z
		some underground tombs where I heard it's not bad hunting. I can {sail} there if you like.",
				cid
			)
			npcHandler.topic[cid] = 4
		else
			npcHandler:say("You are not a premium account..", cid)
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, "carlin") and npcHandler.topic[cid] == 2 then
		npcHandler:say(
			"A city ruled by forthright independent women. Very clean and safe, \z
			but also very strict on the booze, alas. But if that's what you like... I can {sail} there if you like.",
			cid
		)
		npcHandler.topic[cid] = 5
	elseif msgcontains(msg, "darashia") and npcHandler.topic[cid] == 2 then
		if player:isPremium() then
			npcHandler:say(
				"Only for premium travelers! One of the two desert cities. \z
			Built around a lovely oasis. Lions, dragons... decent location for a newcomer. I can {sail} there if you like.",
				cid
			)
			npcHandler.topic[cid] = 6
		else
			npcHandler:say("You are not a premium account..", cid)
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, "edron") and npcHandler.topic[cid] == 2 then
		if player:isPremium() then
			npcHandler:say(
				"Only for premium travelers! Quiet little castle city on an island in the north-eastern \z
			part of Tibia. Trolls, goblins, rotworms... good place for starters, too. I can {sail} there if you like.",
				cid
			)
			npcHandler.topic[cid] = 7
		else
			npcHandler:say("You are not a premium account..", cid)
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, "kazordoon") and npcHandler.topic[cid] == 2 then
		npcHandler:say("The underground dwarven city. Doesn't have a real harbour, so I can't bring you there, sorry.", cid)
		npcHandler.topic[cid] = 8
	elseif msgcontains(msg, "liberty bay") and npcHandler.topic[cid] == 2 then
		if player:isPremium() then
			npcHandler:say(
				"Only for premium travelers! Liberty Bay is on an island group in the South Seas. \z
			Ah, home sweet home. Err. I mean, it's pirates galore. Good deal of tortoises, too. \z
			Just be careful, then it's a good hunting location. I can {sail} there if you like.",
				cid
			)
			npcHandler.topic[cid] = 9
		else
			npcHandler:say("You are not a premium account..", cid)
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, "port hope") and npcHandler.topic[cid] == 2 then
		if player:isPremium() then
			npcHandler:say(
				{
					"Only for premium travelers! Port Hope is an outpost right in the middle of the jungle. ...",
					"Apes, bananas, hydras, tarantulas... Who'd want to go there? \z
				Except for crazy adventurers like these guys here on the island, obviously. Still, I can {sail} there if you like."
				},
				cid,
				false,
				true,
				10
			)
			npcHandler.topic[cid] = 10
		else
			npcHandler:say("You are not a premium account..", cid)
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, "svargrond") and npcHandler.topic[cid] == 2 then
		if player:isPremium() then
			npcHandler:say(
				"Negative, can't bring you there. \z
			You gotta pass some sort of Barbarian test before they let you live there. \z
			Still, you should go there sometime, I heard it's quite interesting.",
				cid
			)
			npcHandler.topic[cid] = 11
		else
			npcHandler:say("You are not a premium account..", cid)
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, "thais") and npcHandler.topic[cid] == 2 then
		npcHandler:say(
			"Old-school city. Actually the oldest main city in Tibia. \z
			Be careful on those streets, there are bandits everywhere. But I can {sail} there if you like.",
			cid
		)
		npcHandler.topic[cid] = 12
	elseif msgcontains(msg, "venore") and npcHandler.topic[cid] == 2 then
		npcHandler:say(
			"Hohoh, one of the richest cities, filled with merchants and LOOT! Err. \z
			I mean, it is HIGHLY recommendable for unexperienced and first-time adventurers. \z
			Don't know why they built it over a stinking swamp though. I can {sail} there if you like.",
			cid
		)
		npcHandler.topic[cid] = 13
	elseif msgcontains(msg, "sail") then
		for index, value in pairs(topicTable) do
			if npcHandler.topic[cid] == index then
				npcHandler:say("So, you've decided on your new home city?", cid)
				npcHandler.topic[cid] = value
			end
		end
	elseif msgcontains(msg, "yes") then
		for index, value in pairs(townTable) do
			local townId = Town(value)
			if npcHandler.topic[cid] == index then
				player:setTown(townId)
				player:teleportTo(townId:getTemplePosition())
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				player:setStorageValue(Storage.Dawnport.Mainland, 1)
				
				-- Liquid Black   
				player:setStorageValue(Storage.LiquidBlackQuest.QuestLine, 1)
				player:setStorageValue(Storage.LiquidBlackQuest.Visitor, 5)
				
				-- Bigfoot's Burden
				player:setStorageValue(Storage.BigfootBurden.QuestLine, 2)
				player:setStorageValue(Storage.BigfootBurden.QuestLine, 4)
				player:setStorageValue(Storage.BigfootBurden.QuestLine, 7)
				player:setStorageValue(Storage.BigfootBurden.QuestLine, 9)
				player:setStorageValue(Storage.BigfootBurden.QuestLine, 12)
				player:setStorageValue(Storage.BigfootBurden.Shooting, 5)
				player:setStorageValue(Storage.BigfootBurden.QuestLine, 16)
				player:setStorageValue(Storage.BigfootBurden.QuestLine, 20)
				player:setStorageValue(Storage.BigfootBurden.QuestLine, 23)
				player:setStorageValue(Storage.BigfootBurden.QuestLineComplete, 2)
				player:setStorageValue(Storage.BigfootBurden.Rank, 1440)
				player:setStorageValue(Storage.BigfootBurden.Warzone1Access, 2)
				player:setStorageValue(Storage.BigfootBurden.Warzone2Access, 2)
				player:setStorageValue(Storage.BigfootBurden.Warzone3Access, 2)

				-- WZ 4, 5 e 6
				player:setStorageValue(Storage.DangerousDepths.Questline, 10)
				player:setStorageValue(Storage.DangerousDepths.Access.LavaPumpWarzoneVI, 10)
				player:setStorageValue(Storage.DangerousDepths.Access.LavaPumpWarzoneV, 10)
				player:setStorageValue(Storage.DangerousDepths.Access.LavaPumpWarzoneIV, 30)
				player:setStorageValue(Storage.DangerousDepths.Dwarves.Status, 10)
				player:setStorageValue(Storage.DangerousDepths.Scouts.Status, 10)
				player:setStorageValue(Storage.DangerousDepths.Gnomes.Status, 10)	

				--In Service of Yalahar 
				player:setStorageValue(Storage.InServiceofYalahar.Questline, 51)
				player:setStorageValue(Storage.InServiceofYalahar.Mission01, 6)
				player:setStorageValue(Storage.InServiceofYalahar.Mission02, 8)
				player:setStorageValue(Storage.InServiceofYalahar.Mission03, 6)
				player:setStorageValue(Storage.InServiceofYalahar.Mission04, 6)
				player:setStorageValue(Storage.InServiceofYalahar.Mission05, 8)
				player:setStorageValue(Storage.InServiceofYalahar.Mission06, 5)
				player:setStorageValue(Storage.InServiceofYalahar.Mission07, 5)
				player:setStorageValue(Storage.InServiceofYalahar.Mission08, 4)
				player:setStorageValue(Storage.InServiceofYalahar.Mission09, 2)
				player:setStorageValue(Storage.InServiceofYalahar.Mission10, 1)
				-- part 2
				player:setStorageValue(Storage.InServiceofYalahar.SewerPipe01, 1)
				player:setStorageValue(Storage.InServiceofYalahar.SewerPipe02, 1)
				player:setStorageValue(Storage.InServiceofYalahar.SewerPipe03, 1)
				player:setStorageValue(Storage.InServiceofYalahar.SewerPipe04, 1)
				player:setStorageValue(Storage.InServiceofYalahar.DiseasedDan, 1)
				player:setStorageValue(Storage.InServiceofYalahar.DiseasedBill, 1)
				player:setStorageValue(Storage.InServiceofYalahar.DiseasedFred, 1)
				player:setStorageValue(Storage.InServiceofYalahar.AlchemistFormula, 1)
				player:setStorageValue(Storage.InServiceofYalahar.BadSide, 1)
				player:setStorageValue(Storage.InServiceofYalahar.GoodSide , 1)
				player:setStorageValue(Storage.InServiceofYalahar.MrWestDoor, 1)
				player:setStorageValue(Storage.InServiceofYalahar.MrWestStatus, 1)
				player:setStorageValue(Storage.InServiceofYalahar.TamerinStatus, 1)
				player:setStorageValue(Storage.InServiceofYalahar.MorikSummon, 1)
				player:setStorageValue(Storage.InServiceofYalahar.QuaraState, 1)
				player:setStorageValue(Storage.InServiceofYalahar.QuaraSplasher, 1)
				player:setStorageValue(Storage.InServiceofYalahar.QuaraSharptooth, 1)
				player:setStorageValue(Storage.InServiceofYalahar.QuaraInky, 1)
				player:setStorageValue(Storage.InServiceofYalahar.MatrixState, 1)
				player:setStorageValue(Storage.InServiceofYalahar.NotesPalimuth, 1)
				player:setStorageValue(Storage.InServiceofYalahar.NotesAzerus, 1)
				player:setStorageValue(Storage.InServiceofYalahar.DoorToAzerus, 1)
				player:setStorageValue(Storage.InServiceofYalahar.DoorToBog, 1)
				player:setStorageValue(Storage.InServiceofYalahar.DoorToLastFight, 1)
				player:setStorageValue(Storage.InServiceofYalahar.DoorToMatrix, 1)
				player:setStorageValue(Storage.InServiceofYalahar.DoorToQuara, 1)
				player:setStorageValue(Storage.InServiceofYalahar.SewerPipe01, 1)
				player:setStorageValue(Storage.InServiceofYalahar.SewerPipe02, 1)
				player:setStorageValue(Storage.InServiceofYalahar.SewerPipe03, 1)
				player:setStorageValue(Storage.InServiceofYalahar.SewerPipe04, 1)
				player:setStorageValue(Storage.InServiceofYalahar.DiseasedDan, 1)
				player:setStorageValue(Storage.InServiceofYalahar.DiseasedBill, 1)
				player:setStorageValue(Storage.InServiceofYalahar.DiseasedFred, 1)
				player:setStorageValue(Storage.InServiceofYalahar.AlchemistFormula, 1)
				player:setStorageValue(Storage.InServiceofYalahar.BadSide, 1)
				player:setStorageValue(Storage.InServiceofYalahar.GoodSide, 1)
				player:setStorageValue(Storage.InServiceofYalahar.MrWestDoor, 1)
				player:setStorageValue(Storage.InServiceofYalahar.MrWestStatus, 1)
				player:setStorageValue(Storage.InServiceofYalahar.TamerinStatus, 1)
				player:setStorageValue(Storage.InServiceofYalahar.MorikSummon, 1)
				player:setStorageValue(Storage.InServiceofYalahar.QuaraState, 1)
				player:setStorageValue(Storage.InServiceofYalahar.QuaraSplasher, 1)
				player:setStorageValue(Storage.InServiceofYalahar.QuaraSharptooth, 1)
				player:setStorageValue(Storage.InServiceofYalahar.QuaraInky, 1)	

				--Cults of Tibia Quest.
				player:setStorageValue(Storage.CultsOfTibia.Questline, 7)
				player:setStorageValue(Storage.CultsOfTibia.Minotaurs.jamesfrancisTask, 1)
				player:setStorageValue(Storage.CultsOfTibia.Minotaurs.Mission, 1)
				player:setStorageValue(Storage.CultsOfTibia.Minotaurs.bossTimer, 1)
				player:setStorageValue(Storage.CultsOfTibia.MotA.Mission, 1)
				player:setStorageValue(Storage.CultsOfTibia.MotA.Pedra1, 1)
				player:setStorageValue(Storage.CultsOfTibia.MotA.Pedra2, 1)
				player:setStorageValue(Storage.CultsOfTibia.MotA.Pedra3, 1)
				player:setStorageValue(Storage.CultsOfTibia.MotA.Respostas, 1)
				player:setStorageValue(Storage.CultsOfTibia.MotA.Perguntaid, 1)
				player:setStorageValue(Storage.CultsOfTibia.Barkless.Mission, 1)
				player:setStorageValue(Storage.CultsOfTibia.Barkless.sulphur, 1)
				player:setStorageValue(Storage.CultsOfTibia.Barkless.tar, 1)
				player:setStorageValue(Storage.CultsOfTibia.Barkless.ice, 1)
				player:setStorageValue(Storage.CultsOfTibia.Barkless.Objects, 1)
				player:setStorageValue(Storage.CultsOfTibia.Barkless.Temp, 1)
				player:setStorageValue(Storage.CultsOfTibia.Barkless.bossTimer, 1)
				player:setStorageValue(Storage.CultsOfTibia.Orcs.Mission, 1)
				player:setStorageValue(Storage.CultsOfTibia.Orcs.lookType, 1)
				player:setStorageValue(Storage.CultsOfTibia.Orcs.bossTimer, 1)
				player:setStorageValue(Storage.CultsOfTibia.Life.Mission, 1)
				player:setStorageValue(Storage.CultsOfTibia.Life.bossTimer, 1)
				player:setStorageValue(Storage.CultsOfTibia.Humans.Mission, 1)
				player:setStorageValue(Storage.CultsOfTibia.Humans.Vaporized, 1)
				player:setStorageValue(Storage.CultsOfTibia.Humans.Decaying, 1)
				player:setStorageValue(Storage.CultsOfTibia.Humans.bossTimer, 1)
				player:setStorageValue(Storage.CultsOfTibia.Misguided.Mission, 1)
				player:setStorageValue(Storage.CultsOfTibia.Misguided.Monsters, 1)
				player:setStorageValue(Storage.CultsOfTibia.Misguided.Exorcisms, 1)
				player:setStorageValue(Storage.CultsOfTibia.Misguided.Time, 1)
				player:setStorageValue(Storage.CultsOfTibia.Misguided.bossTimer, 1)

				-- The Explorer Society
				player:setStorageValue(Storage.ExplorerSociety.QuestLine, 1) -- Joining the Explorers
				player:setStorageValue(Storage.ExplorerSociety.QuestLine, 4)
				player:setStorageValue(Storage.ExplorerSociety.QuestLine, 7)
				player:setStorageValue(Storage.ExplorerSociety.QuestLine, 16)
				player:setStorageValue(Storage.ExplorerSociety.QuestLine, 26)
				player:setStorageValue(Storage.ExplorerSociety.QuestLine, 29)
				player:setStorageValue(Storage.ExplorerSociety.QuestLine, 32)
				player:setStorageValue(Storage.ExplorerSociety.QuestLine, 35)
				player:setStorageValue(Storage.ExplorerSociety.QuestLine, 38)
				player:setStorageValue(Storage.ExplorerSociety.QuestLine, 41)
				player:setStorageValue(Storage.ExplorerSociety.QuestLine, 43)
				player:setStorageValue(Storage.ExplorerSociety.QuestLine, 46)
				player:setStorageValue(Storage.ExplorerSociety.QuestLine, 47)
				player:setStorageValue(Storage.ExplorerSociety.QuestLine, 50)
				player:setStorageValue(Storage.ExplorerSociety.QuestLine, 55)
				player:setStorageValue(Storage.ExplorerSociety.QuestLine, 56)
				player:setStorageValue(Storage.ExplorerSociety.QuestLine, 58)
				player:setStorageValue(Storage.ExplorerSociety.QuestLine, 61)
				player:setStorageValue(Storage.ExplorerSociety.CalassaQuest, 2)

				-- The Forgotten Knowledge
				player:setStorageValue(Storage.ForgottenKnowledge.Tomes, 1)
				player:setStorageValue(Storage.ForgottenKnowledge.LastLoreKilled, 1)    
				player:setStorageValue(Storage.ForgottenKnowledge.TimeGuardianKilled, 1)
				player:setStorageValue(Storage.ForgottenKnowledge.HorrorKilled, 1)
				player:setStorageValue(Storage.ForgottenKnowledge.DragonkingKilled, 1)
				player:setStorageValue(Storage.ForgottenKnowledge.ThornKnightKilled, 1)
				player:setStorageValue(Storage.ForgottenKnowledge.LloydKilled, 1)
				player:setStorageValue(Storage.ForgottenKnowledge.LadyTenebrisKilled, 1)
				player:setStorageValue(Storage.ForgottenKnowledge.AccessMachine, 1)

				-- Barbarian Test Quest.
				player:setStorageValue(Storage.BarbarianTest.Questline, 1)
				player:setStorageValue(Storage.BarbarianTest.Mission01, 3)
				player:setStorageValue(Storage.BarbarianTest.Mission02, 3)
				player:setStorageValue(Storage.BarbarianTest.Mission03, 3)
				player:setStorageValue(Storage.BarbarianTest.Mission03, 3)

				-- Children of the Revolution Quest.
				player:setStorageValue(Storage.ChildrenoftheRevolution.Questline, 21)
				player:setStorageValue(Storage.ChildrenoftheRevolution.Mission00, 2)
				player:setStorageValue(Storage.ChildrenoftheRevolution.Mission01, 3)
				player:setStorageValue(Storage.ChildrenoftheRevolution.Mission02, 5)
				player:setStorageValue(Storage.ChildrenoftheRevolution.Mission03, 3)
				player:setStorageValue(Storage.ChildrenoftheRevolution.Mission04, 6)
				player:setStorageValue(Storage.ChildrenoftheRevolution.Mission05, 3)
				player:setStorageValue(Storage.ChildrenoftheRevolution.SpyBuilding01, 1)
				player:setStorageValue(Storage.ChildrenoftheRevolution.SpyBuilding02, 1)
				player:setStorageValue(Storage.ChildrenoftheRevolution.SpyBuilding03, 1)
				player:setStorageValue(Storage.ChildrenoftheRevolution.StrangeSymbols, 1)

				-- Factions
				player:setStorageValue(Storage.DjinnWar.Faction.Greeting, 2)
				player:setStorageValue(Storage.DjinnWar.Faction.Marid, 2)
				player:setStorageValue(Storage.DjinnWar.Faction.Efreet, 2)
				player:setStorageValue(Storage.DjinnWar.Faction.MaridDoor, 1)
				player:setStorageValue(Storage.DjinnWar.Faction.EfreetDoor, 1)
				-- Efreet
				player:setStorageValue(Storage.DjinnWar.EfreetFaction.Start, 1)
				player:setStorageValue(Storage.DjinnWar.EfreetFaction.Mission01, 3)
				player:setStorageValue(Storage.DjinnWar.EfreetFaction.Mission02, 3)
				player:setStorageValue(Storage.DjinnWar.EfreetFaction.Mission03, 3)
				-- Marid
				player:setStorageValue(Storage.DjinnWar.MaridFaction.Start, 1)
				player:setStorageValue(Storage.DjinnWar.MaridFaction.Mission01, 2)
				player:setStorageValue(Storage.DjinnWar.MaridFaction.Mission02, 2)
				player:setStorageValue(Storage.DjinnWar.MaridFaction.RataMari, 2)
				player:setStorageValue(Storage.DjinnWar.MaridFaction.Mission03, 3)

				-- The Way to Yalahar
				player:setStorageValue(Storage.TheWayToYalahar.Questline, 1)
				player:setStorageValue(Storage.SearoutesAroundYalahar.TownsCounter, 1)
				player:setStorageValue(Storage.SearoutesAroundYalahar.AbDendriel, 1)
				player:setStorageValue(Storage.SearoutesAroundYalahar.Darashia, 1)
				player:setStorageValue(Storage.SearoutesAroundYalahar.Venore, 1)
				player:setStorageValue(Storage.SearoutesAroundYalahar.Ankrahmun, 1)
				player:setStorageValue(Storage.SearoutesAroundYalahar.PortHope, 1)
				player:setStorageValue(Storage.SearoutesAroundYalahar.Thais, 1)
				player:setStorageValue(Storage.SearoutesAroundYalahar.LibertyBay, 1)
				player:setStorageValue(Storage.SearoutesAroundYalahar.Carlin, 1)

				-- The Hidden City of Beregar
				player:setStorageValue(Storage.HiddenCityOfBeregar.DefaultStart, 1)
				player:setStorageValue(Storage.HiddenCityOfBeregar.GoingDown, 1)

				-- The Ice Islands Quest
				player:setStorageValue(Storage.TheIceIslands.Questline, 12)
				player:setStorageValue(Storage.TheIceIslands.Mission01, 3)
				player:setStorageValue(Storage.TheIceIslands.Mission02, 5)
				player:setStorageValue(Storage.TheIceIslands.Mission03, 3)
				player:setStorageValue(Storage.TheIceIslands.Mission04, 2)
				player:setStorageValue(Storage.TheIceIslands.Mission05, 6)
				player:setStorageValue(Storage.TheIceIslands.Mission06, 8)
				player:setStorageValue(Storage.TheIceIslands.Mission07, 3)
				player:setStorageValue(Storage.TheIceIslands.Mission08, 4)
				player:setStorageValue(Storage.TheIceIslands.Mission09, 2)
				player:setStorageValue(Storage.TheIceIslands.Mission10, 2)
				player:setStorageValue(Storage.TheIceIslands.Mission11, 2)
				player:setStorageValue(Storage.TheIceIslands.Mission12, 6)

				-- The Inquisition
				player:setStorageValue(Storage.TheInquisition.Questline, 25)
				player:setStorageValue(Storage.TheInquisition.Mission01, 7)
				player:setStorageValue(Storage.TheInquisition.Mission02, 3)
				player:setStorageValue(Storage.TheInquisition.Mission03, 6)
				player:setStorageValue(Storage.TheInquisition.Mission04, 3)
				player:setStorageValue(Storage.TheInquisition.Mission05, 3)
				player:setStorageValue(Storage.TheInquisition.Mission06, 3)
				player:setStorageValue(Storage.TheInquisition.Mission07, 1)
				player:setStorageValue(Storage.TheInquisition.GrofGuard, 1)
				player:setStorageValue(Storage.TheInquisition.KulagGuard, 1)
				player:setStorageValue(Storage.TheInquisition.TimGuard, 1)
				player:setStorageValue(Storage.TheInquisition.WalterGuard, 1)
				player:setStorageValue(Storage.TheInquisition.StorkusVampiredust, 1)

				-- The New Frontier
				player:setStorageValue(Storage.TheNewFrontier.Questline, 28)
				player:setStorageValue(Storage.TheNewFrontier.Mission01, 3)
				player:setStorageValue(Storage.TheNewFrontier.Mission02, 6)
				player:setStorageValue(Storage.TheNewFrontier.Mission03, 3)
				player:setStorageValue(Storage.TheNewFrontier.Mission04, 2)
				player:setStorageValue(Storage.TheNewFrontier.Mission05, 7)
				player:setStorageValue(Storage.TheNewFrontier.Mission06, 3)
				player:setStorageValue(Storage.TheNewFrontier.Mission07, 3)
				player:setStorageValue(Storage.TheNewFrontier.Mission08, 2)
				player:setStorageValue(Storage.TheNewFrontier.Mission09, 3)
				player:setStorageValue(Storage.TheNewFrontier.Mission10, 1)
				player:setStorageValue(Storage.TheNewFrontier.TomeofKnowledge, 12)
				player:setStorageValue(Storage.TheNewFrontier.Beaver1, 1)
				player:setStorageValue(Storage.TheNewFrontier.Beaver2, 1)
				player:setStorageValue(Storage.TheNewFrontier.Beaver3, 1)
				player:setStorageValue(Storage.TheNewFrontier.BribeKing, 1)
				player:setStorageValue(Storage.TheNewFrontier.BribeLeeland, 1)
				player:setStorageValue(Storage.TheNewFrontier.BribeExplorerSociety, 1)
				player:setStorageValue(Storage.TheNewFrontier.BribeWydrin, 1)
				player:setStorageValue(Storage.TheNewFrontier.BribeTelas, 1)

				-- The ice islands
				player:setStorageValue(12200, 1) -- Storage through the Quest
				player:setStorageValue(12201, 3) -- Befriending the Musher
				player:setStorageValue(12202, 5) -- Nibelor 1: Breaking the Ice
				player:setStorageValue(12203, 3) -- Nibelor 2: Ecological Terrorism
				player:setStorageValue(12204, 2) -- Nibelor 3: Artful Sabotage
				player:setStorageValue(12205, 6) -- Nibelor 4: Berserk Brewery
				player:setStorageValue(12206, 8) -- Nibelor 5: Cure the Dogs
				player:setStorageValue(12207, 3) -- The Secret of Helheim
				player:setStorageValue(12208, 4) -- The Contact
				player:setStorageValue(12209, 2) -- Formorgar Mines 1: The Mission
				player:setStorageValue(12210, 2) -- Formorgar Mines 2: Ghostwhisperer
				player:setStorageValue(12211, 2) -- Formorgar Mines 3: The Secret
				player:setStorageValue(12212, 1) -- Formorgar Mines 4: Retaliation

				-- The Shattered Isles
				player:setStorageValue(Storage.TheShatteredIsles.DefaultStart, 3)
				player:setStorageValue(Storage.TheShatteredIsles.TheGovernorDaughter, 3)
				player:setStorageValue(Storage.TheShatteredIsles.TheErrand, 2)
				player:setStorageValue(Storage.TheShatteredIsles.AccessToMeriana, 1)
				player:setStorageValue(Storage.TheShatteredIsles.APoemForTheMermaid, 3)
				player:setStorageValue(Storage.TheShatteredIsles.ADjinnInLove, 5)
				player:setStorageValue(Storage.TheShatteredIsles.AccessToLagunaIsland, 1)
				player:setStorageValue(Storage.TheShatteredIsles.AccessToGoroma, 1)
				player:setStorageValue(Storage.TheShatteredIsles.Shipwrecked, 2)
				player:setStorageValue(Storage.TheShatteredIsles.DragahsSpellbook, 1)
				player:setStorageValue(Storage.TheShatteredIsles.TheCounterspell, 4)

				-- The Thieves Guild.
				player:setStorageValue(Storage.ThievesGuild.Quest, 1)
				player:setStorageValue(Storage.ThievesGuild.Mission01, 2)
				player:setStorageValue(Storage.ThievesGuild.Mission02, 3)
				player:setStorageValue(Storage.ThievesGuild.Mission03, 3)
				player:setStorageValue(Storage.ThievesGuild.Mission04, 8)
				player:setStorageValue(Storage.ThievesGuild.Mission05, 2)
				player:setStorageValue(Storage.ThievesGuild.Mission06, 4)
				player:setStorageValue(Storage.ThievesGuild.Mission07, 2)
				player:setStorageValue(Storage.ThievesGuild.Mission08, 3)

				-- The Travelling Trader Quest
				player:setStorageValue(Storage.TravellingTrader.Mission01, 1)
				player:setStorageValue(Storage.TravellingTrader.Mission01, 2)
				player:setStorageValue(Storage.TravellingTrader.Mission02, 5)
				player:setStorageValue(Storage.TravellingTrader.Mission03, 3)
				player:setStorageValue(Storage.TravellingTrader.Mission04, 3)
				player:setStorageValue(Storage.TravellingTrader.Mission05, 3)
				player:setStorageValue(Storage.TravellingTrader.Mission06, 2)
				player:setStorageValue(Storage.TravellingTrader.Mission07, 1)

				-- The Ultimate Challenges Quest.
				player:setStorageValue(Storage.SvargrondArena.QuestLogGreenhorn, 1)

				-- Tibia Tales.
				player:setStorageValue(Storage.TibiaTales.DefaultStart, 1)
				player:setStorageValue(Storage.TibiaTales.ToAppeaseTheMightyQuest, 1)

				-- The Postman
				player:setStorageValue(12450, 6) -- Mission 1 - Check Postal Routes
				player:setStorageValue(12451, 3) -- Mission 2 - Fix Mailbox
				player:setStorageValue(12452, 3) -- Mission 3 - Bill Delivery
				player:setStorageValue(12453, 2) -- Mission 4 - Aggressive Dogs
				player:setStorageValue(12454, 4) -- Mission 5 - Present Delivery
				player:setStorageValue(12455, 13) -- Mission 6 - New Uniforms
				player:setStorageValue(12456, 8) -- Mission 7 - Measurements
				player:setStorageValue(12457, 3) -- Mission 8 - Missing Courier
				player:setStorageValue(12458, 4) -- Mission 9 - Dear Santa
				player:setStorageValue(12459, 3) -- Mission 10 - Mintwallin
				player:setStorageValue(12460, 5)  -- Postman Rank

				-- Unnatural Selection
				player:setStorageValue(12330, 1) -- Storage through the Quest
				player:setStorageValue(12331, 3) -- Mission 1: Skulled
				player:setStorageValue(12332, 13) -- Mission 2: All Around the World
				player:setStorageValue(12333, 3) -- Mission 3: Dance Dance Evolution
				player:setStorageValue(12334, 2) -- Mission 4: Bits and Pieces
				player:setStorageValue(12335, 3) -- Mission 5: Ray of Light
				player:setStorageValue(12336, 3) -- Mission 6: Firewater Burn

				-- Friends and Traders
				player:setStorageValue(Storage.FriendsandTraders.DefaultStart, 1)
				player:setStorageValue(Storage.FriendsandTraders.TheSweatyCyclops, 2)
				player:setStorageValue(Storage.FriendsandTraders.TheMermaidMarina, 2)
				player:setStorageValue(Storage.FriendsandTraders.TheBlessedStake, 12)				

				-- KilmareshQuest
				player:setStorageValue(22000, 5) -- Town Counter

				-- Wrath of the Emperor
				player:setStorageValue(Storage.WrathoftheEmperor.Questline, 1)
				player:setStorageValue(Storage.WrathoftheEmperor.Mission01, 3)
				player:setStorageValue(Storage.WrathoftheEmperor.Mission02, 3)
				player:setStorageValue(Storage.WrathoftheEmperor.Mission03, 3)
				player:setStorageValue(Storage.WrathoftheEmperor.Mission04, 3)
				player:setStorageValue(Storage.WrathoftheEmperor.Mission05, 3)
				player:setStorageValue(Storage.WrathoftheEmperor.Mission06, 4)
				player:setStorageValue(Storage.WrathoftheEmperor.Mission07, 6)
				player:setStorageValue(Storage.WrathoftheEmperor.Mission08, 2)
				player:setStorageValue(Storage.WrathoftheEmperor.Mission09, 2)
				player:setStorageValue(Storage.WrathoftheEmperor.Mission10, 6)
				player:setStorageValue(Storage.WrathoftheEmperor.Mission11, 1)

				-- The Ape City Quest.
				player:setStorageValue(Storage.TheApeCity.Started, 1)
				player:setStorageValue(Storage.TheApeCity.Questline, 18)

				-- Oramond.
				player:setStorageValue(Storage.Oramond.QuestLine, 1)
				player:setStorageValue(Storage.Oramond.MissionToTakeRoots, 3000)

				-- Dangerous Depths.
				player:setStorageValue(Storage.DangerousDepths.Questline, 1)
				player:setStorageValue(Storage.DangerousDepths.Dwarves.Home, 2)
				player:setStorageValue(Storage.DangerousDepths.Dwarves.Subterranean, 2)
				player:setStorageValue(Storage.DangerousDepths.Gnomes.Measurements, 2)
				player:setStorageValue(Storage.DangerousDepths.Gnomes.Ordnance, 3)
				player:setStorageValue(Storage.DangerousDepths.Gnomes.Charting, 2)
				player:setStorageValue(Storage.DangerousDepths.Scouts.Growth, 2)
				player:setStorageValue(Storage.DangerousDepths.Scouts.Diremaw, 2)

				-- Threatened Dreams
				player:setStorageValue(Storage.ThreatenedDreams.Start, 1)
				player:setStorageValue(Storage.ThreatenedDreams.TroubledMission01, 4)
				player:setStorageValue(Storage.ThreatenedDreams.TroubledMission01, 17)		
				player:setStorageValue(Storage.ThreatenedDreams.TatteredSwanFeathers, 5)

				-- Adventurers Guild.
				player:setStorageValue(Storage.AdventurersGuild.GreatDragonHunt.WarriorSkeleton, 1)
				player:setStorageValue(Storage.AdventurersGuild.GreatDragonHunt.WarriorSkeleton, 2)

				-- Dawnport
				player:setStorageValue(Storage.Quest.Dawnport.Questline, 1)
				player:setStorageValue(Storage.Quest.Dawnport.GoMain, 1)	
                    
				npcHandler:say(
					"Cast off! Don't forget to talk to the guide at the port for directions to nearest bars... \z
					err, shops and bank and such!",
					cid
				)
				npcHandler.topic[cid] = 0
			end
		end
	else
		npcHandler:say(
			"Kid, listen. Answering with a clear {yes} will get you much further in World. \z
			Most people are not as sharp-eared as I am. Got that?",
			cid
		)
		npcHandler.topic[cid] = 0
	end
	return true
end

npcHandler:setMessage(
	MESSAGE_FAREWELL,
	"You sure you want to spend time on this piece of rock? \z
I can show you the world! Huh."
)

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, greetCallback)

npcHandler:addModule(FocusModule:new())