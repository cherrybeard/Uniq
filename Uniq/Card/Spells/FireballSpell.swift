//
//  FireballSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class FireballSpell: SpellCard {
    init() {
        super.init(name: "Fireball")
        description = "Deals 6 damage to selected target."
        requiresTarget = true
        spotsFilter = SpotsFilters.enemyCreatures
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            if spot != nil {
                battle.dealDamage(6, to: spot!)
                return true
            }
            return false
        }
    }
    
}
