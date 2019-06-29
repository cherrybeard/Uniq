//
//  FireballSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class FireballSpell: SpellCard {
    static private let damage: Int = 5
    
    init() {
        super.init(
            name: "Fireball",
            requiresTarget: true,
            spotsFilter: SpotsFilters.enemyCreatures
        )
        description = "Deals \(FireballSpell.damage) damage to selected target."
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            if spot != nil {
                battle.dealDamage(FireballSpell.damage, to: spot!)
                return true
            }
            return false
        }
    }
    
}
