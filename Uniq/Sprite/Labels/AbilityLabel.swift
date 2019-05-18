//
//  AbilityLabel.swift
//  Uniq
//
//  Created by Steven Gusev on 17/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class AbilityLabel: StatLabel {
    private struct BORDER_COLOR {
        static let base = UIColor(rgb: 0x484644)
        static let ready = UIColor(rgb: 0xC69F78)
    }
    private let _border = SKShapeNode(circleOfRadius: 9)
    
    init(value: Int = -1) {
        super.init(type: .cooldown, value: value)
        _border.position = CGPoint(x: 1, y: 5)
        _border.fillColor = UIColor(rgb: 0x171717)
        addChild(_border)
        redraw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func redraw() {
        super.redraw()
        _border.strokeColor = (value == 0) ? BORDER_COLOR.ready : BORDER_COLOR.base
        if value < 0 {
           self.isHidden = true
        }
    }
}
