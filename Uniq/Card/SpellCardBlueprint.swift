//
//  File.swift
//  Uniq
//
//  Created by Steven Gusev on 11/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//


class SpellCardBlueprint: CardBlueprint {
    let effect: (Battle, Spot?) -> Bool
    
    init(
        description: String = "",
        requiresTarget: Bool,
        spotsFilter: @escaping SpotsFilter,
        effect: @escaping (Battle, Spot?) -> Bool
    ) {
        self.effect = effect
        super.init(
            description: description,
            requiresTarget: requiresTarget,
            spotsFilter: spotsFilter
        )
    }
    
    override func play(battle: Battle, spot: Spot?) -> Bool {
        return effect(battle, spot)
    }
    
    override func generateSprite() -> SpellCard {
        return SpellCard(blueprint: self)
    }
    
    override func copy() -> CardBlueprint {
        let blueprint = SpellCardBlueprint(
            description: description,
            requiresTarget: requiresTarget,
            spotsFilter: spotsFilter,
            effect: effect
        )
        return blueprint
    }
}
