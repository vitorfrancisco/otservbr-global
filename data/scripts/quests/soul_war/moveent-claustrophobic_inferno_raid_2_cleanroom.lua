local CleanRaid2Entrance = MoveEvent()

local config = {
    centerPosition = Position(33991, 31039, 10),
    rangeX = 60,
    rangeY = 60,
}	

function CleanRaid2Entrance.onStepIn(player, item, position, fromPosition)
        
        local spectators = Game.getSpectators(config.centerPosition, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
	for _, creature in pairs(spectators) do
		if creature:isMonster() then
			creature:remove()
		end
	end
        return true
end

CleanRaid2Entrance:aid(65531)
CleanRaid2Entrance:register()