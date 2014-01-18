if not blazins then blazins = {} end

local lastRapture
local blazins = {}

--mouseover healing Immerseus - Contaminated Puddle
function blazins.mouseover()
 if UnitExists("mouseover") and not UnitIsPlayer("mouseover") then
   local npcid = tonumber(UnitGUID("mouseover"):sub(6,10), 16) 				
   if npcid == 71604 then 
	 return true 
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

function blazins.bossCheck()
  if UnitExists("boss1") then
    local npcId = tonumber(UnitGUID("boss1"):sub(6,10), 16)
    if npcId == 71454 then
      return true 
	end
  end
end

function blazins.stopCast(unit)
  if UnitBuff("player", 31821) then return false end -- Devo
  if not unit then unit = "boss1" end
  local spell, _, _, _, _, endTime = UnitCastingInfo(unit)
  local stop = false
  if spell == GetSpellInfo(138763) then stop = true end -- Dark Animus
  if spell == GetSpellInfo(137457) then stop = true end -- Oondasta
  if spell == GetSpellInfo(143343) then stop = true end -- Thok
  if stop then
    if UnitCastingInfo("player") or UnitChannelInfo("player") then
	 local CastFinish = endTime / 1000 - GetTime()
     if CastFinish <= .25 then
       return true
     end
	end
  end
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
