//
//  DefendAbility.swift
//  Uniq
//
//  Created by Steven Gusev on 10/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class DefendAbility: ActiveAbilityEffect {
    
    init(armor: Int) {
        super.init(
            name: "Defend",
            cooldown: 1,
            targetFilter: { $0.sprite?.state.contains(.selected) ?? false }
        )
    }
    
    override func description(caster: Creature) -> String {
        return "Gain 3 armor."
    }
    
    override func effect(battle: Battle, caster: Creature, target: Character) {
        battle.giveArmor(3, to: caster)
    }
}
