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
    
    func draw(card: Card) {
        card.state = .hand
        var cardSprite:CardSprite? = nil
        if card is CreatureCard {
            cardSprite = CreatureCardSprite(card: card as! CreatureCard)
        } else if card is SpellCard {
            cardSprite = SpellCardSprite(card: card as! SpellCard)
        }
        
        cardSprite?.position = CGPoint(x: Int(UIScreen.main.bounds.size.width/2), y: 25)
        
        addChild(cardSprite!)
        cards.append(cardSprite!)
        
        repositionCards()
    }
    
    func clean() {
        for (i, card) in cards.enumerated().reversed() {
            if card.card.state == .discarded {
                card.destroy()
                cards.remove(at: i)
            }
        }
        
        repositionCards()
    }
    
    func markPlayable(mana: Int) {
        for card in cards {
            card.canPlay = (card.card.cost <= mana)
        }
    }
    
    func markUnplayable() {
        for card in cards {
            card.canPlay = false
        }
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
