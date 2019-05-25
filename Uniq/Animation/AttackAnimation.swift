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
        let impulseY = targetYPos - 6 * (targetYPos < 0 ? 1 : -1)
        let initialTargetY = _target.position.y
        let targetImpulse = SKAction.moveTo(y: impulseY, duration: 0.05)
        targetImpulse.timingMode = .easeOut
        let targetReturning = SKAction.moveTo(y: initialTargetY, duration: 0.1)
        targetReturning.timingMode = .easeOut
        let targetMovement = SKAction.sequence([targetImpulse, targetReturning])
        
        // moving back
        let pauseAttacker = SKAction.wait(forDuration: 0.1)
        let initialY = _attacker?.position.y ?? 0
        let moveBack = SKAction.moveTo(y: initialY, duration: 0.5)
        moveBack.timingMode = .easeOut
        let waitAndMoveBack = SKAction.sequence([pauseAttacker, moveBack])
        
        _attacker?.zPosition = 1
        _attacker?.run(hittingTarget) {
            self._target.dealDamage(self._attacker!.attack)
            let isTargetDead = self._target.health <= 0
            if isTargetDead {
                self._target.isActionTaken = true
            }
            // show damage
            let damageLabel = DamageLabel(damage: self._attacker!.attack)
            damageLabel.alpha = 0
            damageLabel.setScale(0)
            self._target.addChild(damageLabel)
            let damageFadeIn = SKAction.fadeIn(withDuration: 0.1)
            let damageScaleUp = SKAction.scale(to: 1, duration: 0.1)
            let damageAppear = SKAction.group([damageFadeIn, damageScaleUp])
            let damagePause = SKAction.wait(forDuration: 0.5)
            let damageFadeOut = SKAction.fadeOut(withDuration: 0.3)
            let damageAppearAndFade = SKAction.sequence([damageAppear, damagePause])
            self._target.run(targetMovement)
            damageLabel.run(damageAppearAndFade) {
                damageLabel.run(damageFadeOut)
                if isTargetDead {
                    // show destroy animation
                    let shaking = SKAction.shake(duration: 0.5, amplitudeX: 5, amplitudeY: 5)
                    let targetFadeOut = SKAction.fadeOut(withDuration: 1)
                    let shakeAndFadeOut = SKAction.group([shaking, targetFadeOut])
                    self.state = .finished
                    self._target.run(shakeAndFadeOut) {
                        self._target.removeFromParent()
                        self._target.spot?.creature = nil
                    }
                }
            }
            self._attacker?.run(waitAndMoveBack) {
                self._attacker?.zPosition = 0
                if !isTargetDead { self.state = .finished }
            }
            
        }
        
    }
}
