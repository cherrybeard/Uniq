//
//  ManaCounter.swift
//  Uniq
//
//  Created by Steven Gusev on 20/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class ManaCounter: SKNode {
    var mana:Int = 0
    var totalMana:Int = 0
    let manaLabel = SKLabelNode()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(mana: Int) {
        super.init()
        self.mana = mana
        totalMana = mana
        
        let border = SKShapeNode(circleOfRadius: 24)
        border.lineWidth = 0
        border.fillColor = UIColor(hue: 205.0/360.0, saturation: 76.0/100.0, brightness: 74.0/100.0, alpha: 1)
        addChild(border)
        
        manaLabel.color = UIColor.white
        manaLabel.fontName = "Courier-Bold"
        manaLabel.fontSize = 24
        manaLabel.position = CGPoint(x: 0, y: -10)
        update()
        addChild(manaLabel)
        
        name = "end-turn"
    }
    
    func use(amount: Int) -> Bool {
        if amount > mana { return false }
        
        mana -= amount
        update()
        return true
    }
    
    func add(amount: Int) {
        mana += amount
        if mana >= 10 { mana = 10 }
        update()
    }
    
    func increaseAndRestore() {
        if totalMana < 10 { totalMana += 1 }
        mana = totalMana
        update()
    }
    
    func update() {
        manaLabel.text = String(mana)
    }
}
