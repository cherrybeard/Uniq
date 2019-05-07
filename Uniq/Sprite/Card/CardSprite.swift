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

class CardSprite: SKNode {
    let WIDTH = 60
    let HEIGHT = 90
    
    private let ACTIVE_BORDER_COLOR = UIColor(rgb: 0xC69F78, alpha: 1)
    private let DEFAULT_BORDER_COLOR = UIColor(rgb: 0x484644, alpha: 1)
    private let DEFAULT_FILL_COLOR = UIColor(rgb: 0x111111, alpha: 1)
    private let ACTIVE_FILL_COLOR = UIColor(rgb: 0x333333, alpha: 1)
    
    var card: Card
    var state: CardState = .deck
    
    private var _canPlay:Bool = false
    var canPlay: Bool {
        get { return _canPlay }
        set(newValue) {
            _canPlay = newValue
            redrawBorder()
        }
    }
    
    private var _isActive:Bool = false
    var isActive: Bool {
        get { return _isActive }
        set(newValue) {
            _isActive = newValue
            redrawBorder()
        }
    }
    
    private let costLabel: StatLabel
    let descriptionLabel = SKLabelNode(text: "")
    let border: SKShapeNode
    
    init(card: Card) {
        self.card = card
        costLabel = StatLabel(type: .cost, value: card.cost)
        border = SKShapeNode(rectOf: CGSize(width: WIDTH, height: HEIGHT), cornerRadius: 3)
        super.init()
        
        border.fillColor = DEFAULT_FILL_COLOR
        border.lineWidth = 1
        redrawBorder()
        
        costLabel.position = CGPoint(x: -WIDTH/2 + 6, y: HEIGHT/2 - 6)
        
        descriptionLabel.text = card.description
        descriptionLabel.fontColor = SKColor.white
        descriptionLabel.fontName = "AvenirNext-DemiBold"
        descriptionLabel.fontSize = 8
        descriptionLabel.preferredMaxLayoutWidth = 48
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.position = CGPoint(x: 0, y: -40)
        
        addChild(border)
        addChild(costLabel)
        addChild(descriptionLabel)
        
        name = "card"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func redrawBorder() {
        border.strokeColor = canPlay ? ACTIVE_BORDER_COLOR : DEFAULT_BORDER_COLOR
        border.fillColor = isActive ? ACTIVE_FILL_COLOR : DEFAULT_FILL_COLOR
    }
}
