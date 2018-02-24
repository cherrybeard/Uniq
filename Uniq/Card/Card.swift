//
//  Card.swift
//  Uniq
//
//  Created by Steven Gusev on 18/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

enum CardState: Int {
    case deck = 0, hand, discarded
}

class Card {
    var cost: Int
    var state: CardState = .deck
    
    init(cost: Int) {
        self.cost = cost
    }
}
