local BlueShrine = Action()

function BlueShrine.onUse(player, item, position, fromPosition)
	if player:getStorageValue(Storage.SoulWar.Quest) < 1 then
		player:teleportTo(fromPosition, true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You dont have access.")
        return true
    elseif player:getStorageValue(Storage.SoulWar.BlueShrine) == 1 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already found out about this sanctuary...")
        return true
    else
        player:setStorageValue(Storage.SoulWar.BlueShrine, 1);
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You get the Blue Shrine")
        return true
    end
end

BlueShrine:aid(65005)
BlueShrine:register()