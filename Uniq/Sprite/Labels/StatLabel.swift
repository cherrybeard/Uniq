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
    
    var value: Int = 1 { didSet { redraw() } }
    var state: StatState = .initial { didSet { redraw() } }
    let label = SKLabelNode()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(type: StatType) {
        self.type = type
        super.init()
        
        label.horizontalAlignmentMode = TEXT_ALIGN[type]!
        label.fontName = "AvenirNext-DemiBold"
        label.fontSize = 12
        addChild(label)
        redraw()
    }
    
    func redraw() {
        label.alpha = isDimmed ? 0.5 : 1
        label.fontColor = TEXT_COLOR[state]
        label.text = String(value)
    }
}
