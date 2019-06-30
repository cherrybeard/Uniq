//
//  Stat.swift
//  Uniq
//
//  Created by Steven Gusev on 04/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

struct Value {
    var current: Int = 1
    var max: Int = 1
    var base: Int = 1
}

class StatLabel: SKNode {
    
    enum Kind {
        case cooldown, attack, health
    }
    
    enum State {
        case initial, damaged, buffed
    }
    
    private static let textColor: [State: UIColor] = [
        .initial: UIColor(rgb: 0xBBBBBB),
        .damaged: UIColor(rgb: 0xA33D3D),
        .buffed: UIColor(rgb: 0xD9B282)
    ]
    private static let textAlign: [Kind: SKLabelHorizontalAlignmentMode] = [
        .attack: .left,
        .health: .right
    ]
    
    private let label = SKLabelNode()
    let type: Kind
    private var value = Value()
    private var states: Set<State> {
        var list: Set<State> = [.initial]
        if value.max > value.base { list.insert(.buffed) }
        if value.current < value.max { list.insert(.damaged) }
        return list
    }
    private var isBuffed: Bool { return value.max > value.base }
    private var isDamaged: Bool { return value.current < value.max }
    var isDimmed: Bool = false { didSet { redraw() } }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(type: Kind) {
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
        for state: State in [.damaged, .buffed, .initial] {
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
