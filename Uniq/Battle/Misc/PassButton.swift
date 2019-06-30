//
//  PassButton.swift
//  Uniq
//
//  Created by Steven Gusev on 12/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class PassButton: SKNode, Interactive {
    private static let fillColor = UIColor(rgb: 0x111111)
    private static let strokeColor: [InteractiveStatus: UIColor] = [
        .base: UIColor(rgb: 0x484644),
        .interactive: UIColor(rgb: 0x775534),
        .targetable: UIColor(rgb: 0x3752A1),
        .targetted: UIColor(rgb: 0x1A54FB)
    ]
    private static let fontColor: [InteractiveStatus: UIColor] = [
        .base: UIColor(rgb: 0x484644),
        .interactive: UIColor(rgb: 0xE3B47B),
        .targetable: UIColor(rgb: 0xE3B47B),
        .targetted: UIColor(rgb: 0xE3B47B)
    ]
    
    var readyToFight: Bool = false { didSet { redraw() } }
    
    var status: Set<InteractiveStatus> = []  { didSet { redraw() } }
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
        addChild(label)
        
        redraw()
        
        targetsFilter = { $0 is PassButton }
        
        name = "pass"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func redraw() {
        label.text = readyToFight ? "Fight" : "Pass"
        for s: InteractiveStatus in [.targetted, .targetable, .interactive, .base] {
            if status.contains(s) || (s == .base) {
                border.strokeColor = PassButton.strokeColor[s]!
                label.fontColor = PassButton.fontColor[s]!
                break
            }
        }
    }
    
}
