//
//  CreatureSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 13/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class CreatureSprite: SKNode, CharacterSprite {
    
    private enum SpriteState: String, CaseIterable {
        case targetted = "targetted"
        case targetable = "targetable"
        case interacted = "interacted"
        case interactive = "interactive"
        case base = "base"
        case exhausted = "exhausted"
    }
    
    static let width: Int = 90
    static let height: Int = 60
    private static let strokeColor: [SpriteState: UIColor] = [
        .targetted: UIColor(rgb: 0x1A54FB),
        .targetable: UIColor(rgb: 0x3752A1),
        .interacted: UIColor(rgb: 0xAC7D4E),
        .interactive: UIColor(rgb: 0x775534),
        .base: UIColor(rgb: 0x483726),
        .exhausted: UIColor(rgb: 0x32302F)
    ]
    private static let fillColor: UIColor = UIColor(rgb: 0x111111)
    
    var state: Set<InteractiveState> = [] { didSet { redraw() } }
    
    private let border = SKShapeNode(
        rectOf: CGSize(width: CreatureSprite.width, height: CreatureSprite.height),
        cornerRadius: 3
    )
    
    let healthLabel = StatLabel(type: .health)
    let attackLabel = StatLabel(type: .attack)
    let abilityLabel = AbilityLabel()
    var isExhausted: Bool = true { didSet {
        attackLabel.isDimmed = isExhausted
        abilityLabel.isDimmed = isExhausted
        redraw()
    } }
    
    init(of card: CreatureCard) {
        super.init()
        
        border.lineWidth = 1
        border.fillColor = CreatureSprite.fillColor
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
        var spriteState: SpriteState = .exhausted
        for s in SpriteState.allCases {
            if let interactiveState = InteractiveState(rawValue: s.rawValue) {
                if state.contains(interactiveState) {
                    spriteState = s
                    break
                }
            } else if ((s == .base) && !isExhausted) {
                spriteState = s
                break
            }
        }
        border.strokeColor = CreatureSprite.strokeColor[spriteState]!
    }
    
}
