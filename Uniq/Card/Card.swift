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
    static let none: SpotsFilter = { _ in false }
    static let all: SpotsFilter = { _ in true }
    static let creatures: SpotsFilter = { !$0.isFree }
    
    static let owner: SpotsFilter = { $0.owner.isActive }
    static let ownerFree: SpotsFilter = { $0.owner.isActive && $0.isFree }
    static let ownerCreatures: SpotsFilter = { $0.owner.isActive && !$0.isFree }
    
    static let enemy: SpotsFilter = { !$0.owner.isActive }
    static let enemyCreatures: SpotsFilter = { !$0.owner.isActive && !$0.isFree }
    
    static let ai: SpotsFilter = { $0.owner.isAi }
    static let aiCreatures: SpotsFilter = { $0.owner.isAi && !$0.isFree }
    static let aiFree: SpotsFilter = { $0.owner.isAi && $0.isFree }
    
    static let humanFree: SpotsFilter = { $0.owner.isHuman && $0.isFree }
    //static let fullHealthCreatures: CardTargetFilter = { $0.isFullHealth }
}

class Card {
    
    enum State {
        case library, deck, hand, discarded
    }
    
    var name: String = ""
    var description: String = "'"
    var requiresTarget: Bool
    var spotsFilter: SpotsFilter
    var state: State = .library
    var sprite: CardSprite = CardSprite()
    
    init(
        name: String,
        requiresTarget: Bool = false,
        spotsFilter: @escaping SpotsFilter = SpotsFilters.none
    ) {
        self.name = name
        self.requiresTarget = requiresTarget
        self.spotsFilter = spotsFilter
        sprite.card = self
    }
    
    func play(battle: Battle, spot: Spot?) -> Bool {
        return false
    }
    
    /// Creates a copy of this card. State and sprite will not be copied.
    ///
    /// - Returns: New instance of the same card.
    func copy() -> Card {
        let card = Card(name: name)
        card.description = description
        card.requiresTarget = requiresTarget
        card.spotsFilter = spotsFilter
        return card
    }
}
