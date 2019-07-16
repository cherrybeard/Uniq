//
//  BlessingAbility.swift
//  Uniq
//
//  Created by Steven Gusev on 16/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class BlessingAbility: ActiveAbility {
    init(healPercentage: Double) {
        super.init(
            name: "Blessing",
            description: "Heal target ally for 30% of their HP, rounded down.",
            cooldown: 1,
            effect: { (battle: Battle, target: Character?) in
                //battle.dealDamage(target)
            }
        )
    }
}
