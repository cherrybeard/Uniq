//
//  RepositionHandAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 25/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class RepositionHandAnimation: Animation {
    private static let DURATION: TimeInterval = 0.3
    
    private let hand: HandSprite
    private let addCard: Bool
    
    init(hand: HandSprite, addCard: Bool = false) {
        self.hand = hand
        self.addCard = addCard
    }
    
    override func play() {
        let cards = hand.children.filter {
            if let card = $0 as? CardSprite {
                return !card.isDiscarded
            }
            return false
        }
        var cardsCount = cards.count
        if addCard {
            cardsCount += 1
        }
        
        for (index, card) in cards.enumerated() {
            let (position, rotation) = HandSprite.cardPosition(at: index + 1, total: cardsCount)
            let move = SKAction.move(to: position, duration: RepositionHandAnimation.DURATION)
            let rotate = SKAction.rotate(toAngle: rotation, duration: RepositionHandAnimation.DURATION)
            let action = SKAction.group([move, rotate])
            action.timingMode = .easeOut
            card.run(action)
        }
        state = .finished
    }
}
