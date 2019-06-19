//
//  HealthLabel.swift
//  Uniq
//
//  Created by Steven Gusev on 19/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class HealthLabel: SKNode {
    private struct TEXT_COLOR {
        static let base = UIColor(rgb: 0xEEEEEE)
        static let damaged = UIColor(rgb: 0xA33D3D)
    }
    var maxHealth: Int = 1 {
        didSet { redraw() }
    }
    var health: Int = 1 {
        didSet { redraw() }
    }
    
    private let _label = SKLabelNode()
    
    override init() {
        super.init()
        
        _label.fontName = "AvenirNext-DemiBold"
        _label.fontSize = 12
        _label.horizontalAlignmentMode = .right
        _label.verticalAlignmentMode = .center
        addChild(_label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func redraw() {
        _label.text = String(health)
        _label.fontColor = (health == maxHealth) ? TEXT_COLOR.base : TEXT_COLOR.damaged
    }
}
