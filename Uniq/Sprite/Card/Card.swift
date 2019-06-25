//
//  Card.swift
//  Uniq
//
//  Created by Steven Gusev on 19/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

typealias SpotsFilter = (Spot) -> Bool

struct SpotsFilters {
    // TODO: Add ability to combine filters maybe in separate class
    // Something like x = Filter([Filter.filterPreset1, Filter.filterPreset2, ...])
    static let all: SpotsFilter = { _ in true }
    static let owner: SpotsFilter = { $0.owner.isActive }
    static let ownerFree: SpotsFilter = { $0.owner.isActive && ($0.creature == nil) }
    static let ownerCreatures: SpotsFilter = { $0.owner.isActive && ($0.creature != nil) }
    static let enemy: SpotsFilter = { !$0.owner.isActive }
    static let enemyCreatures: SpotsFilter = { !$0.owner.isActive && ($0.creature != nil) }
    //static let fullHealthCreatures: CardTargetFilter = { $0.isFullHealth }
}

enum CardState {
    case library, deck, hand, discarded
}

class Card {    // TODO: Convert to protocol?
    let description: String
    let requiresTarget: Bool
    let spotsFilter: SpotsFilter
    var state: CardState = .library
    var sprite: CardSprite
    
    init(
        description: String = "",
        requiresTarget: Bool,
        spotsFilter: @escaping SpotsFilter
    ) {
        self.description = description
        self.requiresTarget = requiresTarget
        self.spotsFilter = spotsFilter
        sprite = CardSprite()
        sprite.card = self
    }
    
    func play(battle: Battle, spot: Spot?) -> Bool {
        return false
    }
    
    func copy() -> Card {
        let card = Card(
            description: description,
            requiresTarget: requiresTarget,
            spotsFilter: spotsFilter
        )
        return card
    }
}
