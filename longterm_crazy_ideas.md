- deeper spell system
  * less spells, but with more ways to modify / cast them:
  * blank scrolls allow spells to be woven into them, and used once (without the normal mp cost)
  * blank wands allows the same
  * can combine multiple schools into a single spell
  * general enhancers (each increases cost and fail rate 1.5x)
    * : reduce time to cast spell (4 turns, 3, 2, 1)
    * : concentration (100% of original failure chance, 50% of original, 25% of original, 12% of original)
    * : boost spell power (make it harder to resist, and/or do more damage)
    * : quieter spell (loud chanting, 1/2 loudness, 1/4 loudness, silent (can work when silenced))
    * : less motion spell (full impact encumberance, 1/2, 1/4, 1/8)
    * : target distance from caster (hand=1, 2, 4, 8)
    * : increase target precision (radius 4, 3, 2, 1, 0)
    * : exclude enemies
    * : exclude friends
    * : exclude self
    * : exclude empty floor
    * : exclude solid objects
    * : increase target area as square (radius 0, 1, 2, 3)
    * : increase target area as line (spread 0, 2, 4, 8)
    * : increase target penetration (normal vision, expanded vision (+3), see invisible, xray)
    * : energy channel (from self, from guardian, from environment, from adjacent friend, from distant friend, from adjacent enemy, from distant enemy)
    * : increase duration of effect (1 turn, 3 turn, 7 turn, 15 turn)
    * : multiply effect (1x, 3x, 7x, 15x)
  * examples
    * flame
      * base effect: random target, self range, delayed 4 turns, one time, full failure chance
        * ddd: duration (2-4, 3-6, 5-10)
        * ss: control subject (direction, exact)
        * e: apply only to enemies
        * fff: reduce failure (1/2, 1/4, 1/8)
    * blink (translocation)
      * base effect: random source+target position and range, domain+source+target=self range, delayed 4 turns, one time
      * base cost: 1 
      * enhancers: (each will double cost of the spell)
        * ggg: subject group size (one other, 2-4, all)
        * rrr: target range (to whole floor, whole branch, whole game)
        * ppp: boost power (making it harder to resist)
        * cc: faster casting (2 turns, 1 turn)
        * lll: (loop) repeat blink over following turns (3-6 turns, 5-10 turns, 8-16 turns, executing each turn)
        * tt: control target (direction, exact placement)
        * ss: control subject (direction, exact)
        * e: apply only to enemies
        * E: exclude enemies
        * f: apply only to friendlies
        * F: exclude friendlies
        * s: apply only to self
        * S: exclude self
    * transform
      * base effect: apply to self, random level 1 transform, delayed (2-4 turns), temporary, duration = 5-10 turns
      * base cost: 1
      * enhancers: (each will double cost of the spell)
        * aaa: apply to others (one other, 2-4, all)
        * pppp: boost power (upgrading form)
        * i: immediate (instead of delayed)
        * ddd: duration (8-16 turns, 13-26 turns, 21-42 turns)
        * ss: control subject (direction, exact)
        * e: apply only to enemies
        * f: apply only to friendlies
        * g: only good forms (beastly appendage/bat/fur (rIce+, ac+), spider/ice beast/blade, statue/hydra/necro, ice dragon/fire dragon/gold dragon)
        * b: only bad forms (disarm, frog/pig)
        * vvv: specific variation
    * summon

