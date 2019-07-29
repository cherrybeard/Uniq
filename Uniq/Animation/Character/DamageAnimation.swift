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
    var character: CharacterSprite
    let label: DamageLabel
    
    static var action: SKAction {
        let fadeIn = SKAction.fadeIn(withDuration: 0.1)
        let scaleUp = SKAction.scale(to: 1, duration: 0.1)
        let appear = SKAction.group([fadeIn, scaleUp])
        let move = SKAction.moveBy(x: 0, y: 40, duration: 0.7)
        let fadeOut = SKAction.fadeOut(withDuration: 0.7)
        let hide = SKAction.group([move, fadeOut])
        hide.timingMode = .easeIn
        
        return SKAction.sequence([appear, hide])
    }
    
    init(character: CharacterSprite, amount: Int) {
        self.character = character
        self.amount = amount
        
        label = DamageLabel(amount: -amount)
        label.alpha = 0
        label.setScale(0)
        label.position = CGPoint(x: 0, y: -30)
        character.addChild(label)
        
        super.init()
    }
    
    override func play() {
        character.healthLabel.dealDamage(amount)
        label.run(DamageAnimation.action) {
            self.label.removeFromParent()
        }
        state = .finished
    }
}
