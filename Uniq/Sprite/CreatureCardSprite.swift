//
//  CreatureCardSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 19/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class CreatureCardSprite: CardSprite {
    private let healthLabel: StatLabel
    private let attackLabel: StatLabel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(card: CreatureCard) {
        healthLabel = StatLabel(type: .health, text: String(card.health))
        attackLabel = StatLabel(type: .attack, text: String(card.attack))
        super.init(card: card)
        
        attackLabel.position = CGPoint(x: -width/2 + 6, y: -height/2 + 6)
        addChild(attackLabel)
        
        healthLabel.position = CGPoint(x: width/2 - 6, y: -height/2 + 6)
        addChild(healthLabel)
    }
}
