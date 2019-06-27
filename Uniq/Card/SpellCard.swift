//
//  SpellCardSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 24/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class SpellCard: Card {
    var effect: (Battle, Spot?) -> Bool = { _,_  in return false }
    
    override func play(battle: Battle, spot: Spot?) -> Bool {
        return effect(battle, spot)
    }
    
    override func copy() -> SpellCard {
        let card = SpellCard(name: name)
        card.description = description
        card.requiresTarget = requiresTarget
        card.spotsFilter = spotsFilter
        card.effect = effect
        return card
    }
}
