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
    
    private let costLabel: StatLabel
    let descriptionLabel = SKLabelNode(text: "")
    let border: SKShapeNode
    
    let width = 50
    let height = 90
    private let canPlayBorderColor = UIColor(hue: 0, saturation: 0, brightness: 80.0/100.0, alpha: 1)
    private let defaultBorderColor = UIColor(hue: 0, saturation: 0, brightness: 40.0/100.0, alpha: 1)
    
    init(card: Card) {
        self.card = card
        costLabel = StatLabel(type: .cost, value: card.cost)
        border = SKShapeNode(rectOf: CGSize(width: width, height: height))
        super.init()
        
        border.fillColor = UIColor(hue: 0, saturation: 0, brightness: 27.0/100.0, alpha: 1)
        border.lineWidth = 1
        redrawBorder()
        
        costLabel.position = CGPoint(x: -width/2 + 6, y: height/2 - 6)
        
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
        border.strokeColor = canPlay ? canPlayBorderColor : defaultBorderColor
    }
}
