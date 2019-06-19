//
//  SwapAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 17/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class SwapAnimation: Animation {
    private var creature: CreatureSprite
    private var position: CGPoint
    
    private var action: SKAction {
        let scaleIn = SKAction.scale(to: 1.2, duration: 0.1)
        let wait = SKAction.wait(forDuration: 0.1)
        let scaleOut = SKAction.scale(to: 1, duration: 0.1)
        let scale = SKAction.sequence([scaleIn, wait, scaleOut])
        let move = SKAction.move(to: position, duration: 0.3)
        move.timingMode = .easeIn
        return SKAction.group([move, scale])
    }
    
    init(creature: CreatureSprite, spot: Spot) {
        self.creature = creature
        position = spot.position
    }
    
    override func play() {
        creature.zPosition = 1
        creature.run(action) {
            self.creature.zPosition = 0
            self.state = .finished
        }
    }
    
}
