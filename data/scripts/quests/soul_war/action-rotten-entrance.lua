local goshnarsSpiteEntrance = MoveEvent()

function goshnarsSpiteEntrance.onStepIn(player, item, position, fromPosition)
	if player:getStorageValue(Storage.SoulWar.Quest) < 1 then
		player:teleportTo(fromPosition, true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You dont have access.")
        return true
    else
        player:teleportTo(Position(33948, 31029, 11), true)
        return true
    end
end

goshnarsSpiteEntrance:aid(65002)
goshnarsSpiteEntrance:register()