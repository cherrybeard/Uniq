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
    let manaLabel = SKLabelNode()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(mana: Int) {
        super.init()
        self.mana = mana
        
        let border = SKShapeNode(circleOfRadius: 24)
        border.lineWidth = 0
        border.fillColor = UIColor(hue: 205.0/360.0, saturation: 76.0/100.0, brightness: 74.0/100.0, alpha: 1)
        addChild(border)
        
        manaLabel.color = UIColor.white
        manaLabel.fontName = "AvenirNext-Bold"
        manaLabel.fontSize = 24
        manaLabel.text = String(self.mana)
        manaLabel.position = CGPoint(x: 0, y: -10)
        addChild(manaLabel)
        
        name = "end-turn"
    }
    
    func useMana(amount: Int) -> Bool {
        if amount > mana { return false }
        
        mana -= amount
        manaLabel.text = String(mana)
        return true
    }
    
    func addMana(amount: Int) {
        mana += amount
        if mana >= 10 { mana = 10 }
        manaLabel.text = String(mana)
    }
}
