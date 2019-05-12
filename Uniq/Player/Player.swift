//
//  Player.swift
//  Uniq
//
//  Created by Steven Gusev on 12/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

enum PlayerType: Int {
    case human = -1, ai = 1
}

class Player {
    let type: PlayerType
    var passed: Bool = false
    var deck: Deck
    
    init(as type: PlayerType) {
        self.type = type
        let name = (type == .human) ? "NotOnlyDamageSpells" : ""
        deck = Deck(name: name)
    }
}
