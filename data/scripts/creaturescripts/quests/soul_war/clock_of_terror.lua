local clockOfTerror = CreatureEvent("ClockOfTerror")



function clockOfTerror.onThink(creature)
    if creature:getHealth() < creature:getMaxHealth() then
        local position = creature:getPosition()
        Game.createItem('backpack', 1, position)



    end
end
clockOfTerror:register()
