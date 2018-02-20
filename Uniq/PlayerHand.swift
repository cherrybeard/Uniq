//
//  PlayerHand.swift
//  Uniq
//
//  Created by Steven Gusev on 20/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class PlayerHand: SKNode {
    var cards: [CardSprite] = []
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
    }
    
    func draw() {
        let creature = Creature(attack: 1, health: 2)
        let card = CreatureCard(cost: 1, creature: creature)
        let cardSprite = CreatureCardSprite(card: card)
        
        cardSprite.position = CGPoint(x: 0, y: 25)
        
        addChild(cardSprite)
        cards.append(cardSprite)
        
        repositionCards()
    }
    
    func clean() {
        for (i, card) in cards.enumerated().reversed() {
            if card.discarded {
                card.destroy()
                cards.remove(at: i)
            }
        }
        
        repositionCards()
    }
    
    func repositionCards() {
        let width = (50 + 20) / 2
        let duration:TimeInterval = 0.2
        var multiplier = cards.count-1
        
        for card in cards {
            let position = CGPoint(x: -(multiplier * width), y: 0)
            let move = SKAction.move(to: position, duration: duration)
            move.timingMode = .easeOut
            card.run(move)
            multiplier -= 2
        }
    }
}
