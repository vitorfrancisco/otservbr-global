local goshnarsSpiteEntrance = Action()

function goshnarsSpiteEntrance.onUse(player, item, position, fromPosition)
	if player:getStorageValue(Storage.SoulWar.BlueShrine) == 0 and player:getStorageValue(Storage.SoulWar.OrangeShrine) == 0 and player:getStorageValue(Storage.SoulWar.PinkShrine) == 0 and player:getStorageValue(Storage.SoulWar.GreenShrine) == 0 then
		player:teleportTo(fromPosition, true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "you haven't visited all the sanctuaries.")
        return true
    else
        player:teleportTo(Position(34148, 30999, 11), true)
        return true
    end
end

goshnarsSpiteEntrance:aid(59133)
goshnarsSpiteEntrance:register()