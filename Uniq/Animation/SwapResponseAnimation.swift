//
//  SwapResponseAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 16/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class SwapResponseAnimation: Animation {
    private let creature: CreatureSprite
    private let position: CGPoint
    private var action: SKAction {
        let action = SKAction.move(to: position, duration: 0.3)
        action.timingMode = .easeIn
        return action
    }
    
    init(creature: CreatureSprite, spot: Spot) {
        self.creature = creature
        self.position = spot.position
    }
    
    override func play() {
        creature.run(action)
        state = .finished
    }
}
