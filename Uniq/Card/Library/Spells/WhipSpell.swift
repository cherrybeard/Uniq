//
//  WhipSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class WhipSpell: SpellCard {
    static private let damage: Int = 1
    
    init() {
        super.init(
            name: "Whip",
            requiresTarget: true,
            spotsFilter: SpotsFilters.ownerCreatures
        )
        description = "Deal \(WhipSpell.damage) damage to your creature and remove its exaustion."
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            if let creature = spot?.creature {
                battle.dealDamage(WhipSpell.damage, to: spot!)
                battle.setActionTakenState(of: creature, toTaken: false)
                return true
            }
            return false
        }
    }
}
