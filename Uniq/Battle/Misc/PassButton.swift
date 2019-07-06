//
//  PassButton.swift
//  Uniq
//
//  Created by Steven Gusev on 12/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class PassButton: SKNode, Interactive {
    
    private enum SpriteState: String, CaseIterable {
        case targetted = "targetted"
        case targetable = "targetable"
        case interactive = "interactive"
        case base = "base"
    }
    
    private static let fillColor = UIColor(rgb: 0x111111)
    private static let strokeColor: [SpriteState: UIColor] = [
        .targetted: UIColor(rgb: 0x1A54FB),
        .targetable: UIColor(rgb: 0x3752A1),
        .interactive: UIColor(rgb: 0x775534),
        .base: UIColor(rgb: 0x484644),
    ]
    private static let fontColor: [SpriteState: UIColor] = [
        .targetted: UIColor(rgb: 0xE3B47B),
        .targetable: UIColor(rgb: 0xE3B47B),
        .interactive: UIColor(rgb: 0xE3B47B),
        .base: UIColor(rgb: 0x484644),
    ]
    
    var state: Set<InteractiveState> = []  { didSet { redraw() } }
    var targetsFilter: (Interactive) -> Bool = { _ in return false }
    
    private let border = SKShapeNode(rectOf: CGSize(width: 40, height: 40))
    private let label = SKLabelNode(text: "Pass")
    
    override init() {
        super.init()
        
        border.zRotation = .pi / 4
        border.lineWidth = 1.2
        border.fillColor = PassButton.fillColor
        addChild(border)
        
        label.fontSize = 12
        label.fontName = "AvenirNext-Medium"
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        label.text = "Fight"
        addChild(label)
        
        redraw()
        
        targetsFilter = { $0 is PassButton }
        
        name = "pass"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func redraw() {
        var spriteState: SpriteState = .base
        for s in SpriteState.allCases {
            if let interactiveState = InteractiveState(rawValue: s.rawValue) {
                if state.contains(interactiveState) {
                    spriteState = s
                    break
                }
            }
        }
        border.strokeColor = PassButton.strokeColor[spriteState]!
        label.fontColor = PassButton.fontColor[spriteState]!
    }
    
}
