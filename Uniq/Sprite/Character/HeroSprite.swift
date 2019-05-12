//
//  HeroSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 09/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class HeroSprite {
    //private let border: SKShapeNode
    
    init(health: Int) {
        /*
        border = SKShapeNode(circleOfRadius: 25)
        
        border.fillColor = UIColor(hue: 0, saturation: 0, brightness: 27.0/100.0, alpha: 1)
        border.lineWidth = 1
        redrawBorder()
        
        _health = health
        _maxHealth = health
        healthLabel.value = _health
        healthLabel.position = CGPoint(x: 16, y: -16)
        healthLabel.zPosition = 1
        
        addChild(border)
        */
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
