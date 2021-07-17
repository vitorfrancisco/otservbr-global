local raid1Entrance = MoveEvent()

local config = {
	firstPlayerPosition = Position(33993, 31045, 9),
	timeToSurvive = 2,
    centerPosition = Position(33993, 31056, 9),
    rangeX = 60,
    rangeY = 22,
}	


-- local function RoomIsOccupied(centerPosition, rangeX, rangeY)
-- 	local spectators = Game.getSpectators(config.centerPosition, false, true, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
-- 	if #spectators ~= 0 then
-- 		return true
-- 	end

-- 	return false
-- end


local function raidFinish(uid)
    local player = Player(uid)

    local spectators,
	spectator = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
	for i = 1, #spectators do
		spectator = spectators[i]
        if spectator:isMonster() then
            spectator:remove()
        end
		if spectator:isPlayer() then
            if spectator.uid == uid then
                if spectator:getStorageValue(Storage.SoulWar.ClaustrophobicInfernoRaidCounter) == 0 then
                    spectator:setStorageValue(Storage.SoulWar.ClaustrophobicInfernoRaidCounter, 1)
                    spectator:teleportTo(Position(33988, 31071, 9))
                    return true
                end
            end
		end
	end

end

function raid1Entrance.onStepIn(player, item, position, fromPosition)
        local tempPos, tempTile, tempCreature
        local players = {}
        for x = config.firstPlayerPosition.x, config.firstPlayerPosition.x + 4 do
            tempPos = Position(x, config.firstPlayerPosition.y, config.firstPlayerPosition.z)
            tempTile = Tile(tempPos)
            if tempTile then
                tempCreature = tempTile:getTopCreature()
                if tempCreature and tempCreature:isPlayer() then
                    table.insert(players, tempCreature)
                end
            end
        end
        for _, pi in pairs(players) do
            addEvent(raidFinish, config.timeToSurvive * 60 * 1000,pi.uid)            
        end
        Game.startRaid("Claustrophobic Inferno 1")
        return true
end

raid1Entrance:aid(65535)
raid1Entrance:register()