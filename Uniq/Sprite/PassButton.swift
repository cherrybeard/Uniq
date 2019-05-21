//
//  PassButton.swift
//  Uniq
//
//  Created by Steven Gusev on 12/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit


class PassButton: SKNode, Tappable, Targetable {
    let border = SKShapeNode(rectOf: CGSize(width: 40, height: 40))
    let label = SKLabelNode(text: "Pass")
    
    private var _readyToFight: Bool = false
    var readyToFight: Bool {
        get { return _readyToFight }
        set(newValue) {
            _readyToFight = newValue
            _redraw()
        }
    }
    
    var isPosssibleToTap: Bool = false
    var isCurrentlyTapped: Bool = false
    var isPossibleTarget: Bool = false
    var isCurrentTarget: Bool = false
    
    override init() {
        super.init()
        
        border.zRotation = .pi / 4
        border.lineWidth = 1.2
        border.fillColor = UIColor(rgb: 0x19160D, alpha: 1)
        border.strokeColor = UIColor(rgb: 0x9F978E, alpha: 1)
        addChild(border)
        
        label.fontSize = 12
        label.fontName = "AvenirNext-Medium"
        label.fontColor = UIColor(rgb: 0xE3B47B, alpha: 1)
        label.position = CGPoint(x: 0, y: -5)
        addChild(label)
        
        _redraw()
        
        name = "pass"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _redraw() {
        label.text = _readyToFight ? "Fight" : "Pass"
    }
}
