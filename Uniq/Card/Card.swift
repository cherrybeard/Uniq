//
//  Card.swift
//  Uniq
//
//  Created by Steven Gusev on 19/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

typealias CharacterFilter = (Character) -> Bool

struct CreatureFilters {
    // TODO: Add ability to combine filters maybe in separate class
    // Something like x = Filter([Filter.filterPreset1, Filter.filterPreset2, ...])
    static let none: CharacterFilter = { _ in false }
    static let all: CharacterFilter = { _ in true }
    /*
    static let creatures: CharacterFilter = { !$0.isFree }
    
    static let owner: CharacterFilter = { $0.owner.isActive }
    static let ownerFree: CharacterFilter = { $0.owner.isActive && $0.isFree }
    static let ownerCreatures: CharacterFilter = { $0.owner.isActive && !$0.isFree }
    
    static let enemy: CharacterFilter = { !$0.owner.isActive }
    static let enemyCreatures: CharacterFilter = { !$0.owner.isActive && !$0.isFree }
    
    static let ai: CharacterFilter = { $0.owner.isAi }
    static let aiCreatures: CharacterFilter = { $0.owner.isAi && !$0.isFree }
    static let aiFree: CharacterFilter = { $0.owner.isAi && $0.isFree }
    
    static let humanFree: CharacterFilter = { $0.owner.isHuman && $0.isFree }*/
    //static let fullHealthCreatures: CardTargetFilter = { $0.isFullHealth }
}

class Card {
    
    enum State {
        case library, deck, hand, discarded
    }
    
    var name: String = ""
    var description: String = "'"
    var requiresTarget: Bool
    var targetFilter: CharacterFilter
    var state: State = .library
    var sprite: CardSprite = CardSprite()
    
    init(
        name: String,
        requiresTarget: Bool = true,
        targetFilter: @escaping CharacterFilter = CreatureFilters.none
    ) {
        self.name = name
        self.requiresTarget = requiresTarget
        self.targetFilter = targetFilter
        sprite.card = self
    }
    
    func play(battle: Battle, for player: Player?, target: Character?) {
        
    }
    
    /// Creates a copy of this card. State and sprite will not be copied.
    ///
    /// - Returns: New instance of the same card.
    func copy() -> Card {
        let card = Card(name: name)
        card.description = description
        card.requiresTarget = requiresTarget
        card.targetFilter = targetFilter
        return card
    }
}
