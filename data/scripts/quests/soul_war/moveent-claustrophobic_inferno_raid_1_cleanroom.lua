local clearRaid1Entrance = MoveEvent()

function clearRaid1Entrance.onStepIn(player, item, position, fromPosition)
        clearRoom(Position(33995,31056, 9), 60, 60, Position(33992,33992,9))
        return true
end

clearRaid1Entrance:aid(65534)
clearRaid1Entrance:register()