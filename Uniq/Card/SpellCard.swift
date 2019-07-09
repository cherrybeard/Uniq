//
//  SpellCardSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 24/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class SpellCard: Card {
    var effect: (Battle, Character?) -> () = { _,_  in return }
    
    override func play(battle: Battle, for player: Player?, target: Character?) {
        effect(battle, target)
    }
    
    override func copy() -> SpellCard {
        let card = SpellCard(
            name: name,
            requiresTarget: requiresTarget,
            targetFilter: targetFilter
        )
        card.description = description
        card.effect = effect
        return card
    }
}
