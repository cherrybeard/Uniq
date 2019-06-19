//
//  CreatureSwapAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 19/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class CreatureSwapAnimation: Animation {
    private var sourceSpot: Spot
    private var targetSpot: Spot
    
    init(sourceSpot: Spot, targetSpot: Spot) {
        self.sourceSpot = sourceSpot
        self.targetSpot = targetSpot
    }
    
    override func play() {
        // Running actions for the second, optional creature
        if let sourceCreature = sourceSpot.creature?.sprite {
            sourceCreature.run(
                moveToSource(position: sourceSpot.position)
            )
        }
        
        // Running actions for the first creature
        if let targetCreature = targetSpot.creature?.sprite {
            targetCreature.zPosition = 1
            targetCreature.run(
                moveToTarget(position: targetSpot.position)
            ) {
                targetCreature.zPosition = 0
                self.state = .finished
            }
        }
        self.state = .finished
    }
    
    private func moveToTarget(position: CGPoint) -> SKAction {
        let scaleIn = SKAction.scale(to: 1.2, duration: 0.1)
        let wait = SKAction.wait(forDuration: 0.1)
        let scaleOut = SKAction.scale(to: 1, duration: 0.1)
        let scale = SKAction.sequence([scaleIn, wait, scaleOut])
        let move = SKAction.move(to: position, duration: 0.3)
        move.timingMode = .easeIn
        return SKAction.group([move, scale])
    }
    
    private func moveToSource(position: CGPoint) -> SKAction {
        let action = SKAction.move(to: sourceSpot.position, duration: 0.3)
        action.timingMode = .easeIn
        return action
    }
}
