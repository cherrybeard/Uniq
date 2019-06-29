//
//  CooldownDecreaseAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 20/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class DecreaseCooldownAnimation: Animation {
    private let label: AbilityLabel
    
    init(creature: CreatureSprite) {
        label = creature.abilityLabel
    }
    
    override func play() {
        label.decreaseCooldown()
        state = .finished
    }
}
