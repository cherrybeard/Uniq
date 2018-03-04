//
//  CreatureCardSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 19/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class CreatureCardSprite: CardSprite {
    var healthLabel: SKLabelNode
    var attackLabel: SKLabelNode
    
    init(card: CreatureCard) {
        healthLabel = SKLabelNode(text: String(card.health))
        attackLabel = SKLabelNode(text: String(card.attack))
        super.init(card: card)
        
        let attackBorder = SKShapeNode(circleOfRadius: 12)
        attackBorder.position = CGPoint(x: -width/2 + 6, y: -height/2 + 6)
        attackBorder.lineWidth = 0
        attackBorder.fillColor = UIColor(hue: 353.0/360.0, saturation: 90.0/100.0, brightness: 69.0/100.0, alpha: 1)
        addChild(attackBorder)
        
        attackLabel.fontColor = SKColor.white
        attackLabel.fontName = "AvenirNext-Bold"
        attackLabel.fontSize = 17
        attackLabel.position = CGPoint(x: -width/2 + 6, y: -height/2 - 7 + 6)
        addChild(attackLabel)
        
        let healthBorder = SKShapeNode(circleOfRadius: 12)
        healthBorder.position = CGPoint(x: width/2 - 6, y: -height/2 + 6)
        healthBorder.lineWidth = 0
        healthBorder.fillColor = UIColor(hue: 35.0/360.0, saturation: 76.0/100.0, brightness: 72.0/100.0, alpha: 1)
        addChild(healthBorder)
        
        healthLabel.fontColor = SKColor.white
        healthLabel.fontName = "AvenirNext-Bold"
        healthLabel.fontSize = 17
        healthLabel.position = CGPoint(x: width/2 - 1 - 6, y: -height/2 - 7 + 6)
        addChild(healthLabel)
        
        name = "player-creature-card"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
