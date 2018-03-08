//
//  HeroSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 09/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class HeroSprite: CharacterSprite {
    private let border: SKShapeNode
    
    init(health: Int) {
        border = SKShapeNode(circleOfRadius: 25)
        super.init(owner: .player)
        
        border.fillColor = UIColor(hue: 0, saturation: 0, brightness: 27.0/100.0, alpha: 1)
        border.lineWidth = 1
        redrawBorder()
        
        _health = health
        healthLabel.value = _health
        healthLabel.position = CGPoint(x: 16, y: -16)
        healthLabel.zPosition = 1
        
        addChild(border)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func redrawBorder() {
        if isTarget {
            border.strokeColor = UIColor(hue: 33.0/360.0, saturation: 70.0/100.0, brightness: 81.0/100.0, alpha: 1)
        } else if canAttack && (owner == OwnerType.player) {
            border.strokeColor = UIColor(hue: 0, saturation: 0, brightness: 80.0/100.0, alpha: 1)
        } else {
            border.strokeColor = UIColor(hue: 0, saturation: 0, brightness: 40.0/100.0, alpha: 1)
        }
    }
}
