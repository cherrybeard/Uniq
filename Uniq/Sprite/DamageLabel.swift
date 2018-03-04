//
//  DamageLabel.swift
//  Uniq
//
//  Created by Steven Gusev on 04/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class DamageLabel: SKLabelNode {
    private let action: SKAction
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        let damageAppear = SKAction.group([
            SKAction.fadeIn(withDuration: 0.1),
            SKAction.scale(to: 1.4, duration: 0.1)
        ])
        damageAppear.timingMode = .easeIn
        
        let damageHide = SKAction.fadeOut(withDuration: 0.1)
        damageHide.timingMode = .easeIn
        
        action = SKAction.sequence([
            damageAppear,
            SKAction.scale(to: 1, duration: 0.1),
            SKAction.wait(forDuration: 0.5),
            damageHide
        ])
        
        super.init()
        
        fontColor = SKColor.white
        fontName = "AvenirNext-Bold"
        fontSize = 32
        alpha = 0
    }
    
    func show(damage: Int) {
        setScale(0.5)
        text = "-" + String(damage)
        run(action)
    }
    
    
}
