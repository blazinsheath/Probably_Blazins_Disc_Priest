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
    { "21562", "!player.buff(21562)" }, -- Fortitude
    { "588", "!player.buff(588)" }, -- Inner Fire
    { "89485" }, -- Inner Focus
	{ "81700", {
	  "player.spell(81700).exists",
	  "player.buff(81661).count = 5"	  --Archangel
	}},
	{"109964", "modifier.lshift" }, --Spirit Shell
	{ "596", "player.spell(109964).cooldown >= 50", "lowest" }, --Prayer of Healing
	
  -- Mana/Survival
  
	{ "123040", { --Mindbender
	  "player.spell(123040).exists",
	  "player.mana < 95",
	  "target.range < 41"
	}, "target" },
	{ "34433", { --Shadowfiend
	  "player.spell(34433).exists",	
      "player.mana < 95",	  
      "target.range < 41"
    }, "target" },	
	{ "14914", { -- Power Word: Solace
	  "!toggle.mouseOver",
	  "player.spell(129250).cooldown < .001",
	  "target.range < 31" 
	}, "target" },
	{ "19236", { --Desperate Prayer
	  "player.health <= 20" 
	}, "Player" },
	
  --Agro
	{ "586", "target.threat >= 80" }, -- Fade
	
  --Mouse Over Healing
    { "47540", { -- Penance
	  "toggle.mouseOver",
	}, "mouseover" },  
	{ "2061", { --Flash Heal
	  "toggle.mouseOver",
	}, "mouseover" },
 
  --Dispel SoO 
    { "527", {
   	  "player.buff(Gift of the Titans)",
	  "player.mana > 20",
	  "@coreHealing.needsDispelled('Mark of Arrogance')" 
	}, nil },
    { "527", {
	  "player.mana > 20",
	  "@coreHealing.needsDispelled('Shadow Word: Bane')"
	}, nil },
    { "527", {
	  "player.mana > 20",
	  "@coreHealing.needsDispelled('Corrosive Blood')"
 	}, nil },
	
  --Tier6 CD's
	{ "121135", {
	  "player.spell(121135).exists",
	  "modifier.lcontrol"
	}, "player" },  --Cascade
	{ "120517", {
  	  "player.spell(120517).exists",
	  "modifier.lcontrol"
	}, "player" }, --Halo
	{ "110744", {
	  "player.spell(110744).exists",
	  "modifier.lcontrol"
	}, "player" }, --Divine Star
	
  -- Tank
    { "17", { --Power Word: Shield
	  "!tank.buff(17).any",
      "!tank.debuff(6788).any",
	  "tank.health <= 100",
	  "tank.range < 41"
	}, "tank" },
	{ "2061", { --Flash Heal
	  "!player.moving",
	  "tank.health <= 30",
	  "target.range < 41"
	}, "tank" },
	{ "33076", { --Prayer of Mending
	  "tank.health <= 95",
	  "tank.range < 41"
	}, "tank" },
	{ "139", { --Renew
	  "!tank.buff(139)", 
	  "tank.health < 90",
	  "tank.range < 41"
	}, "tank" },
	{ "108968", { --Void Shift
	  "player.health >= 80",
	  "tank.health <= 25",
	  "tank.range < 41"
	}, "tank" },
	
  -- Raid Healing
    { "596", { --Prayer of Healing
	  "!player.moving",
	  "@coreHealing.needsHealing(80, 4)",
	  "lowest.range < 41"
	}, "lowest" },
	{ "47540", { --Penance
	  "lowest.health <= 70",
	  "lowest.range < 41"
	}, "lowest" },
	{ "17", { --Power Word: Shield
	  "!lowest.debuff(6788)", --Weakend Soul
	  "lowest.health <= 50",
	  "lowest.range < 41"
	}, "lowest" },
	{ "2060", { --Greater Healing
	  "!player.moving",
	  "lowest.health <= 60",
	  "lowest.range < 41"
	}, "lowest"},
	{ "2061", { --Flash Heal
	  "!player.moving",
	  "lowest.health <= 20",
	  "lowest.range < 41"
	}, "lowest" },
	{ "32546", { --Binding Heal
	  "!player.moving",
	  "lowest.health <= 40",
	  "lowest.range < 41"
	}, "lowest"},
	{ "32546", { --Binding Heal
	  "!player.moving",
	  "player.health <= 70",
	  "lowest.range < 41"
	}, "lowest" },  
	{ "139", { --Renew
	  "!lowest.buff(139)", 
	  "lowest.health <= 50",
	  "lowest.range < 41"
	}, "lowest"},
	{ "62618", "modifier.rshift", "ground" }, --Power Word: Barrier
	{ "10060", "modifier.cooldowns" }, --Power Infusion
	{ "32375", "modifier.rcontrol", "ground" }, --Mass Dispel
  
  --Attonement
    
	{ "589", { --Shadow Word Pain
	  "player.mana > 20",
	  "target.debuff(589).duration < 2",
	  "target.range < 41"
	}, "target" },
	{ "14914", { --Holy Fire
	  "!toggle.mouseOver",
	  "player.spell(129250).cooldown < .001",
	  "target.range < 31" 
	}, "target" },
	{ "47540", { --Penance
	  "player.mana > 20",
	  "target.range < 41"
	}, "target"},
 	{ "585", { --Smite
	  "player.mana > 20",
	  "!player.moving",
	  "target.range < 41"
	}, "target" },
	{ "!/target [target=focustarget, harm, nodead]", "!target.exists" },
	{ "!/target [target=focustarget, harm, nodead]", "target.range > 40" },
},{
  --Out of combat
    { "47540", "toggle.mouseOver", "mouseover" },  --Penance
	{ "2061", "toggle.mouseOver", "mouseover" },  --Flash Heal
    { "21562", "!player.buff(21562)" }, --Fortitude
    { "588", "!player.buff(588)" }, --Inner Fire
	{ "47540", {
	  "lowest.health <= 85", 
	  "lowest.range < 41"
	}, "lowest" }, --Penance
	{ "2061", { --Flash Heal
	  "!player.moving",
	  "lowest.health <= 75",
	  "lowest.range < 41"
	}, "lowest" },
	{ "596", { --Prayer of Healing
	  "!player.moving",
	  "@coreHealing.needsHealing(90, 4)",
	  "lowest.range < 41"
	}, "lowest" },
},function()
ProbablyEngine.toggle.create(
    'mouseOver',
    'Interface\\Icons\\Priest_spell_leapoffaith_a',
    'MouseOver Heal',
    'Toggle Mouse-Over Healing')
