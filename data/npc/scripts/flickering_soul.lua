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

	if msgcontains(msg, "mission") then
		if player:getStorageValue(Storage.ThievesGuild.Quest) == 1 and player:getStorageValue(Storage.ThievesGuild.Mission01) < 1 then
			player:setStorageValue(Storage.ThievesGuild.Mission01, 1)
			npcHandler:say({
				'Your first job is quite easy. The Thaian officials are unwilling to share the wealth they\'ve accumulated in their new town Port Hope. ...',
				'They insist that most resources belong to the crown. This is quite sad, especially ivory is in high demand. Collect 10 elephant tusks and bring them to me.'
			}, cid)
		elseif player:getStorageValue(Storage.ThievesGuild.Mission01) == 1 then
			npcHandler:say('Have you finished your mission?', cid)
			npcHandler.topic[cid] = 2
		elseif player:getStorageValue(Storage.ThievesGuild.Quest) == 2 and player:getStorageValue(Storage.ThievesGuild.Mission02) < 1 then
			player:setStorageValue(Storage.ThievesGuild.Mission02, 1)
			npcHandler:say({
				'A client of our guild would like to get a certain vase. Unfortunately, it\'s not for sale. Well, by the original owner, that is. ...',
				'We, on the other hand, would gladly sell him the vase. Therefore, it would come in handy if we get this vase in our hands. ...',
				'Luckily, the walls of the owner\'s house are covered with vines, that will make a burglary quite easy. ...',
				'You\'ll still need some lock picks to get the chest open in which the vase is stored. Must be your lucky day, as I\'m selling lock picks for a fair price. ...',
				'You might need some of them to get that chest open. The soon to be ex-owner of that vase is Sarina, the proprietor of Carlin\'s general store.'
			}, cid)
		elseif player:getStorageValue(Storage.ThievesGuild.Mission02) == 2 then
			npcHandler:say('Have you finished your mission?', cid)
			npcHandler.topic[cid] = 3
		elseif player:getStorageValue(Storage.ThievesGuild.Quest) == 3 and player:getStorageValue(Storage.ThievesGuild.Mission03) < 1 then
			player:setStorageValue(Storage.ThievesGuild.Mission03, 1)
			npcHandler:say({
				'Our beloved king will hold a great festivity at the end of the month. Unfortunately he forgot to invite one of our guild\'s representatives. ...',
				'Of course it would be rude to point out this mistake to the king. It will be your job to get us an invitation to the ball. ...',
				'Moreover, It will be a great chance to check the castle for, well, opportunities. I\'m sure you understand. However, it\'s up to that pest Oswald to give out invitations, so he\'s the man you\'re looking for.'
			}, cid)
		elseif player:getStorageValue(Storage.ThievesGuild.Mission03) == 2 then
			npcHandler:say('Have you finished your mission?', cid)
			npcHandler.topic[cid] = 4
		elseif player:getStorageValue(Storage.ThievesGuild.Quest) == 4 and player:getStorageValue(Storage.ThievesGuild.Mission04) < 1 then
			player:setStorageValue(Storage.ThievesGuild.Mission04, 1)
			npcHandler:say({
				'Your next mission is somewhat bigger and I\'m sure much fun for you. Some new-rich merchant is being a bit more greedy than it\'s good for him. ...',
				'The good thing is he\'s as stupid as greedy, so we have a little but cunning plan. We arranged the boring correspondence in advance, so you\'ll come in when the fun starts. ...',
				'You\'ll disguise yourself as the dwarven ambassador and sell that fool the old dwarven bridge, south of Kazordoon. ...',
				'Well, actually it is a bit more complicated than that. Firstly, you\'ll have to get forged documents. Ask around in the criminal camp to find a forger. ...',
				'Secondly, you\'ll need a disguise. Percybald in Carlin is an eccentric actor that might help you with that. ...',
				'As soon as you got both things, travel to Venore and find the merchant Nurik. Trade the false documents for the famous painting of Mina Losa and bring it to me.'
			}, cid)
		elseif player:getStorageValue(Storage.ThievesGuild.Mission04) == 7 then
			npcHandler:say('Have you finished your mission?', cid)
			npcHandler.topic[cid] = 5
		elseif player:getStorageValue(Storage.ThievesGuild.Quest) == 5 and player:getStorageValue(Storage.ThievesGuild.Mission05) < 1 then
			player:setStorageValue(Storage.ThievesGuild.Mission05, 1)
			npcHandler:say('Some smugglers underneath Tiquanda, north west of Port Hope owe us some debts. Go there and steal their Golden Goblet and bring it to me.', cid)
		elseif player:getStorageValue(Storage.ThievesGuild.Mission05) == 1 then
			npcHandler:say('Have you finished your mission?', cid)
			npcHandler.topic[cid] = 6
		elseif player:getStorageValue(Storage.ThievesGuild.Quest) == 6 and player:getStorageValue(Storage.ThievesGuild.Mission06) < 1 then
			player:setStorageValue(Storage.ThievesGuild.Mission06, 1)
			npcHandler:say({
				'Your next job will be kidnapping. You\'ll get us the only creature that this scrupulous trader Theodore Loveless in Liberty Bay holds dear. ...',
				'His little goldfish! To get that fish, you\'ll have to get in his room somehow. ...',
				'As you might know I sell lock picks, but I fear unless you\'re extremely lucky, you won\'t crack this expensive masterpiece of a lock. However, get us that fish, regardless how.'
			}, cid)
		elseif player:getStorageValue(Storage.ThievesGuild.Mission06) == 3 then
			npcHandler:say('Have you finished your mission?', cid)
			npcHandler.topic[cid] = 7
		elseif player:getStorageValue(Storage.ThievesGuild.Quest) == 7 and player:getStorageValue(Storage.ThievesGuild.Mission07) < 1 then
			player:setStorageValue(Storage.ThievesGuild.Mission07, 1)
			npcHandler:say({
				'We\'d like to ease our lives somewhat. Therefore, we would appreciate the cooperation with one of the Venore city guards. ...',
				'Find some dirt about one of them. It\'s unimportant what it is. As soon as we have a foothold, we\'ll convince him to cooperate. Bring me whatever you may find.'
			}, cid)
		elseif player:getStorageValue(Storage.ThievesGuild.Mission07) == 1 then
			npcHandler:say('Have you finished your mission?', cid)
			npcHandler.topic[cid] = 8
		elseif player:getStorageValue(Storage.ThievesGuild.Quest) == 8 and player:getStorageValue(Storage.ThievesGuild.Mission08) < 1 then
			player:setStorageValue(Storage.ThievesGuild.Mission08, 1)
			player:addItem(8701, 1)
			npcHandler:say({
				'Competition might be an interesting challenge but our guild isn\'t really keen on competition. ...',
				'Unfortunately, we are lacking some good fighters, which is quite a disadvantage against certain other organisations. However, I think you\'re a really good fighter ...',
				'Travel to the Plains of Havoc and find the base of our competitors under the ruins of the dark cathedral ...',
				'On the lowest level, you\'ll find a wall with two trophies. Place a message of our guild on the wall, right between the trophies. On your way, get rid of as many of our competitors as you can.'
			}, cid)
		elseif player:getStorageValue(Storage.ThievesGuild.Mission08) == 2 then
			npcHandler:say('Have you finished your mission?', cid)
			npcHandler.topic[cid] = 9
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1 then
			player:setStorageValue(Storage.SoulWar.Quest, 1)
            player:setStorageValue(Storage.SoulWar.Mission01, 1)
            player:setStorageValue(Storage.SoulWar.Mission02, 1)
            player:setStorageValue(Storage.SoulWar.Mission03, 1)
            player:setStorageValue(Storage.SoulWar.Mission04, 1)
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
