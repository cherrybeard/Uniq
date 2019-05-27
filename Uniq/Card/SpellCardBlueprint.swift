//
//  File.swift
//  Uniq
//
//  Created by Steven Gusev on 11/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//


class SpellCardBlueprint: CardBlueprint {
    override func generateSprite() -> SpellCard {
        return SpellCard(blueprint: self)
    }
}
