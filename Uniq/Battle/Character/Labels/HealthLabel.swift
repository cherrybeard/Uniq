//
//  HealthLabel.swift
//  Uniq
//
//  Created by Steven Gusev on 28/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class HealthLabel: SKNode {
    
    struct Health {
        var current: Int
        var max: Int
        var base: Int
        var armor: Int
        
        init(_ value: Int, armor: Int = 0) {
            current = value
            max = value
            base = value
            self.armor = armor
        }
    }
    
    var health = Health(1) { didSet { redraw() }}
    let label = SKLabelNode()
    let border = SKShapeNode(rectOf: CGSize(width: 100, height: 19))

    override init() {
        super.init()
        
        label.fontName = "Copperplate"
        label.fontSize = 19
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        addChild(label)
        
        border.fillColor = UIColor(rgb: 0xFFF1D6)
        border.lineWidth = 0
        addChild(border)
        
        redraw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func redraw() {
        var text = String(health.current)
        if health.armor > 0 {
            text += "+\(health.armor)"
        }
        label.text = text
        if health.current < health.max {
            label.fontColor = UIColor(rgb: 0xA33D3D)
        } else {
            label.fontColor = UIColor(rgb: 0x20160B)
        }
        var width = label.frame.width + 8
        if width < 34 { width = 34 }
        border.xScale = width / 100
    }
    
    func dealDamage(_ healthDamage: Int, armorDamage: Int = 0) {
        health.current -= healthDamage
        health.armor -= armorDamage
    }
    
    func heal(_ amount: Int, armor: Int = 0) {
        health.current += amount
        health.armor += armor
    }
}
