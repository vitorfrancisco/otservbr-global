local setting = {
	requiredLevel = 400,
	daily = true,
	bossPosition = {x = 34126, y = 30993, z = 11},
	playersPositions = {
		{fromPos = {x = 34147, y = 30996, z = 11}, toPos = {x = 34126, y = 30998, z = 11}},
	}
}

local LeverHatred = Action()

function LeverHatred.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	print('click')
	if item.itemid == 9825 then
		-- Checks if they have the required level
		for i = 1, #setting.playersPositions do
			if creature and creature:getLevel() < setting.requiredLevel then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "All the players need to be level ".. setting.requiredLevel .." or higher.")
				return true
			end
		end

		-- -- Checks if there are still players inside the room, if so, return true
		-- if Position.hasPlayer(setting.centerDemonRoomPosition, 4, 4) then
		-- 	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "A team is already inside the quest room.")
		-- 	return true
		-- end
        clearRoom(setting.bossPosition, fromPosition)
		Game.createMonster("Goshnar's Hatred", setting.bossPosition)

		-- Get players from the tiles "playersPositions" and teleport to the demons room if all of the above requirements are met
		for i = 1, #setting.playersPositions do
			local creature = Tile(setting.playersPositions[i].fromPos):getTopCreature()
			-- if creature and creature:isPlayer() then
                creature:teleportTo(setting.playersPositions[i].toPos)
				creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			-- else
			-- 	return false
			-- end
		end
		item:transform(9825)
	elseif item.itemid == 9825 then
		-- If it has "daily = true" then it will execute this function
		if setting.daily then
			player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
			return true
		end
		-- Not be able to push the LeverHatred back if someone is still inside the monsters room
		if Position.hasPlayer(setting.bossPosition, 4, 4) then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "A team is already inside the quest room.")
			return true
		end
		-- Removes all monsters so that the next team can enter
		if Position.removeMonster(setting.bossPosition, 4, 4) then
			return true
		end
		item:transform(9825)
	end
	return true
end

LeverHatred:uid(65521)
LeverHatred:register()
