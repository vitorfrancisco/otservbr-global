local GreenShrine = Action()

function GreenShrine.onUse(player, item, position, fromPosition)
	if player:getStorageValue(Storage.SoulWar.Quest) < 1 then
		player:teleportTo(fromPosition, true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You dont have access.")
        return true
    elseif player:getStorageValue(Storage.SoulWar.GreenShrine) == 1 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already found out about this sanctuary...")
        return true
    else
        player:setStorageValue(Storage.SoulWar.GreenShrine, 1);
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You get the Green Shrine")
        return true
    end
end

GreenShrine:aid(65008)
GreenShrine:register()