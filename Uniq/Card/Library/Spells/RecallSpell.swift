//
//  RecallSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 07/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class RecallSpell: SpellCard {
    init() {
        super.init(
            name: "Recall",
            requiresTarget: true,
            spotsFilter: SpotsFilters.ownerCreatures
        )
        description = "Recalls allied creature back to hand."
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            if let creature = spot?.creature {
                battle.kill(at: spot!)  // TODO: Replace with remove() to remove silently
                let card = battle.addToHand(for: battle.activePlayer, cardName: creature.card.name)
                return (card != nil)
            }
            return false
        }
    }
}
