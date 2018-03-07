//
//  Player.swift
//  Uniq
//
//  Created by Steven Gusev on 07/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

struct Player {
    let deck = Deck()
    let hand = PlayerHand()
    let manaCounter = ManaCounter(mana: 1)
    
    func drawCard() {
        hand.draw(card: deck.draw())
    }
    
    func drawSpecificCard(_ card: Card) {
        hand.draw(card: card)
    }
    
    func toggleCardsHighlight(playable: Bool) {
        if playable {
            let manaAmount = self.manaCounter.mana
            hand.markPlayable(mana: manaAmount)
        } else {
            hand.markUnplayable()
        }
    }
}
