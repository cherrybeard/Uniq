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

class StatLabel: SKNode {
    var type: StatType
    private let border: SKShapeNode
    private let label: SKLabelNode
    private let borderColors: [StatType: UIColor] = [
        .cost:   UIColor(hue: 205.0/360.0, saturation: 76.0/100.0, brightness: 74.0/100.0, alpha: 1),
        .attack: UIColor(hue: 353.0/360.0, saturation: 90.0/100.0, brightness: 69.0/100.0, alpha: 1),
        .health: UIColor(hue: 35.0/360.0,  saturation: 76.0/100.0, brightness: 72.0/100.0, alpha: 1)
    ]
    
    var text: String {
        get { return label.text! }
        set(text) { label.text = text }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(type: StatType, text: String) {
        self.type = type
        border = SKShapeNode(circleOfRadius: 12)
        label = SKLabelNode(text: text)
        super.init()
        
        border.lineWidth = 0
        if let color = borderColors[type] { border.fillColor = color }
        addChild(border)
        
        label.text = text
        label.fontColor = SKColor.white
        label.fontName = "AvenirNext-Bold"
        label.fontSize = 17
        label.position = CGPoint(x: 0, y: -7)
        addChild(label)
    }
}
