//
//  MassHysteriaSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 30/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class MassHysteriaSpell: SpellCard {
    init() {
        super.init(
            name: "Mass Hysteria",
            requiresTarget: false
        )
        description = "Force each creature to attack another random creature."
        /*
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            let spots = battle.spots.shuffledSpots(in: SpotsFilters.creatures)
            for spot in spots {
                if let creature = spot.creature {
                    if creature.attack.current <= 0 { continue }
                    let targetSpot = battle.spots.randomSpot { !$0.isFree && ($0 != spot) }
                    if targetSpot == nil { continue }
                    battle.attack(from: spot, to: targetSpot!)
                }
            }
            return true
        }*/
    }
}
