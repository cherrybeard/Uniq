//
//  AttackAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 22/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class AttackAnimation: Animation {
    private weak var _attacker: CreatureSprite?
    private var _target: CreatureSprite
    
    init(attacker: CreatureSprite, target: CreatureSprite) {
        _attacker = attacker
        _target = target
    }
    
    override func play() {
        // preparing
        let scaleUp = SKAction.scale(to: 1.15, duration: 0.2)
        
        // hitting the target
        let scaleBack = SKAction.scale(to: 1, duration: 0.1)
        let targetYPos = _target.position.y
        let hitY = targetYPos + 54 * (targetYPos < 0 ? 1 : -1)
        let moveToTarget = SKAction.moveTo(y: hitY, duration: 0.1)
        moveToTarget.timingMode = .easeOut
        let moveAndScale = SKAction.group([scaleBack, moveToTarget])
        let hittingTarget = SKAction.sequence([scaleUp, moveAndScale])
        
        // shaking the target
        //let shaking = SKAction.shake(duration: 0.2, amplitudeX: 10, amplitudeY: 10)
        let impulseY = targetYPos - 6 * (targetYPos < 0 ? 1 : -1)
        let initialTargetY = _target.position.y
        let targetImpulse = SKAction.moveTo(y: impulseY, duration: 0.05)
        targetImpulse.timingMode = .easeOut
        let targetReturning = SKAction.moveTo(y: initialTargetY, duration: 0.1)
        targetReturning.timingMode = .easeOut
        let targetMovement = SKAction.sequence([targetImpulse, targetReturning])
        
        // moving back
        let wait = SKAction.wait(forDuration: 0.1)
        let initialY = _attacker?.position.y ?? 0
        let moveBack = SKAction.moveTo(y: initialY, duration: 0.5)
        moveBack.timingMode = .easeOut
        let waitAndMoveBack = SKAction.sequence([wait, moveBack])
        
        _attacker?.zPosition = 1
        _attacker?.run(hittingTarget) {
            // show damage
            self._target.run(targetMovement)
            self._attacker?.run(waitAndMoveBack) {
                self._attacker?.zPosition = 0
                self.state = .finished
            }
            //self.state = .finished
            
            /*
            self.defending.showDamage(self.attacking.attack)
            if self.defending.attack > 0 {
                self.attacking.showDamage(self.defending.attack)
            }
            
            self.attacking.run(moveBack, completion: {
                self.attacking.zPosition = 0
                self.state = AnimationState.finished
            })
            */
        }
        
    }
}
