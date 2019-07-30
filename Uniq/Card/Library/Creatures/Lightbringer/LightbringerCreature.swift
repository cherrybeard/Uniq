//
//  LightbringerCreature.swift
//  Uniq
//
//  Created by Steven Gusev on 16/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class LightbringerCreature: CreatureCard {
    init() {
        super.init(name: "Lightbringer", attack: 4, health: 24)
        hasRush = true
        power = 4
        abilities += [
            AttackAbility(name: "Mace blow", multiplier: 1),
            ShieldAlliesAbility(armor: 2),
            BlessingAbility(healPercentage: 0.3)
        ]
    }
}
