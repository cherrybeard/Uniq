//
//  InnerStrengthSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 29/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class InnerStrengthSpell: SpellCard {
    
    init() {
        super.init(
            name: "Inner Strength",
            requiresTarget: true,
            spotsFilter: SpotsFilters.creatures
        )
        description = "Swap creature's Attack and Health."
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            if let creature = spot?.creature {
                let health = creature.health
                let attack = creature.attack
                battle.setStat(.attack, to: health.current, at: spot!)
                battle.setStat(.health, to: attack.current, at: spot!)
                return true
            }
            return false
        }
    }
}
