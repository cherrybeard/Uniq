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

typealias CardTargetFilter = (CreatureSprite) -> Bool

struct CardTargetFilters {
    static let all: CardTargetFilter = { _ in true }
    static let enemyCreatures: CardTargetFilter = { creature in creature.owner == .computer }
    static let ownerCreatures: CardTargetFilter = { creature in creature.owner == .player }
    static let fullHealthCreatures: CardTargetFilter = { creature in creature.isFullHealth }
}

class Card {
    var cost: Int
    var state: CardState = .deck
    var description: String = "Boom!"
    var targetFilter: CardTargetFilter? = CardTargetFilters.all
    var requiresTarget: Bool = false
    
    init(cost: Int) {
        self.cost = cost
    }
    
    func play(battle: Battle, for owner: OwnerType, target: CreatureSprite? = nil) {
        
    }
}
