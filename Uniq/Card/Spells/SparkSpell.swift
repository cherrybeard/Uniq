//
//  SeeingLightSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 07/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import Foundation

class SparkSpell: SpellCardBlueprint {
    init() {
        super.init(description: "Deal 2 damage. Draw 1 card")
        //requiresTarget = true
        //targetFilter = CardTargetFilters.all
    }
    
    override func play(battle: Battle, for owner: PlayerType, target: CharacterSprite? = nil) {
        /*
        if let creature = target {
            creature.dealDamage(2, battle: battle)
        }
        battle.player.deck.draw()
        */
    }
}
