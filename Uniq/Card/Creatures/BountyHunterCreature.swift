//
//  BountyHunterCreature.swift
//  Uniq
//
//  Created by Steven Gusev on 09/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class BountyHunterCreature: CreatureCard {
    init() {
        super.init(cost: 3, attack: 3, health: 2)
        description = "Fast, but not very smart."
    }
    
    override func play(battle: Battle, for owner: OwnerType, target: CharacterSprite? = nil) {
        if let creature = target {
            creature.increaseHealth(by: creature.health)
        }
    }
    
    override func battlecry(battle: Battle, creature: CreatureSprite) {
        
    }
}
