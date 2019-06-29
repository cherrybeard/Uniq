//
//  CreatureSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 13/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class CreatureSprite: SKNode {
    static let width: Int = 90
    static let height: Int = 60
    private struct BORDER_COLOR {
        static let base = UIColor(rgb: 0x484644)
        static let interactive = UIColor(rgb: 0x775534)
        static let interacted = UIColor(rgb: 0xAC7D4E)
        static let targetable = UIColor(rgb: 0x3752A1)
        static let targetted = UIColor(rgb: 0x1A54FB)
    }
    private let FILL_COLOR: UIColor = UIColor(rgb: 0x111111)
    
    var status: Set<InteractiveStatus> = [] { didSet { redraw() } }
    
    private let border = SKShapeNode(
        rectOf: CGSize(width: CreatureSprite.width, height: CreatureSprite.height),
        cornerRadius: 3
    )
    
    let healthLabel = StatLabel(type: .health)
    let attackLabel = StatLabel(type: .attack)
    let abilityLabel = AbilityLabel()
    
    var activeAbilityCooldown: Int {
        get { return abilityLabel.remaining }
        set { abilityLabel.remaining = newValue }
    }
    
    init(of card: CreatureCard) {
        super.init()
        
        border.lineWidth = 1
        border.fillColor = FILL_COLOR
        addChild(border)
        
        var cooldown: Int = -1
        if let ability = card.ability {
            cooldown = ability.cooldown
        }
        abilityLabel.cooldown = cooldown
        abilityLabel.resetCooldown()
        abilityLabel.position = CGPoint(x: 0, y: CreatureSprite.height/2)
        addChild(abilityLabel)
        
        let xPos = CreatureSprite.width/2 - 6
        let yPos = CreatureSprite.height/2 - 10
        attackLabel.changeValue(to: card.attack)
        healthLabel.changeValue(to: card.health)
        attackLabel.position = CGPoint(x: -xPos, y: -yPos)
        healthLabel.position = CGPoint(x: +xPos, y: -yPos)
        addChild(attackLabel)
        addChild(healthLabel)
        
        redraw()
        name = "creature"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func redraw() {
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
