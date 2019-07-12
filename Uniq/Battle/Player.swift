//
//  Player.swift
//  Uniq
//
//  Created by Steven Gusev on 12/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//


class Player: Equatable {
    
    enum ControlledBy: Int, CaseIterable {
        case human = -1
        case ai = 1
    }
    
    // Stats
    let controlledBy: ControlledBy
    var characters: [Character] = []
    var formation = Formation()
    var isActive: Bool = false
    
    //var hero = Hero() // OBSOLETE
    //var passed: Bool = false // OBSOLETE
    //var deck: Deck // OBSOLETE
    
    // Calculated properties
    var isHuman: Bool { return controlledBy == .human }
    var isAi: Bool { return controlledBy == .ai }
    
    init(as player: ControlledBy) {
        controlledBy = player
        /*
        let name = (type == .human) ? "NotOnlyDamageSpells" : ""
        deck = Deck(name: name)*/
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.controlledBy == rhs.controlledBy
    }
}
