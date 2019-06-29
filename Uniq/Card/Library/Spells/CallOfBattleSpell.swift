//
//  CallOfBattleSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 29/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class CallOfBattleSpell: SpellCard {
    init() {
        super.init(
            name: "Call of Battle",
            requiresTarget: true,
            spotsFilter: { $0.owner.isActive && $0.creature == nil }
        )
        description = "Summons random creature from the hand to selected position and remove its exaustion."
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            let owner = battle.activePlayer
            let creaturesInHand = owner.deck.handPile.filter{ $0 is CreatureCard }
            if let card = creaturesInHand.randomElement() {
                _ = battle.play(card, for: owner, to: spot!)
                if let creature = spot?.creature {
                    battle.setActionTakenState(of: creature, toTaken: false)
                }
            }
            return true
        }
    }
}
