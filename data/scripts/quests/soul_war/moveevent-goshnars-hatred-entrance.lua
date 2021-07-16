local goshnarsHatredTeleport = MoveEvent()

function goshnarsHatredTeleport.onStepIn(player, item, position, fromPosition)
	if player:getStorageValue(Storage.SoulWar.BlueShrine) == 1 and player:getStorageValue(Storage.SoulWar.OrangeShrine) == 1 and player:getStorageValue(Storage.SoulWar.PinkShrine) == 1 and player:getStorageValue(Storage.SoulWar.GreenShrine) == 0 then
        player:teleportTo(Position(34148, 30999, 11), true)
        return true
    else
		player:teleportTo(fromPosition, true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "you haven't visited all the sanctuaries.")
        return true
    end
end

goshnarsHatredTeleport:aid(59133)
goshnarsHatredTeleport:register()