//
//  AttackAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 22/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class AttackAnimation: Animation {
    private var creature: CreatureSprite
    private var targetYPos: CGFloat
    private var targetXPos: CGFloat
    
    private var hitTarget: SKAction {
        let xSign = Int(creature.position.x - targetXPos).signum()
        let hitX = targetXPos + CGFloat( (CreatureSprite.width - 6) * xSign )
        
        let ySign = Int(creature.position.y - targetYPos).signum()
        let hitY = targetYPos + CGFloat( (CreatureSprite.height - 6) * ySign )
        
        let scaleUp = SKAction.scale(to: 1.15, duration: 0.2)
        let scaleBack = SKAction.scale(to: 1, duration: 0.1)
        let move = SKAction.move(
            to: CGPoint(x: hitX, y: hitY),
            duration: 0.1
        )
        move.timingMode = .easeOut
        let moveAndScale = SKAction.group([scaleBack, move])
        
        return SKAction.sequence([scaleUp, moveAndScale])
    }
    /*
    // TODO: Move to separate Animation?
    private var shakeTarget: SKAction {
        let targetYPos = target.position.y
        let impulseY = targetYPos - 6 * (targetYPos < 0 ? 1 : -1)
        let move = SKAction.moveTo(y: impulseY, duration: 0.05)
        move.timingMode = .easeOut
        let moveBack = SKAction.moveTo(y: targetYPos, duration: 0.1)
        moveBack.timingMode = .easeOut
        
        return SKAction.sequence([move, moveBack])
    }*/
    
    init(creature: CreatureSprite, target: CreatureSprite) {
        self.creature = creature
        targetYPos = target.position.y
        targetXPos = target.position.x
    }
    
    override func play() {
        creature.zPosition = 1
        creature.run(hitTarget) {
            self.state = .finished
            //self.target.run(shakeTarget)
        }
    }
    
}
