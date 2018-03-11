//
//  PlayerHand.swift
//  Uniq
//
//  Created by Steven Gusev on 20/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class HandSprite: SKNode {
    var cards: [CardSprite] = []
    let cardVolume = (50 + 20) / 2
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
    }
    
    func add(_ sprite: CardSprite) {
        sprite.position = CGPoint(x: Int(UIScreen.main.bounds.size.width/2), y: 25)
        addChild(sprite)
        cards.append(sprite)
        _repositionCards()
    }
    
    func clean() {
        for (i, card) in cards.enumerated().reversed() {
            if card.state == .discarded {
                card.removeFromParent()
                cards.remove(at: i)
            }
        }
        _repositionCards()
    }
    
    func highlightCards(mana: Int = -1) {
        for card in cards {
            card.canPlay = (card.card.cost <= mana)
        }
    }
    
    private func _repositionCards() {
        let duration:TimeInterval = 0.2
        var multiplier = cards.count-1
        
        for card in cards {
            let position = CGPoint(x: -(multiplier * cardVolume), y: 0)
            let move = SKAction.move(to: position, duration: duration)
            move.timingMode = .easeOut
            card.run(move)
            multiplier -= 2
        }
    }
}
