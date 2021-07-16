local raid1Entrance = MoveEvent()

local config = {
	firstPlayerPosition = Position(33993, 31045, 9),
	timeToSurvive = 1,
    centerPosition = Position(33993, 31056, 9),
    rangeX = 90,
    rangeY = 90,
}	


local function RoomIsOccupied(centerPosition, rangeX, rangeY)
	local spectators = Game.getSpectators(config.centerPosition, false, true, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
	if #spectators ~= 0 then
		return true
	end

	return false
end


local function raidFinish(uid)
    local player = Player(uid)
    
    if player:getStorageValue(Storage.SoulWar.ClaustrophobicInfernoRaidCounter) == 0 then
        player:setStorageValue(Storage.SoulWar.ClaustrophobicInfernoRaidCounter, 1)
        player:teleportTo(Position(32659, 32340, 7))
        return true
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
            print(pi.uid)
            addEvent(raidFinish, config.timeToSurvive * 60 * 1000,pi.uid)            
        end
        clearRoom(Position(33995,31056, 9), 90, 90, Position(33993, 31045, 9))
        Game.startRaid("Claustrophobic Inferno 1")
        return true
end

raid1Entrance:aid(65535)
raid1Entrance:register()