end)

ProbablyEngine.rotation.register_custom(256, "Blazins Disc Solo", {	

  --Buffs
	{ "21562", "!player.buff(21562)" }, --Fortitude
    { "588", "!player.buff(588)" }, --Inner Fire
	{ "81700", {
	  "player.spell(81700).exists",
	  "player.buff(81661).count = 5" --Archangel
	}},  
	
	--Tier6 CD's
	{ "121135", {
	  "player.spell(121135).exists",
	  "modifier.lcontrol"
	}, "player" }, --Cascade
	{ "120517", {
  	  "player.spell(120517).exists",
	  "modifier.lcontrol"
	}, "player" }, --Halo
	{ "110744", {
	  "player.spell(110744).exists",
	  "modifier.lcontrol"
	}, "player" }, --Divine Star
	{ "10060", "modifier.cooldowns" },
	
  --Dispel
    { "527", "player.dispellable(527)", "player" }, --Purify
	
  -- Mana
	{ "123040", { --Mindbender
	  "player.spell(123040).exists",
	  "player.mana < 95",
	  "target.range < 41"
	}, "target" },
	{ "34433", { --Shadowfiend
	  "player.spell(34433).exists",
      "player.mana < 95",  
      "target.range < 41" 
    }, "target" },	
	
  --Attonement
    { "17", { --Power Word Shield
      "!player.debuff(6788)",
	  "player.health <= 60"
	}},
	{ "2061", "player.health <= 35", "Player" }, --Flash Heal
	{ "589", { --Shadow Word:Pain
	  "target.debuff(589).duration < 2",
	  "target.range < 41"
	}, "target" },
	{ "14914", { -- Power Word: Solace
	  "player.spell(129250).cooldown < .001",
	  "target.range < 31" 
	}, "target" },
	{ "14914", { --Holy Fire
	  "player.spell(129250).cooldown < .001",
	  "target.range < 31" 
	}, "target" },
	{ "47540", { --Penance 
	   "target.range < 41"
	}, "target" },
	{ "585", "target.range < 41", "target" },	--Smite
	
},{	
    --Out of combat buffs/heals
    { "21562", "!player.buff(21562)" }, --Fortitude
    { "588", "!player.buff(588)" }, --Inner Focus
	{ "47540", "player.health < 100" }, --Penance    

})