local soulWarHunt = CreatureEvent("TheHazardousPhantomHuntkill")

function soulWarHunt.onKill(player, target)
	if target:isPlayer() or target:getMaster() then
		return true
	end
	if target:getName():lower() == "hazardous phantom" then
		local storage = player:getStorageValue(Storage.SoulWar.HazardousPhantom.Counter)
		if storage >= 0 and storage < 20 then
			player:setStorageValue(Storage.SoulWar.HazardousPhantom.Counter, player:getStorageValue(Storage.SoulWar.HazardousPhantom.Counter) + 1)
		end
	end
	return true
end

soulWarHunt:register()
