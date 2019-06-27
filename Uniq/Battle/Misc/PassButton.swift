//
//  PassButton.swift
//  Uniq
//
//  Created by Steven Gusev on 12/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit


class PassButton: SKNode, Interactive {
    private let FILL_COLOR = UIColor(rgb: 0x111111)
    private struct BORDER_COLOR {
        static let base = UIColor(rgb: 0x484644)
        static let interactive = UIColor(rgb: 0x775534)
        static let targetable = UIColor(rgb: 0x3752A1)
        static let targetted = UIColor(rgb: 0x1A54FB)
    }
    private struct FONT_COLOR {
        static let base = UIColor(rgb: 0x484644)
        static let interactive = UIColor(rgb: 0xE3B47B)
    }
    
    var readyToFight: Bool = false { didSet { _redraw() } }
    
    var status: Set<InteractiveStatus> = []  { didSet { _redraw() } }
    var targetsFilter: (Interactive) -> Bool = { _ in return false }
    
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
        
        targetsFilter = { return $0 is PassButton }
        
        name = "pass"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _redraw() {
        _label.text = readyToFight ? "Fight" : "Pass"
        if status.contains(.targetted) {
            _border.strokeColor = BORDER_COLOR.targetted
            _label.fontColor = FONT_COLOR.interactive
        } else if status.contains(.targetable) {
            _border.strokeColor = BORDER_COLOR.targetable
            _label.fontColor = FONT_COLOR.interactive
        } else if status.contains(.interactive) {
            _border.strokeColor = BORDER_COLOR.interactive
            _label.fontColor = FONT_COLOR.interactive
        } else {
            _border.strokeColor = BORDER_COLOR.base
            _label.fontColor = FONT_COLOR.base
        }
    }
}
