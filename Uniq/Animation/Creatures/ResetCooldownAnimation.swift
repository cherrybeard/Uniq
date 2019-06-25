//
//  ResetCooldownAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 26/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class ResetCooldownAnimation: Animation {
    private let creature: CreatureSprite
    
    init(creature: CreatureSprite) {
        self.creature = creature
    }
    
    override func play() {
        creature.abilityLabel.resetCooldown()
        state = .finished
    }
}
