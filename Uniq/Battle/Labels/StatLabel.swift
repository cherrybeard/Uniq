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

struct Value {
    var current: Int = 1
    var max: Int = 1
    var base: Int = 1
}

class StatLabel: SKNode {   // OBSOLETE
    private static let textColor: [StatState: UIColor] = [
        .initial: UIColor(rgb: 0xBBBBBB),
        .damaged: UIColor(rgb: 0xA33D3D),
        .buffed: UIColor(rgb: 0xD9B282)
    ]
    private static let textAlign: [StatType: SKLabelHorizontalAlignmentMode] = [
        .attack: .left,
        .health: .right
    ]
    
    private let label = SKLabelNode()
    let type: StatType
    private var value = Value()
    private var states: Set<StatState> {
        var list: Set<StatState> = [.initial]
        if value.max > value.base { list.insert(.buffed) }
        if value.current < value.max { list.insert(.damaged) }
        return list
    }
    private var isBuffed: Bool { return value.max > value.base }
    private var isDamaged: Bool { return value.current < value.max }
    var isDimmed: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(type: StatType) {
        self.type = type
        super.init()
        
        label.horizontalAlignmentMode = StatLabel.textAlign[type]!
        label.verticalAlignmentMode = .center
        label.fontName = "AvenirNext-DemiBold"
        label.fontSize = 12
        addChild(label)
        redraw()
    }
    
    func redraw() {
        label.text = String(value.current)
        for state: StatState in [.damaged, .buffed, .initial] {
            if states.contains(state) {
                label.fontColor = StatLabel.textColor[state]!
                break
            }
        }
        if type == .attack {
            label.alpha = ( isDimmed || (value.current <= 0) ) ? 0.3 : 1
        }
    }
    
    func changeValue(by amount: Int, changeMax: Bool = true) {
        value.current += amount
        if changeMax { value.max += amount }
        redraw()
    }
    
    func changeValue(to amount: Int, changeMax: Bool = true, changeBase: Bool = true) {
        value.current = amount
        if changeMax { value.max = amount }
        if changeBase { value.base = amount }
        redraw()
    }
}
