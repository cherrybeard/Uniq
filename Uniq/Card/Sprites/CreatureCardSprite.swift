//
//  CreatureCardSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 24/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class CreatureCardSprite: CardSprite {
    private let attackLabel = StatLabel(type: .attack)
    private let healthLabel = StatLabel(type: .health)
    
    override init() {
        let xPos = CardSprite.width / 2 - 6
        let yPos = CardSprite.height / 2 - 10
        attackLabel.position = CGPoint(x: -xPos, y: -yPos)
        healthLabel.position = CGPoint(x: +xPos, y: -yPos)
        super.init()
        addChild(attackLabel)
        addChild(healthLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateCardData() {
        if let creatureCard = card as? CreatureCard {
            attackLabel.setValue(to: creatureCard.attack)
            healthLabel.setValue(to: creatureCard.health)
        }
        super.updateCardData()
    }
}
