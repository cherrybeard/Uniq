//
//  SpellAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 24/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class SpellAnimation: Animation {
    let duration: TimeInterval = 0.2
    var target: CreatureSprite
    var damage: Int
    
    init(target: CreatureSprite, damage: Int) {
        self.target = target
        self.damage = damage
    }
    
    override func play() {
        state = .inProgress
        target.damageLabel.setScale(0)
        target.damageLabel.text = "-" + String(damage)
        let appear = SKAction.fadeIn(withDuration: 0.1)
        let scale = SKAction.scale(to: 1.4, duration: 0.1)
        let appearAction = SKAction.group([appear, scale])
        appearAction.timingMode = .easeIn
        let stabilize = SKAction.scale(to: 1, duration: 0.1)
        let appearing = SKAction.sequence([appearAction, stabilize])
        
        let delay = SKAction.wait(forDuration: 0.5)
        let hide = SKAction.fadeOut(withDuration: 0.1)
        let hideWithDelay = SKAction.sequence([delay, hide])
        hide.timingMode = .easeIn
        
        target.damageLabel.run(appearing, completion: {
            self.target.health -= self.damage
            self.state = .finished
            self.target.damageLabel.run(hideWithDelay, completion: {
            })
        })
    }
}
