local goshnarsMaliceEntrance = MoveEvent()

function goshnarsMaliceEntrance.onStepIn(player, item, position, fromPosition)
	if player:getStorageValue(Storage.SoulWar.ClaustrophobicInfernoRaidCounter) < 3 then
		player:teleportTo(fromPosition, true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to survival to 3 raids.")
        return true
    else
        player:teleportTo(Position(34064, 30997, 11), true)
        return true
    end
end

goshnarsMaliceEntrance:aid(59134)
goshnarsMaliceEntrance:register()