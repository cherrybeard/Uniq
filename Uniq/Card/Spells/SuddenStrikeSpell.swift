//
//  SuddenStrikeSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 07/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class SuddenStrikeSpell: SpellCard {
    override init() {
        super.init()
        description = "Deal 2 damage to to undamaged creature"
        requiresTarget = true
        //targetFilter = CardTargetFilters.fullHealthCreatures
    }
    
    /*
    override func play(battle: Battle, for owner: PlayerType, target: CreatureSprite? = nil) {
        if let creature = target {
            creature.dealDamage(2, battle: battle)
        }
    }
     */
}
