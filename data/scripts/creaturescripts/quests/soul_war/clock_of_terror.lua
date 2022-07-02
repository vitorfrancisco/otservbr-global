local config = {
    timeToRemoveItem = 30,
}

local clockOfTerror = CreatureEvent("ClockOfTerror")


-- local function removeItemFromTheGround(item)
--     local itemToRemove = Item(38840)
--     itemToRemove:remove(1);
-- end

function clockOfTerror.onHealthChange(creature)
    if creature:isPlayer() or creature:getMaster() then
		return true
	end
    if creature:getName():lower() == "cloak of terror" then
        local position = creature:getPosition()
        local item = Game.createItem('pulsating energy', 1, position)
        print(item.id)
        -- addEvent(removeItemFromTheGround, config.timeToRemoveItem * 1000, item.id)
	end

end

-- local cloakOfTerrorOnKill = CreatureEvent('ClockOfTerrorOnKill')

-- function cloakOfTerrorOnKill.onHealthChange(creature)
--     if creature:isPlayer() or creature:getMaster() then
-- 		return true
-- 	end
--     if creature:getName():lower() == "cloak of terror" then
--         local position = creature:getPosition()
--         Game.createItem('pulsating energy', 1, position)
--         addEvent(removeItemFromTheGround, config.timeToRemoveItem * 1000, position)
-- 	end
    
-- end

clockOfTerror:register()
-- cloakOfTerrorOnKill:register()