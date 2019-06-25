//
//  SpellCardSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 24/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class SpellCard: Card {
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
//        self.sprite = SpellCardSprite()
//        sprite.card = self
    }
    
    override func play(battle: Battle, spot: Spot?) -> Bool {
        return effect(battle, spot)
    }
    
    override func copy() -> SpellCard {
        let card = SpellCard(
            description: description,
            requiresTarget: requiresTarget,
            spotsFilter: spotsFilter,
            effect: effect
        )
        return card
    }
}
