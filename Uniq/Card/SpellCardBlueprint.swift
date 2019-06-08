//
//  File.swift
//  Uniq
//
//  Created by Steven Gusev on 11/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//


class SpellCardBlueprint: CardBlueprint {
    let spell: (Battle, Spot?) -> Bool
    
    init(
        description: String = "",
        spotsFilter: @escaping SpotsFilter,
        spell: @escaping (Battle, Spot?) -> Bool
    ) {
        self.spell = spell
        super.init(description: description, spotsFilter: spotsFilter)
    }
    
    override func generateSprite() -> SpellCard {
        return SpellCard(blueprint: self)
    }
    
    override func copy() -> CardBlueprint {
        let blueprint = SpellCardBlueprint(
            description: description,
            spotsFilter: spotsFilter,
            spell: spell
        )
        return blueprint
    }
}
