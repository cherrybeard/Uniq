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
    var amount: Int
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(amount: Int) {
        self.amount = amount
        super.init()
        label.fontColor = SKColor.white
        label.fontName = "AvenirNext-Regular"
        label.fontSize = 24
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center    
        addChild(label)
        redraw()
    }
    
    private func redraw() {
        let text = String(abs(amount))
        let prefix = amount > 0 ? "+" : "–"
        label.text = prefix + text
    }
}
