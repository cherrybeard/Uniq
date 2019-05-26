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

class CardSprite: SKNode, Tappable {
    let WIDTH = 60
    let HEIGHT = 90
    private let FILL_COLOR = UIColor(rgb: 0x111111)
    private struct BORDER_COLOR {
        static let currentlyTapped = UIColor(rgb: 0xAC7D4E)
        static let base: UIColor = UIColor(rgb: 0x484644)
        static let possibleToTap = UIColor(rgb: 0x775534)
    }
    
    var card: Card
    var state: CardState = .deck
    
    var isPosssibleToTap: Bool = false { didSet { _redraw() } }
    var isCurrentlyTapped: Bool = false { didSet { _redraw() } }
    
    let descriptionLabel = SKLabelNode(text: "")
    private let _border: SKShapeNode
    
    init(card: Card) {
        self.card = card
        _border = SKShapeNode(rectOf: CGSize(width: WIDTH, height: HEIGHT), cornerRadius: 3)
        super.init()
        
        _border.lineWidth = 1
        _border.fillColor = FILL_COLOR
        _redraw()
        
        descriptionLabel.text = card.description
        descriptionLabel.fontColor = SKColor.white
        descriptionLabel.fontName = "AvenirNext-DemiBold"
        descriptionLabel.fontSize = 8
        descriptionLabel.preferredMaxLayoutWidth = 48
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.position = CGPoint(x: 0, y: -40)
        
        addChild(_border)
        addChild(descriptionLabel)
        
        name = "card"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _redraw() {
        if isCurrentlyTapped {
            _border.strokeColor = BORDER_COLOR.currentlyTapped
        } else if isPosssibleToTap {
            _border.strokeColor = BORDER_COLOR.possibleToTap
        } else {
            _border.strokeColor = BORDER_COLOR.base
        }
    }
}
