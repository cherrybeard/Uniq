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
        case selected
        case base
    }
    
    static let width: Int = 80
    static let height: Int = 110
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
        .base: UIColor(rgb: 0x483726),
        .selected: UIColor(rgb: 0x775534)
    ]
    private static let fillColor = UIColor(rgb: 0x111111)
    
    var character: Character
    
    var healthLabel = StatLabel(type: .health)
    private let label = SKLabelNode()
    private let border = SKShapeNode(
        rectOf: CGSize(width: CharacterSprite.width, height: CharacterSprite.height),
        cornerRadius: 5
    )
    
    var state: Set<State> = [.base] { didSet { redraw() } }
    
    init(_ character: Character) {
        self.character = character
        super.init()
        
        border.fillColor = CharacterSprite.fillColor
        addChild(border)
        
        label.attributedText = NSAttributedString(
            string: character.name,
            attributes: CharacterSprite.textAttributes
        )
        addChild(label)
        
        let xPos = CharacterSprite.width / 2 - 6
        let yPos = CharacterSprite.height / 2 - 10
        healthLabel.position = CGPoint(x: xPos, y: -yPos)
        healthLabel.value = character.health
        addChild(healthLabel)
        
        redraw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func removeFromFormation() {
        //formation?.characters.remov
        self.removeFromParent()
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
