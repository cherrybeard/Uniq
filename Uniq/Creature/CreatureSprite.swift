//
//  CreatureSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 19/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

enum OwnerType: Int {
    case player = 0, computer
}

class CreatureSprite: SKNode {
    var creature: Creature
    var owner: OwnerType
    var healthLabel: SKLabelNode
    var attackLabel: SKLabelNode
    
    let width: Int = 50
    let height: Int = 90
    
    init(creature: Creature, owner: OwnerType) {
        self.creature = creature
        self.owner = owner
        self.attackLabel = SKLabelNode(text: String(creature.attack))
        self.healthLabel = SKLabelNode(text: String(creature.health))
        super.init()
        
        let border = SKShapeNode(rectOf: CGSize(width: width, height: height))
        border.fillColor = UIColor(hue: 0, saturation: 0, brightness: 27.0/100.0, alpha: 1)
        border.strokeColor = UIColor(hue: 0, saturation: 0, brightness: 40.0/100.0, alpha: 1)
        border.lineWidth = 1
        addChild(border)
        
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
        
        name = (self.owner == OwnerType.player) ? "player-creature" : "computer-creature"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyDamage(damage: Int) {
        creature.health -= damage
        healthLabel.text = String(creature.health)
    }
    
    func destroy() {
        self.removeFromParent()
    }
}
