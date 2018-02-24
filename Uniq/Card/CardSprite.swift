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
    var costLabel: SKLabelNode
    let border: SKShapeNode
    
    private var _canPlay:Bool = false
    var canPlay: Bool {
        get { return _canPlay }
        set(newValue) {
            _canPlay = newValue
            redrawBorder()
        }
    }
    
    let width: Int = 50
    let height: Int = 90
    
    init(card: Card) {
        self.card = card
        costLabel = SKLabelNode(text: String(card.cost))
        border = SKShapeNode(rectOf: CGSize(width: width, height: height))
        super.init()
        
        redrawBorder()
        addChild(border)
        
        let costBorder = SKShapeNode(circleOfRadius: 12)
        costBorder.position = CGPoint(x: -width/2 + 6, y: height/2 - 6)
        costBorder.lineWidth = 0
        costBorder.fillColor = UIColor(hue: 205.0/360.0, saturation: 76.0/100.0, brightness: 74.0/100.0, alpha: 1)
        addChild(costBorder)
        
        costLabel.fontColor = SKColor.white
        costLabel.fontName = "AvenirNext-Bold"
        costLabel.fontSize = 17
        costLabel.position = CGPoint(x: -width/2 + 6, y: height/2 - 7 - 6)
        addChild(costLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func redrawBorder() {
        border.fillColor = UIColor(hue: 0, saturation: 0, brightness: 27.0/100.0, alpha: 1)
        if canPlay {
            border.strokeColor = UIColor(hue: 0, saturation: 0, brightness: 1, alpha: 1)
        } else {
            border.strokeColor = UIColor(hue: 0, saturation: 0, brightness: 40.0/100.0, alpha: 1)
        }
        border.lineWidth = 1
    }
    
    func destroy() {
        self.removeFromParent()
    }
}
