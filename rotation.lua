-- ProbablyEngine Rotation Packager
-- Custom Discipline Priest Rotation
-- Created on Nov 14th 2013 8:58 pm

ProbablyEngine.library.register('coreHealing', {
  needsHealing = function(percent, count)
    return ProbablyEngine.raid.needsHealing(tonumber(percent)) >= count
  end,
  needsDispelled = function(spell)
    for unit,_ in pairs(ProbablyEngine.raid.roster) do
      if UnitDebuff(unit, spell) then
        ProbablyEngine.dsl.parsedTarget = unit
        return true
      end
    end
  end,
})

ProbablyEngine.rotation.register_custom(256, "Blazins Disc Priest", {
	
	
  -- Maintain these buffs
    { "21562", {
	  "!player.buff(21562).any",
   	  "!player.buff(588)"
	}}, -- Fortitude
    { "588", "!player.buff(588)" }, -- Inner Fire
    { "89485" }, -- Inner Focus
	{ "81700", "player.buff(81661).count = 5" },--Archangel
	{ "109964", "modifier.lshift" }, --Spirit Shell
	{ "596", {
	  "player.buff(109964)",
 	  "player.buff(109964).duration > 2.5"
	}, "lowest" }, --Prayer of Healing
	
  -- Mana/Survival
  
	{ "123040", { --Mindbender
	  "player.mana < 95",
	  "target.spell(123040).range"
	}, "target" },
	{ "34433", { --Shadowfiend
      "player.mana < 70",	  
      "target.spell(34433).range"
    }, "target" },	
	{ "129250", { -- Power Word: Solace
	  "!toggle.mouseOver",
	  "target.spell(129250).range" 
	}, "target" },
	{ "19236", { --Desperate Prayer
	  "player.health <= 20" 
	}, "Player" },
	{ "5512", "player.health <= 35" },  --healthstone
	
  --Agro
	{ "586", "target.threat >= 80" }, -- Fade
	
  --Immerseus mouseover healing
    { "!47540", { 
	  "@blazins.mouseover",
	  "mouseover.spell(47540).range"
	}, "mouseover" },  
	{ "!2061", { --Flash Heal
	  "@blazins.mouseover",
	  "mouseover.spell(2061).range"
	}, "mouseover" },
	
  --Mouse Over Healing
    { "47540", { -- Penance
	  "toggle.mouseOver",
	  "mouseover.spell(47540).range"
	}, "mouseover" },  
	{ "2061", { --Flash Heal
	  "toggle.mouseOver",
	  "mouseover.spell(2061).range"
	}, "mouseover" },
 
  --Dispel SoO 
    {"!527", {
	  "!modifier.last",
	  "player.mana > 20",
	  "player.spell(527).casted < 1",
	  "@coreHealing.needsDispelled('Shadow Word: Bane')"
	}, nil },
    { "!527", {
	  "!modifier.last",
   	  "player.debuff(146595)",
	  "player.mana > 20",
	  "@coreHealing.needsDispelled('Mark of Arrogance')" 
	}, nil },
    { "!527", {
	  "!modifier.last",
	  "player.mana > 20",
	  "@coreHealing.needsDispelled('Corrosive Blood')"
 	}, nil },
	
  --Tier6 CD's - CD's
	{ "121135", "modifier.lcontrol", "player" },  --Cascade
	{ "120517", "modifier.lcontrol", "player" }, --Halo
	{ "110744", "modifier.lcontrol", "player" }, --Divine Star
	{ "!62618", "modifier.rshift", "ground" }, --Power Word: Barrier
	{ "10060", "modifier.cooldowns" }, --Power Infusion
	{ "!32375", "modifier.rcontrol", "ground" }, --Mass Dispel
	{ "!48045", "modifier.ralt", "target" }, -- Mind Sear
	{ "33206", {
	  "toggle.painSup",
	  "lowest.health <= 25 ", 
  	  "lowest.spell(33206).range"
	}, "lowest" },  --Pain Suppression
	
	 -- stop casting Thok Deafening Screech
    { "/stopcasting", "@blazins.stopCast(boss1)" },
	
	{ "596", { --Prayer of Healing
	  "!player.moving",
	  "modifier.lalt",
	  "lowest.spell(596).range"
	}, "lowest" },
	
	-- MALKOROK ROTATION
    {{
	
    -- Tank
      { "17", { --Power Word: Shield
	    "@blazins.checkRapture",
        "!tank.debuff(6788).any",
	    "!tank.buff(17).any",
	    "tank.spell(17).range"
	  }, "tank" },
	  { "33076", { --Prayer of Mending
	    "tank.health <= 95",
	    "tank.spell(33076).range"
	  }, "tank" },
	  
	-- Raid Healing
	{ "596", { --Prayer of Healing /Lucidity proc
	    "!player.moving",
		"player.buff(137323)",
	    "lowest.spell(596).range"
	  }, "lowest" },
	  { "47540", { --Penance
	    "lowest.spell(47540).range"
	  }, "lowest" },
	  { "596", { --Prayer of Healing
	    "!player.moving",
	    "lowest.spell(596).range"
	  }, "lowest" },
	  
	--Attonement   
	  { "14914", { --Holy Fire
	    "!toggle.mouseOver",
	    "player.mana > 20",
		"player.buff(81661).count < 5",
	    "target.spell(14914).range" 
	  }, "target" },
	  { "47540", { --Penance
	    "player.mana > 20",
		"player.buff(81661).count < 5",
	    "target.spell(47540).range"
	  }, "target"},
 	  { "585", { --Smite
	    "player.mana > 20",
	    "!player.moving",
		"player.buff(81661).count < 5",
	    "target.spell(585).range"
	  }, "target" },  

	  { "/targetenemy [noexists]", "!target.exists" },
	  { "/focus [@targettarget]" },
	  { "/target [target=focustarget, harm, nodead]", "target.range > 40" },
	  
	}, "@blazins.bossCheck()" },
	
	-- MAIN ROTATION
  
  -- Tank
    { "17", { --Power Word: Shield
	  "@blazins.checkRapture",
      "!tank.debuff(6788).any",
	  "!tank.buff(17).any",
	  "tank.spell(17).range"
	}, "tank" },
    { "108968", { --Void Shift
	  "!tank.player",
	  "player.health >= 75",
	  "tank.health <= 30",
	  "tank.spell(108968).range"
	}, "tank" },
	{ "32546", { --Binding Heal
	  "!tank.player",
	  "tank.health <= 40",
	  "player.health <= 60",
	  "tank.spell(32546).range"
	}, "tank" },
    { "2061", { --Flash Heal
	  "!player.moving",
	  "tank.health <= 40",
	  "target.spell(2061).range"
	}, "tank" },
	{ "139", { --Renew
	  "!tank.buff(139)",
	  "tank.debuff(6788).any",
	  "!player.spell(33076).cooldown", 
	  "tank.health < 100",
	  "tank.spell(139).range"
	}, "tank" },
	{ "33076", { --Prayer of Mending
	  "tank.health <= 95",
	  "tank.spell(33076).range"
	}, "tank" },
	
    
  -- Raid Healing
    { "!596", { --Prayer of Healing /Lucidity proc
	    "!modifier.last",
	    "!player.moving",
		"player.buff(137323)",
	    "lowest.spell(596).range"
	  }, "lowest" },
	{ "2050", { -- Heal
	  "lowest.health <= 65",
	  "player.mana <= 20",
	  "lowest.spell(2050).range"
	}, "lowest" },
    { "2061", { --Flash Heal
	  "!player.moving",
	  "lowest.health <= 20",
	  "lowest.spell(2061).range"
	}, "lowest" },
	{ "17", { --Power Word: Shield
	  "!lowest.debuff(6788).any", --Weakend Soul
	  "!lowest.buff(17).any",
	  "lowest.health <= 30",
	  "lowest.spell(17).range"
	}, "lowest" },
	{ "2060", { --Greater Healing
	  "!player.moving",
	  "lowest.health <= 50",
	  "lowest.spell(2060).range"
	}, "lowest" },
	{ "47540", { --Penance
	  "lowest.health <= 75",
	  "lowest.spell(47540).range"
	}, "lowest" },
    --Attonement    
	{ "14914", { --Holy Fire
	  "!toggle.mouseOver",
	  "player.mana > 20",
	  "target.spell(14914).range" 
	}, "target" },
	{ "47540", { --Penance
	  "player.mana > 20",
	  "target.spell(47540).range"
	}, "target"},
 	{ "585", { --Smite
	  "player.mana > 20",
	  "!player.moving",
	  "target.spell(585).range"
	}, "target" },
	
	
	
	{ "/targetenemy [noexists]", "!target.exists" },
	{ "/focus [@targettarget]" },
	{ "/target [target=focustarget, harm, nodead]", "target.range > 40" },
	 
  
	
},{
  --Out of combat
    { "47540", {
	  "toggle.mouseOver",
   	  "mouseover.spell(47540).range"
	}, "mouseover" },  --Penance
	{ "2061", {
	  "toggle.mouseOver",
  	  "mouseover.spell(2061).range"
	}, "mouseover" },  --Flash Heal
    { "21562", {
	  "!player.buff(21562).any",
   	  "!player.buff(588)"
	}}, -- Fortitude
    { "588", "!player.buff(588)" }, --Inner Fire
	{ "47540", {
	  "lowest.health <= 85", 
	  "lowest.spell(47540).range"
	}, "lowest" }, --Penance
	{ "2061", { --Flash Heal
	  "!player.moving",
	  "lowest.health <= 75",
	  "lowest.spell(2061).range"
	}, "lowest" },
	{ "596", { --Prayer of Healing
	  "!player.moving",
	  "@coreHealing.needsHealing(90, 4)",
	  "lowest.spell(596).range"
	}, "lowest" },
},function()
ProbablyEngine.toggle.create(
    'painSup',
    'Interface\\Icons\\Spell_holy_painsupression.png',
    'Pain Suppression',
    'Toggle Enables Pain Suppression')
ProbablyEngine.toggle.create(
    'mouseOver',
    'Interface\\Icons\\Priest_spell_leapoffaith_a',
    'MouseOver Heal',
    'Toggle Mouse-Over Healing')
end)


