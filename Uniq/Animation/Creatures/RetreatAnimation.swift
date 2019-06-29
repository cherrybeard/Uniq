//
//  RetreatAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 16/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class RetreatAnimation: Animation {
    private let creature: CreatureSprite
    private let position: CGPoint
    private var action: SKAction {
        let pause = SKAction.wait(forDuration: 0.1)
        let moveBack = SKAction.move(to: position, duration: 0.5)
        moveBack.timingMode = .easeOut
        return SKAction.sequence([pause, moveBack])
    }
    
    init(creature: CreatureSprite, spot: Spot) {
        self.creature = creature
        position = spot.position
    }
    
    override func play() {
        creature.run(action) {
            self.creature.zPosition = 0
            self.state = .finished
        }
    }
}
