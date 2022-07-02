local raid2Entrance = MoveEvent()

local config = {
	firstPlayerPosition = Position(33989, 31050, 10),
	timeToSurvive = 1,
    centerPosition = Position(33992, 31043, 10),
    rangeX = 60,
    rangeY = 30,
}	


local function raidTwoFinish(uid)
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
                if spectator:getStorageValue(Storage.SoulWar.ClaustrophobicInfernoRaidCounter) == 1 then
                    spectator:setStorageValue(Storage.SoulWar.ClaustrophobicInfernoRaidCounter, 2)
                    spectator:teleportTo(Position(33989, 31015, 10))
                    return true
                end
            end
		end
	end

end

function raid2Entrance.onStepIn(player, item, position, fromPosition)
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
            addEvent(raidTwoFinish, config.timeToSurvive * 60 * 1000,pi.uid)            
        end
        Game.startRaid("Claustrophobic Inferno 2")
        return true
end

raid2Entrance:aid(65530)
raid2Entrance:register()