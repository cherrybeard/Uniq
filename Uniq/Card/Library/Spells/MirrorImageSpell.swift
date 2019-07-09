//
//  MirrorImageSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 01/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class MirrorImageSpell: SpellCard {
    init() {
        super.init(
            name: "Mirror Image",
            spotsFilter: SpotsFilters.ownerCreatures
        )
        description = "Summon a copy of target creature with 1/1 to the random spot."
        /*
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            if let creature = spot?.creature {
                if let freeSpot = battle.spots.randomSpot(in: SpotsFilters.ownerFree) {
                    let card = creature.card.copy()
                    card.attack = Value(1)
                    card.health = Value(1)
                    battle.summon(card, to: freeSpot)
                    return true
                }
            }
            return false
        }
        */
    }
}
