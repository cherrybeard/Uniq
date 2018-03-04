//
//  Card.swift
//  Uniq
//
//  Created by Steven Gusev on 03/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

enum CardState {
    case deck, hand, discarded
}

class Card {
    var cost: Int
    var state: CardState = .deck
    
    init(cost: Int) {
        self.cost = cost
    }
    
    init(_ card: Card) {
        cost = card.cost
    }
    
    func copy() -> Card {
        return Card(self)
    }
}
