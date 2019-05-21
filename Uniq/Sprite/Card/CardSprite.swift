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
    private struct BORDER_COLOR {
        static let base: UIColor = UIColor(rgb: 0x484644, alpha: 1)
        static let canPlay: UIColor = UIColor(rgb: 0xC69F78, alpha: 1)
    }
    private struct FILL_COLOR {
        static let base: UIColor = UIColor(rgb: 0x111111, alpha: 1)
        static let tapped: UIColor = UIColor(rgb: 0x333333, alpha: 1)
    }
    
    var card: Card
    var state: CardState = .deck
    
    private var _canPlay:Bool = false
    var canPlay: Bool {
        get { return _canPlay }
        set(newValue) {
            _canPlay = newValue
            redraw()
        }
    }
    
    var isPosssibleToTap: Bool = false
    private var _isCurrentlyTapped: Bool = false
    var isCurrentlyTapped: Bool {
        get { return _isCurrentlyTapped }
        set(newValue) {
            _isCurrentlyTapped = newValue
            redraw()
        }
    }
    
    let descriptionLabel = SKLabelNode(text: "")
    let border: SKShapeNode
    
    init(card: Card) {
        self.card = card
        border = SKShapeNode(rectOf: CGSize(width: WIDTH, height: HEIGHT), cornerRadius: 3)
        super.init()
        
        border.lineWidth = 1
        redraw()
        
        descriptionLabel.text = card.description
        descriptionLabel.fontColor = SKColor.white
        descriptionLabel.fontName = "AvenirNext-DemiBold"
        descriptionLabel.fontSize = 8
        descriptionLabel.preferredMaxLayoutWidth = 48
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.position = CGPoint(x: 0, y: -40)
        
        addChild(border)
        addChild(descriptionLabel)
        
        name = "card"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func redraw() {
        border.fillColor = _isCurrentlyTapped ? FILL_COLOR.tapped : FILL_COLOR.base
        border.strokeColor = _canPlay ? BORDER_COLOR.canPlay : BORDER_COLOR.base
    }
}
