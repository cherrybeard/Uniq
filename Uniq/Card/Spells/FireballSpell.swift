//
//  FireballSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 07/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class FireballSpell: SpellCard {
    init() {
        super.init(cost: 4)
        description = "Deal 6 damage"
        requiresTarget = true
    }
    
    override func play(battle: Battle, for owner: OwnerType, target: CharacterSprite? = nil) {
        if let creature = target {
            creature.dealDamage(6, battle: battle)
        }
    }
}
