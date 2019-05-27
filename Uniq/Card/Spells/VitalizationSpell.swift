//
//  VitalizationSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 07/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class VitalizationSpell: SpellCardBlueprint {
    init() {
        super.init(description: "Double creature's health")
        //requiresTarget = true
        //targetFilter = CardTargetFilters.all
    }
    
    /*
    override func play(battle: Battle, for owner: PlayerType, target: CharacterSprite? = nil) {
        if let creature = target {
            creature.increaseHealth(by: creature.health)
        }
    }
 */
}
