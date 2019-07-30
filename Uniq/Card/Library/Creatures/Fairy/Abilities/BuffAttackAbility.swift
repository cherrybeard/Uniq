//
//  BuffAttackAbility.swift
//  Uniq
//
//  Created by Steven Gusev on 10/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class BuffAttackAbility: ActiveAbilityEffect {
    let buff: Int
    
    init(amount: Int) {
        self.buff = amount
        super.init(
            name: "Buff attack",
            cooldown: 2,
            //immediatelyReady: false,
            targetFilter: { $0.sprite?.state.contains(.selected) ?? false }
        )
    }
    
    override func description(caster: Creature) -> String {
        return "Buff attack by \(buff)."
    }
    
    override func effect(battle: Battle, caster: Creature, target: Character) {
        battle.buffAttack(of: caster, by: buff)
    }
}
