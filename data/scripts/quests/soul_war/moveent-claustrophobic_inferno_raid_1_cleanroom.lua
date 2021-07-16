local clearRaid1Entrance = MoveEvent()

local config = {
    centerPosition = Position(33993, 31056, 9),
    rangeX = 60,
    rangeY = 22,
}	

function clearRaid1Entrance.onStepIn(player, item, position, fromPosition)
        
        local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
	for _, creature in pairs(spectators) do
		if creature:isMonster() then
			creature:remove()
		end
	end
        return true
end

clearRaid1Entrance:aid(65534)
clearRaid1Entrance:register()