//
//  ChainLightning.swift
//  Uniq
//
//  Created by Steven Gusev on 07/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class ChainLightningSpell: Card {
    init() {
        super.init(cost: 2)
        description = "Deal 1 damage to all enemy creatures"
    }
    
    override func play(battle: Battle, for owner: OwnerType, target: CreatureSprite? = nil) {
        for creature in battle.desk.creatures.filter({ creature in creature.owner != owner }) {
            creature.dealDamage(1)
        }
    }
}

