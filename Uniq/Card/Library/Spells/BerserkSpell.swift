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
            spotsFilter: SpotsFilters.enemyCreatures
        )
        description = """
            Force enemy creature to deal damage to all creatures next to it. Exhaust berserk \
            creature.
        """
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            if let creature = spot?.creature {
                let neighbors = battle.spots.neighbors(of: spot!, sameOwner: false)
                let notEmptyNeighbors = neighbors.filter(SpotsFilters.creatures)
                if notEmptyNeighbors.count > 0 {
                    for neighborSpot in neighbors {
                        battle.attack(from: spot!, to: neighborSpot)
                    }
                    creature.isExhausted = true
                    return true
                }
            }
            return false
        }
    }
}
