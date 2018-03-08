//
//  CreatureSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 19/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class CreatureSprite: CharacterSprite {
    var creature: CreatureCard
    private let attackLabel: StatLabel
    private let border: SKShapeNode
    
    private let width: Int = 50
    private let height: Int = 90
    
    init(creature: CreatureCard, owner: OwnerType) {
        self.creature = creature
        
        attackLabel = StatLabel(type: .attack, value: creature.attack)
        border = SKShapeNode(rectOf: CGSize(width: width, height: height))
        
        super.init(owner: owner)
        
        _maxHealth = _health
        _health = creature.health
        _attack = creature.attack
        
        healthLabel.value = _health
        attackLabel.value = _attack
        
        border.fillColor = UIColor(hue: 0, saturation: 0, brightness: 27.0/100.0, alpha: 1)
        border.lineWidth = 1
        redrawBorder()
        attackLabel.position = CGPoint(x: -width/2 + 6, y: -height/2 + 6)
        healthLabel.position = CGPoint(x: width/2 - 6, y: -height/2 + 6)
        healthLabel.zPosition = 1
        
        addChild(border)
        addChild(attackLabel)
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
