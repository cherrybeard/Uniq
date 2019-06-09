//
//  AttackAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 22/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class AttackAnimation: Animation {
    private var _attackerSpot: Spot
    private var _targetSpot: Spot
    
    init(attackerSpot: Spot, targetSpot: Spot) {
        // TODO: Rework to use Spot
        _attackerSpot = attackerSpot
        _targetSpot = targetSpot
    }
    
    override func play() {
        if let attacker = _attackerSpot.creature {
            if let target = _targetSpot.creature {
                // create label to show damage
                let damageLabel = DamageLabel(damage: attacker.attack)
                damageLabel.alpha = 0
                damageLabel.setScale(0)
                target.addChild(damageLabel)
                
                // create animations
                let hitTarget = _hitTarget(at: target.position.y)
                let shakeTarget = _shakeTarget(at: target.position.y)
                let moveBack = _moveBack(to: attacker.position.y)
                let showDamage = _showDamage()
                let hideDamage = SKAction.fadeOut(withDuration: 0.3)
                
                // run animation
                attacker.zPosition = 1
                attacker.run(hitTarget) {
                    target.dealDamage(attacker.attack)
                    let isTargetDead = target.health <= 0
                    
                    target.run(shakeTarget)
                    damageLabel.run(showDamage) {
                        damageLabel.run(hideDamage)
                        
                        if isTargetDead {
                            // show destroy animation
                            let shaking = SKAction.shake(duration: 0.5, amplitudeX: 5, amplitudeY: 5)
                            let targetFadeOut = SKAction.fadeOut(withDuration: 1)
                            let shakeAndFadeOut = SKAction.group([shaking, targetFadeOut])
                            self.state = .finished
                            target.run(shakeAndFadeOut) {
                                target.removeFromParent()
                                target.spot.creature = nil
                            }
                        }
                        
                    }
                    
                    attacker.run(moveBack) {
                        attacker.zPosition = 0
                        if !isTargetDead { self.state = .finished }
                    }
                    
                }
            }
        }
    }
    
    private func _hitTarget(at targetYPos: CGFloat) -> SKAction {
        // prepare attacker
        let scaleUp = SKAction.scale(to: 1.15, duration: 0.2)
        
        // hit target
        let scaleBack = SKAction.scale(to: 1, duration: 0.1)
        let hitY = targetYPos + 54 * (targetYPos < 0 ? 1 : -1)
        let move = SKAction.moveTo(y: hitY, duration: 0.1)
        move.timingMode = .easeOut
        let moveAndScale = SKAction.group([scaleBack, move])
        
        return SKAction.sequence([scaleUp, moveAndScale])
    }
    
    private func _shakeTarget(at targetYPos: CGFloat) -> SKAction {
        // move target slightly to follow the impulse
        let impulseY = targetYPos - 6 * (targetYPos < 0 ? 1 : -1)
        let move = SKAction.moveTo(y: impulseY, duration: 0.05)
        move.timingMode = .easeOut
        
        // return target back
        let moveBack = SKAction.moveTo(y: targetYPos, duration: 0.1)
        moveBack.timingMode = .easeOut
        
        return SKAction.sequence([move, moveBack])
    }
    
    private func _moveBack(to attackerYPos: CGFloat) -> SKAction {
        // pause attacker for the dramatic effect
        let pause = SKAction.wait(forDuration: 0.1)
        
        // return attacker back
        let moveBack = SKAction.moveTo(y: attackerYPos, duration: 0.5)
        moveBack.timingMode = .easeOut
        
        return SKAction.sequence([pause, moveBack])
    }
    
    private func _showDamage() -> SKAction {
        let fadeIn = SKAction.fadeIn(withDuration: 0.1)
        let scaleUp = SKAction.scale(to: 1, duration: 0.1)
        let appear = SKAction.group([fadeIn, scaleUp])
        let pause = SKAction.wait(forDuration: 0.5)
        
        return SKAction.sequence([appear, pause])
    }
    
}
