//
//  CardSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 19/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class CardSprite: SKNode {
    var card: Card
    
    private var _canPlay:Bool = false
    var canPlay: Bool {
        get { return _canPlay }
        set(newValue) {
            _canPlay = newValue
            redrawBorder()
        }
    }
    
    private let costLabel: StatLabel
    let border: SKShapeNode
    let width = 50
    let height = 90
    private let canPlayBorderColor = UIColor(hue: 0, saturation: 0, brightness: 1, alpha: 1)
    private let defaultBorderColor = UIColor(hue: 0, saturation: 0, brightness: 40.0/100.0, alpha: 1)
    
    init(card: Card) {
        self.card = card
        costLabel = StatLabel(type: .cost, text: String(card.cost))
        border = SKShapeNode(rectOf: CGSize(width: width, height: height))
        super.init()
        
        border.fillColor = UIColor(hue: 0, saturation: 0, brightness: 27.0/100.0, alpha: 1)
        border.lineWidth = 1
        redrawBorder()
        addChild(border)
        
        costLabel.position = CGPoint(x: -width/2 + 6, y: height/2 - 6)
        addChild(costLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func redrawBorder() {
        border.strokeColor = canPlay ? canPlayBorderColor : defaultBorderColor
    }
}
