//
//  Card.swift
//  Uniq
//
//  Created by Steven Gusev on 03/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

typealias SpotsFilter = (Spot) -> Bool

struct SpotsFilters {
    // TODO: Add ability to combine filters maybe in separate class
    // Something like x = Filter([Filter.filterPreset1, Filter.filterPreset2, ...])
    static let all: SpotsFilter = { _ in true }
    static let owner: SpotsFilter = { $0.owner.isActive }
    static let ownerFree: SpotsFilter = { $0.owner.isActive && ($0.creature == nil) }
    static let enemy: SpotsFilter = { !$0.owner.isActive }
    //static let fullHealthCreatures: CardTargetFilter = { $0.isFullHealth }
}

class CardBlueprint {
    // var effect: (Battle, Spot?) -> Bool
    var description: String
    var spotsFilter: SpotsFilter
    //var requiresTarget: Bool = false  // TODO: Check if needed
    
    init(description: String = "", spotsFilter: @escaping SpotsFilter) {
        self.description = description
        self.spotsFilter = spotsFilter
    }
    
    func generateSprite() -> Card {
        return Card(blueprint: self)
    }
    
    func copy() -> CardBlueprint {
        let blueprint = CardBlueprint(description: description, spotsFilter: spotsFilter)
        return blueprint
    }
}
