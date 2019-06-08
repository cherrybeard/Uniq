//
//  CardSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 19/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

enum CardState {
    case deck, hand, discarded
}

class Card: SKNode, Interactive {
    static let WIDTH = 60
    static let HEIGHT = 90
    private static let FILL_COLOR = UIColor(rgb: 0x111111)
    private struct BORDER_COLOR {
        static let base: UIColor = UIColor(rgb: 0x484644)
        static let interactive = UIColor(rgb: 0x775534)
        static let interacted = UIColor(rgb: 0xAC7D4E)
    }
    
    var blueprint: CardBlueprint
    var state: CardState = .deck
    
    var status: Set<InteractiveStatus> = []  { didSet { _redraw() } }
    var targetsFilter: (Interactive) -> Bool
    
    private let _label = SKLabelNode(text: "")
    private let _border = SKShapeNode(
        rectOf: CGSize( width: Card.WIDTH, height: Card.HEIGHT ),
        cornerRadius: 3
    )
    
    init(blueprint: CardBlueprint) {
        self.blueprint = blueprint
        
        targetsFilter = { (interactive: Interactive) -> Bool in
            if let spot = interactive as? Spot {
                return blueprint.spotsFilter(spot)
            }
            return false
        }
        
        super.init()
        
        _border.lineWidth = 1
        _border.fillColor = Card.FILL_COLOR
        addChild(_border)
        
        _label.text = blueprint.description
        _label.fontColor = SKColor.white
        _label.fontName = "AvenirNext-DemiBold"
        _label.fontSize = 8
        _label.preferredMaxLayoutWidth = 48
        _label.lineBreakMode = .byWordWrapping
        _label.numberOfLines = 0
        _label.position = CGPoint(x: 0, y: -40)
        addChild(_label)
        
        _redraw()
        
        name = "card"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _redraw() {
        if status.contains(.interacted) {
            _border.strokeColor = BORDER_COLOR.interacted
        } else if status.contains(.interactive) {
            _border.strokeColor = BORDER_COLOR.interactive
        } else {
            _border.strokeColor = BORDER_COLOR.base
        }
    }
}
