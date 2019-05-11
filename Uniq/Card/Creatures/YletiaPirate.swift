//
//  YletiaPirate.swift
//  Uniq
//
//  Created by Steven Gusev on 10/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import Foundation

class YletiaPirate: CreatureCard {
    init() {
        super.init(cost: 5, attack: 1, health: 4)
        description = "Yletia Pirate"
        hasActiveAbility = true
    }
    
    override func useActiveAbility(battle: Battle) {
        summon?.increaseAttack(by: 3)
    }
}
