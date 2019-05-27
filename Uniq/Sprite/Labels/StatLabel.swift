//
//  Stat.swift
//  Uniq
//
//  Created by Steven Gusev on 04/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

enum StatType {
    case cooldown, attack, health
}

enum StatState {
    case initial, damaged, buffed
}

class StatLabel: SKNode {   // OBSOLETE
    private let TEXT_COLOR: [StatState: UIColor] = [
        .initial: UIColor(rgb: 0xffffff),
        .damaged: UIColor(hue: 12.0/360.0,  saturation: 64.0/100.0, brightness: 100.0/100.0, alpha: 1),
        .buffed:  UIColor(rgb: 0xD9B282)
    ]
    private let TEXT_ALIGN: [StatType: SKLabelHorizontalAlignmentMode] = [
        .attack: .left,
        .cooldown: .center,
        .health: .right
    ]
    
    var type: StatType
    var isDimmed: Bool = false
    
    private var _value: Int
    var value: Int {
        get { return _value }
        set(newValue) {
            _value = newValue
            redraw()
        }
    }
    
    private var _state: StatState = .initial
    var state: StatState {
        get { return _state }
        set(newState) {
            _state = newState
            redraw()
        }
    }
    
    let label: SKLabelNode
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(type: StatType, value: Int = 1) {
        self.type = type
        _value = value
        label = SKLabelNode(text: String(value))
        super.init()
        
        label.horizontalAlignmentMode = TEXT_ALIGN[type]!
        label.fontName = "AvenirNext-DemiBold"
        label.fontSize = 12
        redraw()
        addChild(label)
    }
    
    func redraw() {
        label.alpha = isDimmed ? 0.5 : 1
        label.fontColor = TEXT_COLOR[_state]
        label.text = String(value)
    }
}
