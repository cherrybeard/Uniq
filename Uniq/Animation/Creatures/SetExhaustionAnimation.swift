//
//  SetExhaustionAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 26/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class SetExhaustionAnimation: Animation {
    private let creature: CreatureSprite
    private let exhausted: Bool
    
    init(creature: CreatureSprite, to exhausted: Bool) {
        self.creature = creature
        self.exhausted = exhausted
    }
    
    override func play() {
        creature.isExhausted = exhausted
        state = .finished
    }
}
