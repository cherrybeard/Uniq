//
//  MindControlSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 29/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class MindControlSpell: SpellCard {
    
    init() {
        super.init(
            name: "Mind Control",
            spotsFilter: SpotsFilters.enemyCreatures
        )
        description = "Take control of the enemy creature."
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            if let randomSpot = battle.spots.randomSpot(in: SpotsFilters.ownerFree) {
                battle.swap(spot!, with: randomSpot)
            }
            return true
        }
    }
}
