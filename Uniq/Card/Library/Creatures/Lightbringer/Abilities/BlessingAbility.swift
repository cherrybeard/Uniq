//
//  BlessingAbility.swift
//  Uniq
//
//  Created by Steven Gusev on 16/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class BlessingAbility: ActiveAbilityEffect {
    init(healPercentage: Double) {
        super.init(
            name: "Blessing",
            cooldown: 2,
            //immediatelyReady: false,
            targetFilter: { $0.sprite?.state.contains(.selected) ?? false }
        )
    }
    
    override func effect(battle: Battle, caster: Creature, target: Character) {
        guard let allies = caster.owner?.formation.characters else { return }
        for ally in allies {
            battle.heal(percentage: 0.3, to: ally)
        }
    }
    
    override func description(caster: Creature) -> String {
        return "Heal target ally for 30% of their HP, rounded down."
    }
}
