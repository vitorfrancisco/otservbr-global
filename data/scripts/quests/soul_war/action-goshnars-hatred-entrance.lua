local goshnarsHatredEntrance = Action()

function goshnarsHatredEntrance.onUse(player, item, position, fromPosition)
	if player:getStorageValue(Storage.SoulWar.BlueShrine) == 1 and player:getStorageValue(Storage.SoulWar.OrangeShrine) == 1 and player:getStorageValue(Storage.SoulWar.PinkShrine) == 1 and player:getStorageValue(Storage.SoulWar.GreenShrine) == 1 then
        player:teleportTo(Position(34148, 30999, 11), true)
        return true
    else
		player:teleportTo(fromPosition, true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "you haven't visited all the sanctuaries.")
        return true
    end
end

goshnarsHatredEntrance:aid(59133)
goshnarsHatredEntrance:register()