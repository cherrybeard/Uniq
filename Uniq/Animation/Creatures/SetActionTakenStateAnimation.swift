//
//  SetActionTakenStateAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 26/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class SetActionTakenStateAnimation: Animation {
    private let creature: CreatureSprite
    private let toTaken: Bool
    
    init(creature: CreatureSprite, toTaken: Bool) {
        self.creature = creature
        self.toTaken = toTaken
    }
    
    override func play() {
        creature.attackLabel.isDimmed = toTaken
        if toTaken {    // TODO: Modify AbilityLabel to isDimmed
            creature.abilityLabel.disable()
        } else {
            creature.abilityLabel.enable()
        }
        state = .finished
    }
}
