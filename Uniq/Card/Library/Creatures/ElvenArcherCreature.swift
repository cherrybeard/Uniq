//
//  ElvenArcherCreature.swift
//  Uniq
//
//  Created by Steven Gusev on 01/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class ElvenArcherCreature: CreatureCard {
    init() {
        super.init(name: "Elven Archer", attack: 2, health: 5)
        whenSummoned = SwiftShotAbility()
        power = 3
    }
}
