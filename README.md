# Dungeon Crawl Stone Soup: Spicy fork

---

Sites which currently host this fork:
  - http://crawl.ufetubus.com

This fork of DCSS is intended to be a stable and playable fork to migrate many of the circus animals fork changes to, in a way that is fully configurable. In other words, with no options set, this fork should behave exactly the same as vanilla crawl. All alterations are activated through rc file settings. This fork will regularly pull in upstream changes to keep it up to date, so whatever new features are added to vanilla crawl will come over here as well.

Feel free to create issues on github for any problems with this fork. Ideas you have that you think are in line with my goals are also welcome, or concerns you have about future plans.

I'll pull over features little by little from circus animals into this fork.

---

Current features:

## All features on: (all_spicy_features=true)
Turns on all of the below features. You can then turn off individual features by setting them to false AFTER this in the rc file. By default, all spicy feautres are off, and can either be turned on individually, or all at once with this option.

## Alternate species definitions: (spicy_species=true)
Increases the differences and unique features between species in a wide variety of ways. This is being incrementally ported from the original circus animals fork. Here is what is currently moved over:
  - felid
    - lives start at 9 and never increase.
    - can wear up to 4 rings.
    - no loss of experience on death.
    - can wear scarves and hats, but not any other armour.

## Unlimited summons: (unlimited_summons=true)
  - summoned creature cap increased to 20
  - summoning spells cost more based on how many total summons you have.
  - summon lightning spire is level 5 instead of 4.

## Multiple difficulty levels: (multiple_difficulty_levels=true)
When starting a game, the player will be asked for what difficulty level they want to play.

- difficulty levels:
  - easy:
    - monsters have 30% less health. 
    - monsters do 30% less damage.
    - monsters have 30% slower attack
    - 30% more potions are generated (a little less gold is generated to balance it out)
    - player starts with a heal wounds potion
  - standard:
    - monsters behave exactly as in vanilla crawl
  - challenge:
    - monsters have 15% more health
    - monsters do 15% more damage
    - monsters have 15% faster attack
    - 15% less potions are generated (a little more gold is generated to balance it out)
  - nightmare:
    - monsters have 30% more health
    - monsters do 30% more damage
    - monsters have 30% faster attack
    - 30% less potions are generated (a little more gold is generated to balance it out)

## Different experience sources: (different_experience_sources=true)
Instead of only getting experience from killing monsters, this option introduces several alternatives, opening up new playstyles.

- You will gain experience from killing monsters 
- You will gain experience for each new floor that you enter
  - except zigs and abyss
- You will gain experience from drinking experience potions that have a 1/3 chance of appearing on each floor, based on the floor you drink them on. In other words, saving the experience potion to drink on a lower floor will give greater experience. 
- You will gain experience from pacifying monsters (like before)

However, experience doesn't stack up like before. The amount of experience gained from any of these things are relative to the difficulty of the challenge and level of the player. It's balanced in a way that if you only focussed on killing monsters, you'd end up with about the same experience that you would in normal crawl. On the other hand, you can get a comparable level of experience just focussing on diving as deep as you can and avoiding most monsters. But if you do both, you'll not gain any additional experience. Another example: if you collect a bunch of experience potions and drink them all one after another on a deep dungeon level, your first few will give you a bunch of experience, but each following potion will rapidly diminish in how much experience it provides. Note: skill gain is scaled in the same way, but all other experience effects (drain elimination, penance, etc) are NOT scaled. As a consequence, experience potions can be used to rapidly wash away some of those experienced based negative effects, at the expense of losing the chance to get a lot more experience by drinking them at a lower level.

You are rewarded for taking extra risks. For example, killing sigmund while your character is only level 3 will give a huge boost in experience, possibly taking you up multiple levels. That may seem a bit broken at first, but keep in mind that exp you gain after that from more ordinary creatures will now be much less, since your character is at a much higher level than before, so it balances out, and yet keeps things interesting. 

You will find a potion of experience on roughly every third floor, but if you drink it on the first floor, it will give very little (if any) experience. It's far better to save them as long as possible, because the lower the floor you drink it on, the more experience it gives. 

