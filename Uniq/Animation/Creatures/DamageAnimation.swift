//
//  DamageAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 13/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class DamageAnimation: Animation {
    let amount: Int
    var creature: CreatureSprite
    let label: DamageLabel
    // TODO: hideAfter: Bool to not hide in case it's final damage
    
    static private var action: SKAction {
        let fadeIn = SKAction.fadeIn(withDuration: 0.1)
        let scaleUp = SKAction.scale(to: 1, duration: 0.1)
        let appear = SKAction.group([fadeIn, scaleUp])
        let pause = SKAction.wait(forDuration: 0.5)
        let hide = SKAction.fadeOut(withDuration: 0.3)
        
        return SKAction.sequence([appear, pause, hide])
    }
    
    init(creature: CreatureSprite, amount: Int) {
        self.creature = creature
        self.amount = amount
        
        label = DamageLabel(damage: amount)
        label.alpha = 0
        label.setScale(0)
        creature.addChild(label)
        
        super.init()
    }
    
    override func play() {
        creature.health -= amount
        label.run(DamageAnimation.action) {
            self.label.removeFromParent()
        }
        state = .finished
    }
}
