//
//  DamageLabel.swift
//  Uniq
//
//  Created by Steven Gusev on 04/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class DamageLabel: SKNode {
    private let _label = SKLabelNode()
    var amount: Int
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(amount: Int) {
        self.amount = amount
        super.init()
        _label.fontColor = SKColor.white
        _label.fontName = "AvenirNext-Regular"
        _label.fontSize = 24
        _label.verticalAlignmentMode = .center
        _label.horizontalAlignmentMode = .center    
        addChild(_label)
        _redraw()
    }
    
    private func _redraw() {
        let text = String(abs(amount))
        let prefix = amount > 0 ? "+" : "–"
        _label.text = prefix + text
    }
}
