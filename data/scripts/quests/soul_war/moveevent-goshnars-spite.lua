local goshnarsSpiteEntrance = MoveEvent()

function goshnarsSpiteEntrance.onStepIn(player, item, position, fromPosition)
	if player:getStorageValue(Storage.SoulWar.Quest) < 1 and player:getStorageValue(Storage.SoulWar.HazardousPhantom.Counter) < 20 then
		player:teleportTo(fromPosition, true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to kill 20 Hazardous Phantom.")
        return true
    else
        player:teleportTo(Position(34094, 31065, 11), true)
        return true
    end
end

goshnarsSpiteEntrance:aid(59131)
goshnarsSpiteEntrance:register()