//
//  ReplaceAbilityAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class ReplaceAbilityAnimation: Animation {
    private let creature: CreatureSprite
    private let cooldown: Int
    
    init(creature: CreatureSprite, ability: ActiveAbility?) {
        self.creature = creature
        if ability != nil {
            cooldown = ability!.cooldown
        } else {
            cooldown = -1
        }
    }
    
    override func play() {
        creature.abilityLabel.cooldown = cooldown
        creature.abilityLabel.resetCooldown()
        state = .finished
    }
}

