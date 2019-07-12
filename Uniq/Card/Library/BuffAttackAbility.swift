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
            description: "Buffs attack by 3",
            cooldown: 1,
            effect: { (battle: Battle, target: Character?) in
                //battle.dealDamage(target)
            }
        )
    }
}
