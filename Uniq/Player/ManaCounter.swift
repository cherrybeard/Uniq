//
//  ManaCounter.swift
//  Uniq
//
//  Created by Steven Gusev on 20/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class ManaCounter: SKNode, Targetable {
    private var _amount:Int
    var amount:Int {
        get { return _amount }
        set {
            _amount = newValue
            label.text = String(_amount)
        }
    }
    var totalAmount:Int
    
    let label = SKLabelNode()
    let border = SKShapeNode(circleOfRadius: 24)
    var isPossibleTarget: Bool = false
    var isCurrentTarget: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(startingAmount: Int = 1) {
        _amount = startingAmount
        totalAmount = startingAmount
        super.init()
        
        amount = startingAmount
        
        border.lineWidth = 0
        border.fillColor = UIColor(hue: 205.0/360.0, saturation: 76.0/100.0, brightness: 74.0/100.0, alpha: 1)
        
        label.color = UIColor.white
        label.fontName = "Courier-Bold"
        label.fontSize = 24
        label.position = CGPoint(x: 0, y: -10)
        label.text = String(_amount)
        
        addChild(border)
        addChild(label)
        
        name = "end-turn"
    }
    
    func use(amount: Int) -> Bool { // replace amount with _
        if amount > self.amount { return false }
        
        self.amount -= amount
        return true
    }
    
    func increaseAndRestore() {
        if totalAmount < 10 { totalAmount += 1 }
        amount = totalAmount
    }
}
