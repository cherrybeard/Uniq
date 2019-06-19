//
//  CreatureSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 13/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class CreatureSprite: SKNode {
    private static let WIDTH: Int = 90
    private static let HEIGHT: Int = 60
    private struct BORDER_COLOR {
        static let base = UIColor(rgb: 0x484644)
        static let interactive = UIColor(rgb: 0x775534)
        static let interacted = UIColor(rgb: 0xAC7D4E)
        static let targetable = UIColor(rgb: 0x3752A1)
        static let targetted = UIColor(rgb: 0x1A54FB)
    }
    private let FILL_COLOR: UIColor = UIColor(rgb: 0x111111)
    
    var status: Set<InteractiveStatus> = [] { didSet { _redraw() } }
    
    private let border = SKShapeNode(
        rectOf: CGSize(width: CreatureSprite.WIDTH, height: CreatureSprite.HEIGHT),
        cornerRadius: 3
    )
    
    private let healthLabel = HealthLabel()
    private let attackLabel = AttackLabel()
    private let abilityLabel = AbilityLabel()
    
    var health: Int {
        get { return healthLabel.health }
        set { healthLabel.health = newValue }
    }
    var attack: Int {
        get { return attackLabel.attack }
        set { attackLabel.attack = newValue }
    }
    var activeAbilityCooldown: Int {
        get { return abilityLabel.remaining }
        set { abilityLabel.remaining = newValue }
    }
    
    var isActionTaken: Bool = false {
        didSet {
            if isActionTaken {
                abilityLabel.disable()
                attackLabel.disable()
            } else {
                abilityLabel.enable()
                attackLabel.enable()
            }
        }
    }
    
    init(of card: CreatureCardBlueprint) {
        super.init()
        
        healthLabel.maxHealth = card.health
        healthLabel.health = card.health
        
        border.lineWidth = 1
        border.fillColor = FILL_COLOR
        addChild(border)
        
        var cooldown: Int = -1
        if let ability = card.ability {
            cooldown = ability.cooldown
        }
        abilityLabel.cooldown = cooldown
        abilityLabel.resetCooldown()
        abilityLabel.position = CGPoint(x: 0, y: CreatureSprite.HEIGHT/2)
        addChild(abilityLabel)
        
        attackLabel.attack = card.attack
        attackLabel.position = CGPoint(x: -CreatureSprite.WIDTH/2 + 6, y: -CreatureSprite.HEIGHT/2 + 10)
        addChild(attackLabel)
        
        healthLabel.health = card.health
        healthLabel.position = CGPoint(x: CreatureSprite.WIDTH/2 - 6, y: -CreatureSprite.HEIGHT/2 + 10)
        addChild(healthLabel)
        
        _redraw()
        name = "creature"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _redraw() {
        if status.contains(.targetted) {
            border.strokeColor = BORDER_COLOR.targetted
        } else if status.contains(.targetable) {
            border.strokeColor = BORDER_COLOR.targetable
        } else if status.contains(.interacted) {
            border.strokeColor = BORDER_COLOR.interacted
        } else if status.contains(.interactive) {
            border.strokeColor = BORDER_COLOR.interactive
        } else {
            border.strokeColor = BORDER_COLOR.base
        }
    }
    
}
