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
    
    var attacking: CharacterSprite
    var defending: CharacterSprite
    
    init(attacking: CharacterSprite, defending: CharacterSprite) {
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
        
        attacking.zPosition = 100
        
        attacking.run(moveTo, completion: {
            self.defending.showDamage(self.attacking.attack)
            self.attacking.showDamage(self.defending.attack)
            
            self.attacking.run(moveBack, completion: {
                self.attacking.zPosition = 0
                self.state = AnimationState.finished
            })
        })
    }
}
