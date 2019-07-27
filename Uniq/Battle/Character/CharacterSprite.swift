//
//  CharacterSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 06/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class CharacterSprite: SKNode {
    
    enum State: CaseIterable {
        case targetable
        case selected
        case exhausted
        case base
    }
    
    static let width: Int = 80
    static let height: Int = 115
    private static var textStyle: NSMutableParagraphStyle {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        style.lineBreakMode = .byWordWrapping
        return style
    }
    private static let textAttributes: [NSAttributedString.Key : Any] = [
        .font: UIFont(name: "AvenirNext-DemiBold", size: 8)!,
        .foregroundColor: UIColor(rgb: 0xffffff),
        .paragraphStyle: CharacterSprite.textStyle
    ]
    private static let strokeColor: [State: UIColor] = [
        .targetable: UIColor(rgb: 0xF69A46),
        .selected: UIColor(rgb: 0xE6B789),
        .exhausted: UIColor(rgb: 0x222222),
        .base: UIColor(rgb: 0x493C2F)
    ]
    private static let fillColor = UIColor(rgb: 0x111111)
    
    var character: Character
    
    var healthLabel = HealthLabel()
    private let label = SKLabelNode()
    private let border = SKShapeNode(
        rectOf: CGSize(width: CharacterSprite.width, height: CharacterSprite.height)
    )
    
    var state: Set<State> = [.base] { didSet { redraw() } }
    
    init(_ character: Character) {
        self.character = character
        super.init()
        
        border.lineWidth = 2
        border.lineJoin = .miter
        border.fillColor = CharacterSprite.fillColor
        addChild(border)
        
        label.attributedText = NSAttributedString(
            string: character.name,
            attributes: CharacterSprite.textAttributes
        )
        addChild(label)
        
        let yPos = CharacterSprite.height / 2 - 6
        healthLabel.position = CGPoint(x: 0, y: -yPos)
        healthLabel.health = HealthLabel.Health(character.health.base)
        addChild(healthLabel)
        
        redraw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func redraw() {
        for s in State.allCases {
            if state.contains(s) || (s == .base) {
                border.strokeColor = CharacterSprite.strokeColor[s]!
                break
            }
        }
    }
    
}
