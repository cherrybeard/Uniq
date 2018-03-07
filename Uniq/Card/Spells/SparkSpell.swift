//
//  SeeingLightSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 07/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import Foundation

class SparkSpell: Card {
    init() {
        super.init(cost: 1)
        description = "Deal 2 damage. Draw 1 card"
        requiresTarget = true
        targetFilter = CardTargetFilters.all
    }
    
    override func play(battle: Battle, for owner: OwnerType, target: CreatureSprite? = nil) {
        if let creature = target {
            creature.dealDamage(2)
        }
        battle.player.drawCard()
    }
}
