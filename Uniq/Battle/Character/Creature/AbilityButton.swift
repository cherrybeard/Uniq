//
//  AbilityButton.swift
//  Uniq
//
//  Created by Steven Gusev on 08/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class AbilityButton: SKNode {
    
    enum State: CaseIterable {
        case selected
        case selectable
        case base
    }
    
    static let size: CGFloat = 30
    private static let strokeColor: [State: UIColor] = [
        .selected: UIColor(rgb: 0xAC7D4E),
        .selectable: UIColor(rgb: 0x775534),
        .base: UIColor(rgb: 0x483726)
    ]
    private static let fillColor: UIColor = UIColor(rgb: 0x111111)
    private static var textStyle: NSMutableParagraphStyle {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        style.lineBreakMode = .byWordWrapping
        return style
    }
    private static let textAttributes: [NSAttributedString.Key : Any] = [
        .font: UIFont(name: "AvenirNext-DemiBold", size: 8)!,
        .foregroundColor: UIColor(rgb: 0xffffff),
        .paragraphStyle: AbilityButton.textStyle
    ]
    
    var ability: ActiveAbility
    var state: Set<State> = [] { didSet { redraw() } }
    //var targetsFilter: (Interactive) -> Bool = { $0 is AbilityButton }
    
    private let label = SKLabelNode()
    private let border = SKShapeNode( hexagonOfRadius: AbilityButton.size )
    
    init(_ ability: ActiveAbility) {
        self.ability = ability
        super.init()
        
        border.lineWidth = 1
        border.fillColor = AbilityButton.fillColor
        addChild(border)
        
        label.attributedText = NSAttributedString(
            string: ability.name,
            attributes: AbilityButton.textAttributes
        )
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.preferredMaxLayoutWidth = 44
        label.numberOfLines = 0
        addChild(label)
        
        redraw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func redraw() {
        for s in State.allCases {
            if state.contains(s) || (s == .base) {
                border.strokeColor = AbilityButton.strokeColor[s]!
                break
            }
        }
    }
    
}
