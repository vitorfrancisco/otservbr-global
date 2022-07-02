local bosses = {
	["goshnar's malice"] = {status = 2, storage = Storage.SoulWar.BossKill.GoshnarsMalice, mission = Storage.SoulWar.Mission01 },
	["goshnar's hatred"] = {status = 2, storage = Storage.SoulWar.BossKill.GoshnarsHatred, mission = Storage.SoulWar.Mission02 },
	["goshnar's spite"] = {status = 2, storage = Storage.SoulWar.BossKill.GoshnarsSpite, mission = Storage.SoulWar.Mission03  },
	["goshnar's cruelty"] = {status = 2, storage = Storage.SoulWar.BossKill.GoshnarsCruelty, mission = Storage.SoulWar.Mission04},
	["goshnar's greed"] = {status = 2, storage = Storage.SoulWar.BossKill.GoshnarsGreed, mission = Storage.SoulWar.Mission05},
}

local soulwarBosses = CreatureEvent("SoulWarBosses")
function soulwarBosses.onKill(creature, target)
	local targetMonster = target:getMonster()
	if not targetMonster then
		return true
	end

	local bossConfig = bosses[targetMonster:getName():lower()]
	if not bossConfig then
		return true
	end

	for pid, _ in pairs(targetMonster:getDamageMap()) do
		local attackerPlayer = Player(pid)
		if attackerPlayer then
			if attackerPlayer:getStorageValue(bossConfig.storage) == 1 then
				return true
			end
			attackerPlayer:setStorageValue(bossConfig.storage, 1)
			attackerPlayer:setStorageValue(bossConfig.storage, 1)
			attackerPlayer:setStorageValue(bossConfig.mission, 2)
			return true
		end
	end
end

soulwarBosses:register()
