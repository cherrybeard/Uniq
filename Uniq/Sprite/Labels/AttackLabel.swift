//
//  AttackLabel.swift
//  Uniq
//
//  Created by Steven Gusev on 18/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class AttackLabel: SKNode {
    private struct TEXT_COLOR {
        static let base = UIColor(rgb: 0xEEEEEE)
        static let buffed = UIColor(rgb: 0xD9B282)
    }
    
    var attack: Int = 1 { didSet { _redraw() } }
    var isDisabled: Bool = false { didSet { _redraw() } }
    var isBuffed: Bool = false { didSet { _redraw() } }
    
    private let _label = SKLabelNode()
    
    override init() {
        super.init()
        
        _label.fontName = "AvenirNext-DemiBold"
        _label.fontSize = 12
        _label.horizontalAlignmentMode = .left
        _label.verticalAlignmentMode = .center
        addChild(_label)
        
        _redraw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _redraw() {
        _label.text = String(attack)
        _label.fontColor = isBuffed ? TEXT_COLOR.buffed : TEXT_COLOR.base
        _label.alpha = isDisabled ? 0.5 : 1
    }
    
    func increaseAttack(by amount: Int = 1) {
        attack += amount
        if !isBuffed { isBuffed = true }
    }
}
