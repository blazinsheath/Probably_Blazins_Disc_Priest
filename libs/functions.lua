if not blazins then blazins = {} end

--mouseover healing Immerseus - Contaminated Puddle
function blazins.mouseover()
 if UnitExists("mouseover")				
	and not UnitIsPlayer("mouseover") then
		local npcid = tonumber(UnitGUID("mouseover"):sub(6,10), 16) 				
		if npcid == 71604
		 then return true 
        end
 end
end  


-- Register library
ProbablyEngine.library.register("blazins", blazins)