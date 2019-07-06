//
//  FairyCreature.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class FairyCreature: CreatureCard {
    init() {
        super.init(name: "Fairy", attack: 0, health: 4)
        hasRush = true
        power = 1
    }
}
