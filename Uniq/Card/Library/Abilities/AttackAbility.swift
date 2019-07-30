//
//  AttackAbility.swift
//  Uniq
//
//  Created by Steven Gusev on 10/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class AttackAbility: ActiveAbilityEffect {
    let multiplier: Float
    
    init(name: String = "Attack", multiplier: Float) {
        self.multiplier = multiplier
        super.init(
            name: name,
            cooldown: 1,
            targetFilter: CharacterFilters.enemy
        )
    }
    
    private func damage(caster: Creature) -> Int {
        let attack = caster.attack
        return Int(Float(attack) * multiplier)
    }
    
    override func effect(battle: Battle, caster: Creature, target: Character) {
        let dmg = damage(caster: caster)
        battle.dealDamage(dmg, to: target)
    }
    
    override func description(caster: Creature) -> String {
        let dmg = damage(caster: caster)
        return "Melee attack: \(dmg) damage to single enemy."
    }
    
}