ProbablyEngine.rotation.register_custom(256, "Blazins Disc Solo", {	

  --Buffs
	{ "21562", "!player.buff(21562).any" }, --Fortitude
    { "588", "!player.buff(588)" }, --Inner Fire
	{ "81700", "player.buff(81661).count = 5" },  --Archangel 
	
	--Tier6 CD's
	{ "121135", "modifier.lcontrol", "player" }, --Cascade
	{ "120517", "modifier.lcontrol", "player" }, --Halo
	{ "110744", "modifier.lcontrol", "player" }, --Divine Star
	{ "10060", "modifier.cooldowns" },
	
  --Dispel
    { "527", "player.dispellable(527)", "player" }, --Purify
	{ "527", "@coreHealing.needsDispelled('Aqua Bomb')" },
	
  -- Mana
	{ "123040", { --Mindbender
	  "player.mana < 95",
	  "target.spell(123040).range"
	}, "target" },
	{ "34433", { --Shadowfiend
      "player.mana < 95",  
      "target.spell(34433).range" 
    }, "target" },	
	
  --DPS
    { "17", { --Power Word Shield
      "!player.debuff(6788).any",
	  "!player.buff(17).any",
	  "player.health <= 60"
	}},
	{ "2061", "player.health <= 35", "Player" }, --Flash Heal
	{ "589", { --Shadow Word:Pain
	  "target.debuff(589).duration < 2",
	  "target.spell(589).range"
	}, "target" },
	{ "129250", { -- Power Word: Solace
	  "target.spell(129250).range" 
	}, "target" },
	{ "14914", { --Holy Fire
	  "target.spell(14914).range" 
	}, "target" },
	{ "47540", "target.spell(47540).range", "target" }, --Penance 
	{ "585", "target.spell(585).range", "target" },	--Smite
	{ "32379", { -- Shadow Word: Death
	  "target.health < 20",
	  "target.spell(32379).range"
	}, "target" },
	
},{
    --Out of combat buffs/heals
    { "21562", "!player.buff(21562).any" }, --Fortitude
    { "588", "!player.buff(588)" }, --Inner Focus
	{ "47540", "player.health < 100" }, --Penance   
	
})