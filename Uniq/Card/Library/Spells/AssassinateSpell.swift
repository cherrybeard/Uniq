//
//  AssassinateSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class AssassinateSpell: SpellCard {
    
    init() {
        super.init(
            name: "Assassinate",
            requiresTarget: true,
            spotsFilter: SpotsFilters.enemyCreatures
        )
        description = "Destroy enemy creature."
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            if let creature = spot?.creature {
                battle.dealDamage(creature.health.current, to: spot!)
                return true
            }
            return false
        }
    }
}
