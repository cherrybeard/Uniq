//
//  InnerFireSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 29/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class InnerFireSpell: SpellCard {
    
    init() {
        super.init(
            name: "Inner Fire",
            requiresTarget: true,
            spotsFilter: SpotsFilters.allCreatures
        )
        description = "Set creature's Attack to its Health."
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            if let creature = spot?.creature {
                let health = creature.health
                battle.setStat(.attack, to: health, at: spot!)
                return true
            }
            return false
        }
    }
}
