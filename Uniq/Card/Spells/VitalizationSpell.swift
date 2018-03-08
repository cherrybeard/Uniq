//
//  VitalizationSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 07/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class VitalizationSpell: Card {
    init() {
        super.init(cost: 2)
        description = "Double creature's health"
        requiresTarget = true
        targetFilter = CardTargetFilters.creatures
    }
    
    override func play(battle: Battle, for owner: OwnerType, target: CharacterSprite? = nil) {
        if let creature = target {
            creature.increaseHealth(by: creature.health)
        }
    }
}
