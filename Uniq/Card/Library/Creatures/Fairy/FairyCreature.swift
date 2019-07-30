//
//  FairyCreature.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class FairyCreature: CreatureCard {
    init() {
        super.init(name: "Fairy", attack: 3, health: 4)
        hasRush = true
        power = 1
        abilities += [
            AttackAbility(multiplier: 1),
            DefendAbility(armor: 2),
            BuffAttackAbility(amount: 2)
        ]
    }
}
