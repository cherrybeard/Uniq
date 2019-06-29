//
//  BerserkSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class BerserkSpell: SpellCard {
    
    init() {
        super.init(
            name: "Berserk",
            requiresTarget: true,
            spotsFilter: SpotsFilters.enemyCreatures
        )
        description = "Force enemy creature to deal damage to all creatures next to it. Exaust berserk creature."
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            if let creature = spot?.creature {
                let damage = creature.attack
                let neighbors = battle.spots.neighbors(of: spot!, sameOwner: false)
                let notEmptyNeighbors = neighbors.filter { $0.creature != nil }
                if notEmptyNeighbors.count > 0 {
                    for neighborSpot in neighbors {
                        battle.dealDamage(damage, to: neighborSpot)
                        battle.wait(for: 0.5)
                    }
                    creature.isActionTaken = true
                    return true
                }
            }
            return false
        }
    }
}
