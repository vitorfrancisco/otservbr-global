local OrangeShrine = Action()

function OrangeShrine.onUse(player, item, position, fromPosition)
	if player:getStorageValue(Storage.SoulWar.Quest) < 1 then
		player:teleportTo(fromPosition, true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You dont have access.")
        return true
    elseif player:getStorageValue(Storage.SoulWar.OrangeShrine) == 1 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already found out about this sanctuary...")
        return true
    else
        player:setStorageValue(Storage.SoulWar.OrangeShrine, 1);
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You get the Orange Shrine")
        return true
    end
end

OrangeShrine:aid(65006)
OrangeShrine:register()