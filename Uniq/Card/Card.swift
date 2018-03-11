//
//  Card.swift
//  Uniq
//
//  Created by Steven Gusev on 03/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

typealias CardTargetFilter = (CharacterSprite) -> Bool

struct CardTargetFilters {
    static let all: CardTargetFilter = { _ in true }
    static let creatures: CardTargetFilter = { creature in (creature is CreatureSprite) }
    static let enemyCreatures: CardTargetFilter = { creature in (creature.owner == .computer) && (creature is CreatureSprite) }
    static let ownerCreatures: CardTargetFilter = { creature in (creature.owner == .player) && (creature is CreatureSprite) }
    static let fullHealthCreatures: CardTargetFilter = { creature in creature.isFullHealth && (creature is CreatureSprite) }
}

class Card {
    var cost: Int
    var description: String = "Boom!"
    var targetFilter: CardTargetFilter? = CardTargetFilters.all
    var requiresTarget: Bool = false
    
    init(cost: Int) {
        self.cost = cost
    }
    
    func play(battle: Battle, for owner: OwnerType, target: CharacterSprite? = nil) {
        
    }
    
    func generateSprite() -> CardSprite {
        return CardSprite(card: self)
    }
}
