//
//  Stat.swift
//  Uniq
//
//  Created by Steven Gusev on 04/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

enum StatType {
    case cost, attack, health
}

enum StatState {
    case initial, damaged, buffed
}

class StatLabel: SKNode {
    var type: StatType
    
    private var _value: Int
    var value: Int {
        get { return _value }
        set(newValue) {
            _value = newValue
            label.text = String(_value)
        }
    }
    
    private var _state: StatState = .initial
    var state: StatState {
        get { return _state }
        set(newState) {
            _state = newState
            label.fontColor = textColors[_state]
        }
    }
    
    private let border: SKShapeNode
    private let label: SKLabelNode
    private let borderColors: [StatType: UIColor] = [
        .cost:   UIColor(hue: 207.0/360.0, saturation: 67.0/100.0, brightness: 65.0/100.0, alpha: 1),
        .attack: UIColor(hue: 33.0/360.0,  saturation: 50.0/100.0, brightness: 63.0/100.0, alpha: 1),
        .health: UIColor(hue: 0/360.0,     saturation: 63.0/100.0, brightness: 64.0/100.0, alpha: 1)
    ]
    
    private let textColors: [StatState: UIColor] = [
        .initial: UIColor(hue: 0/360.0,     saturation: 0/100.0,    brightness: 93.0/100.0, alpha: 1),
        .damaged: UIColor(hue: 12.0/360.0,  saturation: 64.0/100.0, brightness: 100.0/100.0, alpha: 1),
        .buffed:  UIColor(hue: 122.0/360.0, saturation: 48.0/100.0, brightness: 85.0/100.0, alpha: 1)
    ]
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(type: StatType, value: Int) {
        self.type = type
        _value = value
        border = SKShapeNode(circleOfRadius: 12)
        label = SKLabelNode(text: String(value))
        super.init()
        
        border.lineWidth = 0
        if let color = borderColors[type] { border.fillColor = color }
        addChild(border)
        
        label.fontColor = textColors[_state]
        label.fontName = "Courier-Bold"
        label.fontSize = 17
        label.position = CGPoint(x: 0, y: -6)
        addChild(label)
    }
}
