//
//  AbilityLabel.swift
//  Uniq
//
//  Created by Steven Gusev on 17/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class AbilityLabel: SKNode {
    private struct TEXT_COLOR {
        static let base = UIColor(rgb: 0x675F56)
        static let ready = UIColor(rgb: 0xE3B47B)
    }
    private struct BORDER_COLOR {
        static let base = UIColor(rgb: 0x484644)
        static let ready = UIColor(rgb: 0xC69F78)
    }
    
    var cooldown: Int = -1 {
        didSet { _updateVisibility() }
    }
    var remaining: Int = -1 {
        didSet { _redraw() }
    }
    
    private var _isDisabled: Bool = false { didSet { _redraw() } }
    var isDisabled: Bool { return _isDisabled }
    
    private let _border = SKShapeNode(circleOfRadius: 9)
    private let _label = SKLabelNode()
    
    override init() {
        super.init()
        
        _label.fontName = "AvenirNext-DemiBold"
        _label.fontSize = 12
        _label.horizontalAlignmentMode = .center
        _label.verticalAlignmentMode = .center
        addChild(_label)
        
        _border.position = CGPoint(x: 1, y: 0)
        _border.fillColor = UIColor(rgb: 0x171717)
        addChild(_border)
        
        _redraw()
        _updateVisibility()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _updateVisibility() {
        self.isHidden = cooldown < 0
    }
    
    private func _redraw() {
        _label.alpha = isDisabled ? 0.5 : 1
        _label.text = String(remaining)
        if (remaining == 0) && !isDisabled {
            _label.fontColor = TEXT_COLOR.ready
            _border.strokeColor = BORDER_COLOR.ready
        } else {
            _label.fontColor = TEXT_COLOR.base
            _border.strokeColor = BORDER_COLOR.base
        }
    }
    
    func resetCooldown() {
        remaining = cooldown
    }
    
    func decreaseCooldown() {
        if ( remaining > 0 ) {
            remaining -= 1
        }
    }
    
    func enable() {
        _isDisabled = false
    }
    
    func disable() {
        _isDisabled = true
    }
}
