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

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)

	if msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1 then
			player:setStorageValue(Storage.SoulWar.Quest, 1)
            player:setStorageValue(Storage.SoulWar.Mission01, 1)
            player:setStorageValue(Storage.SoulWar.Mission02, 1)
            player:setStorageValue(Storage.SoulWar.Mission03, 1)
            player:setStorageValue(Storage.SoulWar.Mission04, 1)
			player:setStorageValue(Storage.SoulWar.Mission05, 1)
			player:setStorageValue(Storage.SoulWar.HazardousPhantom.Counter, 0);
			player:setStorageValue(Storage.SoulWar.MirrorImage.KnightCounter, 0);
			player:setStorageValue(Storage.SoulWar.MirrorImage.DruidCounter, 0);
			player:setStorageValue(Storage.SoulWar.MirrorImage.SorcererCounter, 0);
			player:setStorageValue(Storage.SoulWar.MirrorImage.PaladinCounter, 0);
			player:setStorageValue(Storage.SoulWar.BossKill.GoshnarsMalice, 0);
            player:setStorageValue(Storage.SoulWar.BossKill.GoshnarsHatred, 0);
            player:setStorageValue(Storage.SoulWar.BossKill.GoshnarsSpite, 0);
            player:setStorageValue(Storage.SoulWar.BossKill.GoshnarsCruelty, 0);
			player:setStorageValue(Storage.SoulWar.BossKill.GoshnarsGreed, 0);
			player:setStorageValue(Storage.SoulWar.BossKill.GoshnarsMegalomania, 0);
			player:setStorageValue(Storage.SoulWar.ClaustrophobicInfernoRaidCounter, 0);
			player:setStorageValue(Storage.SoulWar.BlueShrine, 0);
			player:setStorageValue(Storage.SoulWar.OrangeShrine, 0);
			player:setStorageValue(Storage.SoulWar.PinkShrine, 0);
			player:setStorageValue(Storage.SoulWar.GreenShrine, 0);
			
			npcHandler:say({
				'Thank you for accepting this burden.'
			}, cid)
			npcHandler.topic[cid] = 0
        end
	elseif msgcontains(msg, 'task') then
		if player:getStorageValue(Storage.SoulWar.Quest) < 1 then
			npcHandler:say('Im aware I have no right to ask and I have little to offer as a payment, but I ask you nonetheless. Will you face my fettered vices and destroy them for me?', cid)
			npcHandler.topic[cid] = 1
		end

	end
	return true
end

npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_GREET, 'Greetings, |PLAYERNAME|!')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
