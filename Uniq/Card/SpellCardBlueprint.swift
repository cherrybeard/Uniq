//
//  File.swift
//  Uniq
//
//  Created by Steven Gusev on 11/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//


class SpellCardBlueprint: CardBlueprint {
    let spell: (Battle) -> Bool
    
    init(description: String = "", spell: @escaping (Battle) -> Bool) {
        self.spell = spell
        super.init(description: description)
    }
    
    override func generateSprite() -> SpellCard {
        return SpellCard(blueprint: self)
    }
    
    override func copy() -> CardBlueprint {
        let blueprint = SpellCardBlueprint(
            description: description,
            spell: spell
        )
        return blueprint
    }
}
