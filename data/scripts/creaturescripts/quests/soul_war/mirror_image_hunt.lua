local soulWarMirrorHunt = CreatureEvent("MirrorImageHuntKill")

function soulWarMirrorHunt.onKill(player, target)
	if target:isPlayer() or target:getMaster() then
		return true
	end
    if target:getName():lower() == "knight's apparition" then
        print 'knight kill'
        local storage = player:getStorageValue(Storage.SoulWar.MirrorImage.KnightCounter)
        if storage >= 0 and storage < 25 then
            player:setStorageValue(Storage.SoulWar.MirrorImage.KnightCounter, player:getStorageValue(Storage.SoulWar.MirrorImage.KnightCounter) + 1)
        end
    end
	if target:getName():lower() == "sorcerer's apparition" then
		local storage = player:getStorageValue(Storage.SoulWar.MirrorImage.SorcererCounter)
		if storage >= 0 and storage < 25 then
			player:setStorageValue(Storage.SoulWar.MirrorImage.SorcererCounter, player:getStorageValue(Storage.SoulWar.MirrorImage.SorcererCounter) + 1)
		end
    end
    if target:getName():lower() == "druid's Apparition" then
        local storage = player:getStorageValue(Storage.SoulWar.MirrorImage.DruidCounter)
		if storage >= 0 and storage < 25 then
			player:setStorageValue(Storage.SoulWar.MirrorImage.DruidCounter, player:getStorageValue(Storage.SoulWar.MirrorImage.DruidCounter) + 1)
        end
    end
    if target:getName():lower() == "paladin's apparition" then
        local storage = player:getStorageValue(Storage.SoulWar.MirrorImage.PaladinCounter)
		if storage >= 0 and storage < 25 then
			player:setStorageValue(Storage.SoulWar.MirrorImage.PaladinCounter, player:getStorageValue(Storage.SoulWar.MirrorImage.PaladinCounter) + 1)
        end
    end

	return true
end

soulWarMirrorHunt:register()
