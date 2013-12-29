if not blazins then blazins = {} end

local lastRapture
local blazins = {}

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

function blazins.checkRapture()
  if not lastRapture then
    lastRapture = time()
    return true
  end
  if time() - lastRapture > 12 then return true end
  return false
end

-- Register library
ProbablyEngine.library.register("blazins", blazins)

local function findRapture(timeStamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)
  if CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_ME) and event == 'SPELL_ENERGIZE' then
    local name = select(2, ...)
    if name == 'Rapture' then lastRapture = timestamp end
  end
end
ProbablyEngine.listener.register('COMBAT_LOG_EVENT_UNFILTERED', findRapture)