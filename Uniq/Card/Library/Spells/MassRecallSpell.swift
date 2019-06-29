//
//  MassRecallSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class MassRecallSpell: SpellCard {
    init() {
        super.init(name: "Mass Recall")
        description = "Recalls all allied creatures back to hand."
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            for spot in battle.spots.filter(SpotsFilters.ownerCreatures) {
                if let creature = spot.creature {
                    battle.kill(at: spot)
                    _ = battle.addToHand(for: battle.activePlayer, cardName: creature.card.name)
                }
            }
            return true
        }
    }
}
