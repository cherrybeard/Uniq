//
//  AttackAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 22/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class AttackAnimation: Animation {
    let duration:TimeInterval = 0.2
    
    var attacking: CreatureSprite
    var defending: CreatureSprite
    
    init(attacking: CreatureSprite, defending: CreatureSprite) {
        self.attacking = attacking
        self.defending = defending
    }
    
    override func play() {
        state = AnimationState.inProgress
        let initPos = attacking.position
        let defPos = defending.position
        let targetX = Int( (defPos.x - initPos.x) / 2 + initPos.x )
        let targetY = Int( (defPos.y - initPos.y) / 2 + initPos.y )
        let targetPos = CGPoint(x: targetX, y: targetY)
        
        let moveTo = SKAction.move(to: targetPos, duration: duration)
        moveTo.timingMode = .easeOut
        
        let moveBack = SKAction.sequence([
            SKAction.move(to: initPos, duration: duration),
            SKAction.wait(forDuration: 0.1)
        ])
        moveBack.timingMode = .easeOut
        
        attacking.run(moveTo, completion: {
            self.defending.showDamage(damage: self.attacking.creature.attack)
            self.attacking.showDamage(damage: self.defending.creature.attack)
            
            self.attacking.run(moveBack, completion: {
//                let fadeOut = SKAction.fadeOut(withDuration: self.duration)
//                if self.attacking.health <= 0 { self.attacking.run(fadeOut) }
//                if self.defending.health <= 0 { self.defending.run(fadeOut) }
                
                self.state = AnimationState.finished
            })
        })
    }
}
