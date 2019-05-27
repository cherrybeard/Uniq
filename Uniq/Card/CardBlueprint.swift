//
//  Card.swift
//  Uniq
//
//  Created by Steven Gusev on 03/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

typealias CardTargetFilter = (Creature) -> Bool

struct CardTargetFilters {
    static let all: CardTargetFilter = { _ in true }
    static let enemyCreatures: CardTargetFilter = { $0.owner!.isAi }
    static let ownerCreatures: CardTargetFilter = { $0.owner!.isHuman }
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
        let card = CardBlueprint(description: description)
        //card.targetFilter = targetFilter
        //card.requiresTarget = requiresTarget
        return card
    }
}
