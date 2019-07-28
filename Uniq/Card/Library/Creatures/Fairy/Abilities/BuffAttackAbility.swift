//
//  BuffAttackAbility.swift
//  Uniq
//
//  Created by Steven Gusev on 10/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class BuffAttackAbility: ActiveAbility {
    
    init(amount: Int) {
        super.init(
            name: "Buff attack",
            description: "Buff attack by 3.",
            cooldown: Cooldown(2, immediatelyReady: false),
            effect: { (battle: Battle, creature: Creature, target: Character?) in
                //battle.dealDamage(target)
            }
        )
    }
}
