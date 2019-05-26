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

class Player: Equatable {
    let type: PlayerType
    var passed: Bool = false
    var deck: Deck
    var isHuman: Bool { return type == .human }
    var isAi: Bool { return type == .ai }
    
    init(as type: PlayerType) {
        self.type = type
        let name = (type == .human) ? "NotOnlyDamageSpells" : ""
        deck = Deck(name: name)
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.type == rhs.type
    }
}
