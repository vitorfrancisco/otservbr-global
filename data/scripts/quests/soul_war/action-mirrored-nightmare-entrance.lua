local goshnarsSpiteEntrance = MoveEvent()

function goshnarsSpiteEntrance.onStepIn(player, item, position, fromPosition)
	if player:getStorageValue(Storage.SoulWar.Quest) < 1 then
		player:teleportTo(fromPosition, true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You dont have access.")
        return true
    else
        player:teleportTo(Position(33888, 31185, 10), true)
        return true
    end
end

goshnarsSpiteEntrance:aid(65004)
goshnarsSpiteEntrance:register()