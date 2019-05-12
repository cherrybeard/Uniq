//
//  Card.swift
//  Uniq
//
//  Created by Steven Gusev on 03/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

typealias CardTargetFilter = (CreatureSprite) -> Bool

struct CardTargetFilters {
    static let all: CardTargetFilter = { _ in true }
    static let enemyCreatures: CardTargetFilter = { $0.owner.type == .ai }
    static let ownerCreatures: CardTargetFilter = { $0.owner.type == .human }
    //static let fullHealthCreatures: CardTargetFilter = { $0.isFullHealth }
}

class Card {
    var description: String = ""
    var targetFilter: CardTargetFilter? = CardTargetFilters.all
    var requiresTarget: Bool = false
    
    func play(battle: Battle, for owner: PlayerType, target: CharacterSprite? = nil) {
        
    }
    
    func generateSprite() -> CardSprite {
        return CardSprite(card: self)
    }
}
