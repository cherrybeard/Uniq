//
//  DamageLabel.swift
//  Uniq
//
//  Created by Steven Gusev on 04/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class DamageLabel: SKNode {
    private let label = SKLabelNode()
    var amount: Int { didSet { redraw() }}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(amount: Int) {
        self.amount = amount
        super.init()
        label.fontName = "Copperplate"
        label.fontSize = 36
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center    
        addChild(label)
        redraw()
    }
    
    private func redraw() {
        let text = String(abs(amount))
        let prefix = amount >= 0 ? "+" : "-"
        label.fontColor = amount >= 0 ? UIColor(rgb: 0x539564) : UIColor(rgb: 0xA33D3D)
        label.text = prefix + text
    }
}
