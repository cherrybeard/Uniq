//
//  Card.swift
//  Uniq
//
//  Created by Steven Gusev on 03/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

typealias TargetFilter = (Creature) -> Bool

struct TargetFilters {
    static let all: TargetFilter = { _ in true }
    static let aiCreatures: TargetFilter = { $0.spot.owner.isAi }
    static let ownerCreatures: TargetFilter = { $0.spot.owner.isHuman }
    //static let ownerCreatures: TargetFilter = { $0.owner.isActivePlayer }
    //static let fullHealthCreatures: CardTargetFilter = { $0.isFullHealth }
}

class CardBlueprint {
    var description: String
    //var targetFilter: CardTargetFilter? = CardTargetFilters.all
    //var requiresTarget: Bool = false
    
    init(description: String = "") {
        self.description = description
    }
    
    func play(battle: Battle, for owner: PlayerType, target: CharacterSprite? = nil) {
        
    }
    
    func generateSprite() -> Card {
        return Card(blueprint: self)
    }
    
    func copy() -> CardBlueprint {
        let blueprint = CardBlueprint(description: description)
        //card.targetFilter = targetFilter
        //card.requiresTarget = requiresTarget
        return blueprint
    }
}
