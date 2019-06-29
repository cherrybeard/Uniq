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
    private var target: CreatureSprite
    private var targetPosX: CGFloat { return target.position.x }
    private var targetPosY: CGFloat { return target.position.y }
    
    private var hitTarget: SKAction {
        let xSign = Int(creature.position.x - targetPosX).signum()
        let hitX = targetPosX + CGFloat( (CreatureSprite.width - 6) * xSign )
        
        let ySign = Int(creature.position.y - targetPosY).signum()
        let hitY = targetPosY + CGFloat( (CreatureSprite.height - 6) * ySign )
        
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
    
    private var shakeTarget: SKAction {
        let xSign = Int(creature.position.x - targetPosX).signum()
        let impulseX = targetPosX + CGFloat( -6 * xSign )
        
        let ySign = Int(creature.position.y - targetPosY).signum()
        let impulseY = targetPosY + CGFloat( -6 * ySign )
        
        let move = SKAction.move(to: CGPoint(x: impulseX, y: impulseY), duration: 0.05)
        let resetRotation = SKAction.rotate(toAngle: 0, duration: 0.05)
        let response = SKAction.group([move, resetRotation])
        response.timingMode = .easeOut
        
        
        let randomRotation = CGFloat.random(in: -3...3) / 180 * .pi
        let moveBack = SKAction.move(to: target.position, duration: 0.1)
        let rotate = SKAction.rotate(toAngle: randomRotation, duration: 0.1)
        let restore = SKAction.group([moveBack, rotate])
        restore.timingMode = .easeOut
        
        return SKAction.sequence([response, restore])
    }
    
    init(creature: CreatureSprite, target: CreatureSprite) {
        self.creature = creature
        self.target = target
    }
    
    override func play() {
        creature.zPosition = 1
        creature.run(hitTarget) {
            self.state = .finished
            self.target.run(self.shakeTarget)
        }
    }
    
}
