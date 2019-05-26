//
//  PassButton.swift
//  Uniq
//
//  Created by Steven Gusev on 12/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit


class PassButton: SKNode, Tappable, Targetable {
    private let FILL_COLOR = UIColor(rgb: 0x111111)
    private struct BORDER_COLOR {
        static let base = UIColor(rgb: 0x484644)
        static let possibleToTap = UIColor(rgb: 0x775534)
    }
    private struct FONT_COLOR {
        static let base = UIColor(rgb: 0x484644)
        static let possibleToTap = UIColor(rgb: 0xE3B47B)
    }
    
    var readyToFight: Bool = false { didSet { _redraw() } }
    
    var isPosssibleToTap: Bool = false { didSet { _redraw() } }
    var isCurrentlyTapped: Bool = false
    var isPossibleTarget: Bool = false
    var isCurrentTarget: Bool = false
    
    private let _border = SKShapeNode(rectOf: CGSize(width: 40, height: 40))
    private let _label = SKLabelNode(text: "Pass")
    
    override init() {
        super.init()
        
        _border.zRotation = .pi / 4
        _border.lineWidth = 1.2
        _border.fillColor = FILL_COLOR
        addChild(_border)
        
        _label.fontSize = 12
        _label.fontName = "AvenirNext-Medium"
        _label.verticalAlignmentMode = .center
        _label.horizontalAlignmentMode = .center
        addChild(_label)
        
        _redraw()
        
        name = "pass"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _redraw() {
        _label.text = readyToFight ? "Fight" : "Pass"
        if isPosssibleToTap {
            _border.strokeColor = BORDER_COLOR.possibleToTap
            _label.fontColor = FONT_COLOR.possibleToTap
        } else {
            _border.strokeColor = BORDER_COLOR.base
            _label.fontColor = FONT_COLOR.base
        }
    }
}
