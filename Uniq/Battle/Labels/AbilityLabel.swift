//
//  AbilityLabel.swift
//  Uniq
//
//  Created by Steven Gusev on 17/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

enum AbilityLabelState {
    case base, ready
}

class AbilityLabel: SKNode {
    private static let textColor: [AbilityLabelState: UIColor] = [
        .base: UIColor(rgb: 0x675F56),
        .ready: UIColor(rgb: 0xE3B47B)
    ]
    private static let strokeColor: [AbilityLabelState: UIColor] = [
        .base: UIColor(rgb: 0x484644),
        .ready: UIColor(rgb: 0xC69F78)
    ]
    
    var cooldown: Int = -1 { didSet { updateVisibility() } }
    var remaining: Int = -1 { didSet { redraw() } }
    
    private var _isDisabled: Bool = false { didSet { redraw() } }
    var isDisabled: Bool { return _isDisabled }
    
    private let border = SKShapeNode(circleOfRadius: 9)
    private let label = SKLabelNode()
    
    override init() {
        super.init()
        
        label.fontName = "AvenirNext-DemiBold"
        label.fontSize = 12
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        addChild(label)
        
        border.position = CGPoint(x: 1, y: 0)
        border.fillColor = UIColor(rgb: 0x171717)
        addChild(border)
        
        redraw()
        updateVisibility()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateVisibility() {
        self.isHidden = cooldown < 0
    }
    
    private func redraw() {
        label.alpha = isDisabled ? 0.5 : 1
        label.text = String(remaining)
        let state: AbilityLabelState = ((remaining == 0) && !isDisabled) ? .ready : .base
        label.fontColor = AbilityLabel.textColor[state]!
        border.strokeColor = AbilityLabel.strokeColor[state]!
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
