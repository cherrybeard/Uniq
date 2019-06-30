//
//  VitalizationSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 07/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class VitalizationSpell: SpellCard {
    
    init() {
        super.init(
            name: "Vitalization",
            spotsFilter: SpotsFilters.ownerCreatures
        )
        description = "Double creature's health"
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            if let creature = spot?.creature {
                battle.buffStat(.health, by: creature.health.current, at: spot!)
                return true
            }
            return false
        }
    }
}