You can set debug_exp = true if you want to see exact numbers on how exp is scaled during a game. It will show before and after scaling exp for each kill. The Exp_ratio message represents the scaling percentage. 200 for example means that you received double the normal experience. 50 would mean you received half. 

## Heal wounds potion gives full health: (heal_wounds_potion_gives_full_health=true)
Heal wounds potion always restores full health. To compensate, it is more expensive in stores (200 instead of 80) and spawns much less frequently (1/4 of the frequency). However, currently Gozag is unchanged, which makes him a bit more powerful than before. If this is a problem for people, we'll have to adjust that too. Since heal wounds potions are much less frequent, all players start with one to make early game a little less random. 

## Magic potions give full magic (magic_potion_gives_full_magic=true)
Same idea as above.

## Monster can't climb stairs: (monsters_do_not_use_stairs=true)
Enemies will never use stairs. This eliminates stairdancing tactics. It also makes tomb a bit harder in some ways. 

## Instakill protection expansion: (instakill_protection=true)
The amount of damage that can be done to a player between turns is capped, so that a player can never go from full health to dead before having a turn to respond. Different difficulty levels alter this cap: (if difficulty levels aren't enabled, it's equivalent to being on standard difficulty)

   - Easy: 20% of max health damage cap per turn. This means that it will take at least 5 turns to kill a player on easy mode, if they start at full health.
   - Standard: 40% of max health damage cap per turn. 
   - Challenge: 60% of max health damage cap per turn.
   - Nightmare: 80% of max health damage cap per turn.

Of course this makes the game easier in all game modes, so to somewhat balance this, all damage to the player is boosted 10%. 

## Inventory expansion: (inventory_expansion=true)
   - The inventory has been divided into two groups: consumables (potions and scrolls), and everything else. The 'i' command shows the weapons, armour, evokables, etc. The 'I' command shows the consumables. Each can have 52 items.
   - The drop command has been split into two also: 'd' to drop inventory items, 'D' to drop consumable items.
   - The adjust command '=' can now also be applied to the (c)onsumables.
   - Viewing spells now is mapped to 's' because of the conflict with 'I'
   - Drop last command has been moved from 'D' to 'control-D'.

## Improved shield handling: (shield_convenience=true)
   - auto unequip shields when wielding an incompatible weapon
   - swapping equipment swaps shield also (swapping between ranged attack and weapon/shield melee is easier)

## Wide spell list: (wide_spell_list=true)
   - combine both spell info screens into one detailed view that's a little wider

## Extra numbers: (extra_numbers=true)
   - adds exact numbers to a few keys areas of the game, to provide greater transparency for seasoned players. 
   - shows previous damage done by source and turn in stats region

## No spellpower cap: (no_spellpower_cap=true)
   - spell power for all spells can now reach 300

## No experience level cap: (no_exp_cap=true)
   - experience level and skill levels can now reach 99
   - experience beyond level 13 changes to a pure power curve, each level being 1.33x the exp requirement of the previous level. This makes level 27 require as much exp as before, but lower levels are a little easier to reach, and levels past 27 are much harder. 

If this is combined with different_experience_sources, then it will be hard to get much past level 27, since the experience monsters give is relative to the experience level of the player, rapidly diminishing the amount of experience players can get after level 27. Without different_experience_sources, a player can probably get well into the 30s. 

## Unlimited ammo: (unlimited_ammo=true)
   - basic ammo never runs out
   - even with nothing quivered, rocks can be thrown (even if the player isn't carrying any)
   - 100% mulch rate (ammo is never retrievable after firing)
   - branded ammo spawns in larger numbers, since they can't be recovered after firing

### Some Debugging features:

## Show monster health changes: (debug_monster_hp=true)

## Show damage to player: (debug_ouch=true)

## Show experience gains: (debug_exp=true)

### To Do:
If you have a favorite feature that you'd like implemented sooner, create an issue on github and it will probably be done faster. Of course you are always welcome to submit pull requests. The key requirement in this fork is that all changes from vanilla are activated through non-default init file options.
